Return-Path: <stable+bounces-219949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FXaL3WJoWmtuAQAu9opvQ
	(envelope-from <stable+bounces-219949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:09:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B021B6F2D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2D2303E4A8
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D03A0E97;
	Fri, 27 Feb 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="OqFyo7MY";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="LHReFFx/"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62245313E31;
	Fri, 27 Feb 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194142; cv=fail; b=DSNeM8ZSbaCrTbQR31RlM6GNKcomBkeaWSZtvxDn7M+aHQc8hI3Cf7PfRtpfrPfeosyLDWJ6rGWhl/UodL84KPN2fcoDONO469kyubqhv6zbs0pJJNr/JfGvBuVAKyVNTEd4N6yivCSgk8AOajl7LJAH6XwmpPOUNCQqg/HA0U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194142; c=relaxed/simple;
	bh=NdAqzqQBhbDAelzCm7JyiB2DI8nPTe7kXccb8l58unY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CWU4gKa7i4GUD5n4x0f3f2f2lsnUo2ACIqtay+/BLFeoYHeB2YEd4jcc+rJevYER5HMYym8w6rI4tjo2JNOkyJuQqZXkMrEggz0CDSsYnsbzGao8rN/i3EQWnrVzXbP0lNb4EPcXdKs+NhbHNEXBJSm0FGX4nKq+5hco++blUIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=OqFyo7MY; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=LHReFFx/; arc=fail smtp.client-ip=72.84.236.66
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
	by s1.sapience.com (Postfix) with ESMTPS id 57532480AD5;
	Fri, 27 Feb 2026 07:09:00 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1772194140;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=7Bc/mBgP+hkcJxfUgFkJnt+eN7XZprBmrRE8B9lziDg=;
 b=OqFyo7MYifVzokOFV2Gh/AcjSwHsJMQ2unv7VXt8XGtwArGihP6eIgwEZFG48/z42dUCj
 jPq3NK13w3hhjWlAQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1772194140;
	cv=none; b=tChmMxRJSixV8iAZIQAc88Wg8ZUZOhrrvrtQPLXWy6F+0Q6qpG0b8jbBx1uhmF2tfczOkF43LWk1dVYcWWRE21mLPK7KLo6GLzJZMe2/FG2tltqRaX9ckm5rt1MX6ErwZKUh0ryoDuNGZ4DdUkgRJ3yvMFjsQ0El+MkRBRI8hEIpw0Jq6mmZhQpI7to1gNPiWBpJu0dthI7u0rz929MwsAETDFjB6ZO+mMWFHiVd7yNiWBUaUw4VVYMwAcKgp2Wa2PAfpcMm2pcn1AHHy0l1+SCfH+QJA5oxL1YbMbCWEUR4fYMezKCF0uZnAd111CBLTc+rcQ87Bs7l91xpPEm/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1772194140; c=relaxed/simple;
	bh=NdAqzqQBhbDAelzCm7JyiB2DI8nPTe7kXccb8l58unY=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=cYXlsxlramCCqUatb32ZGDgv22VPRsR8EMonDLsqOkzw7xqjHvO+uL+lGUVxBcIHOJ4kfEoqZBI0ylCLi8z6ObZU66A2Ag6IqbcC4FP4B8KTkWGGWHMLHo8rs5QbwHQJEra3Uo6fW80GUlY3CjJMhU9RLdVNgwp+jy8xoGVj6iDiiYFUTtqshEisjerHQhl2eqIi6Ki67JNWErbBJSA4JXshKhyZtcf69P+NgSZ3S/dEDjb7CspHLZR5ySnQISGG/n+6TK8NurFqlhbwhStJnIlr6nxMCrukc81UQt1HG96IMZVpn+cEwY4oA3yPvFKIaldTwYB1hUK/X550BGT3dQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1772194140;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=7Bc/mBgP+hkcJxfUgFkJnt+eN7XZprBmrRE8B9lziDg=;
 b=LHReFFx/qn5ceqnBG76w9i+8cpXM4BnMuS91KmXHalwqrqz+nQkSmtorB2ZXjlL0fduQX
 hmt9DrPsUpkT5QRVptk3eJm5hxscIqtmLAb7TofFoMR6FCXKar/xJPADilhNZesVi+XdNfi
 z5K9z5KK8wIsFeM/BQtyhX/7EwhgYcRn0/63AoWWs6RzkOhfD6zzPXRaFjbJ9RYLifFutHd
 jerWmYNIAjxOKOXHHzFFR5Cc0W3FAmO89pwIhy3JDqLIVxRn3++NPF5ZnHqWXaz/1Ojqmg/
 2OgtuDPcpgNhJTsQ6/+630k1j81A3oOuzq1pSM+LeHvhELjahckxcpn5EpCw==
Received: by smtp.sapience.com (Postfix) id 34C83280457;
	Fri, 27 Feb 2026 07:09:00 -0500 (EST)
Message-ID: <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
Subject: Re: Linux 6.19.4 - Oops, regression
From: Genes Lists <lists@sapience.com>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 	lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
Date: Fri, 27 Feb 2026 07:09:00 -0500
In-Reply-To: <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
References: <2026022657-clambake-mountable-8175@gregkh>
	 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
	 <2026022612-buckskin-surfacing-d854@gregkh>
	 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-kYquzTJF+yQ0cNPJv0N1"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[sapience.com:s=dk-ed25519-220413,sapience.com:s=dk-rsa-220413];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219949-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sapience.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lists@sapience.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sapience.com:mid,sapience.com:dkim]
X-Rspamd-Queue-Id: 03B021B6F2D
X-Rspamd-Action: no action


--=-kYquzTJF+yQ0cNPJv0N1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting) wrote:
> Greg KH wrote:
> > ...
>=20
> Bisect complete (from 6.19.3 to 6.19.4)
>=20
> > e308d4e35ce1e26cd67070a7035ad265662ab9e5 is the first bad commit
> > commit e308d4e35ce1e26cd67070a7035ad265662ab9e5
>=20
> Kris
>=20
> P.S.=C2=A0 I ran the bisect from 7.0-rc1, so many reboots there, and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it is fine.=C2=A0 The bug only seems=
 to affect 6.x

In my case, 7.0-rc1 also boots just fine, but when attempting to load
the nftables rules,=C2=A0nft gives an error and rules are not loaded. The
same rules work fine in 6.19.3.

Do you anything similar?

  Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
  ...
=C2=A0 In file included from /etc/nftables.conf:134:2-44:
=C2=A0 ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
=C2=A0 Could not process rule: File exists
                 xx.xxx.xxx.x/23,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^=
^^

The line falls somewhere in the middle of list of set elements that are
all ip addresses.

Reported here [1]

gene


=C2=A0[1]https://lore.kernel.org/lkml/a529a6a9a2755d45765f20b58c5c11e2f790e=
acb.camel@sapience.com/

--=-kYquzTJF+yQ0cNPJv0N1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaaGJXAAKCRA5BdB0L6Ze
21plAQCfvThBAm3mxxhRRIznnWn2U3qnveoX+FTSSM+d5m8KBQD9Erhm3mlMRH3I
66YCe18KP8+yIbBsyd6C57h3lvR5HQw=
=ixJv
-----END PGP SIGNATURE-----

--=-kYquzTJF+yQ0cNPJv0N1--

