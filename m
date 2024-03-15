Return-Path: <stable+bounces-28263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F287D36E
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 19:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2936A1F2215A
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC284F1FE;
	Fri, 15 Mar 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="Pkir9aqP"
X-Original-To: stable@vger.kernel.org
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096B4EB22
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526331; cv=none; b=JCoBopUeKpnQ6rlI1fNb8tKJdc44n67qUJD+5Yu0XBlSIhhNm2bXHzD9C2bJtjwKFZjy0D2zpJihCEyMosJu/E6fg5CJPYOPMXdFXILwm25eKEqvBUn8mVdp38VjtI9xqm2u48P5S5/17dmFYMTZEv479fbDlwOwSbWyCys9ot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526331; c=relaxed/simple;
	bh=fD365pqeRnkP050a+hs75xj9kB+NOXZYcJT46fd7VV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToFF1weaAyF8rXwzJF7wBffMSiw9unD+2YizZtl6eQFxI32DS6jyZ5NtHDz3q704fyLFRYVU4v8MUb1jJQ/ytfk6H2tvxckcV39U8BFq2Kwurao2zw7IDKlEOyl33wrb+0gtWKJuvrCZfHq+5/MpZvEyYQQ/VpCkgcYKqoxlloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=Pkir9aqP; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Received: from email.seznam.cz
	by smtpc-mxb-696f4f9cf9-hjdgl
	(smtpc-mxb-696f4f9cf9-hjdgl [2a02:598:64:8a00::1000:3b6])
	id 4ad41e0dfceeb3144f5b0445;
	Fri, 15 Mar 2024 19:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1710526304;
	bh=fD365pqeRnkP050a+hs75xj9kB+NOXZYcJT46fd7VV8=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type;
	b=Pkir9aqPASQdV6oAP9RjQNcFGEsmXdVHdTmqnyaFwf+dnR5IgG48Uqivjv4bX9JKI
	 Jz2mmc2rSKNz40+9D7nENdgCcLt5w7pl8dP9WVqx3DhAHtGFEniefgNxKMwPp8L77T
	 LEmcOHzgcin/pE/cktdtZdC36C8ssJju5ybAlw5xtGUlM6X+OA+8LStj8rUGglu2Ag
	 FZsQxm2hj/d/a0NbWKtawGWVJMDHJuXPt+gn84fXYJKZ+vaWO9lrzpr0Zr8bjgrQad
	 jTfJZRsg7M7aEASmdJsyMvWqinROmFCb3jNCtnfCV4mMtB+x4lHDFWgiRfnPX22fgc
	 1zgIdSW9l0Uuw==
