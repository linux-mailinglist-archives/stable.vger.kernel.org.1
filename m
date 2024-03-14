Return-Path: <stable+bounces-28190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D7B87C2CF
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742461C2152B
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329B70CCB;
	Thu, 14 Mar 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="a8SUxO64"
X-Original-To: stable@vger.kernel.org
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B81A38FB
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441152; cv=none; b=MCXYkbWD7gvLVkEkXg8AEma6ItY0k2cFnOSFUQ0MYDOcjyL63TuhYcyF4AKRg+2uusJ+8Kween/GGWguVFbWusnj/dGb/rgUKwPv3FKYixF6SzaM1kwwjnrg9i3wIB6LPTYEyKFsOaU4YfMsWDmeQKyOJ137O1wQ611Ym0v2iUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441152; c=relaxed/simple;
	bh=ceLo9Rj8yu4e9lUaL42kim2b3g/U7nf+tkiHDnZBTvY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=G2gf+QaZ+zkkk+lh1bDJX2KDOVK4TKUfwXqAsUPiJ8Wd3ANlzOxDCnEJpF7lWqqNhgjBsNgSR1Y0Q/YcOkipT7Rhz4ymV2x3XsvYzo3jE0QOaxqNw9/2IgpSPutRO6OfHfSU3q9cXKcXFyt4sIkzfUJTJ/PjoDHDQnXo97j6xcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=a8SUxO64; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Received: from email.seznam.cz
	by smtpc-mxb-78985f9c95-xx5ls
	(smtpc-mxb-78985f9c95-xx5ls [2a02:598:128:8a00::1000:966])
	id 4994c6f2ffae6beb4c1bdcba;
	Thu, 14 Mar 2024 19:31:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1710441110;
	bh=ceLo9Rj8yu4e9lUaL42kim2b3g/U7nf+tkiHDnZBTvY=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:
	 From:Subject:To:Cc:Content-Type;
	b=a8SUxO64aB3lhAkbD46pfYHidCLA8aFFm3TPK+1RxP6iYWeuXWLnqvexCochtDtjP
	 3mFMIh0DH7N6zFULfjZu7fgWKc/4Ky0Ev6zGTDelr6FPlFYQyXKW5PMrg+MfKvaqry
	 AjEgdmPKNEgGJeoLLSGG43rI+ZN7kMgYYFYWqRJklJORFt4T6kbId9XrtNuWO/nB9S
	 HuE9zAsrcmB0osj0FOIKM/anfjmXCMdIRl+8h05B2AVXILanxoMil454L1p0YKH4SO
	 JEQo69fxTVhVJ5Hl5RokEEEBwubwHgjh7VLP3TLFrx+rfrQnVAn424Cqysncj694l/
	 zQQLxsHe2pHrQ==
