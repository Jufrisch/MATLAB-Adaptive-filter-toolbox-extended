% Author: Justin Frisch

classdef lms_mcc < lms
    properties
        mcc
    end
    methods
        function self = lms_mcc(filterOrder, stepSize)
            self.name = 'LMS MCC';
            self.logger = Logger('LMS MCC');
        end
        function self = train(self,mcc,mu,X,d,val_num)
            self.mcc = mcc;
            self.stepSize = mu;
            train@AdaptFilt(self,X,d,val_num);
        end
    end
    methods (Access = protected)
        function updateModel(self,d_vect,X,n) % d is a vector!
            u_n =  X(n,:)'; % 1xModelOrder 
            d_hat = self.predict(u_n);  % prediction
            e = d_vect(n) - d_hat;          %compute error
            
            self.w = self.w + self.stepSize  ... %
                   * exp(-(e^2)/(2*self.mcc^2))*e*u_n; % add new center scale
            self.e_hist(n) = e;        %store error_history
            self.w_hist(n,:) = self.w; %store weight history
            self.y_hist(n) = d_hat;    %store filter output history
        end
        function d = params(self)
			d = strcat('Filter Order=', num2str(self.filterOrder),' ,Step Size=', num2str(self.stepSize));
		end
    end
end

 