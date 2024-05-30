Return-Path: <stable+bounces-47684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41AA8D4746
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3071F21CD4
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20F176194;
	Thu, 30 May 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5+BVswU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4004176186
	for <stable@vger.kernel.org>; Thu, 30 May 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058267; cv=none; b=QTkRWj0+u7htdODNkw18SdeLN74wDxRn81dMImR+OQjlX+l5T+CWv+6+YV02UXV5rcHumPvpSpQCeqhMGazeVS9RiDd2UDQZN5UP/mbeTFaYhOh0ZFass+AMb4WzXpYqP4+30Uhbjt3JUntQfacGW4A6ZB5L0nJQBkcJ/3JN1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058267; c=relaxed/simple;
	bh=bZa/G5FiTxfBvV+gWC27jKqObZig5zyLCTlZJ8J4XPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZHCNhVG/ywM3DRE09smcvvmT26MRdt4SLIETnENyxQMwTFRS5wjCcoZWC2+vXLMxPANwDDeB5C6zNdVF2feLSmaIGazEP6uv0rZjPryi1Hx7NYCRMzNzDQCaA5YLLs4qqUttR9WuMyZGnT2XWZn2mMitJxjbjJ+U8uD1KQLcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5+BVswU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52a6ef5e731so868728e87.0
        for <stable@vger.kernel.org>; Thu, 30 May 2024 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717058263; x=1717663063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ5RLDbLQezuGZD6WW3IWTonXC6axeGUQvN38zFd42s=;
        b=d5+BVswUkYezmLuvS/enUPy7snpY7gUhE21FcztTHwijAOgMOzd/ZSHE4u8mxa3SD/
         o3/iK7/4zCsy1w9TjByCcoHIQJgO5F39UHSgcaZk3Dnms8rh2avkLg//s5X8RyO6fbyk
         /Wpp9RnJe936EPFHputO0W86y/K/xvn28n7Ztv3NilO55T6VuietEcrqHezsq2+rPNhM
         gLSP0qsaTfJKFz21ft0XNSMCL8rAh3szCvfiMY2XLe3Rhcsp/cVzrYbVxTgP0AV4RZG1
         SQLigYj7VTjBwF3WYyhVVRDePHq6fDYvzE7uzaaD6FTo2BriaZtb7LFo1l8nfW1BBVEE
         rhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058263; x=1717663063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ5RLDbLQezuGZD6WW3IWTonXC6axeGUQvN38zFd42s=;
        b=hf5Tc+eXUu1wScpI6UoryLygKDFt7C9Ot5pIDeus3kAvdvbUqg0hM61iJtE5MckHJQ
         RFFzkbjAXHItwDWIRq3YzjzYgQBCH8j1EvqLGSetnYRwBQFTSKHFziQOLjd4J2s1c3nq
         pywTLsN12sM+Ady8BsWFFFQO3hanadN5Y1b3nrm6IF6E5NehL1o2XJ6sAUB6YMLdH+La
         Syc9Y8V0i1/33hjjBWHVn35CRKmkEL3mCiXWBc/DTqqAs/vuOGnD3yU0IWT9QS4xSPYU
         Jh28M9bjVaFyd7q+GoLrY/g+jh2lLalbaC86eKTJyYJuzyEbVKWrcgvcSpNsIm8mBlwE
         0/mA==
X-Forwarded-Encrypted: i=1; AJvYcCX17THCcAY8EjzZovq61oKQBM/Qi9Ex/gy0bu0+h7tOIh0UwkNb8jEccUa/HdfOZWnE4dk/ciCbgMy0eMx321PR+0n+Lqv5
X-Gm-Message-State: AOJu0YyHVjV9ooQfVzavA0rVKhWBf7cagFbm2hF5tIhUEWngcyeGbo48
	YZ/IQjsgQFzdBo+tmap4EBTyrwadalirxPzRQsuFa3N9AZZiqXCyOqYVYW6xBT0=
X-Google-Smtp-Source: AGHT+IHqo30gINH2FhSbzfIFtkvloEFgqOZkIOuXdkc9A1pHSZQJGV0RkZavzDi9N+AT7QqSl3Trxg==
X-Received: by 2002:a19:a405:0:b0:523:8a79:ed62 with SMTP id 2adb3069b0e04-52b7d419e09mr868817e87.3.1717058263092;
        Thu, 30 May 2024 01:37:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b7baf3982sm192241e87.161.2024.05.30.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:37:42 -0700 (PDT)
Date: Thu, 30 May 2024 11:37:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com, Doug Anderson <dianders@google.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Disable SS instances in
 park mode
Message-ID: <tziambdwgp4nrgrhr6z2hl7crrw32ztpv63wcsc3h3hthformm@ylc7la6jrqr7>
References: <20240530082556.2960148-1-quic_kriskura@quicinc.com>
 <20240530082556.2960148-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530082556.2960148-2-quic_kriskura@quicinc.com>

On Thu, May 30, 2024 at 01:55:55PM +0530, Krishna Kurapati wrote:
> On SC7180, in host mode, it is observed that stressing out controller
> in host mode results in HC died error and only restarting the host
> mode fixes it. Disable SS instances in park mode for these targets to
> avoid host controller being dead.

Just out of curiosity, what is the park mode?

> 
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 2b481e20ae38..cc93b5675d5d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3063,6 +3063,7 @@ usb_1_dwc3: usb@a600000 {
>  				iommus = <&apps_smmu 0x540 0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;
> +				snps,parkmode-disable-ss-quirk;
>  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
>  				maximum-speed = "super-speed";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

