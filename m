Return-Path: <stable+bounces-28364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41487E9EE
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 14:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C79B20C18
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135D38DCC;
	Mon, 18 Mar 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="KfGrZM0B"
X-Original-To: stable@vger.kernel.org
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9533BBC3
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767721; cv=none; b=C8gO/ykBqQiNB6YM6qcCHcqTNkTebpvzFOK/za59FbvvUbwJu3qn79Eke8330SHCpefw0JKAcPZZo4fpLyqA/py+LKzOKGqH8c+Pm+mreGb/F/I/9WMQhpotVIpn81uu934vTNKVgQ/YUWiulPa6LTjX5hueHqV+a18uBlDHKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767721; c=relaxed/simple;
	bh=1XBByTK9DjWO/DFvSmlMo/lt91DVDV5uNytS+AKDCLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jcqcg1h+dNQ02G6k+ubmQ3bCD8oqHc2R3VwX1cn2zHRzzqXMgSXJ7Y7zhI9Uj/30H/nasorpcITnECxEErT1V952HtuGGmO92UE4Ger3eBOnK7wmFVdMYcBVYGpyGOuCu6DzKfDf5eHGS78k1pdUMv8sOWNc4h6Qq6guQFtNVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=KfGrZM0B; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Received: from email.seznam.cz
	by smtpc-mxb-765b87775b-k85z9
	(smtpc-mxb-765b87775b-k85z9 [2a02:598:128:8a00::1000:3f8])
	id 5e2d7064e817dd7d5ba26a2c;
	Mon, 18 Mar 2024 14:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1710767679;
	bh=1XBByTK9DjWO/DFvSmlMo/lt91DVDV5uNytS+AKDCLQ=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type;
	b=KfGrZM0Bv/cN8spP2Z2uSn/zGApnAPFNa3oF8XD06KZR/w9hfRJrw5rMwFCZ1RQMf
	 a+56a9a6RX5GdKmy4x3YBigRuqxIJsVYO/WAJmf4T8jlDaHW1xuIOCdbgW3zo4he3V
	 xFKT6UzVsiOkeB2hRYvbRBiAg1WpKXncYkFKBQ5XtJY9YBAA/q0lzwgdmzbUK+5XI4
	 7fO7UmUh4cJDofj21ZUy2NgKR9/ZWUUAJ+kjEmPdeR+mvSZp/BuiNZgmAl6KTeCkFT
	 r5IxAUDCIaQ/DM7Jwloc5E3R8CkADpEoqWjHpsXon7rRmfJs7rTnQStHVuCnwjSMl2
	 /dZ8CoTNN/39A==
