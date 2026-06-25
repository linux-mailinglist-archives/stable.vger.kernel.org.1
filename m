Return-Path: <stable+bounces-268311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eja/KRLwPGq7uggAu9opvQ
	(envelope-from <stable+bounces-268311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3516C4157
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:08:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NSXfHDJp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268311-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268311-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8880930C5885
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36104376490;
	Thu, 25 Jun 2026 09:04:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54D36828B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:04:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378283; cv=none; b=Nxa9a2eqshy6sFme/x8KMN2eNTHSHquJtltfVuT3gVuHcrUxiJwTWpbmDQOUG6znMJhHQKuTPi9XaHEofHtzkn2cdlp3nDvlyoCq2mebG3XH5v6xk2YW7gj8qVox04Kr3YZ86MvNsxcHSIyWp0NnkGJjvxgeDO4p1FttrlrQ/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378283; c=relaxed/simple;
	bh=Fxdlux4xKPEUY23/deSXomK7ZVU4GMGdOEjfBvmQcWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cANYmmJaUsNaydD5i1cRSLgy+/BhQY4p3FezHyvEbL8aS08d7gqKzUkgWXjrxhbWgET24KTkOhYXTjuDlXOndJcR0xo48LhXYAa35Qa+/VGkqUgfGaK54tVxaI2p3vvfMubovQZmp8SrC1ecIdQ47AaGwOQnbtYKnaFJrR1akr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSXfHDJp; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46e22950091so116227f8f.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378279; x=1782983079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twZyJNe4oKAUakpXmtBipZs2eMFjp62u4eaHu+ufJQQ=;
        b=NSXfHDJp0lc0BwkOvBFnLVC7Xd+dwmRK5UYLfeHXolOjGYZ329uok3SZZXMe9zSLj5
         DNGCxkW+Yue98Amaj6cydaZJaSqeKsyV7o2/3liNkFCC/e/DxjlSAyphYoaW6nuqRPdq
         BT24aN5ekHpGV+Dmk/FqHvgRgEWDzVtMyRzjwd3Sp63fBXRS02mES1W0xebBBY4nQ1A6
         ATYU8eKNmq/7VgXfZnqKKZaYZyIxsRMORi8aNznpHQJy3tsv5HpBUoFyqKiOgDiv0cOt
         qJBAFTq25JucCO1YqBAIdJGipY8BpDbozBOIOYGWApFcfENY3S4Z4sywhN0ddhBfqJtv
         ySYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378279; x=1782983079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twZyJNe4oKAUakpXmtBipZs2eMFjp62u4eaHu+ufJQQ=;
        b=hQnQFDcvW1/1vF/NqtGC26SmrYAQQgsWq6C2CBXdty5vfIsLKJPNuGSHSwwbfZhr1/
         mhl/UrBm4f71m9jH3WC6rSvi68dLyxm/W06WISpcsbyZxksQYrTxF+yvF3MBIXfw7dza
         we7V5Op0fWzDpSyDNyPnqNnneS+H8Ajzr6ejkJDzC39Jzf3zsgka/inq6qs73loGitKz
         HvTk5L7RCQ+dC2TxG9zjxxKwUzNaI0W8UB3sM4BDGOXzbUlOl84aT+pzu6bHljHF2nl8
         9svuknKl/oqr/iqFga4pSquR0qKRfNgLcHN0m+/3M/QxLroqMqNAHtFsG6hsbPoGP361
         NrQg==
X-Forwarded-Encrypted: i=1; AFNElJ/K3oRdpZc3SXreytB3lunrtM88cxeMRs5TaCPi8R2ktv6X8PW6lGHMAApnk+xB0BQk/Ze/KqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFXRN6kF8TewE6xrjrKQDNbsATh5W9EZDy9/TyXTxpg55liKo
	amSbtbAlCTDUhpWjBZjMOVhJ9fpCjFKH3Jey03a4QBVUD+vzJcUP1yli
X-Gm-Gg: AfdE7cl1I8w/jBBR6ebkE9bSTE5wSos+zBkuwiaIxogLW3XZxV1oAJJFZFwNnxtjyIp
	N8dJSKZO3pJnhoTbrwJx4X6yNI7i3W9hMRn+cOQ9E/ips9sExpTEh28ulLgG8JQLAYFzIgH9153
	Ptkv0Dy2FOdtlxztKdzYl6OUUrW0L1jAtAn1x7GAsIlD7v3+vJk5RqqOWk66c+TIbIxXGeRjN4N
	gpmXut93rTEZ9sQdYc64gLY/xTxDiL5PJ+/XtQKVfMBu+QCmdzNc8Z9IzCybtPOiLytTAGkBgNK
	nd+R3b7pRA59QHFwhQSkmfZw9IB80ijXqKcqyYKmrMjR+5dIx+guFxWVk+KS3icknUUpMjIZNLU
	aEFYUhR6rIjfUVgbO60Y3MLdMcUq7dSpQ80+2va919Zi7sbmeFjdANhqVVLHbWVWSsg==
X-Received: by 2002:a05:600c:c058:b0:492:48c8:c705 with SMTP id 5b1f17b1804b1-49266865fe5mr18834925e9.1.1782378279131;
        Thu, 25 Jun 2026 02:04:39 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926494f129sm47950825e9.0.2026.06.25.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:04:38 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:04:36 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: imx: fix locked bus on SMBus block-read of 0
 (atomic)
Message-ID: <ajzvJE5LuzvLmpZN@eichest-laptop>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-1-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-1-26a3cc8cd055@free.fr>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vjardin@free.fr,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:andi.shyti@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:wsa@kernel.org,m:kaushalkernelmailinglist@gmail.com,m:shawn.guo@freescale.com,m:stefan.eichenberger@toradex.com,m:linux-i2c@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268311-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eichest@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[free.fr];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eichest-laptop:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A3516C4157

Sorry for the late reply.

On Mon, May 25, 2026 at 06:43:15PM +0200, Vincent Jardin wrote:
> SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the atomic
> (polling) path rejects it as -EPROTO. Worse, it returns without a
> NACK+STOP: the next receive cycle has already started, so the target
> keeps holding SDA and the bus stays stuck until a power cycle for
> this i2c controller.
> 
> Reading I2DR to obtain the count likewise arms the next byte on the
> count > I2C_SMBUS_BLOCK_MAX path, which also returned -EPROTO directly
> and left the bus held.
> 
> Handle both: NACK the in-flight dummy byte (TXAK) and extend msgs->len so
> the existing last-byte handling emits STOP; the dummy byte is discarded.
> A count of 0 is a valid empty block read; a count above
> I2C_SMBUS_BLOCK_MAX is still reported as -EPROTO, but only after the bus
> has been released.
> 
> The interrupt-driven path has the same flaw from a later commit and is
> fixed separately, as it carries a different Fixes: tag and stable range.
> 
> Fixes: 8e8782c71595 ("i2c: imx: add SMBus block read support")
> Cc: <stable@vger.kernel.org> # v3.16+
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/i2c/busses/i2c-imx.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a208fefd3c3b..14107e1ad413 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1415,6 +1415,7 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
>  	int i, result;
>  	unsigned int temp;
>  	int block_data = msgs->flags & I2C_M_RECV_LEN;
> +	int block_err = 0;
>  
>  	result = i2c_imx_prepare_read(i2c_imx, msgs, false);
>  	if (result)
> @@ -1436,8 +1437,20 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
>  		 */
>  		if ((!i) && block_data) {
>  			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> -			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
> -				return -EPROTO;
> +			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
> +				/*
> +				 * SMBus 3.1 6.5.7: support count byte of 0.
> +				 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
> +				 */
> +				if (len > I2C_SMBUS_BLOCK_MAX)
> +					block_err = -EPROTO;
> +				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +				temp |= I2CR_TXAK;
> +				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +				msgs->buf[0] = 0;
> +				msgs->len = 2;
> +				continue;
> +			}
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> read length: 0x%X\n",
>  				__func__, len);
> @@ -1485,7 +1498,7 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
>  			"<%s> read byte: B%d=0x%X\n",
>  			__func__, i, msgs->buf[i]);
>  	}
> -	return 0;
> +	return block_err;
>  }

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>

