Return-Path: <stable+bounces-100862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576389EE237
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AA41884137
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2E020A5D1;
	Thu, 12 Dec 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NJsUVr6J"
X-Original-To: stable@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C951D8E10
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994204; cv=none; b=BRCxZbexpHMMOz49nuXsCWhvbTaG3qSRRXUk3zm6XshLZKDEI6reKkdxsb7vNqIi0vqxA2D49CrJ8rrgLprp7ydmxuw8CyzrACpFRAuZqj2nFS/Qbe3Pxl7OFg75RGsCbzrZhO8SjmtUjTOd8C2VtCPs4IMHEWaiuBF/Uz1WnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994204; c=relaxed/simple;
	bh=7Ikej1gXGz40a/9xqhCPhAV0Bvtii8ZB45DcHcV85zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YE4oOlwdUhP6oZElbFle5M4Eif7pLYxrLBudmnt0Q16r/Ytkm79WQ4mY84k0m6X4ZBiyiyW7EMepccFAVc7PTzgFgBG5Gh/p+tJHh08/EbhWflZHpQRT9g9puifAjqZ4WHh/kyUaSaXfzIsYvP/4KQJ17tMaVAFWc1WtIFXtV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NJsUVr6J; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1733994102;
	bh=7Ikej1gXGz40a/9xqhCPhAV0Bvtii8ZB45DcHcV85zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NJsUVr6JB0GRg0arHVP/QLrA4z8EHX7c9V45d2KPGdg33O9zxjT7xbYoKv1FzkGs1
	 XP0EwfoLQO3RNq8s9dqMg2yUe9f8n9SygOthAirZO8/RjJ7UI9vl7ZzUQECfx2BOuR
	 riAQH0Fpgc2Ad/KLarmXbwLaP5X4FITHdXzPbxsY=
