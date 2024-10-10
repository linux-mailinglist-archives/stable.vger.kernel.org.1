Return-Path: <stable+bounces-83358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C999881C
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7F328ADB4
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CD1C9DD3;
	Thu, 10 Oct 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5E2cHXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074851B5337
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567964; cv=none; b=JyPD4jMIKea0VYP+KX9DK2Lt06jAAQ/qic8RUYvEg7PQ6akBPgeOP84KgCSibNy3U+3NrhhbjhlqgLMSGD7Ru1dboD4NEGMT/xxFfftmW26ILcP8dmQlItAdBvMsffHsFOIOA1WuhKArQnpPtub/TnUYLfupGHbwbwKyH65SxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567964; c=relaxed/simple;
	bh=aqf6FA1ModO8YdrSAdH7Rvzvf/NsbPNUiAWY1Oybvx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4EOx1GGOESnHunIR1V8ZOvzmrf5tk1gpfhanaPOH/U28JS7ybG0v/Q7opa9duXSEDfQT6khhGgh95j6P7DJk2gop+p7oHrzJ4JyrdTkV0X3cRhKh4uMfWpvEeuPb0jBcD2Kl01S0uwEzFaqx+5wOA7/R5itkVuaS1HzFJsLAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5E2cHXf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so1846906e87.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728567961; x=1729172761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=daYbA/IQ2VsUidG5QXueWwrgZDxCl0o/PDmc/HXVE1k=;
        b=S5E2cHXflWEEwtibALBgH4kskcjbcuEhXD5hvnfNFtJHyKZg5R/2OS1g0iEA/rnyvY
         45o9zo5RzjOSqcLMk9T8wUI5HYBFyAyMsbiRf99DAKDwL0lE0KeiSsm9egzuA2yDuuMs
         61NL2FUKJBFYqEJio5HgozpQTdVxRyOohEZqxV8ZTmd1u1Uix1krPnWpunJHY+UY+R3v
         OFjRxNNKG637s4x0jJhDbYEnRGAebVZCfmhPy5hRMGQ0S7WVWtqQTyWdDP60rJn8K2q5
         NL5exhGe9ghxWAySS8D/eQHE8Je0xBLIj6ZXDx1vAxhgrxuz071sgx0JGjhK10c+pMNw
         YGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567961; x=1729172761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daYbA/IQ2VsUidG5QXueWwrgZDxCl0o/PDmc/HXVE1k=;
        b=ce4I/qYQ8RqR+KOZx49pIXzKtW7ZN+6QhxWVaDibsj1lRx3dTGzcqHgKC9B7XbMnzX
         JkuzXksMwnC8t0M3r9b9u4Nj7bywG3c5ZpxIAwEsuiZW99/3+ZdmPLYiPgYoN9cg7d+x
         ncyRyBN7PRmD5IRCLZlFxUkwSYwwHkJfcqVDkFBbm+JcUEbG2YHqQebkxfZo9vFkwV7w
         vgxwfp+vJothCNebyKBdFhmAVZxHnH81kW2yALou8FnSMvdVWoLCzDSbK39IWUk7GO6+
         sWyzC2x83Tpiu2FEJ3YC0i/m93CXOjKHSJD6CwGpQulQpZri4ZWv3va7ki+9Ap3pP1Xq
         7kGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7TR1y5kd4jADGX666VyEP0D8KqQ5nhfIJDz6ciMnt7mp7l4i/CvrPefRHQZGQ2w/hQ5bYIs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6mXbmA0PMs5XgKvhAPBTQ7grlf7kgk6YsB+/kLGsMNYdwjEx
	6NVeuLkQxNk/lC2y3L+eekjQiXzNYbXOGXBA0+nUTWobu1d4wvuzsrV+2OclPRQ=
X-Google-Smtp-Source: AGHT+IG8VZyQ2Csj/t2qN0rUAUd1Mt/8bM1qBklXVbOB/H5xxqv45UlS19dZiOWrZWbiyjsSdd4NFQ==
X-Received: by 2002:a05:6512:3f0a:b0:539:8ee8:749e with SMTP id 2adb3069b0e04-539c985a7f0mr1301444e87.3.1728567961166;
        Thu, 10 Oct 2024 06:46:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c10b9sm262053e87.62.2024.10.10.06.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:45:59 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:45:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: neil.armstrong@linaro.org, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Chris Lew <quic_clew@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
Message-ID: <jtxci47paynh3uuulwempryixgbdvcnx3fhtkru733s6rkip7l@jxoaaxdxvp3d>
References: <20241010074246.15725-1-johan+linaro@kernel.org>
 <CAA8EJpoiu2hwKWGMTeA=Kr+ZaPL=JJFq1qQOJhUnYz6-uTmHWw@mail.gmail.com>
 <ZweoZwz73GaVlnLB@hovoldconsulting.com>
 <CAA8EJprg0ip=ejFOzBe3iisKHX14w0BnAQUDPqzuPRX6d8fvRA@mail.gmail.com>
 <Zwe-DYZKQpLJgUtp@hovoldconsulting.com>
 <c84dd670-d417-4df7-b95f-c0fbc1703c2d@linaro.org>
 <ZwfVg89DAIE74KGB@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfVg89DAIE74KGB@hovoldconsulting.com>

On Thu, Oct 10, 2024 at 03:24:19PM GMT, Johan Hovold wrote:
> On Thu, Oct 10, 2024 at 01:46:48PM +0200, neil.armstrong@linaro.org wrote:
> > >> On Thu, 10 Oct 2024 at 13:11, Johan Hovold <johan@kernel.org> wrote:
> 
> > >>> As I tried to explain in the commit message, there is currently nothing
> > >>> indicating that these issues are specific to x1e80100 (even if you may
> > >>> not hit them in your setup depending on things like probe order).
> 
> > The in-kernel pd-mapper works fine on SM8550 and SM8650, please just revert
> > the X1E8 patch as suggested by Dmitry.
> 
> Again, you may just be lucky, we have x1e users that also don't hit
> these issues due to how things are timed during boot in their setups.
> 
> If there's some actual evidence that suggests that this is limited to
> x1e, then that would of course be a different matter, but I'm not aware
> of anything like that currently.

Is there an evidence that it is broken on other platforms? I have been
daily driving the pd-mapper in my testing kernels for a long period of
time.

-- 
With best wishes
Dmitry

