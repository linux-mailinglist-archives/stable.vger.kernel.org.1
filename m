Return-Path: <stable+bounces-118269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD3A3BFA0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F90A1896444
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB21E231E;
	Wed, 19 Feb 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiT9M1QW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095651E0B8A
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970810; cv=none; b=LOGcnER4wGwry6izQv6OhnphltLBjb2vvX6itt2/Mgii0QLTJvlpRWdEicsyivi3azhjgO3w2my9wWHIQnGOkGztlEtpPoNNJNisXWFl6XboQwGKmLkglIOAvmZYeE7uaitqN4rIhrL5DZTxo23SWVmfESCMA1x5IGt6qnYRTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970810; c=relaxed/simple;
	bh=N1DHUdSnvmt36V2m5nNLQz+GAkBLimsA64IQtEB74XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0cJhRUnfiK3nETNi73qT4GJRj/m0ImNoKIN+ZHG8haJj+9ccSngjM2zUG4Qbz3VzfQDDdaIsWvl46xj7i3aMH3DTI/TTeXd7SvcwFDgzdALUhcoc884Qa0FOHi9kKXHmSNSBXFR/oTyWGBjW+gJfnzFxacpUYqhFhfiXD4jbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iiT9M1QW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22100006bc8so76322825ad.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 05:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739970808; x=1740575608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+URBwMiBnKyGY5kPdMN3kkeBQNC7Y+f9MSb7kdc35Q=;
        b=iiT9M1QWVkFukFNm1xyjzR9+TX9qJMrwEOOnKzUo09FwBOYBWSzySYhKxWFRIzt/gZ
         IJkY4I51ys4OnKVJ22z8o1fu7f8daMVqITwZAkcO3wG8IlRlXaGTbnFAN9HjMLNqT8L1
         lm20WLjV9f3TuX7sidxL8DVYQDgyWaF3DxJwhJVXsq8TmlscjGPiuPRwM6sUe54O96kw
         kqOOTpe+UAnSs/BzqtWwmeRfk9QKVmfzSOw88tKr7eVWoWsnS51faHrAPeWOexIPmCxH
         6k6a2kT02PfJTIx1dvBdUGV/0lVLmmJ2xwnUe1DfKwOLjwu2UOscxabIlepYpA8b+Em8
         dfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739970808; x=1740575608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+URBwMiBnKyGY5kPdMN3kkeBQNC7Y+f9MSb7kdc35Q=;
        b=Asvy6fO3VYcsZ5Tmn0PBZyPtt7RewIJ0XOUi22Bo/Hz97W3cUX6sVBp+Bn8zl4tzBm
         tPoNLkwbS8pPhUYIsi6LSh3yDlqq4rV+rcA7jkVRnpTjVQfyRMJSXKRy0QIK7jLsIVhx
         1GAZHwym0LYhNuljezEm8ddOn1xehb5HB+TyXS7b78qWSLi4Twuvx9OjGx8MkdwUxk9y
         dSSfSvmQqiB2S0fn95whbORKvdCGop2K0rEB21DG/jyf3TmlwpNlYZwwr2JYGui/j9+S
         F1cK7RChMDK51/bU4/AildJ60Zl2KpdVhclJeNsrFsAfQ+dbIjF8cCIZ1nm8V6r/2LhJ
         VY/A==
X-Forwarded-Encrypted: i=1; AJvYcCXp5bkbo6+njUYczLCbFOfO0ScCfXjt7WrrpBESV0cmQoHI8Qoje8Bea2ebirD1nOmqVLNURcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9384WGGzP3ERqHLD+K7buoVjr+weKmc++xt9IbmfcpYMAIwAl
	Ji6T8zJWTZoHIdEGa0dShPtuoGoLJDh3CqJQlylmLnmmbiVVxYwQvqzrgkBUbw==
X-Gm-Gg: ASbGncuhTFzIubD9L3GKqhOHTy6Ie0TTCzSeeTpUj/T7x+LXcMQA/mngQtcN46r+5sn
	v4+1sMwcxbv4xQ9tSjx7bVOLpOXMwd5Car6UQEyZszwZ/29nrvDdPMrCvwllX4hXZCmmUly+1FB
	9aBZU6GdR319VXDv31yB8VylIfPN4mVvBwhQkdTSyBD4Lifo9Hww5Z4Py3WVFALACNntnGYrIeb
	xZD1sGnB5rgKeS+f47fW4EpZcIUrbbndpxuLkW9LrAfyRK3OvjfTdF/NCJ7HPBJ1Kopcyv0JWd3
	wRh9+nXCrj2qji4ZWvIvLMaG0KE=
