Return-Path: <stable+bounces-217277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFbSOXmtlWl1TgIAu9opvQ
	(envelope-from <stable+bounces-217277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:15:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060915646A
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21D313019C94
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B530BB88;
	Wed, 18 Feb 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS2hMCua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16723243964;
	Wed, 18 Feb 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416946; cv=none; b=PQcckOanv/W11r2KDHDadoxZjMpie5LGKMjSeVh2uxOkId6TBaDSlCXqaQb6/LVzLMbwbbAQdha/muYAt9ZFdP3NbtDywESkQ6ozCt4JDEO9U1VF+n4Z8Tivn1HEPCtG4+aB4jhjaKmv3HgJ7BfwLqeL/G/UxPgf2N4Whx/tin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416946; c=relaxed/simple;
	bh=CMfoICr25vJULHXEU9DptywfEfHQ/EWd11ZFFXA3TZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQrxouwsD1hHlvaENDv7eJkcbcq4QX9etErSpzx/5AHh0+hDa4lFZRrygfBWd63rS3FrgJh4clrP0uz1qfovoLt20ygPl2k9OE1LOdeev/4zU6oRzJ161XHWH4k7na5FDkdVLJAu1D0ew3ySMBk7UaWvQYlOU4JzSLoBQLnVIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS2hMCua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31118C19421;
	Wed, 18 Feb 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771416945;
	bh=CMfoICr25vJULHXEU9DptywfEfHQ/EWd11ZFFXA3TZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CS2hMCuaN/8Ioi7cWg7F/BI7xAIrCVt7pqw22ip7EXsHh2HkOngNgTItqKBdBKSZN
	 PuvEUOGJhMDa7zf4Szyar2n3kXf+EDRiK8cLNWFEln3rI5tN11fW/5VxvYJoUQzU6K
	 ULN1P75IFUJw1hpYwA3c0+v8mhYWR6iZ5/h/GEWoWkHLkDx07oXM6YVmOH9DyX4/EC
	 pPaX3vwMTxii9k1A5s0KXFEB0pD8G9ZmG0nW3FC1VHuhujA/PHXqC/qtxJ8EfVm4ip
	 lSM7LyG7bEUuuhPmjSh+ucBzjSSncoLAwMDchIVoNtjzUnRJ4yxSGHCwEZpY4CZTuv
	 8xiRO/BnZ5Acg==
Date: Wed, 18 Feb 2026 12:15:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ASoC: rockchip: i2s_tdm: Re-add the set_sysclk
 callback"
Message-ID: <6ffc8939-147f-4b2f-a8cb-63a388d3dad4@sirena.org.uk>
References: <20260218-snd-rk3308-i2s-revert-set_sysclk-v1-1-79ab787f88ac@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tN0IzqP3xmtYQ7S/"
Content-Disposition: inline
In-Reply-To: <20260218-snd-rk3308-i2s-revert-set_sysclk-v1-1-79ab787f88ac@bootlin.com>
X-Cookie: They just buzzed and buzzed...buzzed.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217277-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,sntech.de,collabora.com,bootlin.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 6060915646A
X-Rspamd-Action: no action


--tN0IzqP3xmtYQ7S/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 18, 2026 at 01:11:24PM +0100, Luca Ceresoli wrote:

> This reverts commit 5323186e2e8d33c073fad51e24f18e2d6dbae2da.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tN0IzqP3xmtYQ7S/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmVrWsACgkQJNaLcl1U
h9CiRwf/b/PyM6sh+/IY6KcTy577bNhqdqaZ3r+FuOqbpZngqzuc09sJKu284k1Q
vuU3JJ3he28hEUSwkazGVpEiLAWvGxNP3MPFuCgDGqtKb5fYCXORj8EX4ilVBiTE
dYC9oAab3VILGDf3lHQlPG3B/ZunIYQGdITIdmgHHsJ2Uet9TLEGEm7uhUZQybCp
jXzXTlRRh4Vx5oArEOWKIZdUw4IxtGQD7iLwG+N6Pt3L13d/8WG+XVgIdTzpMU78
SqviGJyfrH05JA4w3vlg1IXf/K9UYQ361nHhkCI2YQVlI6IokGh7eqr3LAzwQx/3
bkKavE7823h5HkFxYwH0lviYWdSTUA==
=y9au
-----END PGP SIGNATURE-----

--tN0IzqP3xmtYQ7S/--

