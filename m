Return-Path: <stable+bounces-241321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPQRObFg72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A834947333D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 961D1300D85F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC53C13E0;
	Mon, 27 Apr 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JB5ppoGw"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF53C198E
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295344; cv=none; b=mC+dbKtXO6xfDB1KN1ANytxGWIEPXJ5DLVYrA0UbRfABn6NbsY5WMc6qG+Nnap+JFrsUuzAcc8b3T/mc4HypbrykMr+/V59un9/f7RG+4w37cukJ9TDx/YUGGIT8cxLi9YcLkOM9VY58WM3+TT1spjr9vBD9cjnqjAfXylj0eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295344; c=relaxed/simple;
	bh=VBWt0kaQnFT4JHolqg/vgM57aj7M7jjkSXwVvcQWg4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eHoIDMO+izucrV5/lgQ6SMDtxu8EmZD5z5oRCDu5vMfMB0U6A0SknaHCcq8FsXARPdaSj+5BBU6myhS915HFXOWO/cK9ZPe1wNi9NSlPXRR8t7Bb/8Z9Ktf+6OfeX18i6C0yRf+6xsbz2GPzK0c4gkpMipJj51isspyRnbfqlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JB5ppoGw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A00A4E42B34;
	Mon, 27 Apr 2026 13:08:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBC16600D1;
	Mon, 27 Apr 2026 13:08:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EE9510728039;
	Mon, 27 Apr 2026 15:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777295337; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O8yxX0gO7nTEAcY/1Dd9O+rvwBL+vwhqZY4uok46s0Y=;
	b=JB5ppoGws1cWp+TPLhjXB5zGL54fxXQKVnuBVJ+xwaYL/LTsh9W86NI79+k3pKTL4+0rDU
	D+evLg+uwrklJarNRyhcQ6zlBErM75BWT4B7J8eduTjGV1cTBwvRlUMoD/eaclWTh0Td5J
	k+OWhNWUqrRAmwL0wht1io4Ayzu87O+26Jd4fY+orcP8PxdCoXyXTjO6wC+zKaSLIEmG+6
	ZYXZfa5YD8JQdhlxZqFJkQWyrWfXQA2aoNJwEXf9qc/9ONswo3SHB56r848y6uFKLLQ5qY
	wcYTNjiiFgzXXyg9ZZ1RvDRIgFPSxoHN8isdX/FOOYy7S++7UNxoD/9FhyICOg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
References: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
Message-Id: <177729533643.179808.1459860787473321982.b4-ty@bootlin.com>
Date: Mon, 27 Apr 2026 15:08:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A834947333D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-241321-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 17 Apr 2026 15:24:39 +0000, Tudor Ambarus wrote:
> Sashiko noticed an out-of-bounds read [1].
> 
> In spi_nor_params_show(), the snor_f_names array is passed to
> spi_nor_print_flags() using sizeof(snor_f_names).
> 
> Since snor_f_names is an array of pointers, sizeof() returns the total
> number of bytes occupied by the pointers
> 	(element_count * sizeof(void *))
> rather than the element count itself. On 64-bit systems, this makes the
> passed length 8x larger than intended.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()
      commit: e47029b977e747cb3a9174308fd55762cce70147

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


