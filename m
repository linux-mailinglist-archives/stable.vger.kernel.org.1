Return-Path: <stable+bounces-219959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNcOMDOaoWl8ugQAu9opvQ
	(envelope-from <stable+bounces-219959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:20:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E01B78D2
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E1D3044154
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715DA221F39;
	Fri, 27 Feb 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="8q+ZRjNX";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="GosyYij7"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FE8462;
	Fri, 27 Feb 2026 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198335; cv=fail; b=jEbtrVaUxuoVQL0B8ukVt1FfPPtr5s3Db5fyywdvKSzQrlM8yEMUwHtTDe0WU8CjILwk2so3Zw5eoyFzMg5IDcob2GKTn//SHdiepEQftmflMqQ4MSJmV89dWOAN2wk39UGA3ClWrkbA04txqt+eXl+RxHc0MUoWUl5tNrV9lG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198335; c=relaxed/simple;
	bh=lZpZZAQ3rrfrUiVJ1tr4mTFItT24hNVdlRYi6k6Nz0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+kz6c3OoxpxS6CuOVPq9LQeFOZE6qJihhPw9dySw8d3B2FGaeV3knlG7yT7wBv5NzdEXgrKOONNOq/zfCwDig1Q+f6h8v72e5ybA/ktMS6KJryb/1F9SjHKRJFzHq4At7NTD/MIs1I9lOiIktcmMeJo1z3hIPPOrXbo2C7OlSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=8q+ZRjNX; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=GosyYij7; arc=fail smtp.client-ip=72.84.236.66
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
	by s1.sapience.com (Postfix) with ESMTPS id 4EFB8480AF2;
	Fri, 27 Feb 2026 08:18:53 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1772198333;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=GpQfItAkpVGQK8fIjOm3axg4IKomCKqWmx3uYC64GPs=;
 b=8q+ZRjNXrq8YFutq1MgpWhdxiecWjp5avRnkZNGAKqUqzGaVWgAfY1lPjsBangYIlzf+6
 EnX/gWGDiVOv7WrBw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1772198333;
	cv=none; b=uh1KcZS3qdx7XQB6hXQWNK2RjBJ4rNwb0W1T0nRCR9/pOpusJMp6jsqjZ4JFaUKBQMqcUwPn55636SPNqkdkIxNoxp9hJHsRMAZmhzjYirw/BRcetBXRAJunNgKeSh7olTdQ0HzJ7yL42R+uc8aCvGz/BrUeQae0iNHZVS5ETbrHPWd0DPmmz0ZJ213s2cC8Ja1DZIB5xZsBVrm8P7d4Kg4LFClXo6od2zErfJkoFS5SKcBkDhFKnEPRaIcqzT1SgXCGaY2gd2thzRDn0degvms8nw/dSvfkZ2gtfSs0/olSPQuOWlxJRHRhk71zHFsTFDlDP9WbxTXv5bPdQcn3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1772198333; c=relaxed/simple;
	bh=lZpZZAQ3rrfrUiVJ1tr4mTFItT24hNVdlRYi6k6Nz0o=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=WAN4t6uWX3kolDAlRjr1E0fsSvBmhVNBMAiMhXpd+txLvIqTxunCIYa7iR44wucaX625eWVYsM0/1/bnCLKTurCAfJKKWzTSljHl2TV6OPlfQ/gmEG6cFABN9ZZcPTV0Mvw3aRNwoCHDk78TSZUgAyUfqVKaljMupjvE16gbVTCxu3g1z72mu5T99tUfCQEyzdkA+xvOLTzkXn3dfUCZT1TaKdjwGi0RhxEagk1AebnE1xbmAmE7u/d6Cn6RoaCO7/U+qe+WlnxiDgSidZHXdORF9+ZvYaZmDB1RUZupqFSHz15UmsuWVTngSA93hDlpuiS/2EDUj0mikd5zG6virw==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1772198333;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=GpQfItAkpVGQK8fIjOm3axg4IKomCKqWmx3uYC64GPs=;
 b=GosyYij7EPn3ytUasXCguE1TIGeSm7bpWAy2iG2VrEA4KdmWX0W9y51++gcpTDoHYOnnS
 AoxgcvJoWIkFuDQMcjqTMVZ3xsQnv42v8E+1L7JZzyq1tO4wCczELTyg3Vhc/wONiSAwxXK
 6d7fEGF1y4aUF9IFpuqbi5azkJUYds+LAtGjWBdfcGqHUcZ/XhdzwRLAP25speY6TTEYbXO
 kCIBrH7VodCpuZTQAJWtMBTCoptL2J8VVOTXsRqiVcTPUKUUH9IKrlj2Nsx/q74GsRShLn4
 Hh3Y7wqI48ib3uwLP3ZlBMRnCjd166wsC33NOHK6hpy0qJI1pdLrsuE9yI7w==
Received: by smtp.sapience.com (Postfix) id 1AAD5280010;
	Fri, 27 Feb 2026 08:18:53 -0500 (EST)
Message-ID: <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
Subject: Re: Linux 6.19.4 - Oops, regression
From: Genes Lists <lists@sapience.com>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 	lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
Date: Fri, 27 Feb 2026 08:18:52 -0500
In-Reply-To: <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
References: <2026022657-clambake-mountable-8175@gregkh>
		 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
		 <2026022612-buckskin-surfacing-d854@gregkh>
		 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
	 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-E2fVhgLw55Odqj4x1ZIh"
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
	TAGGED_FROM(0.00)[bounces-219959-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 174E01B78D2
X-Rspamd-Action: no action


--=-E2fVhgLw55Odqj4x1ZIh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 07:09 -0500, Genes Lists wrote:
> On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting) wrote:
> > Greg KH wrote:
> > >=20
>=20
> =C2=A0 Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
> =C2=A0 ...
> =C2=A0 In file included from /etc/nftables.conf:134:2-44:
> =C2=A0 ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
> =C2=A0 Could not process rule: File exists

Sorry for noise, not kernel related.
Resolved by updated userspace.

Resolved by rebuilding userspace nftables on 6.19.4.=C2=A0
I used git head for all.

 nft rules now load without error using:

 - nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
 - libmnl   commit 54dea548d796653534645c6e3c8577eaf7d77411
 - libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc


gene

--=-E2fVhgLw55Odqj4x1ZIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaaGZvQAKCRA5BdB0L6Ze
27sqAQCsQ8635lYpK+8+8R0GCm2KlZUa2W5I+4YgXdj9LbwcowEAlgtNo27y/TEY
pJ3jGcE/P8Z+kWFLY5SjCepAyEjujAM=
=YhXp
-----END PGP SIGNATURE-----

--=-E2fVhgLw55Odqj4x1ZIh--

