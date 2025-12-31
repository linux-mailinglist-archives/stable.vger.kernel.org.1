Return-Path: <stable+bounces-204348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6605CEC149
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D856F300EA2C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F6266576;
	Wed, 31 Dec 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzgwFsgr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2A2222BF
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191300; cv=none; b=RXxZ8CiMCsu7WA6fKoW1VD4RZ8RGPlYv/8eM5KTbfRe6mVuGWOkx6g4DsbkYfXECrRFboQStqGU/Egao9GePiW2Qu44FycxuPp7QrwsdNlcIUNPBlwBizrhVUIAEv/oXRAp8qP+qHrQ62bS8S0FIbGtph8RXk4kKUxEzKXnqe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191300; c=relaxed/simple;
	bh=2eFuPTdKA5XuNm5nzNn9/WiAWLq+5UoOPb5Um71Qgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcznJN00cyz7z1oTbH1Wo7M7xtLsGPvRToHmbR/rrL03TmhlDOiyKwu5FGLE2Jiqj/Cq1XG/WK/GlgyshT8WAUa7QvWQD2+QmCyjmxxxo2+mqjBeZsbr6f+YYBu1a3c8p/pUrsT0kR0gix5JZKwi1Tc9E8uBdjwCeMNdm1AqK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzgwFsgr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso113164035ad.1
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767191298; x=1767796098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMV6DeeoDol5vW6Ifpd5XnY16YMsP6em2WlQ7TohT2g=;
        b=CzgwFsgrktAgAZep2PSUtCdm5nfN5f/CUJkJB/asxoMiWkaOPkaN0ug19ycxVChwYE
         LdGeNo698x3oeIRZP3oVru7OYSWgrEcYj46oyMuJ0gU97PEck02V6ifDQ/simNAjylns
         jmzZgiNUBWa3HLOW6kChIkK9KCXFlFM4t6Ncxg7xC/un++0m9E5lqx6H5E7zxQDphCeE
         I1vMkaT5OFgD+cd8LUIsLK8AvCmmfpV03Go5+1JMR/WXOfJMV1Q5LuK6xt3P5KeJYE81
         MpCBF9Gp1Wg0yr4ojRObDhJsu46tZT6CG9dUPzMyaI5b+Q3gkEN54sdkL9I27XwaONgH
         dyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767191298; x=1767796098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMV6DeeoDol5vW6Ifpd5XnY16YMsP6em2WlQ7TohT2g=;
        b=DE7Akuf42QCYSfSXNl5B69WgTXRFapuV49ajxNN1Fi5TueYHRcu6hW4bi0mnbTUF9D
         QKISV/vBQ0HVSuwPz8SgcU2i7oDBcBMT8vcp12tyNWIF0H1CbHqeQMsGixWRE3oR/kNQ
         F18x2cwJH+qf8KTxz4IVe66BZW5Nnyek9ouU1e3R+ZBtHeWx7lJNqXPzouJhar+wS5cw
         QtetRf0N02MS1yZbjJ29EQGvpbq7GtIndlR27l5tQmXJLCgsUMjFPfi6ZR/bh5LuB5/q
         6pTh0iMTM+HH5gLc1CpJWJOoFh4So7ULjUuN7Y9k0MEqZ4AKmrLzbLSlcS9eTjkW2RlJ
         2egw==
X-Forwarded-Encrypted: i=1; AJvYcCVcFEJqYUx/qmR2ZxX6FGuPtjieh9/Pq3eSr3GDRyJB+cKTou/BtF7TfTKW2p0duEvTrY/Xq2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4rDyr2YkATnJzPfCmArQPaod9i59tsJRZHUxSePwV2/d+z7D
	GvGYqU4tkfzIi+KeusdOcbcogH02LrDuU1Auz7Nh5XmVMRuR00kIcnDt
X-Gm-Gg: AY/fxX6iND8pb6PblF5o6p84WWPmhDjvNTWv+xb1pIFCN5Kx/NISlwaQ41MOVGC6TCX
	j0Mihg+UssqJxT4Q1RIYWLYGWDBG0KsNLRRIVHP0fz0pdWspTaxvZOJkMWDXqpfafcS92u+EPZS
	46NE0EWN7f0IXtpxnHF2SdevjJu33cOpEh9vCr4zjgpaYHxJO6if1P6F8Odc2kKtb37Q2IkLbB5
	aHuNO0rz4RbNEcyS1mC609bBt5OnqoseSTzsTt+2JR3fi3JXMso2N9Nfu0sZ2FL1w8Eynt2M4G3
	sHSfoU6l/QOBh1f+ab9dCHE30P0/s9TdfPLp7yUE+kXa138dmn3LOc9qkHlPVa4+g/prCfQxP28
	xZ0obKsiIEXRvaH63vLURImz62dYshA9FjkHC2wddBfJdpjsXysvlbdZ55kfWddeT26acnI28Qb
	0rZBk8nIfJYqBM3PaGe5FDMsXc
X-Google-Smtp-Source: AGHT+IHT1LbcUINYNqMyB9CX8YBrFNHzxw864OFLPJDnx9s6IC7xwrB55T2EWxDGNkf6J10kosGXXw==
X-Received: by 2002:a05:7022:f698:b0:11d:bea3:c93d with SMTP id a92af1059eb24-121722eba22mr29428274c88.29.1767191298434;
        Wed, 31 Dec 2025 06:28:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm135194664c88.15.2025.12.31.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:28:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Dec 2025 06:28:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
Message-ID: <68e8bd60-85b1-4b4a-8a82-f47640ad0ad9@roeck-us.net>
References: <20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net>

On Wed, Dec 31, 2025 at 01:07:21PM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,wdt" anymore [1]. Use
> "apple,t8103-wdt" as base compatible as it is the SoC the driver and
> bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
I don't understand the rationake from the reference. This patch will need
an Ack from a DT maintainer.

Thanks,
Guenter

> Fixes: 4ed224aeaf66 ("watchdog: Add Apple SoC watchdog driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> This is split off from the v1 series adding Apple M2 Pro/Max/Ultra
> device trees in [2].
> 
> 2: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net
> ---
>  drivers/watchdog/apple_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index 66a158f67a712bbed394d660071e02140e66c2e5..6b9b0f9b05cedfd7fc5d0d79ba19ab356dc2a080 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -218,6 +218,7 @@ static int apple_wdt_suspend(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
>  
>  static const struct of_device_id apple_wdt_of_match[] = {
> +	{ .compatible = "apple,t8103-wdt" },
>  	{ .compatible = "apple,wdt" },
>  	{},
>  };
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251231-watchdog-apple-t8103-base-compat-8a623e9831b6
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 

