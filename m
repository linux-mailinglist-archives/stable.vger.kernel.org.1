Return-Path: <stable+bounces-241530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN4MH4iM8GkuUwEAu9opvQ
	(envelope-from <stable+bounces-241530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:31:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CE482ABE
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E10321F5A7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA93E121A;
	Tue, 28 Apr 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C2tvSgRo"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51303DA7CA
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370754; cv=none; b=Z9cUi3lIgSM6R2y/rkAjxVKy7rXsPCUYg8moVyeWL39nYrd6S8tbzdpnLvrfwGWw5SfjsmfEA+UPZleAubTI/pphBqoX2XkJWjQ2m15K3VyFs2KOHAA66J7i7on6B7urddywC1OIpSABaOTfteOrlrX+m2kBThpcSWkyqu4XXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370754; c=relaxed/simple;
	bh=si0GeyNOTWvpzr2O7XDw6IYfZNCHM16G3PuXERXzzAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2B2PiHHSVT/+R9OtyirSVXHWoNnavjfIRrYy0kcTaEVrxc8LUBaw8Wp2/ApK8Z4YjcITxDif/M+iCNSezQwTgfE3fBt3ehCcei3DX4o/nJqNrPe3IEVMnunOTeUf9OcHHoOudcvHMqEsVEZW4Qex/Kgp1FKQfwXXpMs1yNhclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C2tvSgRo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Apr 2026 12:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777370751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6NiVM+FcqKtdb/sqcUTVrGuVbWGle0JubOydHUeo5o=;
	b=C2tvSgRoc9Rwd5HDBOTSOX3/BUYtGIOIUbowRvaIbS1C/rncw+UmBZ1O5rRCo9xQk8rzxf
	z0bjNVDH+ioOZ42m0u/uPjHi9NKFCba9keqic7OenW9a1q/9+rsROB+Q3JLDTz3+2E+dQu
	iR9keTnJI7vDrTQSUISieZim/PAXgD8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Linus Walleij <linusw@kernel.org>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-sha204a - drop hwrng quality reduction for
 ATSHA204A
Message-ID: <afCGefyZV_ujj41K@linux.dev>
References: <20260427124030.315590-3-thorsten.blum@linux.dev>
 <2d42b1fc-b5d5-4dcb-8dc8-62580502f586@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d42b1fc-b5d5-4dcb-8dc8-62580502f586@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DB2CE482ABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241530-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid,microchip.com:url,metzdowd.com:url]

On Tue, Apr 28, 2026 at 07:58:39AM +0200, Ard Biesheuvel wrote:
> Hi Thorsten,
> 
> On Mon, 27 Apr 2026, at 14:40, Thorsten Blum wrote:
> > Commit 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to
> > lowest possible") reduced the hwrng quality to 1 based on a review by
> > Bill Cox [1]. However, despite its title, the review only tested the
> > ATSHA204, not the ATSHA204A.
> >
> > In the same thread, Atmel engineer Landon Cox wrote "this behavior has
> > been eliminated entirely"[2] in the ATSHA204A and "this problem does not
> > affect the ATECC108 or the ATECC108A (or the ATSHA204A)"[3].
> >
> > According to the official ATSHA204A datasheet [4], the device contains a
> > high-quality hardware RNG that combines its output with an internal seed
> > value stored in EEPROM or SRAM to generate random numbers. The device
> > also implements all security functions using SHA-256, and the driver
> > uses the chip's Random command in seed-update mode.
> >
> > Keep 'quality = 1' for ATSHA204, but drop the explicit hwrng quality
> > reduction for ATSHA204A and fall back to the hwrng core default.
> >
> 
> Interesting! Thanks for digging this up.
> 
> > [1] 
> > https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
> > [2] 
> > https://www.metzdowd.com/pipermail/cryptography/2014-December/023852.html
> > [3] 
> > https://www.metzdowd.com/pipermail/cryptography/2014-December/023886.html
> > [4] 
> > https://ww1.microchip.com/downloads/en/DeviceDoc/ATSHA204A-Data-Sheet-40002025A.pdf
> >
> > Fixes: 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to 
> > lowest possible")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  drivers/crypto/atmel-sha204a.c | 40 ++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
> > index dbb39ed0cea1..df69fb190e52 100644
> > --- a/drivers/crypto/atmel-sha204a.c
> > +++ b/drivers/crypto/atmel-sha204a.c
> > @@ -19,6 +19,25 @@
> >  #include <linux/workqueue.h>
> >  #include "atmel-i2c.h"
> > 
> > +enum atmel_sha204a_variant {
> > +	ATSHA204 = 1,
> > +	ATSHA204A,
> > +};
> > +
> 
> I agree that setting quality to '1' is only appropriate for the ATSHA204
> but this looks a bit clunky to me.

Moving the declarations to the top was also a leftover from a previous
approach and not necessary anymore. I'll send a v2.

Thanks,
Thorsten

