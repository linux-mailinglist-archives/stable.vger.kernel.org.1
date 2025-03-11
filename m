Return-Path: <stable+bounces-124061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5DA5CC4F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25C77A6ED3
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2C260A21;
	Tue, 11 Mar 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HPC6AvGp"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422381D514A
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714561; cv=none; b=ucaKYAEJK9q03ON8LhS/cSjEPuPJNPsrcuu0RPMgIVXlD5IdQFy2ggAqt7XPjqrIsPFvcgR6Q0HFZOC4SlNMwi+eDm03Jiroll1JXdrPJ51psFJu7+gfwoiePGs2+D74CNy0Sz+77xYr8uxJd5T54Thf76c5cIjcSoegEIrUXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714561; c=relaxed/simple;
	bh=8Y+kIiH6iKaquBeRE8JOYmv7po0lqghShjlJK6YBnE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwZZ34MpBvOSXppoAIo0XDzww/oi7QqV0s1t0RbDZI+9u5TnNcF83LgOGntuay0L+NWhO7TpVHC/m/rjggo35ETarYdxxP7wDU4KOn2/GwTHaQ2jaU8Lx6HLK7knklxjR1StCSMYozmwVwQiHECpiL7KbrZ9cLIZoe3hZG+lJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HPC6AvGp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WIPa+o2R1gTg4hTLhSiMuS1Mj6VpHq9QRjlUrFZYEaQ=; b=HPC6AvGpmX7El0wYcI8gvQ18Lo
	IVCNJdy1ZkYdj2rxya7erFcQA/D3u7wH8+Zwnh8QfbiXf9mvzYLwUVpywQD/zdHFtGetpGXPFNKa0
	bv2Rl+ZMIIUVz+rv1HF/MXCWPrf5/+AxGff7giNh+0eB/StR+Nr/gihJpXrQHOQTe1BUw8uP7CGuI
	xQ7G2CjMjhrlO8hyWzrw+JQkwqpW2jSPOytORvjrOGY5nWHMEhSsAHEH4w4BhaoGRlChAfzRQlgUC
	QvKq4Hnh4naDZXJ/JvCUnryZSGWC9gd9jlgLxlEJdC1iaozPlG4F6/wDToeSiTfgVS45fgnkTPkd6
	759emxVQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1ts2ya-009oQg-KQ; Tue, 11 Mar 2025 17:01:08 +0000
Message-ID: <3a8557b9237ab9fc31f8d10e9a7912560af68dbb.camel@debian.org>
Subject: Re: [PATCH 5.4,5.10 2/2] udf: Fix use of check_add_overflow() with
 mixed type arguments
From: Ben Hutchings <benh@debian.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Date: Tue, 11 Mar 2025 18:00:58 +0100
In-Reply-To: <2025031054-kiwi-snowdrift-678b@gregkh>
References: <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
	 <29f96d04ceac67563df0b4b17fb8a887dff3eb04.camel@debian.org>
	 <2025031054-kiwi-snowdrift-678b@gregkh>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-z9ziEy30bPiCgHoOU7xe"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-z9ziEy30bPiCgHoOU7xe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-03-10 at 17:29 +0100, Greg KH wrote:
> On Mon, Feb 24, 2025 at 11:28:22PM +0100, Ben Hutchings wrote:
> > On Mon, 2025-02-24 at 17:00 +0100, Ben Hutchings wrote:
> > > Commit ebbe26fd54a9 "udf: Avoid excessive partition lengths"
> > > introduced a use of check_add_overflow() with argument types u32,
> > > size_t, and u32 *.
> > >=20
> > > This was backported to the 5.x stable branches, where in 64-bit
> > > configurations it results in a build error (with older compilers) or =
a
> > > warning.  Before commit d219d2a9a92e "overflow: Allow mixed type
> > > arguments", which went into Linux 6.1, mixed type arguments are not
> > > supported.  That cannot be backported to 5.4 or 5.10 as it would rais=
e
> > > the minimum compiler version for these kernel versions.
> > [....]
> >=20
> > And for 5.15, I think it should be safe to backport commit
> > d219d2a9a92e.  Otherwise this patch should be applied to fix the
> > warning there.
>=20
> I'll take either, whch do you want us to do?

Please apply commit d219d2a9a92e to 5.15.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-z9ziEy30bPiCgHoOU7xe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfQbEoACgkQ57/I7JWG
EQnQfxAAoGWkCI/zUezSrrfWjXeAUNNz9FHuE2iffWgff6IDotSmqbYsotTLZksQ
5M91nnQCMweD8qMmHef5t/HtlsKudEYHRATvHpHG05yR0jB+AFrzXnzJ71JwmZOB
nwPpZhTcEQeI6Fq66bI/pI31ol2XteMhQZu+CZOqzKazB/47ChUAm9Br3Ln6oewu
82BBUWzwqOgsWvxkVEBgXp9MwAsPSeDq/7qi3vNmFlJxM1zNE/8n1egjqs6uGNU1
XwZuC5mBA9QsVv9kEAejS7+8U3073EWeDILboWec1QUwnOdDy5kQGaqI/UA807OM
wokU0bdJ0YbM6QWPuE5QYeOsE1eG+nRpu5o367TO61mJlmpmXxBpK++6Gx+1JS5M
6nYJgskYFoTfPDt1DVQTP0vgTWrDkI3IG1BFoe6SW8v9jqJxENS8zBhi4BQBJX/u
R54/H0mz795cKu7xnrrsTVMtPMPxVQuwwAOWUo9i1LaGDsfu2rf59cg6Epfb9uy5
wrj1yD/xgbxIC79HzmxuZuznEuR5QS18EDLzeCpvjwdeXRDe2DoPpxXXgXegZgMY
vt1lKZN5U/sx/4Xt3fu1HXWBNq3FEJ19anF/8INXKt+UDDZ/pO+kWbWuT1hJ4zVH
jp2MU9mbRLNDXIY55Tng+hx4JTinp+eo86c2B9x1+LE6vwX/Vww=
=+Oeb
-----END PGP SIGNATURE-----

--=-z9ziEy30bPiCgHoOU7xe--