X-Google-Smtp-Source: AGHT+IHkVE5PfzgLunRYfW7LOverW0PdjTWo0Wwm0ksUnlxjHfmqNgrs9+yjaxVIVMFyRcmK9zw8KQ==
X-Received: by 2002:a17:902:ef49:b0:216:6769:9ed7 with SMTP id d9443c01a7336-221040b131dmr298362555ad.40.1739970808214;
        Wed, 19 Feb 2025 05:13:28 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537c921sm104190715ad.104.2025.02.19.05.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:13:27 -0800 (PST)
Date: Wed, 19 Feb 2025 18:43:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: mhi@lists.linux.dev, Loic Poulain <loic.poulain@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: mhi: host: pci_generic: Use
 pci_try_reset_function() to avoid deadlock
Message-ID: <20250219131324.ohfrkuj32fifkmkt@thinkpad>
References: <20250108-mhi_recovery_fix-v1-0-a0a00a17da46@linaro.org>
 <20250108-mhi_recovery_fix-v1-1-a0a00a17da46@linaro.org>
 <Z5EKrbXMTK9WBsbq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5EKrbXMTK9WBsbq@hovoldconsulting.com>

On Wed, Jan 22, 2025 at 04:11:41PM +0100, Johan Hovold wrote:
> On Wed, Jan 08, 2025 at 07:09:27PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > There are multiple places from where the recovery work gets scheduled
> > asynchronously. Also, there are multiple places where the caller waits
> > synchronously for the recovery to be completed. One such place is during
> > the PM shutdown() callback.
> > 
> > If the device is not alive during recovery_work, it will try to reset the
> > device using pci_reset_function(). This function internally will take the
> > device_lock() first before resetting the device. By this time, if the lock
> > has already been acquired, then recovery_work will get stalled while
> > waiting for the lock. And if the lock was already acquired by the caller
> > which waits for the recovery_work to be completed, it will lead to
> > deadlock.
> > 
> > This is what happened on the X1E80100 CRD device when the device died
> > before shutdown() callback. Driver core calls the driver's shutdown()
> > callback while holding the device_lock() leading to deadlock.
> > 
> > And this deadlock scenario can occur on other paths as well, like during
> > the PM suspend() callback, where the driver core would hold the
> > device_lock() before calling driver's suspend() callback. And if the
> > recovery_work was already started, it could lead to deadlock. This is also
> > observed on the X1E80100 CRD.
> > 
> > So to fix both issues, use pci_try_reset_function() in recovery_work. This
> > function first checks for the availability of the device_lock() before
> > trying to reset the device. If the lock is available, it will acquire it
> > and reset the device. Otherwise, it will return -EAGAIN. If that happens,
> > recovery_work will fail with the error message "Recovery failed" as not
> > much could be done.
> 
> I can confirm that this patch (alone) fixes the deadlock on shutdown
> and suspend as expected, but it does leave the system state that blocks
> further suspend (this is with patches that tear down the PCI link).

Yeah, we wouldn't know when not to return an error to unblock the suspend. So
this is acceptable.