X-QQ-mid: bizesmtp82t1733994069t0afr190
X-QQ-Originating-IP: /J0U6lJfC4/x3klShLZ3pqOcjOH7xB5pmELSzLYq8CQ=
Received: from [198.18.0.1] ( [223.104.122.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Dec 2024 17:01:06 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 541220267174211849
Message-ID: <E10C8C21570ADB69+4747ffa5-22b2-4752-961b-983ebfd3f6a9@uniontech.com>
Date: Thu, 12 Dec 2024 17:01:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
To: Jiri Kosina <jikos@kernel.org>
Cc: ulm@gentoo.org, helugang@uniontech.com, regressions@lists.linux.dev,
 stable@vger.kernel.org, regressions@leemhuis.info, bentiss@kernel.org,
 jeffbai@aosc.io, zhanjun@uniontech.com, guanwentao@uniontech.com
References: <uikt4wwpw@gentoo.org>
 <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
 <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WRNZdZzslgQNPEzkn3AuyUvh"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MaS7Y9S/TO7dPsf4W60LEv6+wm9aC43l/TI0d5oofV26XDYEHb42MLmU
	6R/zbtLstxcMvAPex0f53oIiYs8qpylGnZRYXBa3Vx9NuJgtUWg/I5he0VKBAfXEtLXVfkp
	d/GvYvUAtSX32+TW3G5tcjQgOb5/jfGEN23fz2BM4NSwuHHSsE8cRCPgUkPLzmsCkSxf0Mn
	u5WxmqCgvwRGNCGtjEoWLzr1t4woVIJU6kMJeT3lZbcgRl6p6dj+YNWnwOANlOahrGN/yMK
	gZJii+mPbIAsxJzcJzuURkuvBCfMDHfOp8BX8OFu71681/3ydfCcqk9MJeLc4h1kYVbX92m
	/uGvumV4JbZWJw6+ZH4oRL67HeOIpqRpmaoo57McaV7FzEf+oLcmZF9lr2XaRQQBdclbGlU
	nzD+n0jg1bI2mMPPzVMIEYyIkowYn50oTCjKd75I+m8VWbnXZb/2jFOoArRwhwGQrGE1x7k
	6baI62ACA24POl+i6hipkjX1M0UUIw5j27bDwIbbbGMLNfVi76MQsPTTwh8PCNMOZTa/YWc
	71a8UUXc4Kg+VR1kz6BDVu8PEGap8ErFfj/UrGbLCIw30he8ln3Or0VDyFSVDN9s9hl0yyt
	C/tLuufrXBH7IhDBOX+m5KGg4jyyhOeJwq/23C4tYkamuoVSMKIGjr9XP7le2UC6IWAn50e
	QgZbx5H0vOYa/waEo3sUbmM/ys5eOobV8521BssJS1b6fA9NAJm25Qc8uV+IHrxyanvpGAO
	Vx9R55KvSr27+e4p8fy6LMg0GwZuMoM8urZdUxITFDjsuiUlfVakT/XQgwgd9sF+n54Aw2m
	8JEWXlY131KEwY4U9zkuF4gFkM/nS3JSGT9uMbt/na+OBlm/1cwP7GcQ38AtKe9eE4b3Tgc
	DFvpYmNJVf4bBWaTEIhLftrQTQrqGKjL8ZDVzGoboKZC7pbiXcyqFQ/mrQcO2QQuUqxdCtK
	SwzXwWirOvU6NCsRLTnbhYwy/8iqMm7ECFp/HoeIhL/gr6VCV/s+3fhUEZd//enQgv+F4b6
	wuyVa031TrcXBYfEVvydMWIIBJQAcpm89pRflkg5bOQ5IoVqQB55SREyTEZG4nbDJvCw5sy
	XpmMmAsHyMgzBJElS8NV4chOpur0DO+wQI1QSez5cXDZDpfPyO3BvY=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WRNZdZzslgQNPEzkn3AuyUvh
Content-Type: multipart/mixed; boundary="------------yX5n00rw1F2wDVTqV3xnRkl3";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: ulm@gentoo.org, helugang@uniontech.com, regressions@lists.linux.dev,
 stable@vger.kernel.org, regressions@leemhuis.info, bentiss@kernel.org,
 jeffbai@aosc.io, zhanjun@uniontech.com, guanwentao@uniontech.com
Message-ID: <4747ffa5-22b2-4752-961b-983ebfd3f6a9@uniontech.com>
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
References: <uikt4wwpw@gentoo.org>
 <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
 <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet>
In-Reply-To: <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet>

--------------yX5n00rw1F2wDVTqV3xnRkl3
Content-Type: multipart/mixed; boundary="------------TzzLkuKgMwV7Fc5eNiegNTqU"

--------------TzzLkuKgMwV7Fc5eNiegNTqU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNC8xMi8xMiAxNjo1NiwgSmlyaSBLb3NpbmEgd3JvdGU6DQoNCj4gVGhhbmtzIGZv
ciBsb29raW5nIGludG8gdGhpcy4gSSBoYXZlIG5vdyBxdWV1ZWQgdGhlIHJldmVydCBpbg0K
PiBoaWQuZ2l0I2Zvci02LjEzL3Vwc3RyZWFtLWZpeGVzDQo+DQpIbW0sDQpUaGUgb3JpZ2lu
YWwgY29tbWl0IGluY2x1ZGVkIGEgY3J1Y2lhbCBmaXggZm9yIGEgdHlwbyB3aGVyZSAwMUU4
IHdhcyANCmluY29ycmVjdGx5IHVzZWQgaW5zdGVhZCBvZiAwMUU5LiBXZSBuZWVkIHRvIG1h
a2Ugc3VyZSB3ZSBrZWVwIHRoYXQgDQpjb3JyZWN0aW9uLg0KDQpQbGVhc2UgYmUgYXdhcmUs
DQotLSANCldhbmdZdWxpDQo=
--------------TzzLkuKgMwV7Fc5eNiegNTqU
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------TzzLkuKgMwV7Fc5eNiegNTqU--

--------------yX5n00rw1F2wDVTqV3xnRkl3--

--------------WRNZdZzslgQNPEzkn3AuyUvh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ1qmUgUDAAAAAAAKCRDF2h8wRvQL7kml
AQDTqoDOEdQUXUd6AdhGoL5mOAnVeT4nzUE6Ewd+zfsXHwEAnLLq0qggdaYO7C2UFBe3qlB185ec
utM24tUeIKM1hw4=
=mQi4
-----END PGP SIGNATURE-----

--------------WRNZdZzslgQNPEzkn3AuyUvh--

