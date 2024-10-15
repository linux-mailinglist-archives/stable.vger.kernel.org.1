Return-Path: <stable+bounces-86381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2799F7E2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 22:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DF71F223CF
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB001F582E;
	Tue, 15 Oct 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="iwneV//P";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="djrALNGE"
X-Original-To: stable@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3F1B3936;
	Tue, 15 Oct 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023087; cv=none; b=KqGmeFv2/NgE2AoPlyv1S7qd5HsJObtIZgi4hstkOOVuo+rmc43yWcK4sxsUWAPK1M1waoPWF9gc00EKffMPXwPyTnyrybFTyEcpkPJ0wfd/H7ompnfSuT06WCVRp7EQ1GFi6s37dingCQ6+PWYWUtzLcyaJFX5bqSnF7YG+4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023087; c=relaxed/simple;
	bh=Fu78ZqWldsxz5I49tuuyG64vbdSGHOM3Qa0jC4RLOFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0HzziuBcY5jMyk+dPgAQXluZaTJC1hXPFVMWrxVHd1AVX89+hCrddV1TWYn8LLydDFXx1M1RA589yHMBWKp3s4djn6K78kW/1uc/Qb7LP6GWZ4ijVYmn0J3P0eoRH7YcyHCTwqRgS+3KQHcCOm4ftypk5rd2L7Yi7VydVw/86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=iwneV//P; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=djrALNGE; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <1af38ab3-786d-43e8-a414-50554edf7eac@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1729022762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fu78ZqWldsxz5I49tuuyG64vbdSGHOM3Qa0jC4RLOFE=;
	b=iwneV//PZmNfZSPIATH7ZBIqGzSIjpXzDNpqIT4bAiwoCZbK499oi3rBLA4Z3raDHrznT8
	zmkXLYu/FmlhbVVoncH9nNtzD+Ko2z9kCDJSxwNyMoIR5E1V37Ql8tXm3JI5EV6DaqUYy6
	Xf4992COruWt2qOUaiMCRdYhGEuO0O0MzQelyRJDup4Mh3YloIcTeVUZ6KIRgFTc0oAzmG
	39z1ahqlBAd+QgfGlMuINjwdYKeT/IHipJWb1IJG9BxjrVo5nFUZZPezk528c4/9uAnN1e
	AI7/nW1QP+EW7mugbMP0jQQyvGfTNJmB+ddHYx+ZHxwG1cC+mxpL88TOadzUA+P++yr/lQ
	uFeh2pawshjXdOys9mabPYubXv1yR8PjR+urMC8+yirsKCZarc0JriHE/qwISrn1bRoteD
	Q/59OcRBkUip85TwpemPCA/iF6Y0kQF4518EKmYTr8mF5DUS5rq3Gw2o9PiLww0bJOhM3V
	dPJM6yoy9DtqJd8GUe+6ZEly5mfsYpMm/Q7a7YEii0NUOJZyw0lBfcXmHcempvWE8iSryk
	2Qg3CpVt9wLf0xxhZ013r7+g7Ft7F2rPjDYQphafMliVYS+uLwJTE1K/wIBF/n2Xs3ZS7a
	NKPbvsVB8H+JKvKmN/mW3hmVybzdiVhmjdChFNt6B5KNMia3nLKzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1729022762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fu78ZqWldsxz5I49tuuyG64vbdSGHOM3Qa0jC4RLOFE=;
	b=djrALNGErjiaIzFL/AIPiMLF81Q+IM8cTMRtNJyWCNCWA9pOZMoPUynJ4xfD/HF3WWrOWw
	q4dnwFVjPKaaD/AA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date: Tue, 15 Oct 2024 23:05:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Stuebner <heiko@sntech.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Jason Montleon <jmontleo@redhat.com>, stable@vger.kernel.org
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
From: Felix Yan <felixonmars@archlinux.org>
Content-Language: en-US-large
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
 EAXqa6vUBxBrfkBwwf11sYqqZyFORHr8
In-Reply-To: <20241009072749.45006-1-alexghiti@rivosinc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hAHpfw1bwkWTx3Aju9c33paG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hAHpfw1bwkWTx3Aju9c33paG
Content-Type: multipart/mixed; boundary="------------jluT9zCFJUvyVOXjKssCP6HF";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Stuebner <heiko@sntech.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Jason Montleon <jmontleo@redhat.com>, stable@vger.kernel.org
Message-ID: <1af38ab3-786d-43e8-a414-50554edf7eac@archlinux.org>
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
In-Reply-To: <20241009072749.45006-1-alexghiti@rivosinc.com>

