Return-Path: <stable+bounces-196815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA6C82A34
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117C93ACBD3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701F230D14;
	Mon, 24 Nov 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Afnt4dvI"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13238D;
	Mon, 24 Nov 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764022743; cv=none; b=rvujzvgkVHVMZAaJ2Pqis7f4QYTrJauYaCCd4OtW4lotato+kfZKAOUmQYlNPL6t//yZpMialguUCMKTiB+y87WwzMQ9L8BkTm9ma8IWBsIqKkggb0SfPDl4rROoAHQksVYv2mKvamAlyPc8caMnw5hUizK1p2wleJsyehGgUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764022743; c=relaxed/simple;
	bh=Z8NpdcuT1nwfKei3mh3g/WjgavM1azUIVBGdSwibf/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikY66fOF7oqSenj3OXzUCMgwmXjLkSQwBBGiDCrbjNjfRU9gzm8ap6xmxOmlNZlGXKpPiAZPqHNFprVAhFaO9FrCD54hQuVa+gkXEt48VeQMZUpaEJnr8K2LqMXamPif5J9WCCkeSRzUTu37V+BsG4brlswBHW5w8jqQ+0RVVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Afnt4dvI; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A75291C01C4; Mon, 24 Nov 2025 23:18:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1764022730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzruiFsyXf/+HODnlfoc7taXRjE+q/NxonHCE/IBbUM=;
	b=Afnt4dvIwIm9SsJ4GXHOixPZbrX/HFmzd4Cw81qI6ODSFzP2qe6MjcUvl1ghxchpL8ciKI
	08DpcO+dyypO8Y/m/z9meFJe8nrr6oMZ+hH4NH1oUhOzJWGXN5JpZOX36VcVTeZOuQK5Yt
	+QfzvtMprVszmrZompi3Tx1+QOmnaug=
Date: Mon, 24 Nov 2025 23:18:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Jung <ptr1337@cachyos.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
Message-ID: <aSTZylJfiN5uXDi1@duo.ucw.cz>
References: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
 <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RVDJ6xVA4bgVS92o"
Content-Disposition: inline
In-Reply-To: <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>


--RVDJ6xVA4bgVS92o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Add a fix glue which checks microcode revisions.
> >=20
> >    [ bp: Add microcode revisions checking, rewrite. ]
> >=20
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Gregory Price<gourry@gourry.net>
> > Signed-off-by: Borislav Petkov (AMD)<bp@alien8.de>
> > Link:https://lore.kernel.org/r/20251018024010.4112396-1-gourry@gourry.n=
et
> > ---
> >   arch/x86/kernel/cpu/amd.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >=20
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index ccaa51c..bc29be6 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -1035,8 +1035,18 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
> >   	}
> >   }
> > +static const struct x86_cpu_id zen5_rdseed_microcode[] =3D {
> > +	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
> > +	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
> > +};
> > +

> This fix seems to break quite a bunch of users in CachyOS. There has been
> now several users reporting that there system can not get properly into t=
he
> graphical interface.
>=20
> CachyOS is compiling the packages with -march=3Dznver5 and the GCC compil=
er
> currently does pass RDSEED.

Besides other things, GCC should probably be fixed not to do that.

And this will be fun for both mainline and -stable: security bug or
broken boot, pick one :-(.

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--RVDJ6xVA4bgVS92o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSTZygAKCRAw5/Bqldv6
8vk+AKCw7aghUH2Ox+xw8O5EkNTQz+dk2ACfagIs6UZAWmouYIy6ObGgNGDfYPw=
=6YLc
-----END PGP SIGNATURE-----

--RVDJ6xVA4bgVS92o--

