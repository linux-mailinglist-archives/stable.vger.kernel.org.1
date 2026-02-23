Return-Path: <stable+bounces-217714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOqPAl8enGkZ/wMAu9opvQ
	(envelope-from <stable+bounces-217714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:31:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81633173EE9
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C9783053A86
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6AC34DCC4;
	Mon, 23 Feb 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp7TxbYf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE134E777;
	Mon, 23 Feb 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838964; cv=none; b=YzECHcRW9QPAmhByDnUufqNNDqEK7hn/RyCNqe72jeDBWMcyeicbMTFNfqqUAJLsChIFGO7YX+d8y+KakZtHA8el8P9DRzSJr75XoEH/ZhvQcVK+e9hnafhJBDiwyswfaPduflRufrrxDgEmIw0QdKHjJOeth9+zNjiwlkD5zvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838964; c=relaxed/simple;
	bh=qSc8GpjmV8N4ESmmtoyex8meT32NYtvc0z27Ol22oBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=uFNjQ2Jf5JQdfxb4Qr+yZinGjCHUKToav0m3UG+bJz9b66GDNsNaNigmo7uO2iAytGSd0d/4HXB3Lz5bMxBX6Uk4pDZTTKejOVhYSYQlxHukRlAu5MWefj2R08q4Y7S9c9RODNTNe2fLwBgqowdz1xZivaKitak5EM0o/B/tJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp7TxbYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE1BC19421;
	Mon, 23 Feb 2026 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771838964;
	bh=qSc8GpjmV8N4ESmmtoyex8meT32NYtvc0z27Ol22oBY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Fp7TxbYfRJ5481Vdo9QJM9dPqJgvg1E1O1mnF6BNpUF6Xdoi1VVrNAhpVPa3L6sEQ
	 n0cfQ5fmYCAyikDxWMi/lniSdpOLEwjm55C3nzOL108Tbumr6RYbrhrJ9zeMyk+5aJ
	 xDJy4f2dOxPBFrb8sOQiLdEZU3H0kvkWMbOkMPckE3KUCQv7wL0PSRti3ALWjYOevn
	 5x4c/Fqups+tmKAqPX3YiW0iDo68lJuwdB+Yk/1L62wGy8MCI1X+JCo254VaGzv0YE
	 E/tzJQun95dLQEY1qjDYxshd9wmfgNUcEavoK/Uep1X42CJ4XN1P8YEu/H8XlpOf/0
	 1vcXj3Wz5+Q9Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=adf5d6bf2817c52630721166249761492ef851abe98547b5f7470d47818c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 23 Feb 2026 10:29:20 +0100
Message-Id: <DGM8HPC181AF.3FCCS4MIE4A43@kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sst: Fix write enable before AAI
 sequence
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <miquel.raynal@bootlin.com>, <pratyush@kernel.org>, <richard@nod.at>,
 <sanjaikumar.vs@dicortech.com>, <stable@vger.kernel.org>,
 <tudor.ambarus@linaro.org>, <vigneshr@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Sanjaikumar V S" <sanjaikumarvs@gmail.com>
X-Mailer: aerc 0.20.0
References: <DGM6ZPOT1WCR.157JI0LW4W3E8@kernel.org>
 <20260223091733.47-1-sanjaikumarvs@gmail.com>
In-Reply-To: <20260223091733.47-1-sanjaikumarvs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81633173EE9
X-Rspamd-Action: no action

--adf5d6bf2817c52630721166249761492ef851abe98547b5f7470d47818c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Feb 23, 2026 at 10:17 AM CET, Sanjaikumar V S wrote:
>> Raises concern about writes ending at odd offsets potentially
>> having the same issue
>
> The odd end address case (trailing byte) is already handled in the
> existing code at lines 243-255:
>
> /* Write out trailing byte if it exists. */
> if (actual !=3D len) {
>     ret =3D spi_nor_write_enable(nor);
>     ...
>     ret =3D sst_nor_write_data(nor, to, 1, buf + actual);
> }

Ah, I must be blind. I stopped reading at the write_disable.

> So write_enable is already called before writing the trailing
> byte. My patch only addresses the odd start case where BP clears
> WEL before the AAI sequence begins.
>
>> Suggests simplifying the conditional logic by removing the length
>> check
>
> The condition `if (actual < len - 1)` avoids an unnecessary
> write_enable when len =3D=3D 1 (single byte write at odd address, no
> AAI follows). But if you prefer unconditional write_enable for
> simplicity, I can change it in v3.

I know, but I actually don't like repeating the condition in the for
loop. So I'd prefer to have a local "needs_write_enable" boolean
which will be set to true. But then, I wouldn't care too much if
there is a write enable followed by a write disable for a rare case.

>> Notes the patch lacks runtime testing
>
> I don't have the hardware setup to test odd-address writes at the
> moment. The fix is based on code analysis. I have tested patch 2/2
> (dirmap fallback) on hardware.

I'm hesitant - because like I said, if there is really a bug - it
would have never worked correctly, since day 1. But yeah, I've also
read the datasheet and it clearly states that the byte write will
clear the write enable latch.

> Please let me know if you'd like me to send a v3 with the
> simplified unconditional write_enable.

Please see above.

-michael

--adf5d6bf2817c52630721166249761492ef851abe98547b5f7470d47818c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaZwd8BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gD+AF+PMpnOIUXZU15ZBDAvkgvNBLt4H5g2WC7
aDt3o03I0g2/SHw0sv84Dd1FQiMqqAVxAYCjWOam711N/Ut6j2f+6MXK9h9dIcwO
dmEauy79oSIIyC7Q8J0sTI1nFnBaJSKRk+k=
=CCQO
-----END PGP SIGNATURE-----

--adf5d6bf2817c52630721166249761492ef851abe98547b5f7470d47818c--

