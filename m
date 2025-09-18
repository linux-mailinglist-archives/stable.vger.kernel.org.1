Return-Path: <stable+bounces-180553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79095B85B58
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAA43B0E4A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C1313E1B;
	Thu, 18 Sep 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+NQbqf2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6E31065D
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209925; cv=none; b=ZoLMa6XxAmRaIEPUDbG/cRwIBRjAIfcKS7sOS9Hyspr0d9C/NJg8S8nBrDfYkSUeg7Qc4iZ2EQzs5AbHy25zLbR36YaPQPq9eU2ec2WoKmul/Pcph169I5VdVC2nb74inZrxAOKtImdZphKlBcb0oY3ggZX60pIH+9nRhBr69hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209925; c=relaxed/simple;
	bh=WXZzoEkr5HMQOA3/Bzjsdzdf1qJeWiNkpcYemh5e3Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F30PYflsnLUxWUc/WyhVHmPr/b7lEdd53dY9XK6JdcAW5kdVFEqncsRSvwQfkuZjdtuIYhz4Jf6E2t67RyxU02fgMPQNf/bmH6RYYYll9HWT7KktP5VsCbtqYoZ9Gi60kOvts4wFnayHYoGwtcXD/wFo6AL1gBdCedBf8h0NmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+NQbqf2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso1291277e87.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758209922; x=1758814722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uU1Yqis+8TjWDixzlQWTPOERfCi/hGhUBKZOoxLfOA=;
        b=O+NQbqf2YVFVjjRoQoT4JMuMM7ya14jitHasgd7TTI2shbA83BRnpd9nF3NLGw4irk
         lnYdF/AznE1ACaoZCSuvSCV80vVb/TKqvrZoCQM7BwL/LnhwQmptvMnlnQhLWPRtoyWs
         iB3GJmHGh/J7oRD1C0DCGgk7Gt/CypHpUJCzvtk5zrlve+dGyOrNIaEtHS/aWxFSUpfd
         4i5iMsl9iWSqtpyp5s7aU7hFZ37CcQmfIaT07XVpOl7JoNM/wA8xI3fv/ZqrQp0S8w/E
         R8Cphnr5n0mzzWkDrdaHlqlLbECXAEK94Dn75qpGnqh6xeQVY4sbpagcndtbmEvOeK+4
         h24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209922; x=1758814722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uU1Yqis+8TjWDixzlQWTPOERfCi/hGhUBKZOoxLfOA=;
        b=MT0qYEJ0QQD7swL9Y6ZexZxlrkW1wXhuoDetMLJiNGYxKckzdxcyc8Em5Wt+nYkmvv
         ks6pY11UhoSwo9+2JEc+iFGV1rPAYvAt2vqtiwpFddkjsv30WY3M9TKP8m77DF8IU1wt
         +uttEISHAbMhoemEE4wYuVXaqge0/kJc8Q9JIPlJrjP8WPf8gxiMQzQIgMG6Oe4YnM8r
         p8LpOZerlVjg0nSPrXDlfPDOPbmzCOFoxxrjbi8vcRORUIgas9rV7BH7sG5lg/fyNsg4
         //vjCyLF2MRE95VwXr1sd9jO9c7ktPW/H581QWIyEZj5AAQIr082nlq5gsrCgMtWmKIN
         w/Og==
X-Forwarded-Encrypted: i=1; AJvYcCU4Msi9fWZdVgSxm26KYxpoQN/21xaeTZzVXdt8m66m6x58SXCfimso/SowLOQYqinrjXfRGYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2AtHGwbYl4iJpo8krLkbyB7ph2Rj4T4S2zXwGjRVxvPwMCpr
	O13fCcFaKwDVftuUG5SFYp0vzj0pRq5fRXrVUYw4kdaaEEAB/xmIC5Zr
X-Gm-Gg: ASbGncuXL6KkkHrFpe0PZmXtn7ErXH8wTEnCX0X8OJ7ECbNh8FfOkxOzwP1fTxBRtCW
	WN7xlKYW0NEZqfpLVb/tSZPm14yuA2cHgrgBCLjhMgKS0NwCmgjg2i6NM0X0MlNmYRgMN1mIHDX
	boCez9tQ/ctMDZmv4L7lzYsjVnJxJsH1RGvI7h9HkUpeISBWVyphvNRBTp9GbAFoE2Kry0QaOVx
	p5FKCWUuH+IageRX9+vuxa/AW3TB5lYyHk2Ef7NMTlj7CB8MraE2+I4yifUyZYDeiU9r061qTlZ
	vTvjX+3P2l/R3Kn3yTEtJWtaXSyj+71EcAYBVl/iXr6UOSkISjZ2khi4jTGaghiHSstdCFAUrTM
	EdsuuGsqdUwSTOC56l7FpNlSSAydrm2vFO1GB/Vt5Xe2defn7tiDABQ==
X-Google-Smtp-Source: AGHT+IGPk7ZNmXlXU2ixuYtToZHIHGFguajk9+7DwOwXUT5jca2TARiZv+la7RKAwfynRhSAjFV3bQ==
X-Received: by 2002:a19:6a12:0:b0:573:68fd:7ad2 with SMTP id 2adb3069b0e04-579e2131278mr36626e87.35.1758209921620;
        Thu, 18 Sep 2025 08:38:41 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a90a20e8sm733118e87.76.2025.09.18.08.38.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Sep 2025 08:38:41 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:38:36 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <20250918173836.0def4d12.michal.pecio@gmail.com>
In-Reply-To: <20250918130838.3551270-1-lgs201920130244@gmail.com>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 21:08:38 +0800, Guangshuo Li wrote:
> kcalloc_node() may fail. When the interrupter array allocation returns
> NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
> and in cleanup paths), leading to a potential NULL pointer dereference.
> 
> Check the allocation and bail out to the existing fail path to avoid
> the NULL dereference.
> 
> Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/usb/host/xhci-mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d698095fc88d..da257856e864 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>  		       "Allocating primary event ring");
>  	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
>  					  flags, dev_to_node(dev));
> -
> +	if (!xhci->interrupters)
> +		goto fail;

This is a patch against some old kernel, this exact check has been
added in v6.16 by 83d98dea48eb6.

But it's missing Fixes and Cc:stable, so 6.6 and 6.12 were left broken.

>  	ir = xhci_alloc_interrupter(xhci, 0, flags);
>  	if (!ir)
>  		goto fail;
> -- 
> 2.43.0
> 

