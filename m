Return-Path: <stable+bounces-241415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EKKEhWZ72nQDAEAu9opvQ
	(envelope-from <stable+bounces-241415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 926EF476E5F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B5283077561
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820133DC4D2;
	Mon, 27 Apr 2026 17:07:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AB3D646C;
	Mon, 27 Apr 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.41.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309667; cv=none; b=DM1e34I5bOOm+yeVxKqoYgNclJ6rQfJod26BHb9wlyE6b2BSXjnUNpubvB7B8wc+8mg1ay+T/TJPvMZ/PwPo4m3XMkLUyxzwAdZjaSA3glI+Eyeiqi6mPvmkqwEeXkNeqxHVFrCVq6OL7Qows71TQoASL/yCILHlPLKYlI/WSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309667; c=relaxed/simple;
	bh=ZTF7P6cVktQcKZ8CxeRCeC+D3MifGxjZe454CcN5Wjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFER5yT+CWb6pc3fzKfysICf4FCWf0ODiukULnhD8iq8qNWdmiEhwe6mECF/dRcLGmrPiXErxK///JKE6uVT821f4UL+2L4Mw2wi8vpgO0km7mVCCtWYtPhR/JdHQVBqgFGC6uCoKDsBLR7Eq3LiM5APLSr1F0AugvX/LdSjg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=kleine-koenig.org; arc=none smtp.client-ip=162.55.41.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kleine-koenig.org
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
	id C3EB511B2B9C; Mon, 27 Apr 2026 19:01:03 +0200 (CEST)
Date: Mon, 27 Apr 2026 19:00:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Li Jian <lazycat-xiao@foxmail.com>, 
	lgirdwood@gmail.com, loongarch@vger.kernel.org, zhoubinbin@loongson.cn, 
	jeffbai@aosc.io, stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Zhang Yi <zhangyi@everest-semi.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Alexandru Ardelean <aardelean@deviqon.com>, Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
Message-ID: <ae-VofUzVa_ladMh@monoceros>
References: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
 <177724622731.266775.3161558352144649934.b4-ty@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjjlhwvkljtq2oyu"
Content-Disposition: inline
In-Reply-To: <177724622731.266775.3161558352144649934.b4-ty@b4>
X-Rspamd-Queue-Id: 926EF476E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241415-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,foxmail.com,gmail.com,loongson.cn,aosc.io,perex.cz,suse.com,everest-semi.com,opensource.cirrus.com,renesas.com,deviqon.com,kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@pengutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--fjjlhwvkljtq2oyu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 08:30:27AM +0900, Mark Brown wrote:
> On Fri, 17 Apr 2026 18:53:14 +0800, Li Jian wrote:
> > ASoC: ES8389: convert to devm_clk_get_optional() to get clock
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
7.1
>=20
> Thanks!
>=20
> [1/1] ASoC: ES8389: convert to devm_clk_get_optional() to get clock
>       https://git.kernel.org/broonie/sound/c/8ed331113107

I see you dropped the Fixes: line, but I still think the commit log is
wrongly blaming abae8e57e49a. Unless I'm missing something, abae8e57e49a
didn't change behaviour of devm_clk_get() or devm_clk_get_optional(), so
"since commit abae8e57e49a ("clk: generalize devm_clk_get() a bit"),
devm_clk_get() would return an error pointer when a clock source was not
detected (instead of falling back to a static clock)," is wrong.

Best regards
Uwe

--fjjlhwvkljtq2oyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnvlkgACgkQj4D7WH0S
/k6OQAf7B8u1Znv9CChLSgiFjZ+MJBKOddYUAla+AjVrrSWVE98W1ZaTuG3Lk1y5
Zgn1Ni9Rbp/Z6HneZ5YAugPdtxJdM6IHbEL5u4NqnX7uoyJ7akxBR3gLpGRfuuXB
P/2gfwvqwikM8Nwfhos0VUyiQk4n60zb1j+F/LzhuphkoATOPWKq/uvNFmk6TMb9
4o9SMquVYOf52fHRooZnLnU5WPfWvxEcDaG5aG1HXDRlYxs1TLcO2L++Ic45g+i7
7URi3tOvE3sZqCJu5f018b0OtBZIZG2zoJ9o+ySNAV0D3lcIOOmnXlliVGARJa1M
yBzEuFe6D+2uAHRlxxgF/F2o1ONwjQ==
=/bxX
-----END PGP SIGNATURE-----

--fjjlhwvkljtq2oyu--

