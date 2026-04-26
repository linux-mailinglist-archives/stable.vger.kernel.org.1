Return-Path: <stable+bounces-241153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZGD0JcGZ7WnvlQAAu9opvQ
	(envelope-from <stable+bounces-241153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 06:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21393468B9B
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 06:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 899C530058D8
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665FC2BDC2F;
	Sun, 26 Apr 2026 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPR+b6v8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6178F3A
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777179068; cv=none; b=qVQVBDghn3q/DmTFck1bsuFTG4ckm79kmm8GYSL2nZYVT13ECBbOE3LMse/Stc4h38s05maEBnQgNLLGNerUxA5XHAngKNR0LRFtucUvLqbxaGs4dB76P/7V1Ue+Pe1zqPZ+c01Im538ofAjAO7SRrjM4JkAh9Vz9FBYZFtyKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777179068; c=relaxed/simple;
	bh=4/1dm9v2x6HqLfmARPOK2LRXOfRfLUHSz+Wlm2pqaJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUwLSQ025lP/JPXkGZhjNe3f0StCebFZPYv6bs9WNCGZTMrGn2Vih82dIrhRSz7LvzULWgpdJ+cWCSpHzCsnunrIwiofhxjZ0nthKle2SFeApZVOB3ai6x8EEB85JJzXGjOQhEjLudFH/NSbo0bzwN0DtneQ3R5k2HznwDoKlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPR+b6v8; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c637089ccso11630697c88.1
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777179065; x=1777783865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vaOJDGyw3wxp09UGOcbQa5slZ7g91u9irMmTCg27/0=;
        b=RPR+b6v8QzBK5bG1zRpsnSK5Y3ivVVnBRnXexn1bqRrg9M+x62REsWb9rXm93ArfD0
         i3rF346hGODFIr2ajhhCx0PR49CWNMM5hhA74+FU+REzNPNLROb2SRcFB3S4Cq0DO0IJ
         l4J5IdoMy+hIa2eyvrxau3vFqJ+xh+AbehmfEKmLl/wF86zGzsQzOlQ55aGKXdr2cx7r
         tpG4+dHnxmgY6sEhL+8iTGybqVPQHcxfV+BpZ//NJGnKTM76Bq8gnIX0Y+KU2sINiBdf
         0miv3y6DGihN2leyxhiCo4ZXTmgFxWxHAlZ6UMffG4eRqBM7RICDdkSxk+iQju2A4unQ
         zeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777179065; x=1777783865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vaOJDGyw3wxp09UGOcbQa5slZ7g91u9irMmTCg27/0=;
        b=jczNHnzMuNesANEqDr0Xj3um1oCRuMcFYF5rx7Xpwt/9Fzwiq8JwiKoM5kSE2+nKiP
         oyTdZY5K6+C7gBteffJHwMR5W7YjT9KW5oN3svvE+X/ZERNuZEadYXCzVgZ5kfSmzBEs
         0P6Ed9G/gGuFzaiRg3jSy595oj0SCPtvuK9jh77lqZCBB1SZD63q2at79co75fqZzSAw
         IWkCcLKX1BqgeVRRpPZJD0qFie0Mf5asVGeT9tpA3VFcYFgEDW/ojC0PY6gGW2zC5Li1
         AOyut4D3Ho8Scp8r3z+Z2KIO/W3jXpDlAcmXaFG/q6djwlm+Qnnbywc1n76vGao46+jX
         GiZw==
X-Forwarded-Encrypted: i=1; AFNElJ9bwCe4MeC2Wg8c5Hq6jmyfdVRUU2xQnO0mGu6lBUIO9qTHwZeEjRVLYAnWINatZ2pgxZ4OedI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eHnb/oiuuTFl3wwhPl7XlqQLD8BZiL/1yRHwA1676rGDh2Gy
	gxX6UqUUXSZAFJarM1ccg383rLOEwNhLCD5DqVd2i53AzPOuLm2rkxwF
X-Gm-Gg: AeBDiesJy6uREiD6Z0bx9T19+91nmnsH5nXFWcCWoqtS3xM+BSmBynkESTeaFRhxXhc
	LGjco0J6+Ji7Hk6moJzXKybN0pXJoRb551Mhzbtxw/1K4yVNS92CnEUycdzf6uAqqtg/3a2pyeN
	O1x10KMKulU/b/3WD0jsXOt5bpAqcm8H5lKFSpBE3sBMCukG4sjjGNf/O2Pg5/KVTZ4Uz6smDQm
	lCZgjna5Uqo1P5w4hXr7qSClAtuXr8DDNGlHLEagZJdSlHHJFZVdjXneoh7K2I4iUujG6NsQe6v
	+A+NxbIs5eXVjjzz3MlJF0X1Vtr7/F32F4AdZoTRaG3sc7RAiuj+OCDCBqPvNZxHPSXDISBrY1E
	HWEYoUQPLzJ3JEkqKQ+qGD4Wo9fBLiVonlwztXI2IXJ3Ifc+KuTE92eNmwcj7ZHgf84wCnpGRNR
	H2zPEHgVbJquB/XqlZFznPh5/8wxYi3xItqQU+iZ6WtWSqXiFwINuqxkdaKyOq2qvjdZADx7sha
	iE=
X-Received: by 2002:a05:7022:ea2c:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c73fa3c01mr20631223c88.28.1777179064969;
        Sat, 25 Apr 2026 21:51:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f359:aa0c:530d:9dfd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm38343163c88.1.2026.04.25.21.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 21:51:04 -0700 (PDT)
Date: Sat, 25 Apr 2026 21:51:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <ae2YWxew6M03MFfN@google.com>
References: <20260424192534.3504976-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424192534.3504976-1-kris@embeddedTS.com>
X-Rspamd-Queue-Id: 21393468B9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

Hi Kris,

On Fri, Apr 24, 2026 at 07:25:34PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits, moving the 3 bytes to a single message.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 4b39f7212d35c..599793d27129e 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -327,7 +327,7 @@ struct ser_req {
>  	u8			ref_off;
>  	u16			scratch;
>  	struct spi_message	msg;
> -	struct spi_transfer	xfer[8];
> +	struct spi_transfer	xfer[7];
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -403,16 +403,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>  
>  	/* clear the command register */
> -	req->scratch = 0;
> -	req->xfer[6].tx_buf = &req->scratch;
> -	req->xfer[6].len = 1;
> +	req->xfer[6].rx_buf = &req->scratch;
> +	req->xfer[6].len = 3;

Doesn't this overflow "scratch" which is only 2 bytes? I guess there is
a hole in ser_req between "scratch" and "msg" but I do not think we
should rely on this.

Can we also set rx_buf to NULL to discard incoming data?

[credit to sashiko].

Thanks.

-- 
Dmitry

