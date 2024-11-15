Return-Path: <stable+bounces-93557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26D89CF0D4
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341BF1F2BAF5
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5235D1CEEBE;
	Fri, 15 Nov 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3eI1y5N"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B081C75E2
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686354; cv=none; b=pluGmBLACl6QLGTGwTS2DqJHcIRjgY6mrU1HYrJxhEGKT/2IBinhQtnl0InYAkhi8VJK/+KIab7HBUUHoeqid1ZAKS4cVYAFuweSMfOHgTl/i0iYqaghZ0chlsYvnBi5fxQoIaQNM4nlV5tBjvlxuX4zrnrScq2jslCWo/V+JR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686354; c=relaxed/simple;
	bh=AliMht6MUf2kRcQC+r9MBmkYM7mVB19mv+CzjTt4qc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d17Q0tvpu9D6wtxEK549/15mShyj0mvMRZq9ez+KBReqSEoca3a8N8kcaUqanKeF2dabSYOx1tImypuZaKiBS3Qt5Wraeadp4K/R5yd9B29FjQ347m+5E+yRThd88iR+gU8BkLYX/dygMYygfxW821et5M7uTyFumBJZUYP0HG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3eI1y5N; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a097aa3daso2049793e87.1
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731686351; x=1732291151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMfxO2Ju8vEjnQTSKznfl18LDxvCiGquG5jWu4YVQBI=;
        b=S3eI1y5NnEf3Fm71IaxIL+/U75QPem/vapNJk7PYb761MBDTJsWS57bwidyTm3BXCV
         JWFx9dCWk4wJgdxRd1PvX1dX367rAYvPBZ8N1Pe8lG4miGy5wBo9E+eCAEIJegCfB2Zi
         rKk6YqN0mjUxNwa/4oxga/wLPXjIMNQhW0uRpoeNA17fbF6xfmw0+ZGyUlyz3bRxXTFV
         oQX5COoSKcJfZDHiswdXqAaQl6eMQVMxTVKkU2gb7cvFQARBJiC50ePjUPKewLfqzWT6
         MhkF9jpvDD6n46BsH4HZkHmo4p8q3yO6yxXUiBm66xW50n8hcnBCdyzxGZZUoqmU5OZb
         2ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686351; x=1732291151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMfxO2Ju8vEjnQTSKznfl18LDxvCiGquG5jWu4YVQBI=;
        b=GMTvL0HW70fADu59u1krZ2HaCpmwyYW1jjtcOlKX2ZuhgImVd32pHaI8cz1BBwbvc3
         BkSrqm5OM+5Hq4fmaz+MZNBOKXpuTY/rOKvbbrbc8hFRBApVRccaS1h3XwzUxIUE2bF5
         RrfgPO/OFgBxc+MPfMLm9pKu8vvGt0BzAu4N24RWz8g6lx0jjvp2ag4t5xrGMMDmp6Pn
         0D2jdzd8DcV1Tq+XHvDkFzdL+TaJNWOzZeCMYWFB4q+SpoYWF43yszqqICWRtgLt8zUr
         yw/1k8ZIkFCoRK3Fu5z22Smh3O2eWXREl9ZyOzuL2nc2J4B55IGNDhfnLKtj8RoxSqsK
         0SPA==
X-Forwarded-Encrypted: i=1; AJvYcCXJjw8v0zpsSM4U366QNeDrkkLCwNJcHryM5gUOrq3IMS5seN+NzIV8FZxDt6cOV7OycSp1RTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiiTCL64ri536VobbSDTlBOKjuYNLpsop2cBy1fb8aL15uhlN
	tvzPohoLBWKLy2WgsrNOSBllHId3wEHswjiSZ3QfUFncWrbOxf2v+vUNc2PqhFw=
X-Google-Smtp-Source: AGHT+IGM7mU2Z7NRzQuZyYKrHQmac88PdjbXj6OEF7ihDrIv75j0NtxGn8TGk54rYau4nJmsS7JKLw==
X-Received: by 2002:a05:6512:1594:b0:539:93e8:7eca with SMTP id 2adb3069b0e04-53dab2b3c5dmr1925115e87.35.1731686350401;
        Fri, 15 Nov 2024 07:59:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548b79sm615903e87.242.2024.11.15.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:59:08 -0800 (PST)
Date: Fri, 15 Nov 2024 17:59:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] phy: qcom: qmp: Fix NULL pointer dereference for
 USB Uni PHYs
Message-ID: <ibh3n7gl5qcawpiyjgxy2yum6jsmfv5lpfefuun3m2ktldcswl@odhjnmkj5jre>
References: <20241115091545.2358156-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115091545.2358156-1-quic_kriskura@quicinc.com>

On Fri, Nov 15, 2024 at 02:45:45PM +0530, Krishna Kurapati wrote:
> Commit [1] introduced DP support to QMP driver. While doing so, the
> dp and usb configuration structures were added to a combo_phy_cfg
> structure. During probe, the match data is used to parse and identify the
> dp and usb configs separately. While doing so, the usb_cfg variable
> represents the configuration parameters for USB part of the phy (whether
> it is DP-Cobo or Uni). during probe, one corner case of parsing usb_cfg
> for Uni PHYs is left incomplete and it is left as NULL. This NULL variable
> further percolates down to qmp_phy_create() call essentially getting
> de-referenced and causing a crash.

The UNI PHY platforms don't have usb3-phy subnode. As such the usb_cfg
variable should not be used in the for_each_available_child_of_node()
loop.

Please provide details for the platform on which you observe the crash
and the backtrace.

> 
> Subsequently, commit [2] split the driver into multiple files, each
> handling a specific PHY type (USB, DP-Combo, UFS, PCIe). During this
> refactoring, the probing process was modified, and the NULL pointer
> dereference issue no longer showed up.
> 
> [1]: https://lore.kernel.org/all/20200916231202.3637932-8-swboyd@chromium.org/
> [2]: https://lore.kernel.org/all/20220607213203.2819885-1-dmitry.baryshkov@linaro.org/
> 
> Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
> Cc: stable@vger.kernel.org # 5.15.y
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index eef863108bfe..e22ee71aa060 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -5714,6 +5714,8 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  
>  		usb_cfg = combo_cfg->usb_cfg;
>  		cfg = usb_cfg; /* Setup clks and regulators */
> +	} else {
> +		usb_cfg = cfg;
>  	}
>  
>  	/* per PHY serdes; usually located at base address */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

