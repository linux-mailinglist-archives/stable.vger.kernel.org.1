Return-Path: <stable+bounces-70142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D037495EB65
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D741F21261
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1ED12C465;
	Mon, 26 Aug 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGhkX/41"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C78837
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659655; cv=none; b=LZALOByM9yA26Qhy0Dbd8RbMkfsnovU88zDR+x+iJaidY4r2kcbY6JH9FEhodNzRASrJWG8tkogSwA0UBaRZcRjFmnt3FUDIlBOvP32oaMSF1Tp/IYIC7hR8o0CTiIOUoOJVrHt7BxuxMb6v+w8xK/6OleYqx/ZsbZn0gCXlC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659655; c=relaxed/simple;
	bh=hV7TuaBbJxdh8PMDEbM6FyaOUO1HfxZZRMdSrK8OE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRg208+J1aUVy7y/swzTU9uTVEZXUnRRu8ep1N2RwhD/4UqM5oPzzNpQFzglZM2joZ1IodoWepEmBbViYhbU5rB07HsiYPY3F49LiCTPi+zKIiZKjv0jOXcBJnice0ERf+xYTx802vVtvL/g+N1fCntxjtn247+4jo4PxWRjivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGhkX/41; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c9a67eaeso2834322a91.2
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724659653; x=1725264453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvPqTM9lOHuvyIm7/RZh/RxFxg0X7bP4l3quDfoGQkE=;
        b=mGhkX/41zpNBPhM4n3N6tSnwSYIJ9AnNlHHW9d4QKj0WsmQjdaP3XK6Duf2j4MiAEt
         OJ6LeCMg63DuXUpn2JGsqPHUw1wfoyD0U2PQwyK25QT14nwvKdKfjsXvcrnNJ32Dl8Bt
         byQGbhHsq/gcV5FpSaQl1MIz40bjgyZYxD2XXllPZ4aDE7txQyALd/ejJ3SptRntF+g9
         FCU73xOR80nDekvOFMPlqm64+jYzoZF/GzSs2xdV5237vOKbSqgbjNwemLtCEPJST5QD
         9yCObn6lUYYB5YdXKyJNGaT6qY+UFhY4wpf/Y5ISQ9ebXR/p6ZA8NgJkMi7vNbhR6mVv
         AHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724659653; x=1725264453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvPqTM9lOHuvyIm7/RZh/RxFxg0X7bP4l3quDfoGQkE=;
        b=nozCC1c4hsHiTS19YLrM+PCKpWQYVN5myFXehQL7DQgmgaClCDhpPC8mQhOk5fkiuf
         Fg8V4rY87RAe1NpO2ikXEI4yr7hNRytlOHomRwsVeljtH+gX8Jf1X1m0X6Z86V0qVEfc
         d33h3CsVGts5ibp4K/zeZ2GxwciT0UMDR5sNIX7hUrsc+VU0g6/Qps+3vk1ZTW0Bpu3I
         S/Xub1SENYs04amDCA8YVQJFweBL834T0W94ff8N7turfHFg1qOJ1dS7dNZcK8Ab1qXk
         Tv7oFdWDGX/rv2dhe5H7Bqd0RBkqwqc558RWGGsA0VAxJg6gVAnKSBrX1K5BtfP+Iw0R
         tHlw==
X-Forwarded-Encrypted: i=1; AJvYcCWn2iEQqJbbyDYgN6hhnHV82WFqQVGbQ8/iena9jpiiqoRo1OYeAYkHa+0KhVB9tnKuHLG/DEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvX+ljM4jydJ6ktLq5mk9D8VyGYKzSG8+Qy0gat1yLj477ZBZ+
	QQaDLG3Q4kMdHQUqkK2UY36R1WA9NrM45uOj57RYu9b7sX2d/lvuWUWeAZnjCw==
X-Google-Smtp-Source: AGHT+IFX23Te10Zeki5eDRR2JQF2WuxBqrUSKbBm0Dtnccf1x4S1ehHPRhh557+EAHWGUsykWovd3Q==
X-Received: by 2002:a17:90b:4f83:b0:2c9:80fd:a111 with SMTP id 98e67ed59e1d1-2d646bf2bd3mr8610579a91.18.1724659652847;
        Mon, 26 Aug 2024 01:07:32 -0700 (PDT)
Received: from thinkpad ([220.158.156.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b1cc67sm9071887a91.51.2024.08.26.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:07:32 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:37:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Daniele Palmas <dnlplm@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Fix the name for the Telit
 FE990A
Message-ID: <20240826080728.myy5whs5kmghnvvo@thinkpad>
References: <20240820080439.837666-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820080439.837666-1-fabio.porcedda@gmail.com>

On Tue, Aug 20, 2024 at 10:04:39AM +0200, Fabio Porcedda wrote:
> Add a mhi_pci_dev_info struct specific for the Telit FE990A modem in
> order to use the correct product name.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: 0724869ede9c ("bus: mhi: host: pci_generic: add support for Telit FE990 modem")
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 14a11880bcea..fb701c67f763 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -680,6 +680,15 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
>  	.mru_default = 32768,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_telit_fe990a_info = {
> +	.name = "telit-fe990a",
> +	.config = &modem_telit_fn990_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.sideband_wake = false,
> +	.mru_default = 32768,
> +};
> +
>  /* Keep the list sorted based on the PID. New VID should be added as the last entry */
>  static const struct pci_device_id mhi_pci_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> @@ -697,9 +706,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* Telit FN990 */
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> -	/* Telit FE990 */
> +	/* Telit FE990A */
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2015),
> -		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> +		.driver_data = (kernel_ulong_t) &mhi_telit_fe990a_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
> -- 
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்