> Looks like the modem is also hosed.
> 
> [  267.454616] mhi-pci-generic 0005:01:00.0: mhi_pci_runtime_resume
> [  267.461165] mhi mhi0: Resuming from non M3 state (SYS ERROR)
> [  267.467102] mhi-pci-generic 0005:01:00.0: failed to resume device: -22
> [  267.473968] mhi-pci-generic 0005:01:00.0: device recovery started
> [  267.477460] mhi-pci-generic 0005:01:00.0: mhi_pci_suspend
> [  267.480331] mhi-pci-generic 0005:01:00.0: __mhi_power_down
> [  267.485917] mhi-pci-generic 0005:01:00.0: mhi_pci_runtime_suspend
> [  267.498339] mhi-pci-generic 0005:01:00.0: __mhi_power_down - pm mutex taken
> [  267.505618] mhi-pci-generic 0005:01:00.0: __mhi_power_down - pm lock taken
> [  267.513372] wwan wwan0: port wwan0qcdm0 disconnected
> [  267.519556] wwan wwan0: port wwan0mbim0 disconnected
> [  267.525544] wwan wwan0: port wwan0qmi0 disconnected
> [  267.573773] mhi-pci-generic 0005:01:00.0: __mhi_power_down - returns
> [  267.591199] mhi mhi0: Requested to power ON
> [  267.914688] mhi mhi0: Power on setup success
> [  267.914875] mhi mhi0: Wait for device to enter SBL or Mission mode
> [  267.919179] mhi-pci-generic 0005:01:00.0: mhi_sync_power_up - wait event timeout_ms = 8000
> [  276.189399] mhi-pci-generic 0005:01:00.0: mhi_sync_power_up - wait event returns, ret = -110
> [  276.198240] mhi-pci-generic 0005:01:00.0: __mhi_power_down
> [  276.203990] mhi-pci-generic 0005:01:00.0: __mhi_power_down - pm mutex taken
> [  276.211269] mhi-pci-generic 0005:01:00.0: __mhi_power_down - pm lock taken
> [  276.220024] mhi-pci-generic 0005:01:00.0: __mhi_power_down - returns
> [  276.226680] mhi-pci-generic 0005:01:00.0: mhi_sync_power_up - returns
> [  276.233417] mhi-pci-generic 0005:01:00.0: mhi_pci_recovery_work - mhi unprepare after power down
> [  276.242604] mhi-pci-generic 0005:01:00.0: mhi_pci_recovery_work - pci reset
> [  276.249881] mhi-pci-generic 0005:01:00.0: Recovery failed
> [  276.255536] mhi-pci-generic 0005:01:00.0: mhi_pci_recovery_work - returns
> [  276.328878] qcom-pcie 1bf8000.pci: qcom_pcie_suspend_noirq
> [  276.368851] qcom-pcie 1c00000.pci: qcom_pcie_suspend_noirq
> [  276.477900] qcom-pcie 1c00000.pci: Failed to enter L2/L3
> [  276.483535] qcom-pcie 1c00000.pci: PM: dpm_run_callback(): genpd_suspend_noirq returns -110
> [  276.492292] qcom-pcie 1c00000.pci: PM: failed to suspend noirq: error -110
> [  276.500218] qcom-pcie 1bf8000.pci: qcom_pcie_resume_noirq
> [  276.721401] qcom-pcie 1bf8000.pci: PCIe Gen.4 x4 link up
> [  276.730639] PM: noirq suspend of devices failed
> [  276.818943] mhi-pci-generic 0005:01:00.0: mhi_pci_resume
> [  276.824582] mhi-pci-generic 0005:01:00.0: mhi_pci_runtime_resume
> 
> Still better than hanging the machine, but perhaps not much point in
> having recovery code that can't recover the device.
> 

Unfortunately, we cannot know if we could not recover the device.

> We obviously need to track down what is causing the modem to fail to
> resume since 6.13-rc1 too.
> 

Yeah, this is worth tracing down.

> > Cc: stable@vger.kernel.org # 5.12
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Closes: https://lore.kernel.org/mhi/Z1me8iaK7cwgjL92@hovoldconsulting.com
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> And since I've spent way to much time debugging this and provided the
> analysis of the deadlock:
> 
> Analyzed-by: Johan Hovold <johan@kernel.org>
> Link: https://lore.kernel.org/mhi/Z2KKjWY2mPen6GPL@hovoldconsulting.com/
> 

Sure.

> > Fixes: 7389337f0a78 ("mhi: pci_generic: Add suspend/resume/recovery procedure")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/bus/mhi/host/pci_generic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> > index 07645ce2119a..e92df380c785 100644
> > --- a/drivers/bus/mhi/host/pci_generic.c
> > +++ b/drivers/bus/mhi/host/pci_generic.c
> > @@ -1040,7 +1040,7 @@ static void mhi_pci_recovery_work(struct work_struct *work)
> >  err_unprepare:
> >  	mhi_unprepare_after_power_down(mhi_cntrl);
> >  err_try_reset:
> > -	if (pci_reset_function(pdev))
> > +	if (pci_try_reset_function(pdev))
> >  		dev_err(&pdev->dev, "Recovery failed\n");
> 
> Perhaps you should log the returned error here as a part of this patch
> so we can tell when the recovery code failed due to the device lock
> being held.
> 

Makes sense. Added the errno to the log and applied to patch to mhi/next with
your tags. Thanks a lot!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

