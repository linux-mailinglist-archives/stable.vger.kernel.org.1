Return-Path: <stable+bounces-243150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBtpGr2n+GlexgIAu9opvQ
	(envelope-from <stable+bounces-243150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:05:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6904BE801
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F483303938F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F523DE457;
	Mon,  4 May 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KOoBPuZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668C3DDDD7
	for <stable@vger.kernel.org>; Mon,  4 May 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903144; cv=none; b=VA9WIm3rlTMHYMcq5vPwpULqwcsmjRbLKLWRCnEtQuV2tRGaXuExZ7zlftB6c56+WQuY78Feipo+aOoXDUM8NFPs+gmreAA2gw015t9/RJJX+z43RZe8fRw6bJpx8sahyYCj+2Shm85m+5Zfshz4xs9mVy8H2x9bD4GV8pIj87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903144; c=relaxed/simple;
	bh=gOGLBCbpHD5jUNJprldmV5V8WZ1GfuJwuregfRGrSjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z6sbTGUD+9BL/1PJODuGX2KEDtTWRALxEyZheeAv0hxJgMlMMdtmVAnkJTwOG8Svil1/R1CIr9DQ2ZIz2Jb08YZ/zg8ao4O91MTR1kqFY4Z8NItWFO1AchVGKoU0t8DvHZ0QSpj58YAUCDFoYJer90ZADGJYyKGevmCK5y6b8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KOoBPuZ8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A7974E42BB8;
	Mon,  4 May 2026 13:58:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69A915FD5F;
	Mon,  4 May 2026 13:58:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B737E11AD2449;
	Mon,  4 May 2026 15:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777903138; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LVrH+hRa8k60712RPQs7XAU8jqIwLgDkBraOs0In2Cc=;
	b=KOoBPuZ8iPsqVJviZXRPur58W4+JFX2f+4e1Yw2f62tBEjd3M/aDEw1paPJy7ALa2H3qiA
	DGBZfFGDu+PCKMTqLGRCgqsBPtOg1zI1apECUFvNwyW230zpPrzczAmwnBusuwnnuy013J
	DEqVNFYwkAK1wsTRcLzbxR8X1ApVq6zAPansft6cn28IfpDvJAssHkX1K4JAI8Q1rJyH43
	/dQjB7cGMcrekjEwPSLABk+OXXQrbsvrkLjNMzgcHmqj5o+bwQZl9MFV8+Lyy/P48PmpzD
	eQFYHcXKEOasY8/e7LJtXeMmbBDmJxda19p/PwuSTJtn6SjuYp6cKX9CtVUGxg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Vastargazing <vebohr@gmail.com>
Cc: linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  David Woodhouse <dwmw2@infradead.org>,  Lennert Buytenhek
 <buytenh@wantstofly.org>,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 3/5] mtd: maps: physmap: fix reference leak on failed
 device registration
In-Reply-To: <6717e0b2a6244ee4e691dba03eb8c790c202e89e.1777889235.git.vebohr@gmail.com>
	(Vastargazing's message of "Mon, 4 May 2026 13:08:45 +0300")
References: <cover.1777889235.git.vebohr@gmail.com>
	<6717e0b2a6244ee4e691dba03eb8c790c202e89e.1777889235.git.vebohr@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 04 May 2026 15:58:56 +0200
Message-ID: <87a4ufs2cf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CD6904BE801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243150-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]

On 04/05/2026 at 13:08:45 +03, Vastargazing <vebohr@gmail.com> wrote:

> When platform_device_register() fails in physmap_init(), the embedded
> struct device has already been initialized by device_initialize() inside
> platform_device_register(). The error path unregisters the driver but
> returns without dropping the device reference:
>
>   physmap_init()
>     -> platform_device_register(&physmap_flash)
>        -> device_initialize(&physmap_flash.dev)   /* kref =3D 1 */
>        -> platform_device_add(&physmap_flash)     /* fails */
>     <- platform_driver_unregister() called, but kref still 1
>
> Per platform_device_register() kernel-doc:
>
>   NOTE: _Never_ directly free @pdev after calling this function, even if
>   it returned an error! Always use platform_device_put() to give up the
>   reference initialised in this function instead.
>
> Fix this by calling platform_device_put() before unregistering the driver.
>
> Fixes: 73566edf9b91 ("[MTD] Convert physmap to platform driver")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
> Signed-off-by: Vastargazing <vebohr@gmail.com>

Somehow b4 applied another patch from that series, I'm not sure why. I
just dropped it. Please resend this patch alone.

Also, your SoB line seems to be incorrect, we need a proper name, please
have a loot at the DCO.

Thanks,
Miqu=C3=A8l

