Return-Path: <stable+bounces-98867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD059E613A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBE62838DA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD191CDA05;
	Thu,  5 Dec 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="1Fcraesx";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="YsKQ41mJ"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0B1B4123;
	Thu,  5 Dec 2024 23:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441080; cv=fail; b=IDop0b2b5qJi8DB/l3tC72wHOwoqIsatW6OiEpIM+uACa8TDImqeIL9wYWJdPA6nVz+pN3WbxRI8pM6lTWZGqWXClZrtZMj+H3e+X4wQpl65gZJq0Lok5ytAtgPr/uXE76WEJGGaZb467NGGW1BgtQ4Oc2FfBmXXuQigFJClnKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441080; c=relaxed/simple;
	bh=cPY/rcKLg7apIyeqaXIPA0hFJME3AW7ueKuJEfB3/zM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j53jPf8ynQXnkIJh/vOuQ2Y7yzPuSTlrDAf/v2mI9B+9lLLMqsuYcC4ejWM1Z14f9psCRL4h4zEOGyOF24prV/Fs2pESNEJdTgLqD4qMbpsI+po22DzJE8PDjoIIvT3M4vIulH498rwzlav9w23bRnvMtRDJ5UiCgCptGPEY+YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=1Fcraesx; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=YsKQ41mJ; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 64CEF480AB4;
	Thu, 05 Dec 2024 18:24:37 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1733441077;
 h=message-id : subject : from : to : date : in-reply-to : references :
 content-type : mime-version : from;
 bh=cPY/rcKLg7apIyeqaXIPA0hFJME3AW7ueKuJEfB3/zM=;
 b=1FcraesxglsCtV/5zgBlM47lyj6Kx7g+Uq0qbUpt8j8pftJ5gpWVKQ6JCYG02nD3O2FKa
 4PhezKih98VoxU2Bw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1733441077;
	cv=none; b=klyuSU9x68Met0CFh7N4nSiSvuKqk2F0H2p37CQeFwjfjFifp9IfEZls1toaQFv7psnQTnpJmPqEjFeAWH4GR9WACsO7puuPCz+r5c+Z9apuj7H3eQBz6Yq3SugedPtyNfKyOn9E/oDfWjTAlDkLiJ8tn8yN8G2wYtYlsaR9zjM6SSe6CNeOYIQpG3GVM3zqoUaN5iWhZHUEeQTvIuLdV3gFhX4H2qz4w89sB7N13olJSjOa4fol7AnCU0ySnsvf/z0F07myz8ub2KGA5KYiNuX3qNY7qIif364gctLl06jxIvUKKAMfDnFBKL3D6fjClATCKlwBL+ZL8siFs/Wrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1733441077; c=relaxed/simple;
	bh=cPY/rcKLg7apIyeqaXIPA0hFJME3AW7ueKuJEfB3/zM=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=pNh91NHeHQt2aDW5I6CShBTS+y3MXaQQmcnb5gwTWfOp6+RYNz2DzmXuUtA3HQjUJpWiG638o52nc6QcIdqPCDzUTpDW40AW8Uuaehi/YVDPMYX0qMqeQiBnwrZDYi+sN4lYe2t1Lk8TReQPBwtzc+hBDOepD1YxZtUDTn7y6WTgpdtTeV+EMklSIO4yMgPxwiQBo9CXRFUTolsWS7U/LYavpRQZ7tdLVvwO8hLeSO9/ueRvTpUvOC0S2UqQhJayDB3GQ3avq6Q2i0b247h7jUoO7cnwH+ia17TFsIFDi30/W5ajqw2OkGFZPwl4qywsh+S5styF2ZHNN9D789/iNg==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1733441077;
 h=message-id : subject : from : to : date : in-reply-to : references :
 content-type : mime-version : from;
 bh=cPY/rcKLg7apIyeqaXIPA0hFJME3AW7ueKuJEfB3/zM=;
 b=YsKQ41mJ7/wElQvIysdVqWDfa57VbrcQtzBZkBvq5+SVbCpW7n+cCzNfsgCNjbDxYb7J3
 yoC4HRrvloqu/siWf+8gallCBH5bzReqvVGJYP+yAxJQA4myl/EqZtUTqoLxoIvd7fijOdt
 Go/frozdO7VvT+vL4SpVurpxdKJK/mC2V63rHbgVrnmE8PgIm7ZrNsown2qoA6KVJcySked
 FPYF2Jzca7pwaJsUO+h6IxIJRHXUp/KzptZrRw+XlIRzB4oN5GHYH15swzN7wdptMcJj/vh
 B5gTSU9IBWl3RSdmKHnzg++krQu4hNg2SymVYM8/ZIwDBh9rX6rnYsc88qRQ==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 206A4280050;
	Thu, 05 Dec 2024 18:24:37 -0500 (EST)
Message-ID: <136fbb7aedc6e3750f8361309609ddf4283cd91d.camel@sapience.com>
Subject: Re: Linux 6.12.2
From: Genes Lists <lists@sapience.com>
To: Holger =?ISO-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 05 Dec 2024 18:24:36 -0500
In-Reply-To: <01a7263b-3739-582e-aade-6d9d9495500d@applied-asynchrony.com>
References: <2024120529-strained-unbraided-b958@gregkh>
	 <bad6ec6fc4e8d43198c0873f2e92d324dc1343eb.camel@sapience.com>
	 <01a7263b-3739-582e-aade-6d9d9495500d@applied-asynchrony.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-NT4Z4Mdj94hjuaRs8wWQ"
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-NT4Z4Mdj94hjuaRs8wWQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-06 at 00:07 +0100, Holger Hoffst=C3=A4tte wrote:
> > 6.12.1 works fine but 6.12.2 generates lots of errors during
...
>=20
>=20
> As Linus has indicated in:
> https://lore.kernel.org/stable/CAHk-
> =3DwhGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com/
>=20
> the problem is the missing commit b23decf8ac91 ("sched: Initialize
> idle tasks
> only once"). Applying that on top of 6.12.2 fixes the problem.
>=20
> We just encountered this issue in Gentoo as well when releasing a new
> kernel
> and adding that patch has resolved the issue.
>=20
> > Thought it best to share before I start to work on bisect....

> No need to, just add b23decf8ac91 :)
>=20
> cheers
> Holger
>=20
Excellent - missed that completely.=C2=A0
I will stop bisecting now, thank you so much.


--=20
Gene


--=-NT4Z4Mdj94hjuaRs8wWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZ1I2NAAKCRA5BdB0L6Ze
2+TiAQDhPOk8JkWxpz7R2S5bQbL4xWHkHs7TemE1HrxbMpvsyAD/RNaEg+jAgnZY
YzAOrgBSuKGA54hQF8ke135TMaqVjgs=
=OaZS
-----END PGP SIGNATURE-----

--=-NT4Z4Mdj94hjuaRs8wWQ--