--------------jluT9zCFJUvyVOXjKssCP6HF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvOS8yNCAxMDoyNywgQWxleGFuZHJlIEdoaXRpIHdyb3RlOg0KPiBFYXJseSBjb2Rl
IGRlc2lnbmF0ZXMgdGhlIGNvZGUgZXhlY3V0ZWQgd2hlbiB0aGUgTU1VIGlzIG5vdCB5ZXQg
ZW5hYmxlZCwNCj4gYW5kIHRoaXMgY29tZXMgd2l0aCBzb21lIGxpbWl0YXRpb25zIChzZWUN
Cj4gRG9jdW1lbnRhdGlvbi9hcmNoL3Jpc2N2L2Jvb3QucnN0LCBzZWN0aW9uICJQcmUtTU1V
IGV4ZWN1dGlvbiIpLg0KPiANCj4gRk9SVElGWV9TT1VSQ0UgbXVzdCBiZSBkaXNhYmxlZCB0
aGVuIHNpbmNlIGl0IGNhbiB0cmlnZ2VyIGtlcm5lbCBwYW5pY3MNCj4gYXMgcmVwb3J0ZWQg
aW4gWzFdLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEphc29uIE1vbnRsZW9uIDxqbW9udGxlb0By
ZWRoYXQuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJp
c2N2L0NBSkRfYlBKZXM0UWhtWFk1ZjYzR0hWOUI5SEZrU0NvYVpqay1xQ1QyTkdTN1E5SE9E
Z0BtYWlsLmdtYWlsLmNvbS8gWzFdDQo+IEZpeGVzOiBhMzU3MDdjM2Q4NTAgKCJyaXNjdjog
YWRkIG1lbW9yeS10eXBlIGVycmF0YSBmb3IgVC1IZWFkIikNCj4gRml4ZXM6IDI2ZTdhYWNi
ODNkZiAoInJpc2N2OiBBbGxvdyB0byBkb3duZ3JhZGUgcGFnaW5nIG1vZGUgZnJvbSB0aGUg
Y29tbWFuZCBsaW5lIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZHJlIEdoaXRpIDxhbGV4Z2hpdGlAcml2b3NpbmMuY29tPg0KPiAt
LS0NCj4gICBhcmNoL3Jpc2N2L2VycmF0YS9NYWtlZmlsZSAgICB8IDYgKysrKysrDQo+ICAg
YXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgICAgfCA1ICsrKysrDQo+ICAgYXJjaC9yaXNj
di9rZXJuZWwvcGkvTWFrZWZpbGUgfCA2ICsrKysrLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvZXJyYXRhL01ha2VmaWxlIGIvYXJjaC9yaXNjdi9lcnJhdGEvTWFrZWZpbGUN
Cj4gaW5kZXggOGEyNzM5NDg1MTIzLi5mMGRhOWQ3YjM5YzMgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvcmlzY3YvZXJyYXRhL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvcmlzY3YvZXJyYXRhL01h
a2VmaWxlDQo+IEBAIC0yLDYgKzIsMTIgQEAgaWZkZWYgQ09ORklHX1JFTE9DQVRBQkxFDQo+
ICAgS0JVSUxEX0NGTEFHUyArPSAtZm5vLXBpZQ0KPiAgIGVuZGlmDQo+ICAgDQo+ICtpZmRl
ZiBDT05GSUdfUklTQ1ZfQUxURVJOQVRJVkVfRUFSTFkNCj4gK2lmZGVmIENPTkZJR19GT1JU
SUZZX1NPVVJDRQ0KPiArS0JVSUxEX0NGTEFHUyArPSAtRF9fTk9fRk9SVElGWQ0KPiArZW5k
aWYNCj4gK2VuZGlmDQo+ICsNCj4gICBvYmotJChDT05GSUdfRVJSQVRBX0FOREVTKSArPSBh
bmRlcy8NCj4gICBvYmotJChDT05GSUdfRVJSQVRBX1NJRklWRSkgKz0gc2lmaXZlLw0KPiAg
IG9iai0kKENPTkZJR19FUlJBVEFfVEhFQUQpICs9IHRoZWFkLw0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgYi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmls
ZQ0KPiBpbmRleCA3Zjg4Y2M0OTMxZjUuLjY5ZGM4YWFhYjNmYiAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwv
TWFrZWZpbGUNCj4gQEAgLTM2LDYgKzM2LDExIEBAIEtBU0FOX1NBTklUSVpFX2FsdGVybmF0
aXZlLm8gOj0gbg0KPiAgIEtBU0FOX1NBTklUSVpFX2NwdWZlYXR1cmUubyA6PSBuDQo+ICAg
S0FTQU5fU0FOSVRJWkVfc2JpX2VjYWxsLm8gOj0gbg0KPiAgIGVuZGlmDQo+ICtpZmRlZiBD
T05GSUdfRk9SVElGWV9TT1VSQ0UNCj4gK0NGTEFHU19hbHRlcm5hdGl2ZS5vICs9IC1EX19O
T19GT1JUSUZZDQo+ICtDRkxBR1NfY3B1ZmVhdHVyZS5vICs9IC1EX19OT19GT1JUSUZZDQo+
ICtDRkxBR1Nfc2JpX2VjYWxsLm8gKz0gLURfX05PX0ZPUlRJRlkNCj4gK2VuZGlmDQo+ICAg
ZW5kaWYNCj4gICANCj4gICBleHRyYS15ICs9IHZtbGludXgubGRzDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2tlcm5lbC9waS9NYWtlZmlsZSBiL2FyY2gvcmlzY3Yva2VybmVsL3Bp
L01ha2VmaWxlDQo+IGluZGV4IGQ1YmYxYmM3ZGU2Mi4uODFkNjlkNDVjMDZjIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9waS9NYWtlZmlsZQ0KPiArKysgYi9hcmNoL3Jp
c2N2L2tlcm5lbC9waS9NYWtlZmlsZQ0KPiBAQCAtMTYsOCArMTYsMTIgQEAgS0JVSUxEX0NG
TEFHUwk6PSAkKGZpbHRlci1vdXQgJChDQ19GTEFHU19MVE8pLCAkKEtCVUlMRF9DRkxBR1Mp
KQ0KPiAgIEtCVUlMRF9DRkxBR1MJKz0gLW1jbW9kZWw9bWVkYW55DQo+ICAgDQo+ICAgQ0ZM
QUdTX2NtZGxpbmVfZWFybHkubyArPSAtRF9fTk9fRk9SVElGWQ0KPiAtQ0ZMQUdTX2xpYi1m
ZHRfcm8ubyArPSAtRF9fTk9fRk9SVElGWQ0KPiAgIENGTEFHU19mZHRfZWFybHkubyArPSAt
RF9fTk9fRk9SVElGWQ0KPiArIyBsaWIvc3RyaW5nLmMgYWxyZWFkeSBkZWZpbmVzIF9fTk9f
Rk9SVElGWQ0KPiArQ0ZMQUdTX2N0eXBlLm8gKz0gLURfX05PX0ZPUlRJRlkNCj4gK0NGTEFH
U19saWItZmR0Lm8gKz0gLURfX05PX0ZPUlRJRlkNCj4gK0NGTEFHU19saWItZmR0X3JvLm8g
Kz0gLURfX05PX0ZPUlRJRlkNCj4gK0NGTEFHU19hcmNocmFuZG9tX2Vhcmx5Lm8gKz0gLURf
X05PX0ZPUlRJRlkNCj4gICANCj4gICAkKG9iaikvJS5waS5vOiBPQkpDT1BZRkxBR1MgOj0g
LS1wcmVmaXgtc3ltYm9scz1fX3BpXyBcDQo+ICAgCQkJICAgICAgIC0tcmVtb3ZlLXNlY3Rp
b249Lm5vdGUuZ251LnByb3BlcnR5IFwNCg0KSSB3YXMgaGF2aW5nIHNpbWlsYXIgYm9vdCBp
c3N1ZXMgd2l0aCBOZXpoYSBEMSBhbmQgdGhpcyBmaXhlcyBpdCBmb3IgbWUgDQphcyB3ZWxs
LiBUaGFua3MgKGFuZCB0aGFua3MgRW1pbCBmb3IgcG9pbnRpbmcgbWUgdG8gdGhpcyBwYXRj
aCkhDQoNCkFwcGxpZWQgaW4gbXkgQXJjaCBMaW51eCBSSVNDLVYgcG9ydC4NCg0KLS0gDQpS
ZWdhcmRzLA0KRmVsaXggWWFuDQoNCg==

