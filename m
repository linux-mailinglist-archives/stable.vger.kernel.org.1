Return-Path: <stable+bounces-28247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB887CF78
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B122825BF
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E138380;
	Fri, 15 Mar 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="kl8XrhMc"
X-Original-To: stable@vger.kernel.org
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7F381B4
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514321; cv=none; b=aL9rH9s7lmFrscACFlJmRyG8+/lxouByQ64f6SEaq+9W1mtyMd4lYt80SuK6nTIipsaupVDPnnvGGNNcEXpcwCZSQP2y8elPjPANwpj8wtNHpktr2hD1zA6VBIa8DKCvLF1l2IymmmWUnP9jMnC/y0HXHKBC4XmboiEjpR+eLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514321; c=relaxed/simple;
	bh=dOwhBo0NeJjHvCrIemZZp50EMXX1nAE4hUqkSh+64g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6xZCHK1CHEwrvhNCGVmhmz7rjEwn1nJSZMPIL2HAPRVlhTo0T1lABGepxO/W8VEimOnUeizPnwVVXaPglpoyRwMcu0dIODTCAaHZXSiuJPiawg9CvULj4PD0OvJ2OA91wwPwQcAgSZoJGF0twDUyn7IZW3dkA2oxnlNHg2DYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=kl8XrhMc; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Received: from email.seznam.cz
	by smtpc-mxb-696f4f9cf9-hjdgl
	(smtpc-mxb-696f4f9cf9-hjdgl [2a02:598:64:8a00::1000:3b6])
	id 10628b25a658263c15ed916d;
	Fri, 15 Mar 2024 15:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1710514298;
	bh=dOwhBo0NeJjHvCrIemZZp50EMXX1nAE4hUqkSh+64g4=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type;
	b=kl8XrhMcs2KnLLen5e5Vw4X3RGjaKBpvZtBY3Mi4fprr0CSRSyaC+I9uBR4IETwin
	 uVT28YLxzq+z+wYYNvKvkTficegP+i+wEA9Oh7J4xvvSntax8YI4oM6hIrTz2eFp0C
	 tjMqOwkeXKqcdSb2zr/7K34hNgRi19nbE9+Tye2XoWiQZigRtsyDkQkyvO7CiNinJm
	 wAv+ywD6y1CjVlLcENTLBe3+UNZwnskbJDlu6v24RHBCYp4loEjrPGC9vI6wkN+cOs
	 pLP/gWzu/DeHT0nYYiZAZtvZXjUFzdSO8riEY9mXBvVFGw2PKrRC9G/LibABSqlAvg
	 Rlrga4Rdq72PA==
