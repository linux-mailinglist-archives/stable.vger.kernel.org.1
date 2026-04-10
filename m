Return-Path: <stable+bounces-235636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHYxB2Ad2WnVmQgAu9opvQ
	(envelope-from <stable+bounces-235636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B14073D9DC7
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08F6C304C289
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C33DB62D;
	Fri, 10 Apr 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJbUy9Dp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178593D411F
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835205; cv=none; b=hQHbR8PGBeQe+LlsW3OG2miUZONyLcnxruKZ0gkEUHTWVzacbc7ob01UBpjmJ2gVFx8l6n+sLLbD3YFkyeYezi5VHjvcqcm+8FbUsuxP16hBFfubuw/IZgzbXc96kY/lXMuZA2QYivioxX/896mPYi/A+LEBQrhRHFWsqYIh8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835205; c=relaxed/simple;
	bh=ZZC/7pTR8Z+M22c09b+belFKQ8vblnXKj0LhFjGY9RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPZHD2RlCg4xiIoQ5T/uE/obSelWIdjBuBNnavHpbW6VJPwJxHVC219eslrQo7d0KC0RXRuiT8G27m7DD3i4nq4ukEGakWMnS5IB0jDNPLwQ5yGSrHeN1Cmfhpt6RTnUln3hPlvWE7yWu78fOukuLeAP1nI7izt0+3xSE/DiL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJbUy9Dp; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12713e56abdso1472232c88.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835203; x=1776440003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWET2ruDlUVRXbekIo0f8Ls4HuM1RWM1Huitb0VTboQ=;
        b=KJbUy9Dph55REDZ1FRu72OqpvDswTljW/TJNVHaN3B3xDAwoSIK0nu9HxHQVF83hDI
         n+sAz7pE/ayC1HdcylhLAO8ZAS3Xiq+pO+GSN4l7hQLKwYoxlyviQ1YujDMsBAKiY4JI
         9UIGYI59s2EN5LgHdaxMXPET6hsTtZ6MebaRiSC07X+KTj07FGR633kMfBLa967V3rYp
         PU9gYGXxYqz36QbSVygufY/ul9m0niq27QPKH/8gluu+/mjesh/bzc2+QcVBH29RNn0j
         0Je7jhkJ19teX8kGDKm6oB0/gv3nTEPrzTV/klHtwGHGfTxkaFXDX3RbBjZvchqm9P8i
         t0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835203; x=1776440003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWET2ruDlUVRXbekIo0f8Ls4HuM1RWM1Huitb0VTboQ=;
        b=iw4EMApo3ztThmhGxjCWIIOvdrXN/0TjwvTMCnHLODjjAXPmJB4Rs2yAH7CUubtlkR
         zPxI6CMOD033639FF9cco0Qp9NnUcSE8T10jvY2aNydtu3FEOiJSveArtahZ5kQUKXDt
         sVVsVKaASxMGRxPFqXrLWu9oe5MmNtkGXnlrp/+QlyW+M+/uR2tRaFeTKtghhG/0kQOk
         7EKoPCZRH0QLus9Ad2naEGCgTXocwlETG8MHOgexQk4A/QTvqAOF0Hgej4f+uHPuIdzt
         PPDy1pgHX04QK3fVbvGPQZshzJ1zVFLToPI4mFIrlvXzKbeCTZqDxtrZf+l41dgQN9rk
         BIbg==
X-Forwarded-Encrypted: i=1; AJvYcCW3FzkwlMaL+EqaGvFeLxhvSyFhke1NtdXuC8pQuAxUfFcxdeHeau9ui8ZIAsQaI5qApKtUIDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+sIcgsJRh2mAL2fdHyMfKjevxl8MgvckrAeLkbDvMMMEEiXLx
	mL6uOTnqXhw/wya13qFLTVMHdZuS/adYaM8UTaZJWlhT3lRhDZM2sp0Q
X-Gm-Gg: AeBDieui5wW2KexD+k0tDV+ShsYMx5DH6+jBW1/HLKe+j2qtIjs//zQtNk2H5tWGO+v
	vbBEShWyRJUFhvz0noQiqjIcvbw6UMF7vXhakgGh16DUjpOvVuaNPIrGK0ryX7Z+9lzFZ33Y0Bn
	q5rmxBM0PwBkI5RsZQbQNC9NzLFurGG4XeRNO5EJUGv8C+Kc3YBq4fmLF9Db+s49IpjPPdj7z9S
	CyURwLxkk+QEWrPpYRG5UDmejd/8rQZ+OtByPgvJRcLGmxng0ACrblkXNfz6jHuqyfQElNFyvOb
	EvtPixqFVKx8PdPmh6/sC5PLUurKGAYrq81wbuGQX7wibX0CjTicazBGioGZRNoee009Ft6Mg90
	OGn1r+AQ4tjnSy9UTBpxrEc0Lzw96xBqpSyImBfkrzK6cfE6vmXMddLc3nAhLLnJfrHuBnOosqk
	Nlk+KMPgcE54l4mT/GPR7wTNHz1xpiLsQB/Odyy5zUWDJtmDA=
X-Received: by 2002:a05:7022:2393:b0:123:2de5:346e with SMTP id a92af1059eb24-12c351300a7mr1590257c88.0.1775835203147;
        Fri, 10 Apr 2026 08:33:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm3699164c88.0.2026.04.10.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:33:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 08:33:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (powerz) Avoid cacheline sharing for DMA buffer
Message-ID: <7e05f89e-b719-4ba8-bbec-7f9cbfd51909@roeck-us.net>
References: <20260408-powerz-cacheline-alias-v1-1-1254891be0dd@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408-powerz-cacheline-alias-v1-1-1254891be0dd@weissschuh.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235636-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,weissschuh.net:email,roeck-us.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B14073D9DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:45:50PM +0200, Thomas Weiﬂschuh wrote:
> Depending on the architecture the transfer buffer may share a cacheline
> with the following mutex. As the buffer may be used for DMA, that is
> problematic.
> 
> Use the high-level DMA helpers to make sure that cacheline sharing can
> not happen.
> 
> Also drop the comment, as the helpers are documentation enough.
> 
> https://sashiko.dev/#/message/20260408175814.934BFC19421%40smtp.kernel.org
> 
> Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
> Cc: stable@vger.kernel.org # ca085faabb42: dma-mapping: add __dma_from_device_group_begin()/end()
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Thanks,
Guenter

