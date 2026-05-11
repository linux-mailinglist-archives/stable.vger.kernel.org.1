Return-Path: <stable+bounces-245229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCh4MJLiAWq1lwEAu9opvQ
	(envelope-from <stable+bounces-245229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:07:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2479D50FAE7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613DD3016506
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195D3FB069;
	Mon, 11 May 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MphwHYF7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB863FA5FE
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508268; cv=none; b=p9nVVR7SsqLrEG8iDSkTqnXEIDwXBaeNO5xMc9iqTBhQxrASfl4bg8moAI6yP7gHtRAHOa3HY7xImmzVpF+FzI8uc4Gd8Kq0qNruFO/McA3NQXFUXW7EyQivGeK/nNEp2xELpRpYweULNaHBVfEwmBBqsg6m12KGieonp2RA9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508268; c=relaxed/simple;
	bh=AX1Zk6/eGznmnS4ph6+vfj8Fy71FvHX/m4IeROCTXqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR3Be9IEG4/i/KwrpK5eRmzqo4w/3/YkjYS+JuB5Yj5E+XtqIW0QNGFeWdxrDYmiJc81ZtC3Wz4DzBgQ9Bw2g0jUKAAf7OnBSUbnhCJnahYj/oMVFD0J7mGG0MsP0v+xQNZ/MEL9zwPhYyIgz5n0X9ATnw3EbSEcDpj958AMbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MphwHYF7; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1329507c387so7380313c88.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508264; x=1779113064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH3rO19odGUqCMhpZ/xU1p2BIeedWHGic3C9w+3oAVE=;
        b=MphwHYF7uBMd+p+rzVYJy9D+8E6+PWaXIzU6nTp/aUDak5+NqH9BW/FQ6gzMw6H9hv
         kiyvCnMThls2kHT1UX67ugnzVyilB7FZYUF1fjiimvyg9xsJjlMxHnxThvP9pj7FWXZB
         jtuagVvfhC06O6VIsk9m6Z1v4x9jnxXTHoG26Nt1+RSL66cSjCrohW5AWDODyl6kDHfV
         cwgvMv5JAZ5Q/MXpmwzE7KUw1DdQ2Zj0rUaQA5fqoq7FSyQtgrh9DFdmPC7UbgYP3LrM
         KXaC49VxDM2BjOtfF/aPAO2k0Lo1KSpEVloL/xu+YS8BiTFRGLGnYTQoKxre7b+3eCpn
         ccjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508264; x=1779113064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iH3rO19odGUqCMhpZ/xU1p2BIeedWHGic3C9w+3oAVE=;
        b=Aki/2mHaAUhoo6uZx/muRzLIrktRgDGfIoE3ttPY4m56QkT7CX4lTsRiU6nB300j1G
         n6vkLrN41r+1wXfYNrAa/TCECJYuJ48j9SbYZx9q2EuPQcz0W9e8cCu0W9Qa4IADeJc+
         Qc71wNBBjwIireEl20wSWVMdKpm0Wc6VCgzacgJibDzgXTQ0AUm3jVX9G5S+Qtw1YGJV
         UieN10hVfeyjV2AjvmYVVD260G06VUP9z8w+fmpEbe4LFHHeEO5YU/CRhvK9sITki2ec
         ee3i4nsV3jUK1eHOS2JLImz54ivL/sXnL3o9BvOMpQSFxp49ZLjtQ63xYdwdInBvs+zg
         kJwg==
X-Forwarded-Encrypted: i=1; AFNElJ/GlHpl8jSijczWr4IB+BItkTGokRe9Wlwl4hPzoTGwjLe4YiU/HwDkW7do1GesL6lJmMU9Oso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQme21jYA4FAiqNJpTYBPQxWJXib9yF3U86notqkutXSNNXcH6
	QbVNQWB8QBIwXdEGDoDY3pFwA02kjBwCNEtUymXu3fLr9q4I5he49VzdKh+LTg==
X-Gm-Gg: Acq92OGVCywy7RmrEcol2vedOKa31w//Yg4IiHaNeWYVCcRPRnxp0h4A0kqq6Pr8Th6
	oNUCIrsRYLY6ETLIsWccbP8AIcb2yzzPBo2p8HyIVeIZQvZ1XwqW2zsInvxX9nmZQBi2QZ3Uld8
	Y27QAVSdX7NGMJAzPOc0V6i9r05r8sa73ZaFpP2Sw2P9ApbJT2dN5ch4QjZdovYg/23Sc1aHrEe
	PCZZiqDsnveo57Tu6EMUrgDYYVXQ1mvO8/9rWrSqc6wS+ytlX+KJ3Gr4ZypHLTzgXskkTHAo4lY
	ELD8eFO6dqsVDY1Ra+PMAIsvq5nAZEw9JIT0R1SnQLL22HlR5HtM9De2u0oQnBDvjrNe122ddvJ
	8LLl5FzWkhh5dhGajd42mDNtiN+S7Ig2q6OGvK7yOTUjarASiOJH5lKJjmlTdQKtfirzEzjgytm
	OJSAbjaBMdy3ubpAUYj1QlLEszDhMS26l0uMND
X-Received: by 2002:a05:7022:ea22:b0:12d:de3f:d844 with SMTP id a92af1059eb24-1319ce5634cmr12752150c88.39.1778508262863;
        Mon, 11 May 2026 07:04:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865955fsm18373850c88.11.2026.05.11.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:04:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 May 2026 07:04:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
Message-ID: <87766879-ca5e-44cc-a341-87b2afa70910@roeck-us.net>
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
X-Rspamd-Queue-Id: 2479D50FAE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-245229-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gompa.dev:email,jannau.net:email,roeck-us.net:mid]
X-Rspamd-Action: no action

On Wed, Dec 31, 2025 at 01:07:21PM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,wdt" anymore [1]. Use
> "apple,t8103-wdt" as base compatible as it is the SoC the driver and
> bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> Fixes: 4ed224aeaf66 ("watchdog: Add Apple SoC watchdog driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Applied to my hwmon-next branch.

Thanks,
Guenter

> ---
> This is split off from the v1 series adding Apple M2 Pro/Max/Ultra
> device trees in [2].
> 
> 2: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net
> ---
>  drivers/watchdog/apple_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251231-watchdog-apple-t8103-base-compat-8a623e9831b6
> 
> Best regards,
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