Received: from [IPV6:2a01:9422:904:1ee:e65e:37ff:feee:e29c]
	([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-594d8f6859-w4lvq (szn-email-smtpd/2.0.18) with ESMTPA
	id 40fae93a-075b-4aca-9519-52e347320dbf;
	Fri, 15 Mar 2024 15:51:35 +0100
Message-ID: <f85da4d3-f1c7-44fb-8e5a-30833208d019@podgorny.cz>
Date: Fri, 15 Mar 2024 15:51:33 +0100
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
 <CAMj1kXGWMOOJwezcOyS1qfAimLHmptUuL=hiqrinLL_FWHpm2A@mail.gmail.com>
From: Radek Podgorny <radek@podgorny.cz>
In-Reply-To: <CAMj1kXGWMOOJwezcOyS1qfAimLHmptUuL=hiqrinLL_FWHpm2A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UQd7gZVizApNq8CM3fjNNrIT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UQd7gZVizApNq8CM3fjNNrIT
Content-Type: multipart/mixed; boundary="------------ahXkXiDqN6T1ouNDVYpUeH0H";
 protected-headers="v1"
From: Radek Podgorny <radek@podgorny.cz>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
Message-ID: <f85da4d3-f1c7-44fb-8e5a-30833208d019@podgorny.cz>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz>
 <CAMj1kXGWMOOJwezcOyS1qfAimLHmptUuL=hiqrinLL_FWHpm2A@mail.gmail.com>
In-Reply-To: <CAMj1kXGWMOOJwezcOyS1qfAimLHmptUuL=hiqrinLL_FWHpm2A@mail.gmail.com>

--------------ahXkXiDqN6T1ouNDVYpUeH0H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

b2ssIG5vIHByb2JsZW0sIHRoYW5rcyENCg0KaSB3YXMganVzdCB3b25kZXJpbmcgd2hhdCB3
YXMgdGhlIHB1cnBvc2Ugb2YgdGhlIG9yaWdpbmFsIGNoYW5nZSAtIGkgDQpkb24ndCB3YW50
IG90aGVycyB0byBtaXNzIHNvbWUgaW1wcm92ZW1lbnQganVzdCBiZWNhdXNlIG9mIG15IHdl
aXJkIA0KbWFjaGluZS4gOy0pDQoNCnIuDQoNCg0KT24gMy8xNS8yNCAxNToyNSwgQXJkIEJp
ZXNoZXV2ZWwgd3JvdGU6DQo+IE9uIEZyaSwgMTUgTWFyIDIwMjQgYXQgMTU6MTIsIFJhZGVr
IFBvZGdvcm55IDxyYWRla0Bwb2Rnb3JueS5jej4gd3JvdGU6DQo+Pg0KPj4gaGkgYXJkLCB0
aGFua3MgZm9yIHRoZSBlZmZvcnQhDQo+Pg0KPj4gc28sIHlvdXIgZmlyc3QgcmVjb21tZW5k
ZWQgcGF0Y2ggKHRoZSBtZW1zZXQgdGhpbmcpLCBhcHBsaWVkIHRvIGN1cnJlbnQNCj4+IG1h
aW5saW5lICg2LjgpIERPRVMgTk9UIHJlc29sdmUgdGhlIGlzc3VlLg0KPj4NCj4+IHRoZSBz
ZWNvbmQgcmVjb21tZW5kYXRpb24sIGEgcmV2ZXJ0IHBhdGNoLCBhcHBsaWVkIHRvIHRoZSBz
YW1lIG1haW5saW5lDQo+PiB0cmVlLCBpbmRlZWQgRE9FUyByZXNvbHZlIHRoZSBwcm9ibGVt
Lg0KPj4NCj4+IGp1c3QgdG8gYmUgc3VyZSwgaSdtIGF0dGFjaGluZyB0aGUgcmV2ZXJ0IHBh
dGNoLg0KPj4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IElmIHRoZSByZXZlcnQgd29ya3MgZm9y
IHlvdSwgSSB0aGluayB3ZSBjYW4gc3RvcCBsb29raW5nLg0KPiANCj4gVGhpcyBwb2ludHMg
dG8gYW4gaXNzdWUgaW4gdGhlIGZpcm13YXJlJ3MgaW1hZ2UgbG9hZGVyLCB3aGljaCBkb2Vz
IG5vdA0KPiBjbGVhciBhbGwgdGhlIG1lbW9yeSBpdCBzaG91bGQgYmUgY2xlYXJpbmcuDQo+
IA0KPiBJIHdpbGwgcXVldWUgdXAgdGhlIHJldmVydCB3aXRoIHlvdXIgdGVzdGVkLWJ5Lg0K
PiANCj4gVGhhbmtzLA0KPiBBcmQuDQo=

--------------ahXkXiDqN6T1ouNDVYpUeH0H--

--------------UQd7gZVizApNq8CM3fjNNrIT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEydMGi3nQKasCS8bLahNm1VQL0ZwFAmX0YHYFAwAAAAAACgkQahNm1VQL0ZwT
FhAAgriWpppJ5em4Otg4407vC4/VTNa0xFL7hFIy4gLlTmhgFmWAJoQ3KDZGikvHWnXz4KcFEKgA
AH2aOTvRkXp05C9V1XzK08mMrXuDhSPfzhOwCSQU/jQqmbgzF4BrdAPZou2/snSD/3+xobObdAp3
6FCe6Ggq49ozaIHiRQCDTWlCbYPlvJmkEX4+bJAcV2+EAksbM89s6VohNv4U4JCDIQgFJyKOSg4I
IFD4AdCCR5US/uSln9l59H8stpDXGrWEBHJa/n6RX5tVV+Ewmy2et/f3p9tSMVdQyQEgLdT1rQ5K
vd2WzYInnPrixmonZ448Q+wnBCFyxcZw1fC/3STwvHEhyHR00vplod8OUAZ6GpAiBUYZi1HkybDW
uehPfVOPGOECPt3f3lNTCOu7oePH91O3r94jYRoMGnFiqyicPxT2NFuy6z0PVRZgft//alnAdGEM
NFjLoUdStoUZop0BL4IdJLpDLazpUDsiHH0OOLYATgtAz8mRQObdv13aj3RwwZ88Ou2ZXEDnw6W/
+eLxKef4Q51jaLlRN6O0fTAZGXuciKEGCx+3ESGUHVELBINz2VrO4cA4Q0L1X1XYVjA7hEWap7O8
HmOctO3Hjk+jP0G37nZGpedXYXjkonfK58sjZjT+RzP2p1IYxi+FbUw3d844LE1Z1S2pvcHCMfOT
rdg=
=NbLM
-----END PGP SIGNATURE-----

--------------UQd7gZVizApNq8CM3fjNNrIT--

