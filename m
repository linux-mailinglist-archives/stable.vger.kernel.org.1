Return-Path: <stable+bounces-220011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BqiK68KomngyQQAu9opvQ
	(envelope-from <stable+bounces-220011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:20:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986C1BE24D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2C5309CCB0
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B6B478861;
	Fri, 27 Feb 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="z7X9EOu7";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="BCCXXmrb"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFE38B7D6;
	Fri, 27 Feb 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227226; cv=fail; b=mntBdZBAFi84meIKrAN53EpvWp6B4p7pFvYDC5zgrPE6LtqNbXEYfahmsrQLElUIKZ8eDrJna/EymEKLCPjXkkT9rjw0YWX4H2fsBD0L4TmbKNbb0XTYts3rctS8zt/NTChz4/Zw3qAHZQtz5K0Y3LFoxK/95hEan1mukgXE/fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227226; c=relaxed/simple;
	bh=9nzPC0ZsPsu/r6oXAJKaZqNtdbiIzq6sD5xdk8LPrHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMz8TS3rsX6xl01xSVriN+urIK0noceScBuZMerTtfDUSs9sA2BDLV/ssdM5JpjqOqxM8yHKQccPhDk5/uAxvNpdxSLZjdUcr6AO4bUC6atmUwDg7tBz4BFKXbwRawu8Vf6yUOEz+0jb/i4ja1JDAntNprDeOI9x3sM1+jMjlKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=z7X9EOu7; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=BCCXXmrb; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from smtp.sapience.com (srv8.prv.sapience.com [10.164.28.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 889FC480AE8;
	Fri, 27 Feb 2026 16:20:24 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1772227224;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=gJd6TgK9250Yu/lFChNiTaHU/m7Dw9jCMeHuDEYi+qc=;
 b=z7X9EOu7WKStIr7SpsZkmyBRbTCFhArkvFdqDsZfiN0U7ppFhfCeLCq06WhwDLGwUarZ+
 hH97hHr+ahZBZbsBw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1772227224;
	cv=none; b=oRVlvHqrn34W3vOulff3axV4XKiKaEtN8bgzBHk2gmOzUJTZIue1Gyq0sUH3Qd8gOV/uVT44brHklw2+LCe7rIebqQMFTX/7ldseFuZ7t6ZcOp1sv0ybQf24vaacURwMvSuxRY0lg42nUizKbqrnP+Gb3zdyjdFjrJ4xtIzUoX9vQ0GDEdAVPG/ZQ95eMi1G6AlKIUue+JP6UQHd9i9f9CTXNQvHPe3F4z7mU4vREsHIpVpXbWLt1quUuPZNoxrEGXDDJIXsHLsdohuDrRQL4JRo4ZsLCwsdHKUphz2SjKhz9no0m8nMc6Oq6Kl9wE8gsuEM53AQjecVxD7M05ueKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1772227224; c=relaxed/simple;
	bh=9nzPC0ZsPsu/r6oXAJKaZqNtdbiIzq6sD5xdk8LPrHc=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=F7kuRygx/myIcppdvh4At2GHyWlFDbKLv8QnbT3pOCPZLqZWhPKnq4LvIryLGBYPkmFpnQuO3+XvNv2ZZ7P63r7NAofqHBY1GKwSLzY7pbaZr0s6KBgtPwc/st0leCLiHS6jLW/bukseDZOmCaDcahW3O2pCjqUlhbAi0PcKorsE1I0gR8JfdCxoxuY5YXEv4lDWw9wDqX9OGLu3AV4Joye0anL8rVjhGM02DtkXcSBLl5/8+zGsDIJpmwlQAEbh+rvkwHSINcVEAcp6rscVRuFKvSiCsi95BYQnzkLUuOjfHggk4Lz2IheXxMufLCvRcRIgOCFZK79A4VNub+LK4w==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1772227224;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=gJd6TgK9250Yu/lFChNiTaHU/m7Dw9jCMeHuDEYi+qc=;
 b=BCCXXmrbtFJ1DAsLJCtR5IRA4XRzhTrZbg7v3qjsXETQadqqghJB6CTcOpaKWzep3vZHE
 3uLRwdZJXrpkgjD+wldpHILEooA96MauYgSRUlTT38WwZLcBqj/zlfDFfSfikb0AjEOV2J9
 Q3RY0eBzNDr87aM3cdz8LI+li3ZWuO7zCDyZCA+OpWYFYSJya3rSZEENT4F0baEfNuYRXM5
 zXihdZ1R0B9ySjVUkJBCbE6GGPTP9pGF8GX4+2di782Qd2/csvpafdhzHgpmuu9mR+z/3ee
 cmk6MNwT1NXzyaNH9ofRl2InNjrmOXCRtVoQr/swqCnUcSjXVm/Bq8k8sEyw==
Received: by smtp.sapience.com (Postfix) id 5BC1E280010;
	Fri, 27 Feb 2026 16:20:24 -0500 (EST)
Message-ID: <e6b43861cda6953cc7f8c259e663b890e53d7785.camel@sapience.com>
Subject: Re: Linux 6.19.4 - Oops, regression
From: Genes Lists <lists@sapience.com>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 	lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
Date: Fri, 27 Feb 2026 16:20:24 -0500
In-Reply-To: <8909a57e-22ca-427d-8d41-cbd68895d33e@moonlit-rail.com>
References: <2026022657-clambake-mountable-8175@gregkh>
	 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
	 <2026022612-buckskin-surfacing-d854@gregkh>
	 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
	 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
	 <8909a57e-22ca-427d-8d41-cbd68895d33e@moonlit-rail.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-zU5SOuZhSUt8A4X6puI9"
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[sapience.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[sapience.com:s=dk-ed25519-220413,sapience.com:s=dk-rsa-220413];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220011-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sapience.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lists@sapience.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,sapience.com:mid,sapience.com:dkim]
X-Rspamd-Queue-Id: 1986C1BE24D
X-Rspamd-Action: no action


--=-zU5SOuZhSUt8A4X6puI9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 16:01 -0500, Kris Karas (Bug Reporting) wrote:
> Genes Lists wrote:
>=20
>=20
> I second Greg's comment - "Odd" - in wondering why you need to patch=20
> userspace and/or recompile it if the same userspace was working fine
> on=20
> 6.19.3?
>=20
> FWIW, nftables 1.1.6 (libnftnl 1.3.1, libmnl 1.0.5) is still working=20
> fine for me under 6.19.4 using the .abort_skip_removal patches from=20
> Pablo as forwarded by Greg.
>=20
> Kris

Thanks Kris, I'll try help clarify. Things weren't crystal clear at
first.

There were actually 2 separate issues that happened to hit at the same
time.

=C2=A0(1) the 6.19.4 netfilter crash=20
     Now fixed or will be shortly in 6.19.5.

and=20

=C2=A0(2) a userspace issue with nft v1.1.6 and large sets leading to=C2=A0
     spurious 'file exists'=C2=A0errors.=C2=A0
     This has nothing at all to do with any kernel oops.

     This 2nd issue has been fixed in nftables by commit:=C2=A0

=C2=A0=C2=A0---
=C2=A0=C2=A0=C2=A0 commit e83e32c8d1cd228d751fb92b756306c6eb6c0759
=C2=A0=C2=A0=C2=A0 Author: Pablo Neira Ayuso <pablo@netfilter.org>
=C2=A0=C2=A0=C2=A0 Date:=C2=A0=C2=A0 Mon Jan 12 12:59:26 2026 +0100

=C2=A0=C2=A0=C2=A0 mnl: restore create element command with large batches
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0 The rework to reduce memory consumption has introduced a
=C2=A0=C2=A0=C2=A0 bug that result in spurious EEXIST with large batches.
=C2=A0=C2=A0=C2=A0 ---

This commit came after nftables v1.1.6 release.
Rebuilding nftables with this commit sorts out the 2nd (userspace)
issue.

gene



--=-zU5SOuZhSUt8A4X6puI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaaIKmAAKCRA5BdB0L6Ze
2/mcAP9n8Z6T52eJDe+eZxYMb34iaTG/duF0Y8WbqtiLEfB5HAD/aSvBOsX+YZFr
O0qk1eTF3AVKKHNIlm6uSPWKhEPUpwI=
=jMmZ
-----END PGP SIGNATURE-----

--=-zU5SOuZhSUt8A4X6puI9--

