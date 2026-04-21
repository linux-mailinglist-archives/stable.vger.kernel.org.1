Return-Path: <stable+bounces-240135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEopEiJg52nF7QEAu9opvQ
	(envelope-from <stable+bounces-240135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:31:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E443A1DE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A259B300A673
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ADF202C46;
	Tue, 21 Apr 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="IBi1306X"
X-Original-To: stable@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412413C9C4;
	Tue, 21 Apr 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771098; cv=none; b=EvbKtZfWF6Y3sBgM0kGBSrWa9JmjG+cjNSkoqHCvz9nCIVpL0PAi2EfKavzqhkBpVwBlTPQZu9QdTYMOYPskBjooMXend8+qLzvQ1t9oSTg7tTpXQ8kmwYeT0NCxkqhCqDW74Y3zK6Zfb2xL5n1x5BuswAyQDKJmvDJz892tlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771098; c=relaxed/simple;
	bh=W8XE6AsCjiyMkNiqm+W/kCNKHXSvr5jtjoTpdBLQW5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=JCvJxrmgPaWuLtWK28RJ+82tVYn+MmM7ZXfcaFoW9A/C25CGrtbZyaC9sWRyJkvEpR2rluCtwRnwtlY1S41JLSDOPCPwvN4HNISqYZ8PBKu7xJD6+bYe/uLXny9QgaR+IRB9uyRPZcQiY6o4sVBmaIAwnzL0ZRw+QgAzt7bIFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=IBi1306X; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 89D296BF;
	Tue, 21 Apr 2026 13:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1776771087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hhuFXO06bOWCEdQdbRTwVTgeyM0AujBkhd+2NkK3l9w=;
	b=IBi1306Xp2a7BD4ZWoIujYfFV3vZRXxdwTV9OeillI8sKbEIEA+rpMtXgudjsvIogfqs8f
	yolJqnt85aODRotApLBIlZ7aSc7sNRZzVXZNfypnLfLPwYFygm17nGblteHEDxGs/gHMZJ
	AcAcrtW569pj4ZbufPsANYSErX16kbP0SLJjfvDkqowavhjswsUmqYG0+NP9aU1OHJBG65
	BEGMr5aeouoXlFIJe0ae4EuEe4zlH6GAhqZqnC2OspEWsJ51R7wcWsV0IR9JVnIagW1fsv
	BGK2FkEqUI9dHyH5RxiMDdSKWln9Iyky3KEyQFjINXGH/uDS3sRC8bW/TjuqsA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a992d56beca61ff579dbf32576fdc45441f3dd00ff95a0dc2cdd6b1bcd39;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Apr 2026 13:31:25 +0200
Message-Id: <DHYSS8G7AU19.2K78IJHZUMHYT@walle.cc>
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
Cc: "Pratyush Yadav" <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
X-Mailer: aerc 0.20.0
References: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
In-Reply-To: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[walle.cc,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[walle.cc:s=mail2022082101];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-240135-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[walle.cc:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@walle.cc,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 348E443A1DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--a992d56beca61ff579dbf32576fdc45441f3dd00ff95a0dc2cdd6b1bcd39
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 17, 2026 at 5:24 PM CEST, Tudor Ambarus wrote:
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
> Inside spi_nor_print_flags(), the 'names_len' argument is used to
> bounds-check the 'names' array access. An out-of-bounds read occurs
> if a flag bit is set that exceeds the array's actual element count
> but is within the inflated byte-size count.
>
> Correct this by using ARRAY_SIZE() to pass the actual number of
> string pointers in the array.
>
> Cc: stable@vger.kernel.org
> Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugf=
s")
> Closes: https://sashiko.dev/#/patchset/20260417-die-erase-fix-v2-1-73bb70=
04ebad%40infineon.com [1]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--a992d56beca61ff579dbf32576fdc45441f3dd00ff95a0dc2cdd6b1bcd39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaedgDREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+P5pAX4+w/PCCqkj8/+nFtLJAU2g7jDhH9ZBAh0j
aEgznV9hRDXp3zPhk+uukvCt/VCRFbUBfjXPmZwavXvJ6TmduqJG5oEqM2bomxH5
n3U8iB017VVnUmndo44akDUShbZOgSfNgA==
=kKJO
-----END PGP SIGNATURE-----

--a992d56beca61ff579dbf32576fdc45441f3dd00ff95a0dc2cdd6b1bcd39--

