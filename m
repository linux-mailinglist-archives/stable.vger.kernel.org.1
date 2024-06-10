Return-Path: <stable+bounces-50099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765A79025B9
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 17:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F40B2B83E
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B614D719;
	Mon, 10 Jun 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="BnjpAAhF";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="Xf6VSCr/";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="T0a5Z8z3"
X-Original-To: stable@vger.kernel.org
Received: from e2i411.smtp2go.com (e2i411.smtp2go.com [103.2.141.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7E13E034
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032822; cv=none; b=UsZEPlUcns2M1ouXqg5mSUAP1GdN7IXAHpa668F1ytRylJHik+ygj6P0FWpzw3FJs7DHMtO75ewf2WoXsNeMPM4knLdiKIjSryydJdZ/b/2fpTYLsvr3NRYHQDCh7mrF2yB5lKD0I7VwNmy0+NyWWSsOMy0emP6afL6WxMO/PKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032822; c=relaxed/simple;
	bh=kxNj0ZVeNkElcPtWPQix8aAJ+poPiEk20mwi+FyEiHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdXMFLuqSwkCeJZYFPTxsnUVrab980SIbM8iXgvLPMf7gI7VTnc3zVaFtCgoCf60SFDxqOC2GcgA1bafJX6dR4PBZGxAqHpdOTKrX5fFeNMH47gHAzA6fMJtSYmJrIHedNXlgd5ARcn7cRC+4wzPKxrk+tQbLG/kI0fJByQDnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=BnjpAAhF reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=Xf6VSCr/; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=T0a5Z8z3; arc=none smtp.client-ip=103.2.141.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1718033716; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=vQoHrYF9OOJVsItZVr7XOj46Z1AabogKCVDMzdKF77k=; b=BnjpAAhFnu4fqJxm7oRJSRLHcp
	5ezHHYuxFIzfLBchrXr1r1uZqhvPvilIv6mkrTwVYhZkNDfRdqs17I4rPm8W6FLPlzIBxV9nrv9qM
	7Gn8pHPqZPU7UyV5BobKIHNeiHCoBX510oLoNAi/sUnxzJjz+EgbMjYv9tOmlxjjQ98RyNvQkajHQ
	gdUX2f8UdSJg59YAZR48YQlBxF+JSFAB94ofKUum3PsjXPKksA0u37srFVORIiz1z0XpP/L5tWzx/
	scSpp9An+Y0ZeOny/nM8VRwl4/LyQ8C47rgXYE989j4QvT8wuya7yh+UQjgr7ci16dYn03COru+F0
	QnzU8r9w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1718032816; h=from : subject :
 to : message-id : date;
 bh=vQoHrYF9OOJVsItZVr7XOj46Z1AabogKCVDMzdKF77k=;
 b=Xf6VSCr/1LWrADZvwWLaoIKB7qTPzFR2RpKEhAKE8O4ikxk0SqrqebtqzWdGIqr2geKBG
 5vwnv9hIn67eYPOJAbzoQ0lfEnPT2VUfC4U0sE+gk8JRKB5PN99zEydTisl9mYzDbR5Oryk
 72pVjF/M+XHwIVBJq59C+RFhljmWYowAEqT+u68RLE3CEEKiDTwEDopqisEZaRv7w/Izunm
 d56LHVkJvqL8H883FIbFXMcwzm5r/5SBkC9GHVzkgvqvITH+Y7Prcm/IIkT3P9RTDY2fUes
 TkAXenAoKWz+ycKIo86skA87etSIjxZfPPOcu1pdoHs5riTjxfLLvpEuCx5Q==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sGgnR-TRk6qx-8T; Mon, 10 Jun 2024 15:18:58 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sGgnS-4o5NDgrmh8E-kNoA; Mon, 10 Jun 2024 15:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1718032735; bh=kxNj0ZVeNkElcPtWPQix8aAJ+poPiEk20mwi+FyEiHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T0a5Z8z30r1iVhdVISPBwi+GY4h/CJgav387QmCnhhy/p5gbCtYB+9pvLo5sc2XQP
 vn5C64RVh2OrE1cmvlXTAzJPDcJ7fDH6DE6o4lOC4GFRAPjOLwajcMo2jO3TGzPjUU
 v0b46JGmtDSVIAqOBoY2zAhqvE+Fmr5xuMRO6l/A=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id A81023C8B4; Mon, 10 Jun 2024 17:18:54 +0200 (CEST)
Date: Mon, 10 Jun 2024 17:18:54 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-kbuild@vger.kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 Diederik de Haas <didi.debian@cknow.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Install dtb files as 0644 in Makefile.dtbinst
Message-ID: <ZmcZXuETxg_C7KI8@fjasle.eu>
References: <e1fd1b659711f59c61ec48dc43912dddccbb4d92.1717996742.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1ZrVfO6RKau8OEqg"
Content-Disposition: inline
In-Reply-To: <e1fd1b659711f59c61ec48dc43912dddccbb4d92.1717996742.git.dsimic@manjaro.org>
X-Smtpcorp-Track: kp6iOemPXodo.GqvIRvx4HzNQ.C9gtawNqQMR
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286swy0Xjnx8o
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--1ZrVfO6RKau8OEqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 07:21:12AM +0200 Dragan Simic wrote:
> The compiled dtb files aren't executable, so install them with 0644 as th=
eir
> permission mode, instead of defaulting to 0755 for the permission mode and
> installing them with the executable bits set.
>=20
> Some Linux distributions, including Debian, [1][2][3] already include fix=
es
> in their kernel package build recipes to change the dtb file permissions =
to
> 0644 in their kernel packages.  These changes, when additionally propagat=
ed
> into the long-term kernel versions, will allow such distributions to remo=
ve
> their downstream fixes.
>=20
> [1] https://salsa.debian.org/kernel-team/linux/-/merge_requests/642
> [2] https://salsa.debian.org/kernel-team/linux/-/merge_requests/749
> [3] https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/rules=
=2Ereal?ref_type=3Dheads#L193
>=20
> Cc: Diederik de Haas <didi.debian@cknow.org>
> Cc: stable@vger.kernel.org
> Fixes: aefd80307a05 ("kbuild: refactor Makefile.dtbinst more")
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>=20
> Notes:
>     Changes in v2:
>       - Improved the patch description, to include additional details and
>         to address the patch submission issues pointed out by Greg K-H [4]
>       - No changes were made to the patch itself
>    =20
>     Link to v1: https://lore.kernel.org/linux-kbuild/ae087ef1715142f606ba=
6477ace3e4111972cf8b.1717961381.git.dsimic@manjaro.org/T/#u
>    =20
>     [4] https://lore.kernel.org/linux-kbuild/2024061006-ladylike-paving-a=
36b@gregkh/
>=20
>  scripts/Makefile.dtbinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
> index 67956f6496a5..9d920419a62c 100644
> --- a/scripts/Makefile.dtbinst
> +++ b/scripts/Makefile.dtbinst
> @@ -17,7 +17,7 @@ include $(srctree)/scripts/Kbuild.include
>  dst :=3D $(INSTALL_DTBS_PATH)
> =20
>  quiet_cmd_dtb_install =3D INSTALL $@
> -      cmd_dtb_install =3D install -D $< $@
> +      cmd_dtb_install =3D install -D -m 0644 $< $@
> =20
>  $(dst)/%: $(obj)/%
>  	$(call cmd,dtb_install)

Thanks for the patch.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--1ZrVfO6RKau8OEqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmZnGVcACgkQB1IKcBYm
EmnNrRAAnKc299Uv4LXbaLkPY/Bi3m3PR2SVFR1zYfcuvOU2PYgYKlKv4Yx9o+Y4
52yJrRJ9em1QyAeYqL4F37dTsGZm1IzxZON7vaqKUzdBjq8LbH+cKAhvzyuhO4lB
28pVDwVhVD38ylQe6soSv2t190TpBX6diDlAnAe/8c63Ao6RJ8qA9MEDeLQxTY4T
+FTo3cRHDSAhgcmv/sYO44gd+/TPrELa5aBOsY4ohGQRKhqfa4G3gceRuz6GaJt3
QK3GmrEOk6GH6zxo9RxB8CDyv7Bu0Q5XTjK+HLvzS6IJ53y288KU2BIDtD81T01T
OzR1f3HfjKX0komAk2Iqw8M35kOLqMVlv+39pttbT3cLEslma0vs8LGyuc1FabHd
D+3HR2+3VeWmwHbfEHzQjz73XMPSeqhSvhxfRStXwyiz0BeVpkDiz3tLEchIv2hD
XQdXCQldYlh2AKNXzZomBES30lU42BKs1lyDFCusJM+E1TIkQjWcv5xIrkyQNzES
5gPS24+8HQ9EvRXATZRNNoe7NDt1BTTKtzAZn723UnrSIbi4gfLfVl4zrxf2rQYC
uSJaoQsGqTx7SwETNHSyULk3RNvjyG2JSAv/n3+pszYhw/Qa3tcj7Jd7LWHIT4Nd
gsyro6LCplLpxICG7SLmTl8ZErRUlXBxwndXuiYkklJHLFGlcxE=
=ckY9
-----END PGP SIGNATURE-----

--1ZrVfO6RKau8OEqg--