Received: from [IPV6:2a01:9422:904:1ee:e65e:37ff:feee:e29c]
	([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-594d8f6859-m6hpf (szn-email-smtpd/2.0.18) with ESMTPA
	id c51e4f74-8c4d-4a36-8f2a-6e42de0460e8;
	Thu, 14 Mar 2024 19:31:48 +0100
Message-ID: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
Date: Thu, 14 Mar 2024 19:31:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US-large
From: Radek Podgorny <radek@podgorny.cz>
Subject: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 regressions@lists.linux.dev
Cc: regressions@leemhuis.info
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pdMdvZsGczNI50M8e09AvFdI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pdMdvZsGczNI50M8e09AvFdI
Content-Type: multipart/mixed; boundary="------------aRgCRvGyZw0PvoZ2H1rHjGSj";
 protected-headers="v1"
From: Radek Podgorny <radek@podgorny.cz>
To: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 regressions@lists.linux.dev
Cc: regressions@leemhuis.info
Message-ID: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
Subject: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"

--------------aRgCRvGyZw0PvoZ2H1rHjGSj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGksDQoNCmkgc2VlbSB0byBiZSB0aGUgb25seSBvbmUgaW4gdGhlIHdvcmxkIHRvIGhhdmUg
dGhpcyBwcm9ibGVtLiA6LSgNCg0Kb24gb25lIG9mIG15IG1hY2hpbmVzLCB1cGRhdGluZyB0
byA2LjYuMTggYW5kIGxhdGVyIChpbmNsdWRpbmcgbWFpbmxpbmUgDQpicmFuY2gpIGxlYWRz
IHRvIHVuYm9vdGFibGUgc3lzdGVtLiBhbGwgb3RoZXIgY29tcHV0ZXJzIGFyZSB1bmFmZmVj
dGVkLg0KDQpiaXNlY3RpbmcgdGhlIGhpc3RvcnkgbGVhZHMgdG86DQoNCmNvbW1pdCA4MTE3
OTYxZDk4ZmIyZDMzNWFiNmRlMmNhZDdhZmI4YjYxNzFmNWZlDQpBdXRob3I6IEFyZCBCaWVz
aGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+IA0KIA0KDQpEYXRlOiAgIFR1ZSBTZXAgMTIgMDk6
MDA6NTMgMjAyMyArMDAwMCANCiANCg0KIA0KIA0KDQogICAgIHg4Ni9lZmk6IERpc3JlZ2Fy
ZCBzZXR1cCBoZWFkZXIgb2YgbG9hZGVkIGltYWdlIA0KIA0KDQogDQogDQoNCiAgICAgY29t
bWl0IDdlNTAyNjIyMjlmYWFkMGM3YjhjNTQ0NzdjZDFjODgzZjMxY2M0YTcgdXBzdHJlYW0u
IA0KIA0KDQoNCiAgICAgVGhlIG5hdGl2ZSBFRkkgZW50cnlwb2ludCBkb2VzIG5vdCB0YWtl
IGEgc3RydWN0IGJvb3RfcGFyYW1zIGZyb20gdGhlDQogICAgIGxvYWRlciwgYnV0IGluc3Rl
YWQsIGl0IGNvbnN0cnVjdHMgb25lIGZyb20gc2NyYXRjaCwgdXNpbmcgdGhlIHNldHVwDQog
ICAgIGhlYWRlciBkYXRhIHBsYWNlZCBhdCB0aGUgc3RhcnQgb2YgdGhlIGltYWdlLg0KDQog
ICAgIFRoaXMgc2V0dXAgaGVhZGVyIGlzIHBsYWNlZCBpbiBhIHdheSB0aGF0IHBlcm1pdHMg
bGVnYWN5IGxvYWRlcnMgdG8NCiAgICAgbWFuaXB1bGF0ZSB0aGUgY29udGVudHMgKGkuZS4s
IHRvIHBhc3MgdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgb3IgdGhlDQogICAgIGFkZHJlc3Mg
YW5kIHNpemUgb2YgYW4gaW5pdGlhbCByYW1kaXNrKSwgYnV0IEVGSSBib290IGRvZXMgbm90
IHVzZSANCml0IGluDQogICAgIHRoYXQgd2F5IC0gaXQgb25seSBjb3BpZXMgdGhlIGNvbnRl
bnRzIHRoYXQgd2VyZSBwbGFjZWQgdGhlcmUgYXQgYnVpbGQNCiAgICAgdGltZSwgYnV0IEVG
SSBsb2FkZXJzIHdpbGwgbm90IChhbmQgc2hvdWxkIG5vdCkgbWFuaXB1bGF0ZSB0aGUgc2V0
dXANCiAgICAgaGVhZGVyIHRvIGNvbmZpZ3VyZSB0aGUgYm9vdC4gKENvbW1pdCA2M2JmMjhj
ZWIzZWJiZTc2ICJlZmk6IHg4NjogV2lwZQ0KICAgICBzZXR1cF9kYXRhIG9uIHB1cmUgRUZJ
IGJvb3QiIGRlYWxzIHdpdGggc29tZSBvZiB0aGUgZmFsbG91dCBvZiB1c2luZw0KICAgICBz
ZXR1cF9kYXRhIGluIGEgd2F5IHRoYXQgYnJlYWtzIEVGSSBib290LikNCg0KICAgICBHaXZl
biB0aGF0IG5vbmUgb2YgdGhlIG5vbi16ZXJvIHZhbHVlcyB0aGF0IGFyZSBjb3BpZWQgZnJv
bSB0aGUgc2V0dXANCiAgICAgaGVhZGVyIGludG8gdGhlIEVGSSBzdHViJ3Mgc3RydWN0IGJv
b3RfcGFyYW1zIGFyZSByZWxldmFudCB0byB0aGUgYm9vdA0KICAgICBub3cgdGhhdCB0aGUg
RUZJIHN0dWIgbm8gbG9uZ2VyIGVudGVycyB2aWEgdGhlIGxlZ2FjeSBkZWNvbXByZXNzb3Is
IHRoZQ0KICAgICBjb3B5IGNhbiBiZSBvbWl0dGVkIGFsdG9nZXRoZXIuDQoNCiAgICAgU2ln
bmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCiAgICAgU2ln
bmVkLW9mZi1ieTogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+DQogICAgIExpbms6
IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDkxMjA5MDA1MS40MDE0MTE0LTE5
LWFyZGJAZ29vZ2xlLmNvbQ0KICAgICBTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KDQp0aGlzIHNlZW1zIHRvIGJlIHRo
ZSBjb21taXQgdG8gaW50cm9kdWNlIHRoZSByZWdyZXNzaW9uLg0KDQppIGhhdmUgbm8gaWRl
YSB3aGVyZSB0byBsb29rIGFuZCB3aGF0IGluZm9ybWF0aW9uIHRvIHByb3ZpZGUgdG8gZXhw
bGFpbiANCndoYXQgdGhlIHByb2JsZW0gbWlnaHQgYmUgb3Igd2h5IHRoaXMgc2luZ2xlIG1h
Y2hpbmUgaXMgZGlmZmVyZW50LiA6LSgNCg0KcGxlYXNlIGRvbid0IGhlc2l0YXRlIHRvIGFz
ayBtZSBmdXJ0aGVyIHF1ZXN0aW9ucyAtIGkgY2FuIGRvIGFueSANCmRlYnVnZ2luZyB5b3Ug
bWF5IG5lZWQgb24geW91ciBiZWhhbGYuDQoNCnNpbmNlcmVseSwNClIuDQoNCiNyZWd6Ym90
IGludHJvZHVjZWQ6IDgxMTc5NjFkOThmYjJkMzM1YWI2ZGUyY2FkN2FmYjhiNjE3MWY1ZmUN
Cg==

--------------aRgCRvGyZw0PvoZ2H1rHjGSj--

--------------pdMdvZsGczNI50M8e09AvFdI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEydMGi3nQKasCS8bLahNm1VQL0ZwFAmXzQpAFAwAAAAAACgkQahNm1VQL0ZwK
tA/9FGzilbYIPP4AwHtENWOQB5oeQXo8fqK0YienUbVpR9ozHwtyKwk2dseunv9R7T+4hRgEnn+S
Sx7L6y4C8t8tSgW+PZvJ462Rv2n7CREY+LtxAvdrw5LTcmZwElLVzuv1eGvnhIjYE0wlwfp6ndad
U0bm3KsE/p5A5kD0GbwE8OT1PRThYRA6xaBHe8YOWa3dilPPQONmZ5QABnn5ffTzzV7Msp+IX3RB
OubHJdCKM0VnX59uLB9PcFvqwJIpT1vP5Gu5bw74RMTfLe5qRCGH4gildU3UpTn26VqhsQ5n2wCi
NTKV+/U2/eckRMsFbvsyJHMQtNSq3BwP1VsoTdlpSCj97fPNPg3MAywxXtD+TmDczwQ/SJ8uLr2F
IjQDsZzAbND8jG9v4Sbwb+Y7fcaz5qEYr9RKVdp3warGveZ4LUWx8KL6YDwypc70vPl5O+EWhis2
DBdFXRAodumzVQqf5NyDt04/65EnvLhNx7pxrMAu8Y34QMMbxUjZOQCCUUSmiVSjuq+nWddaMr6j
GZsH9C5L4ISqSvpqLCvoyGX0a2zdosP8Uy0D8trz+l8auA0wFPJfYgcDl8g35ZyCa26v2Wg0PP1l
R6K8hDrCklOyU6pG0eEi5b2O7Juncjce6OWzjUZAMWBj4IHMjAak7GUAjI9D7AKqQPNLLUIPjKeX
ahw=
=fRg6
-----END PGP SIGNATURE-----

--------------pdMdvZsGczNI50M8e09AvFdI--