Received: from [IPV6:2a01:9422:904:1ee:e65e:37ff:feee:e29c]
	([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-594d8f6859-2ldrj (szn-email-smtpd/2.0.18) with ESMTPA
	id 4c250af0-e637-466a-9a24-3b79821497e9;
	Mon, 18 Mar 2024 14:14:36 +0100
Message-ID: <92898285-e85c-4e72-a179-70fb65349978@podgorny.cz>
Date: Mon, 18 Mar 2024 14:14:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
Content-Language: en-US-large
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz>
 <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
 <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
 <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz>
 <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>
 <35ae3208-a0ba-43a7-ac4c-6f770b3df405@podgorny.cz>
 <CAMj1kXHO_R4XpQ=To1ZW_yac_sjWFPnw7pjunn0UmraFDA2wCg@mail.gmail.com>
From: Radek Podgorny <radek@podgorny.cz>
In-Reply-To: <CAMj1kXHO_R4XpQ=To1ZW_yac_sjWFPnw7pjunn0UmraFDA2wCg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HEnKX58qu80dj0vSgweuWTi0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HEnKX58qu80dj0vSgweuWTi0
Content-Type: multipart/mixed; boundary="------------GmtRFQGqL2eqf8NcZm5hpxEY";
 protected-headers="v1"
From: Radek Podgorny <radek@podgorny.cz>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
Message-ID: <92898285-e85c-4e72-a179-70fb65349978@podgorny.cz>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz>
 <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
 <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
 <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz>
 <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>
 <35ae3208-a0ba-43a7-ac4c-6f770b3df405@podgorny.cz>
 <CAMj1kXHO_R4XpQ=To1ZW_yac_sjWFPnw7pjunn0UmraFDA2wCg@mail.gmail.com>
In-Reply-To: <CAMj1kXHO_R4XpQ=To1ZW_yac_sjWFPnw7pjunn0UmraFDA2wCg@mail.gmail.com>

--------------GmtRFQGqL2eqf8NcZm5hpxEY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGVsbG8gYXJkLA0KDQpzbywgaSBoYXZlIHNvbWUgYmFkIG5ld3MuIHVuZm9ydHVuYXRlbHks
IG5vbmUgb2YgdGhlIHN1Z2dlc3RlZCBjaGFuZ2VzIA0KcmVzb2x2ZXMgdGhlIGlzc3VlLiA6
LSgNCg0KdGhlIGxhc3QgdHdvIHBhdGNoZXMgc3RpbGwgbGVhZCB0byBib290LXN0dWNrIHN5
c3RlbS4NCg0Kb3ZlcmFsbCwgdGhlIHBhdGNoZXMgb25seSBtYWtlIHRoZSBkaWZmZXJlbmNl
IGluIGVycm9yIGJlaW5nIHByaW50ZWQ6IA0Kc29tZXRpbWVzIGl0J3Mgc29tZXRoaW5nIGxp
a2UgIndyb25nIHBhZGRpbmciLCBzb21ldGltZXMgdGhlICJpbnZhbGlkIA0KbWFnaWMiIG1l
c3NhZ2UuIGkgb25seSBub3RpY2VkIGxhdGVyIHNvIGkgY2FuJ3QgcmVhbGx5IHRlbGwgd2hp
Y2ggcGF0Y2ggDQpsZWFkcyB0byB3aGljaCBtZXNzYWdlIGJ1dCBpIGNhbiByZXRyeSB0aGVt
IGFsbCBhbmQgdGVsbCB5b3UgZXhhY3RseSBpZiANCml0IGhlbHBzLg0KDQphbnl3YXksIGlm
IHlvdSBoYXZlIGFueSBvdGhlciBwYXRjaGVzLCBpJ2xsIGJlIG1vcmUgdGhhbiBoYXBweSB0
byB0ZXN0IA0KdGhlbSBvdXQgKGFuZCBiZSBtb3JlIGNhcmVmdWwgYWJvdXQgdGhlIG1lc3Nh
Z2UgdGhpcyB0aW1lKSENCg0KdGhhbmtzLA0Kci4NCg0KDQpPbiAzLzE1LzI0IDE5OjI1LCBB
cmQgQmllc2hldXZlbCB3cm90ZToNCj4gT24gRnJpLCAxNSBNYXIgMjAyNCBhdCAxOToxMSwg
UmFkZWsgUG9kZ29ybnkgPHJhZGVrQHBvZGdvcm55LmN6PiB3cm90ZToNCj4+DQo+PiBvaywg
d2lsbC4gdGhlIGtlcm5lbCB3aXRoIHByZXZpb3VzIHBhdGNoIGlzIHN0aWxsIGNvbXBpbGlu
ZyBzbyBpJ2xsDQo+PiBxdWV1ZSBpdC4gOy0pDQo+Pg0KPj4gYW55d2F5LCBzaG91bGQgaSBh
cHBseSB0aGlzIGFzIGEgc2VwYXJhdGUgcGF0Y2ggb3IgYXMgYW4gYWRkaXRpb24gdG8gdGhl
DQo+PiBwcmV2aW91cyBvbmUgKHRoZSBvbmUgd2l0aCBic3MuZWZpc3R1YiBhZGRpdGlvbik/
DQo+Pg0KPiANCj4gT25seSB0aGlzIG9uZSBjaGFuZ2UgcGxlYXNlLg0K

--------------GmtRFQGqL2eqf8NcZm5hpxEY--

--------------HEnKX58qu80dj0vSgweuWTi0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEydMGi3nQKasCS8bLahNm1VQL0ZwFAmX4PjoFAwAAAAAACgkQahNm1VQL0ZwV
XA/+LeywJlMRtbDUGsigXD/P3YAyO7gIG/+Gb5y9TT0qPaTcGCIVM8qvtLgwAiYE4VSZaolvzzji
sC9L6bnHinScLGtuFf3apq+ZS5rct/Pfw8WiVQbMHIMMNDXNZhBcsW0vrksztSJhsixXyHoqJXmI
YL8foRBnmPSFnmKnOXYOw6+wWipYdNtGrjAH0NkO0PxHNS7+2hoia9x0LtDsMd42VhDgh/FjT4TF
5Z3f7Mi4vUdbgsulJi/cJHGQ62aNWhXuRa34n6frthmv6YzoV9KbOylibfEHOfK0PjBQhQZV5VjH
lQPurUbTzFQSdvjk7kJ8f4xgNaAzmNx1ceU+ya5RCgMJ8aRmlR6/2HnPotuJ569dDJbuPNBOHhBl
nyGrn6+/bwZd78lsSZNFJDPPZf8jg70mpUw7zz6fLW7eGFUu13xuF1phw9EBONG0O1UyFZeYy/YV
pY02835gtkX9Rtm1ZURvRQx8xdK8wOFMtPp8L4FsQL/0p+A0e4SVw3504Vt1VCyROo/Ws65zO0Uw
M4nVPS6c8YW7S7vjztbsP5PnVSk0yilBM25GvHbmDva27Q6oAM1S6SXpVO3lSZqvA6BPL+j+Snac
TMWkfvjvSmUCONxBjawvwn9myp7r+2RY/7p0wdmuImQ73em6eqj8ZZmzVuWYCpgpuqujhP5T7tvO
LAY=
=zCyH
-----END PGP SIGNATURE-----

--------------HEnKX58qu80dj0vSgweuWTi0--

