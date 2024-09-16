Return-Path: <stable+bounces-76204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73829979E86
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750631C22AE0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B54E1459E0;
	Mon, 16 Sep 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="C6nMpWwq"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7013D612
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479158; cv=none; b=Si2m5PjhUWi0c3xywJ8MAITy8AJCvKca4Ic9WXj4UAWApMADrAqtfsQtC/dO7biJyLvHkXcIgRVmLnk43vPmuN0kLbzJcrc8Qou5ujuNvd5z5eFNLC3nGxiIAP9DkfkdBBIyVp/SnpWEIif4MhEf6oxFlLx6I54SJ5IXF8bu0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479158; c=relaxed/simple;
	bh=USbGwEO7IwcHWeNLhpwNDOUlKjzXqvfr9ct/oRzf6/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wjym4AQ6wb8aUjw871wK4vfibZK341Mxn2spWMN5U31AM13Uls5N7XeO5fxNhA/Q7x0RZf5w1Z7kB+U6TM5CLFs7V37t99SlF33hB0MSPLHPlAa7AgKN3yQjY6rV/ohvThp6uEH5DpmNzvZCnRa3DpbfxAImibB4YnZiuEdxfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=C6nMpWwq; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726479139;
	bh=USbGwEO7IwcHWeNLhpwNDOUlKjzXqvfr9ct/oRzf6/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=C6nMpWwqYxGFdPPYAXK2jEhxh5V/9d/v+BZRPuqvJsmz0ESPuHj3a48uSWepg2T1y
	 24vC13VN1vJb3nZj5Bcn6JhovO3j/Uu/mKpsa221LpeQuLcx5lLVO6T3txloKwfFqC
	 YtvsTqoJSX2WKnZcdw91XEAtsPWkHQa2x+ZCYPmk=
X-QQ-mid: bizesmtpip4t1726479134td6dydv
X-QQ-Originating-IP: u61mJaE1jT59hiRq71n3xxPlEAr5Pfy9ohSojPmcDec=
Received: from [IPV6:240e:36c:df7:ef00:7c16:95 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 17:32:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8058414913114651353
Message-ID: <535BAC253A2AA9E5+8efb29ef-a3b4-4e3f-b8ff-31aebb5eefff@uniontech.com>
Date: Mon, 16 Sep 2024 17:32:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10] LoongArch: KVM: Remove undefined a6 argument comment
 for kvm_hypercall()
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
References: <Zuf5zjeeWO9zfUkL@3bb1e60d1c37>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Zuf5zjeeWO9zfUkL@3bb1e60d1c37>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zPbJb0saSJ40xEAq3FqPz6LI"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zPbJb0saSJ40xEAq3FqPz6LI
Content-Type: multipart/mixed; boundary="------------8YdOfnc7UemR0qZ4RE3IKS5m";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Message-ID: <8efb29ef-a3b4-4e3f-b8ff-31aebb5eefff@uniontech.com>
Subject: Re: [PATCH 6.10] LoongArch: KVM: Remove undefined a6 argument comment
 for kvm_hypercall()
References: <Zuf5zjeeWO9zfUkL@3bb1e60d1c37>
In-Reply-To: <Zuf5zjeeWO9zfUkL@3bb1e60d1c37>

--------------8YdOfnc7UemR0qZ4RE3IKS5m
Content-Type: multipart/mixed; boundary="------------qeZG1mGiGoWD0JD0PoUMoxOr"

--------------qeZG1mGiGoWD0JD0PoUMoxOr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAyMDI0LzkvMTYgMTc6MjYsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPiBIaSwN
Cj4NCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPg0KPiBGWUk6IGtlcm5lbCB0ZXN0IHJv
Ym90IG5vdGljZXMgdGhlIHN0YWJsZSBrZXJuZWwgcnVsZSBpcyBub3Qgc2F0aXNmaWVkLg0K
Pg0KPiBUaGUgY2hlY2sgaXMgYmFzZWQgb24gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2Mv
aHRtbC9sYXRlc3QvcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWwjb3B0aW9uLTMN
Cj4NCj4gUnVsZTogVGhlIHVwc3RyZWFtIGNvbW1pdCBJRCBtdXN0IGJlIHNwZWNpZmllZCB3
aXRoIGEgc2VwYXJhdGUgbGluZSBhYm92ZSB0aGUgY29tbWl0IHRleHQuDQo+IFN1YmplY3Q6
IFtQQVRDSCA2LjEwXSBMb29uZ0FyY2g6IEtWTTogUmVtb3ZlIHVuZGVmaW5lZCBhNiBhcmd1
bWVudCBjb21tZW50IGZvciBrdm1faHlwZXJjYWxsKCkNCj4gTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvc3RhYmxlLzhFRkFBMzg1MTI1M0VCOUElMkIyMDI0MDkxNjA5MjU0Ni40
Mjk0NjQtMS13YW5neXVsaSU0MHVuaW9udGVjaC5jb20NCj4NCj4gUGxlYXNlIGlnbm9yZSB0
aGlzIG1haWwgaWYgdGhlIHBhdGNoIGlzIG5vdCByZWxldmFudCBmb3IgdXBzdHJlYW0uDQo+
DQpTb3JyeSBmb3IgYm90aGVyaW5nIHlvdSBhbGwsDQpwYXRjaC12MiBsaW5rOiANCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC81QjEzQjJBRjdDMjc3OUE3KzIwMjQwOTE2MDkyODU3
LjQzMzMzNC0xLXdhbmd5dWxpQHVuaW9udGVjaC5jb20vDQpUaGFua3MsDQotLSANCldhbmdZ
dWxpDQo=
--------------qeZG1mGiGoWD0JD0PoUMoxOr
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

--------------qeZG1mGiGoWD0JD0PoUMoxOr--

--------------8YdOfnc7UemR0qZ4RE3IKS5m--

--------------zPbJb0saSJ40xEAq3FqPz6LI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZuf7HAUDAAAAAAAKCRDF2h8wRvQL7obx
AQCB0yiArM+pUxTf+6w0vGMUZ7586hFObeS4BWAKqunMRQEA2w6KggOZ+X9gK4cdac+Ln9fCawh5
kw+fFdBBC/vuEAM=
=9Fsf
-----END PGP SIGNATURE-----

--------------zPbJb0saSJ40xEAq3FqPz6LI--