--------------jluT9zCFJUvyVOXjKssCP6HF--

--------------hAHpfw1bwkWTx3Aju9c33paG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmcOyyYFAwAAAAAACgkQeGxj8zDXy5Jm
LA/9HWo8UrV4VnyaXDjZFadjKqoXDaMYplFhyoaddcFw84tAw8jX4GrRq91H3xIaSYsaLjFSJ1Tz
Yp1fGPziHVnaB0w4vQF5lzjRXRPuaLz/sK7YY35DhBCv+zm6ulwSOamYyk8XJm35f05NGv2AVpE5
1orgubUIj2b4D1vb0B+roYVz9iQ9ukn1mU11NpMMGDWoZTg2zt8k4SOgTUGyvuhcuWalWiLm2z6c
+IBnE6B/bKSA7NF7yfVFd1m5i5gowDiVpPlyamzNOxTUN2K1U2pkhGSkoqUgL7u7xV46/8c8f4Bn
ebt5kAuNhHw0DeozSMScp2XydfJx8Krzw856xCCLZECOMXgG1pzaE5ws4Ii2pwuktXV5KqqrE44z
HXvnClh4cyxHgW73YR+hs+/Nyqa9Da1hi2NH5y66H6UtyXBCp8Rjvf6HdGw31fz6Uy2m7epqP5Sw
woB8dJWw9JTOosHuvtSJ1jsnYn3snZ6nZn2uqoUAdunXfpkWflmwKdvVr6ms4QJYWEph+BB0yvZg
SRaNyqRl7eLFcC7VUnQuXcBzr0RBknsTxSSJ8C26ARZTdk/73gDtsu9Y2+i4N+97MxymVuzpXPq9
eiLP5Si5f2Pu+h2FUHhbvQDA/W9Hu0Gtkc/J3VoK9Ejtzic6LiJL2vKnwkOcLPaT4ZIEHcgLUmAu
N20=
=Fjnh
-----END PGP SIGNATURE-----

--------------hAHpfw1bwkWTx3Aju9c33paG--

