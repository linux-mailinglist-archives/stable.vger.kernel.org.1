Return-Path: <stable+bounces-28256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8587D128
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FB61C228E8
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820645945;
	Fri, 15 Mar 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="pgUzrG1I"
X-Original-To: stable@vger.kernel.org
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B566FD9
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519887; cv=none; b=tTB3wPxOYiB5jJXgPIxQEfjH2lI1ETIJjSOn1Q9r3GLuikz2MawVdewCoHU0Zp6DYVT4GAeEqW3Cxr0OJYSfb1Tm5ToifdfDR8Gw9zSSqZsiiVgku5jYWQdT1JMO2jrgpbt2YQVzlAMTho+k+oEccvCgpklUkAbgGSDSsEBjeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519887; c=relaxed/simple;
	bh=gc7gzKqYttkOzF3iRrIXTejoC7VKWKXqI9UO1389Eqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1y3Wme7qLKwC/U9a02xuk3Kbc5+wHI/diGZpeMvwOu0S9GMX1O9UE0K7WZgf3lM4sqKAtrqbLbmloV+T23R9eXiRrNHGUWRSMtMoDw/zQ+ytCsl4eqr7U/wm+YmZtyIHm2BG63axIqouSafzMa+NaGiDtkMWi/ldEc+lGJHWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=pgUzrG1I; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Received: from email.seznam.cz
	by smtpc-mxb-79548bf4db-6g5l8
	(smtpc-mxb-79548bf4db-6g5l8 [2a02:598:64:8a00::1000:970])
	id 6e25e59bd81f48826baaffd3;
	Fri, 15 Mar 2024 17:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1710519861;
	bh=gc7gzKqYttkOzF3iRrIXTejoC7VKWKXqI9UO1389Eqs=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type;
	b=pgUzrG1I79OkAcwKKqmZsGhjfieUsn1p8LrzyjN6VUNYj/i4VC+IbguF6Ssowtdpq
	 azpuFmWceX+W3b89SjuG9iQpfcpo5RvHblRm/ngJfQZPuT6boV9YIPR853r+tc4BQs
	 wKWaj3zPthIbu7TdPT8iasS+RJsKTpSY3pWrN4sAaVRsYj1CHGg1qB+CGmrUAWLZMa
	 9/Q+BxSpEVUD544ucH5N607hR/Pb7Xhc8Tw+VFEA0jM1Em2vFktBbJpHCSdiphQuHn
	 CfTKNdOqQfHbja4Jh1ydN37mMGnJvWTVJXyiboWtVl8Hpuhiy/I4xOKitDj9WU4Q0y
	 RfF12seAtY/dQ==
