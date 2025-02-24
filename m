Return-Path: <stable+bounces-119421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF43A43014
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 23:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9494816DF1F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 22:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C5205502;
	Mon, 24 Feb 2025 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Upq0NF2r"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03D1C84D0
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436119; cv=none; b=h6glv5j8xQKcTmgWFohuWk865d9+JA5rHpvJnT19XJ1pFi4KlhSzoiC8nusfHOSwL3BuklRLsfO5em7kN0fFgdDB5SMZNCn9+bqndBuT/MSclVlkfmT29TNHaZ/m/o342sjzvhDL12b9vVgIeBkjcL+945kZLpOy5IvshfnJC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436119; c=relaxed/simple;
	bh=HUOZgKCB2hsLgwu+4UBAzkClY4TEAdyAHQwlsXPCkYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNIqHME6IT+SsqFvvMKGtD7j5x/Dsw1kBIxP3bSfMtYn0z2fuwz4z0v0Z+8qVH5a1bzdNM6lRYL6SYhGmMcaAPwM52INidKe6ZokityKt+XFQEw4YeUy7QoZIVoyGmeeTPWn6RqJY3ntfQy8ni3XjDqc2ahsdXj2xYOBu/Gm2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Upq0NF2r; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2mE3DglGa17dXmDisT0py0i+F+3GkyW4peakrb1pdvs=; b=Upq0NF2reOIVb2QRDy/gmAs6PD
	kY/CufDTKOQf40k1jzsXgOENfgeKTKekx3Ovo9v89gXk92Be456tV3de34VCPOf/ldw23Vgz4OMBV
	hdAcZmIwhi+ECqde/oxedTIpd/3w1UEpX4uqvh0PA4zsHvchPlB8udQQcpe2ZIv+i8r0MDR9eR6s6
	AoaPZUrDJl0mAzjsA0MoRmaWcjn+mRLlsukNucDvE9IzqflkAzvmhwvZD9j2yUL5urrWN+zWz6ZcX
	DUyFqfCOMi11w3FoeXLDxKOU2cOcQUVRuc69FMMVGO6IK0+euSfTQKd3ffx282xcObR6NUjCIAzAC
	nA4tp2Hw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1tmgw9-000g9x-W4; Mon, 24 Feb 2025 22:28:30 +0000
Message-ID: <29f96d04ceac67563df0b4b17fb8a887dff3eb04.camel@debian.org>
Subject: Re: [PATCH 5.4,5.10 2/2] udf: Fix use of check_add_overflow() with
 mixed type arguments
From: Ben Hutchings <benh@debian.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Date: Mon, 24 Feb 2025 23:28:22 +0100
In-Reply-To: <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
References: <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-z/2kx14fNOtla9rVE18o"
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-z/2kx14fNOtla9rVE18o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-02-24 at 17:00 +0100, Ben Hutchings wrote:
> Commit ebbe26fd54a9 "udf: Avoid excessive partition lengths"
> introduced a use of check_add_overflow() with argument types u32,
> size_t, and u32 *.
>=20
> This was backported to the 5.x stable branches, where in 64-bit
> configurations it results in a build error (with older compilers) or a
> warning.  Before commit d219d2a9a92e "overflow: Allow mixed type
> arguments", which went into Linux 6.1, mixed type arguments are not
> supported.  That cannot be backported to 5.4 or 5.10 as it would raise
> the minimum compiler version for these kernel versions.
[....]

And for 5.15, I think it should be safe to backport commit
d219d2a9a92e.  Otherwise this patch should be applied to fix the
warning there.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-z/2kx14fNOtla9rVE18o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAme88oYACgkQ57/I7JWG
EQnsEA//UTfIQnKYZNsZzvfWpyJF09lNY0BWXwixquUgQ0u1nZU45aRsaLrTuKqH
u4bILlKUS2bkE36M3qxBrV8rjKnBuKJJZhKUP3tmZ6gpQBLimbzBE1fOlMi6/khM
S3Qfx3HLExP6O318WIqYM31pCb3cEKskmBmlk+e4I0ems0++Ln3xDYU/4ucZpOA5
cDw4IzMicmim0zfrWQ5urfiKEvlfvsryDATEKjhDY8l7BEM7gy7xYIEhL6M057ho
8AD3hM8zZHMj1YceOIf/dkbW8rZ3p60gDPBYk6WMPyn4CSau1bKt84Xs1dJLK04X
k3UABCIUntUtIOYtfgi2pdGk14pkBOcNF0j7o5ZDvPQpWBnps+/T8WZZTjOY5eaY
N+EyIiO+4Dv3r5LVR6E27eMppL0dDxMAtXChVUtp2BlrdLRwkN0iZTvznKGM07Me
DFuWoMlCAUy8Fpa3sDRtHJsMe2KtcDy27rZaRFETBI1UTOPimfPAJRqFw2clw7B2
CZQHsL6lwTjoH8kq1Xg4LUi1f7geNpQFy/bgscKZJZXOY68Mog0E2pvJHmBMJGBt
+lc57nYKMKK3qP1vPAwzbaDKMK7LYhbWZYapKm9Av/k9Fr4ajvt050DnCe0BwG24
wpchG0cHl458ONNvjjb3mN9Bdejr8BcC6cM+IPweCxxsq5VgIwM=
=1rH+
-----END PGP SIGNATURE-----

--=-z/2kx14fNOtla9rVE18o--

