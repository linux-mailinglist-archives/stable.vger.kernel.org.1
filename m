Return-Path: <stable+bounces-70144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA795EBFB
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820AF1F20F66
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 08:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73090145A16;
	Mon, 26 Aug 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpLOR8Za"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3660142E67
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660894; cv=none; b=cMvtyWaJeNhPKl5F9XolIAjSLZHw8YTBzzygbH087SxFkIfmlTGy35QDiwpuhCGLLMrUVmyAj/dOjufFzWLtdHISiD1gazRkgkjSXzbq3m1VRwuI+kHOFqukRrr3gaYMZNzzALwJIZSAKNio52zmY3tZrSrAv3kmaHiBbEBid/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660894; c=relaxed/simple;
	bh=vt7J5fux2isI7FeeCpAPhtTik4aGVuoRkW0tWzHij04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP7C4TQ7zsU78UfOndAJMN2dRG/Vrg/3sP+J+pvGJ3kUmhie6r/+h8sye4MACJwSa17+MBDRldkioIUhH5h4UWNBmhLsQ8rk1xASs6mKcvJ30b1HCn58Chsp2+V9mRdnmUc0qPJx5iYvxJV0aOJ1AcYwO7ht/OiIQIUNPxfbnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BpLOR8Za; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201cd78c6a3so27166295ad.1
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724660892; x=1725265692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnSngmqp5XPF4Gq535As1t8mXzDMy72BxOhWXC2WS8g=;
        b=BpLOR8ZaKnca/dn97+srT6gkQvO2XtN/5geKwab6kSOi1dRDDZPXM+RFtZQaUZa1/b
         SQ0GwGu6HtqlimC6FusTEqaV0ongKpep0aEZo3zAxLNLRO4jmWRpFMGRijOXU5g6trm8
         kK5DwZsnW5acfs6wBv5XXPAutdN3i0PPZlF1daMkNSoQVC4QKD7Ymz/AUzu0PeCML2vE
         E9FTRbzrhs1BySbrY8rLFDTbN/7z5ig3EDvfsNqt/F/eg+0+/Djh2e8PJUDVefjWdGgN
         PYV1fs/7toLoKi9+7jwpQT9C28PwrBzXobPBckdg5cbB0+Z60UBTd1M2eAbowSbheGjJ
         InlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660892; x=1725265692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnSngmqp5XPF4Gq535As1t8mXzDMy72BxOhWXC2WS8g=;
        b=czZTcuLm4ysKHCRhqIUlJSWv3nd03kXcOPdjl1AewrdkFkDu4SaY+nz7ZU8ee3uQGN
         gCrdKEMGQ/eDUlOjSQmbFd9iDVV3V2WKEh5aa1koIIYWC5w9lJnGu2yZR9zWatsgsIgW
         4+nTV1pbnzvUntXw8obtFuiurIIKuUtPTESY77bRkKjmmu7j35bVjLmUgj+/mNdfAXhn
         ogRuxPkYYEfofPO4VZo6mOQNya4LU8vUPANM7JMpYFiZItN1LfOHH6E0bKFx6rPM4jdZ
         xNxTCFbM9L6UCYHvlKa7RYnpCCqbyrU36kYcM24m9FALLBobYWV7PmTJlhbLDgQ15bWY
         8bEw==
X-Forwarded-Encrypted: i=1; AJvYcCXYCm8ibciAtJhLyE0HDKWE2PRK2tJlmgN4TljJrgDCncLu5AuWdbAegGJzcnetGyPCnw7+tyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhb5OUp5VNjxh3Fdz8w72yI+VMMYZF4xueX221KUbn/49Dq8X
	F1P1DJXZiYyHsk5szntq9A+c425FuoWacJ1CdRINJ3zuSVWBwvk06O53Qo/REQ==
X-Google-Smtp-Source: AGHT+IF4dF7YIx5UOBAuR3Levd85eEDnPi0e521uYSc593XVFS3WuJodpsylh0iqMs4OnqtH2tw+Tg==
X-Received: by 2002:a17:903:22c7:b0:203:a030:d0a1 with SMTP id d9443c01a7336-203a030df42mr113206305ad.58.1724660891917;
        Mon, 26 Aug 2024 01:28:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560e53dsm63489725ad.191.2024.08.26.01.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:28:11 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:58:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Daniele Palmas <dnlplm@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Fix the name for the Telit
 FE990A
Message-ID: <20240826082808.gnsrbjfxvpqqi3fo@thinkpad>
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

Applied to mhi-next!

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