Received: from [IPV6:2a01:9422:904:1ee:e65e:37ff:feee:e29c]
	([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-594d8f6859-4vkd8 (szn-email-smtpd/2.0.18) with ESMTPA
	id 824f5021-ac6f-440b-ac02-48e82f59aa00;
	Fri, 15 Mar 2024 17:24:18 +0100
Message-ID: <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz>
Date: Fri, 15 Mar 2024 17:24:16 +0100
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
From: Radek Podgorny <radek@podgorny.cz>
In-Reply-To: <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bX9AywMx93iSsEEK0m8RdY80"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bX9AywMx93iSsEEK0m8RdY80
Content-Type: multipart/mixed; boundary="------------k9CzYCAAMy8oH6cVvt5HvEx2";
 protected-headers="v1"
From: Radek Podgorny <radek@podgorny.cz>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
Message-ID: <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz>
 <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
 <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
In-Reply-To: <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>

--------------k9CzYCAAMy8oH6cVvt5HvEx2
Content-Type: multipart/mixed; boundary="------------qJKvIhf7JdyPFi8winmmFzkq"

--------------qJKvIhf7JdyPFi8winmmFzkq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aXQncyBzeXN0ZW1kLWJvb3QuIGF0dGFjaGluZyBib290Y3RsIG91dHB1dC4gbm93IGxvb2tp
bmcgYXQgaXQsIGl0IHNlZW1zIA0KdGhhdCB3aGlsZSBzeXN0ZW1kIChhbmQgc3lzdGVtZC1i
b290KSBnZXRzIHRpbWVseSB1cGRhdGVzIG9uIG15IHN5c3RlbSANCihjdXJyZW50bHkgYXQg
MjU1LjQpLCB0aGUgc3R1YiAoaXMgdGhpcyBob3cgaXQncyBjYWxsZWQ/KSBkb2VzIG5vdCBn
ZXQgDQp1cGRhdGVkIGF1dG9tYXRpY2FsbHkgaW4gdGhlIGVmaSBwYXJ0aXRpb24gKHN0aWxs
IGF0IHZlcnNpb24gMjQ0PykuDQoNCmkgY2FuIHRyeSB0byB1cGRhdGUgaXQuIGJ1dCBpJ2xs
IHdhaXQgZm9yIHlvdXIgaW5zdHJ1Y3Rpb25zIHNpbmNlIHRoaXMgDQptYXkgYmUgc29tZSBy
YXJlIHNpdHVhdGlvbiBhbmQgd2UgbWF5IHVzZSBpdCBmb3IgdGVzdGluZy4NCg0KYW55d2F5
LCBpJ20gY29tcGlsaW5nIG5ldyBrZXJuZWwgd2l0aCB5b3VyIHN1Z2dlc3RlZCBjaGFuZ2Vz
IHJpZ2h0IG5vdyANCnNvIGknbGwgbGV0IHlvdSBrbm93IGhvdyBpdCB0dXJuZWQgb3V0LCBz
b29uLg0KDQpyLg0KDQpwLnMuOiBoYSEgbmV2ZXJtaW5kLCBpIGp1c3QgY2hlY2tlZCB0aGUg
b3RoZXIgc3lzdGVtcyB3aGljaCBib290IGZpbmUgDQphbmQgdGhleSBhbHNvIGFyZSBvbiBz
dHViICg/KSAyNDQgc28gaXQncyBwcm9iYWJseSBub3QgdGhlIGNhdXNlLg0KDQoNCk9uIDMv
MTUvMjQgMTc6MDgsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0KPiBPbiBGcmksIDE1IE1hciAy
MDI0IGF0IDE2OjMzLCBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToN
Cj4+DQo+PiBPbiBGcmksIDE1IE1hciAyMDI0IGF0IDE1OjEyLCBSYWRlayBQb2Rnb3JueSA8
cmFkZWtAcG9kZ29ybnkuY3o+IHdyb3RlOg0KPj4+DQo+Pj4gaGkgYXJkLCB0aGFua3MgZm9y
IHRoZSBlZmZvcnQhDQo+Pj4NCj4+PiBzbywgeW91ciBmaXJzdCByZWNvbW1lbmRlZCBwYXRj
aCAodGhlIG1lbXNldCB0aGluZyksIGFwcGxpZWQgdG8gY3VycmVudA0KPj4+IG1haW5saW5l
ICg2LjgpIERPRVMgTk9UIHJlc29sdmUgdGhlIGlzc3VlLg0KPj4+DQo+Pj4gdGhlIHNlY29u
ZCByZWNvbW1lbmRhdGlvbiwgYSByZXZlcnQgcGF0Y2gsIGFwcGxpZWQgdG8gdGhlIHNhbWUg
bWFpbmxpbmUNCj4+PiB0cmVlLCBpbmRlZWQgRE9FUyByZXNvbHZlIHRoZSBwcm9ibGVtLg0K
Pj4+DQo+Pj4ganVzdCB0byBiZSBzdXJlLCBpJ20gYXR0YWNoaW5nIHRoZSByZXZlcnQgcGF0
Y2guDQo+Pj4NCj4+DQo+PiBBY3R1YWxseSwgdGhhdCBpcyBub3QgdGhlIHBhdGNoIEkgaGFk
IGluIG1pbmQuDQo+Pg0KPj4gUGxlYXNlIHJldmVydA0KPj4NCj4+IHg4Ni9lZmk6IERyb3Ag
RUZJIHN0dWIgLmJzcyBmcm9tIC5kYXRhIHNlY3Rpb24NCj4+DQo+IA0KPiBCVFcgd2hpY2gg
Ym9vdGxvYWRlciBhcmUgeW91IHVzaW5nPw0K
--------------qJKvIhf7JdyPFi8winmmFzkq
Content-Type: text/plain; charset=UTF-8; name="bootctl.txt"
Content-Disposition: attachment; filename="bootctl.txt"
Content-Transfer-Encoding: base64

G1swbVN5c3RlbToKICAgICAgRmlybXdhcmU6IFVFRkkgMi4zMSAoQW1lcmljYW4gTWVnYXRy
ZW5kcyA0LjY1MSkKIEZpcm13YXJlIEFyY2g6IHg2NAogICBTZWN1cmUgQm9vdDogZGlzYWJs
ZWQgKHVuc3VwcG9ydGVkKQogIFRQTTIgU3VwcG9ydDogbm8KICBNZWFzdXJlZCBVS0k6IG5v
CiAgQm9vdCBpbnRvIEZXOiBub3Qgc3VwcG9ydGVkCgobWzBtQ3VycmVudCBCb290IExvYWRl
cjoKICAgICAgUHJvZHVjdDogc3lzdGVtZC1ib290IDI0NC0xLWFyY2gKICAgICBGZWF0dXJl
czog4pyTIEJvb3QgY291bnRpbmcKICAgICAgICAgICAgICAg4pyTIE1lbnUgdGltZW91dCBj
b250cm9sCiAgICAgICAgICAgICAgIOKckyBPbmUtc2hvdCBtZW51IHRpbWVvdXQgY29udHJv
bAogICAgICAgICAgICAgICDinJMgRGVmYXVsdCBlbnRyeSBjb250cm9sCiAgICAgICAgICAg
ICAgIOKckyBPbmUtc2hvdCBlbnRyeSBjb250cm9sCiAgICAgICAgICAgICAgIOKckyBTdXBw
b3J0IGZvciBYQk9PVExEUiBwYXJ0aXRpb24KICAgICAgICAgICAgICAg4pyTIFN1cHBvcnQg
Zm9yIHBhc3NpbmcgcmFuZG9tIHNlZWQgdG8gT1MKICAgICAgICAgICAgICAg4pyXIExvYWQg
ZHJvcC1pbiBkcml2ZXJzCiAgICAgICAgICAgICAgIOKclyBTdXBwb3J0IFR5cGUgIzEgc29y
dC1rZXkgZmllbGQKICAgICAgICAgICAgICAg4pyXIFN1cHBvcnQgQHNhdmVkIHBzZXVkby1l
bnRyeQogICAgICAgICAgICAgICDinJcgU3VwcG9ydCBUeXBlICMxIGRldmljZXRyZWUgZmll
bGQKICAgICAgICAgICAgICAg4pyXIEVucm9sbCBTZWN1cmVCb290IGtleXMKICAgICAgICAg
ICAgICAg4pyXIFJldGFpbiBTSElNIHByb3RvY29scwogICAgICAgICAgICAgICDinJcgTWVu
dSBjYW4gYmUgZGlzYWJsZWQKICAgICAgICAgICAgICAg4pyTIEJvb3QgbG9hZGVyIHNldHMg
RVNQIGluZm9ybWF0aW9uCiAgICAgICAgICBFU1A6IC9kZXYvZGlzay9ieS1wYXJ0dXVpZC8y
YWRlZmM3NS0zZGEwLTRjM2QtOTQ0OS1lYTAxMTRhNGIyODEKICAgICAgICAgRmlsZTog4pSU
4pSAL0VGSS9zeXN0ZW1kL3N5c3RlbWQtYm9vdHg2NC5lZmkKChtbMG1SYW5kb20gU2VlZDoK
IFN5c3RlbSBUb2tlbjogc2V0CiAgICAgICBFeGlzdHM6IHllcwoKG1swbUF2YWlsYWJsZSBC
b290IExvYWRlcnMgb24gRVNQOgogICAgICAgICAgRVNQOiAvYm9vdCAoL2Rldi9kaXNrL2J5
LXBhcnR1dWlkLzJhZGVmYzc1LTNkYTAtNGMzZC05NDQ5LWVhMDExNGE0YjI4MSkKICAgICAg
ICAgRmlsZTog4pSc4pSAL0VGSS9zeXN0ZW1kL3N5c3RlbWQtYm9vdHg2NC5lZmkgKHN5c3Rl
bWQtYm9vdCAyNDQtMS1hcmNoKQogICAgICAgICAgICAgICDilJTilIAvRUZJL0JPT1QvQk9P
VFg2NC5FRkkgKHN5c3RlbWQtYm9vdCAyNDQtMS1hcmNoKQoKG1swbUJvb3QgTG9hZGVycyBM
aXN0ZWQgaW4gRUZJIFZhcmlhYmxlczoKICAgICAgICBUaXRsZTogTGludXggQm9vdCBNYW5h
Z2VyCiAgICAgICAgICAgSUQ6IDB4MDAwOQogICAgICAgU3RhdHVzOiBhY3RpdmUsIGJvb3Qt
b3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBhcnR1dWlkLzJhZGVmYzc1LTNk
YTAtNGMzZC05NDQ5LWVhMDExNGE0YjI4MQogICAgICAgICBGaWxlOiDilJTilIAvRUZJL3N5
c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBUaXRsZTogTGludXggQm9vdCBN
YW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwOAogICAgICAgU3RhdHVzOiBhY3RpdmUsIGJv
b3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBhcnR1dWlkL2RhY2RlODMx
LTYwYWYtNGY4Yy1iYmIyLWM0YjAzYTMyNjVlNAogICAgICAgICBGaWxlOiDilJTilIAvRUZJ
L3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBUaXRsZTogTGludXggQm9v
dCBNYW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwMQogICAgICAgU3RhdHVzOiBhY3RpdmUs
IGJvb3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBhcnR1dWlkL2Y5MTY5
Nzg0LWQxNjMtNGM1OC1hOTVkLTI2ZGViNDE0NTcxNAogICAgICAgICBGaWxlOiDilJTilIAv
RUZJL3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBUaXRsZTogTGludXgg
Qm9vdCBNYW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwNAogICAgICAgU3RhdHVzOiBhY3Rp
dmUsIGJvb3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBhcnR1dWlkL2Vk
NzdjZjkyLTJhY2QtNGUyYi1iZTA3LWI2ZjFlNGNkZWQyOQogICAgICAgICBGaWxlOiDilJTi
lIAvRUZJL3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBUaXRsZTogTGlu
dXggQm9vdCBNYW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwMAogICAgICAgU3RhdHVzOiBh
Y3RpdmUsIGJvb3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBhcnR1dWlk
L2NhMThkNzM0LWQ4YjMtNDhmOC1iNjhlLTNlNGFlOTE5ZTBjNgogICAgICAgICBGaWxlOiDi
lJTilIAvRUZJL3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBUaXRsZTog
TGludXggQm9vdCBNYW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwMgogICAgICAgU3RhdHVz
OiBhY3RpdmUsIGJvb3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBhcnR1
dWlkLzg5NmIxZDMxLTczM2UtNDE3YS1hNzQwLWE3ODdhY2ZmM2YxNQogICAgICAgICBGaWxl
OiDilJTilIAvRUZJL3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBUaXRs
ZTogTGludXggQm9vdCBNYW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwMwogICAgICAgU3Rh
dHVzOiBhY3RpdmUsIGJvb3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5LXBh
cnR1dWlkL2U3YmY2ZmM1LTBiZjYtNGRjMi04MTE2LWMyZGJjODk5OWE1NAogICAgICAgICBG
aWxlOiDilJTilIAvRUZJL3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKICAgICAgICBU
aXRsZTogTGludXggQm9vdCBNYW5hZ2VyCiAgICAgICAgICAgSUQ6IDB4MDAwNgogICAgICAg
U3RhdHVzOiBhY3RpdmUsIGJvb3Qtb3JkZXIKICAgIFBhcnRpdGlvbjogL2Rldi9kaXNrL2J5
LXBhcnR1dWlkLzZkOWZhNzY1LWE0YzktNDcyMy1iZWNmLTYxMTA1YTlkMWYzMAogICAgICAg
ICBGaWxlOiDilJTilIAvRUZJL3N5c3RlbWQvc3lzdGVtZC1ib290eDY0LmVmaQoKG1swbUJv
b3QgTG9hZGVyIEVudHJpZXM6CiAgICAgICAgJEJPT1Q6IC9ib290ICgvZGV2L2Rpc2svYnkt
cGFydHV1aWQvMmFkZWZjNzUtM2RhMC00YzNkLTk0NDktZWEwMTE0YTRiMjgxKQogICAgICAg
IHRva2VuOiBhcmNoCgobWzBtRGVmYXVsdCBCb290IExvYWRlciBFbnRyeToKICAgICAgICAg
dHlwZTogQm9vdCBMb2FkZXIgU3BlY2lmaWNhdGlvbiBUeXBlICMxICguY29uZikKICAgICAg
ICB0aXRsZTogQXJjaCBMaW51eAogICAgICAgICAgIGlkOiBhcmNoLmNvbmYKICAgICAgIHNv
dXJjZTogL2Jvb3QvL2xvYWRlci9lbnRyaWVzL2FyY2guY29uZgogICAgICAgIGxpbnV4OiAv
Ym9vdC8vdm1saW51ei1saW51eAogICAgICAgaW5pdHJkOiAvYm9vdC8vaW50ZWwtdWNvZGUu
aW1nCiAgICAgICAgICAgICAgIC9ib290Ly9pbml0cmFtZnMtbGludXguaW1nCiAgICAgIG9w
dGlvbnM6IHJvb3Q9L2Rldi9kaXNrL2J5LWxhYmVsL01BVExBX1JPT1QgcncK

--------------qJKvIhf7JdyPFi8winmmFzkq--

--------------k9CzYCAAMy8oH6cVvt5HvEx2--

--------------bX9AywMx93iSsEEK0m8RdY80
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEydMGi3nQKasCS8bLahNm1VQL0ZwFAmX0djEFAwAAAAAACgkQahNm1VQL0Zz7
XxAA0KbtlwOIJx8l3rKOWuCZYsbO2FmDQOZKLLPoHbmQt708YThTn+e3f65HFv1p+AFRaNzkIVL0
6zby/242SoATXak9waXLvZ0bwsiP/E3XKrw7vgSK7NE0xGO/dqIc1G2B6asT5Jz3R21pir/G9eQn
nByt8c4YkszX4M+VNY+6SR2esPDyEOvS8iaGw+nc7z9ltHir8VZTJ9z2+yviuOtZeVXGUJCbIm4u
C/enpde/T+kpFKLpTNSqZTJ5jip8L6S2IWKEnB3VJYUElSMkKYuyw/vbBHiRj008V5D/AbOKCKr7
MyqzC/t3lh484Rb8SddoudaCvcFw+MD/8k76xR3lg+njNiwpdBLI+9u+/4KmDrAuc0Kr+gBpDhgt
HPNlnGao8KCJQ12aMKnb9oZ7xyKyDbWm521rm4x8Ev/SehVlXCu/JjWi4tzlewPCfDg+VaLCBHDD
vWrNNMptgJbrntGycPA5z5ZB6QYUMFFl75/fkcHI5BySNhoI8s4tBpjbU5GzpVB1w20v4m1h7PVJ
o5JSdKuJFi0Y7Y5hm80zQRPmBG/hUNZxzgthIPIfDGTRnwXSwAkHkDQrVCUMesXMs3P2N2p7Z/eO
lnFAahvenKHOojjCOeCmI0LFFokRlLUoZA8EBPGTNMpTAk9bNP2SKARRAkVtP5aCEho5fffK4MbE
TVw=
=HARZ
-----END PGP SIGNATURE-----

--------------bX9AywMx93iSsEEK0m8RdY80--