Received: from [IPV6:2a01:9422:904:1ee:e65e:37ff:feee:e29c]
	([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-7554644787-xg5cl (szn-email-smtpd/2.0.18) with ESMTPA
	id f8107add-121b-414d-ace8-7d72958de1d1;
	Fri, 15 Mar 2024 19:11:41 +0100
Message-ID: <35ae3208-a0ba-43a7-ac4c-6f770b3df405@podgorny.cz>
Date: Fri, 15 Mar 2024 19:11:38 +0100
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
From: Radek Podgorny <radek@podgorny.cz>
In-Reply-To: <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j6JiJHgiC1wPvm0sc1IDVNzP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j6JiJHgiC1wPvm0sc1IDVNzP
Content-Type: multipart/mixed; boundary="------------yn2i0I4emEkAeRpFkoWv4pwv";
 protected-headers="v1"
From: Radek Podgorny <radek@podgorny.cz>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
Message-ID: <35ae3208-a0ba-43a7-ac4c-6f770b3df405@podgorny.cz>
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
In-Reply-To: <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>

--------------yn2i0I4emEkAeRpFkoWv4pwv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

b2ssIHdpbGwuIHRoZSBrZXJuZWwgd2l0aCBwcmV2aW91cyBwYXRjaCBpcyBzdGlsbCBjb21w
aWxpbmcgc28gaSdsbCANCnF1ZXVlIGl0LiA7LSkNCg0KYW55d2F5LCBzaG91bGQgaSBhcHBs
eSB0aGlzIGFzIGEgc2VwYXJhdGUgcGF0Y2ggb3IgYXMgYW4gYWRkaXRpb24gdG8gdGhlIA0K
cHJldmlvdXMgb25lICh0aGUgb25lIHdpdGggYnNzLmVmaXN0dWIgYWRkaXRpb24pPw0KDQpy
Lg0KDQoNCk9uIDMvMTUvMjQgMTg6NDgsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0KPiBPbiBG
cmksIDE1IE1hciAyMDI0IGF0IDE3OjI0LCBSYWRlayBQb2Rnb3JueSA8cmFkZWtAcG9kZ29y
bnkuY3o+IHdyb3RlOg0KPj4NCj4+IGl0J3Mgc3lzdGVtZC1ib290LiBhdHRhY2hpbmcgYm9v
dGN0bCBvdXRwdXQuIG5vdyBsb29raW5nIGF0IGl0LCBpdCBzZWVtcw0KPj4gdGhhdCB3aGls
ZSBzeXN0ZW1kIChhbmQgc3lzdGVtZC1ib290KSBnZXRzIHRpbWVseSB1cGRhdGVzIG9uIG15
IHN5c3RlbQ0KPj4gKGN1cnJlbnRseSBhdCAyNTUuNCksIHRoZSBzdHViIChpcyB0aGlzIGhv
dyBpdCdzIGNhbGxlZD8pIGRvZXMgbm90IGdldA0KPj4gdXBkYXRlZCBhdXRvbWF0aWNhbGx5
IGluIHRoZSBlZmkgcGFydGl0aW9uIChzdGlsbCBhdCB2ZXJzaW9uIDI0ND8pLg0KPj4NCj4+
IGkgY2FuIHRyeSB0byB1cGRhdGUgaXQuIGJ1dCBpJ2xsIHdhaXQgZm9yIHlvdXIgaW5zdHJ1
Y3Rpb25zIHNpbmNlIHRoaXMNCj4+IG1heSBiZSBzb21lIHJhcmUgc2l0dWF0aW9uIGFuZCB3
ZSBtYXkgdXNlIGl0IGZvciB0ZXN0aW5nLg0KPj4NCj4+IGFueXdheSwgaSdtIGNvbXBpbGlu
ZyBuZXcga2VybmVsIHdpdGggeW91ciBzdWdnZXN0ZWQgY2hhbmdlcyByaWdodCBub3cNCj4+
IHNvIGknbGwgbGV0IHlvdSBrbm93IGhvdyBpdCB0dXJuZWQgb3V0LCBzb29uLg0KPj4NCj4+
IHIuDQo+Pg0KPj4gcC5zLjogaGEhIG5ldmVybWluZCwgaSBqdXN0IGNoZWNrZWQgdGhlIG90
aGVyIHN5c3RlbXMgd2hpY2ggYm9vdCBmaW5lDQo+PiBhbmQgdGhleSBhbHNvIGFyZSBvbiBz
dHViICg/KSAyNDQgc28gaXQncyBwcm9iYWJseSBub3QgdGhlIGNhdXNlLg0KPj4NCj4gDQo+
IE9LIHRoYXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiBJIGluc3RhbGxlZCBBcmNoIGxpbnV4IGlu
IGEgVk0gKHdoYXQgYSBwYWluISkgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlDQo+IGRpc3RybyBo
YXMgYW55dGhpbmcgdG8gZG8gd2l0aCBpdC4NCj4gDQo+IEkgZGlkIHJlYWxpemUgdGhhdCBy
ZXZlcnRpbmcgdGhhdCBwYXRjaCBpcyBub3QgZ29pbmcgdG8gYmUgYSBmdWxsDQo+IHNvbHV0
aW9uIGluIGFueSBjYXNlLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSB0cnkgd2hldGhlciB0
aGUgZm9sbG93aW5nIGZpeCB3b3JrcyBmb3IgeW91Pw0KPiANCj4gLS0tIGEvZHJpdmVycy9m
aXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYw0KPiBAQCAtNDczLDYgKzQ3Myw5IEBADQo+ICAg
ICAgICAgIGludCBvcHRpb25zX3NpemUgPSAwOw0KPiAgICAgICAgICBlZmlfc3RhdHVzX3Qg
c3RhdHVzOw0KPiAgICAgICAgICBjaGFyICpjbWRsaW5lX3B0cjsNCj4gKyAgICAgICBleHRl
cm4gY2hhciBfYnNzW10sIF9lYnNzW107DQo+ICsNCj4gKyAgICAgICBtZW1zZXQoX2Jzcywg
MCwgX2Vic3MgLSBfYnNzKTsNCj4gDQo+ICAgICAgICAgIGVmaV9zeXN0ZW1fdGFibGUgPSBz
eXNfdGFibGVfYXJnOw0K

--------------yn2i0I4emEkAeRpFkoWv4pwv--

--------------j6JiJHgiC1wPvm0sc1IDVNzP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEydMGi3nQKasCS8bLahNm1VQL0ZwFAmX0j1sFAwAAAAAACgkQahNm1VQL0ZxK
FRAA3Qd/0q8Fsrd74/HR6S36TMShCAXOXcK9qTXzwJtNeCu7O3vj1NjPQLzPHuDlYmiCDjqP/avT
sVOBCfKcwwhsg67pJvaXUHrV2r/7CYAj6Aa2By4hXS3+zsTcmt6LcNLQbww8LliaX1DUYjacNQen
YhY9179HSxV+wEsqRX5FvSD8V25TRNNS/zo0FBUdCA8J7CVoXsV2VN1PSf4gF7C1kzW50dqgVT0L
BzF4ydR1wCdoIHsWkXBglHnoK0L4Syah9KgAxJRcc/45xIza4D1e+pKEsnaVV6aimBEJZZ198REK
StEcJhu0nPTtgRrdXPF4fGpYRl0veYLy4GBqll58/iSAvL2QwOeL835hlRO8vx65oZdR63tl/BYI
iRUohAxJpoIObjpULrOIOm/xZZ5a/ZLJp168MdQLrqX0QU5PcKZSoshuE6htOq5fDrA80HO0BdmD
iKhSbjV1jIi4WhZhJh44CLTy5ExUMuTC/Lr0VrM5ZSpysg8tEx9oQgGvA4TNjd24VRn+Us4zU8tI
VZc+zXQCe/gn1wFIfYPf7k7sQ56M9Vgqgt1sBu2ZhYeeczTF72SeRMfVx7ZqbnqYphQnejwaKaxb
hCgzH5LyFwH9B1JPt1ZkFGThKym1mdsVw7fbiS1kiPiV9aCiyYSo/QMxZ55IQkapeXBLF42/e4Fz
zlY=
=8kG9
-----END PGP SIGNATURE-----

--------------j6JiJHgiC1wPvm0sc1IDVNzP--

