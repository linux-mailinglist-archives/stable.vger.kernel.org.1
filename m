Return-Path: <stable+bounces-181799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726ABA5602
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 01:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45FD6279A4
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CF27F4F5;
	Fri, 26 Sep 2025 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iyanmv.com header.i=@iyanmv.com header.b="vPb2fNok"
X-Original-To: stable@vger.kernel.org
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFE22D4D3
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758927815; cv=none; b=DDLoQ5S85hynGzwy16daY/gfnYl+qZy5h1zT/IQoXj2H/ojBODs13Na3a/49parxeWKkNAJCvPBzENXZUEKPB8W8vsUXPBKfYlZ8TOf+p4IPNwuH484icqVyZnOkzPorldnt3oMCH4U59XlR+i8JwkaISNGcxsvDssp++33JuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758927815; c=relaxed/simple;
	bh=9fbFrDq9Q608yE5Sbyzp6hLo4hkVOoXPQ/HT2QVjj58=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uuSWgnId847k6MkvhJ2OgamlHDHrFInSt03gjbfan77RxIFMdqqyqjWbRlWF486vlJ+TqqDN0madb4ezNLnYlpL2BBBiMlIBpH8dZ8zVOmEiNz+HYQymK2vVlOuIBLWt1g6b6P/SlE5u4iYE5/dLinUAbdCPotdc0jBhbYNZpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iyanmv.com; spf=pass smtp.mailfrom=iyanmv.com; dkim=pass (2048-bit key) header.d=iyanmv.com header.i=@iyanmv.com header.b=vPb2fNok; arc=none smtp.client-ip=162.0.218.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iyanmv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iyanmv.com
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4cYQwz5M9Lz2xMw
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 22:58:27 +0000 (UTC)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 4cYQwr32JCz3hhVC;
	Fri, 26 Sep 2025 18:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iyanmv.com; s=default;
	t=1758927500; bh=9fbFrDq9Q608yE5Sbyzp6hLo4hkVOoXPQ/HT2QVjj58=;
	h=Date:To:Cc:From:Subject:From;
	b=vPb2fNokeh6suvaZgdgelv4ttuk1ggGvRblYhdtX8fpLtmg4GOVpf0eci62aRPk+A
	 rGpqFgDm0UETEk4sNrm74e9FBnloA5qbDXysBbsbBuf2wKyZ/y1xWHWWa3Gibz/86E
	 jlZoCwe4GSq7OlQAruKh6X/y6nknKLpuG7knmrfaY3mXXMdUNI6MDMM4nmU+qss8tC
	 vMnYwYHWyiWaG6rtjTmS+8AOs/yLTDAmPOhOfpbSF4rg/Kr2d+N8Zw1EdlCnsIMP06
	 9AB18fWnaSzRM506z2tCrfI/GiiYADKFv5+65n1HE7Mp28qD4pi67QZR40IGqJ+p2s
	 IlUkrd5KWlWHg==
Received: from [192.168.69.204] (adsl-89-217-41-119.adslplus.ch [89.217.41.119])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Fri, 26 Sep 2025 18:58:16 -0400 (EDT)
Message-ID: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
Date: Sat, 27 Sep 2025 00:58:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Content-Language: en-US, es-ES
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org
From: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>
Subject: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't boot
 with 6.16.9 and Xe driver
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dnSgrBGw2pAPx7gtbe9QyB3f"
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4cYQwz5M9Lz2xMw

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dnSgrBGw2pAPx7gtbe9QyB3f
Content-Type: multipart/mixed; boundary="------------Bv8zz6f9B88KdLNUc0pUQvE0";
 protected-headers="v1"
From: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org
Message-ID: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
Subject: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't boot
 with 6.16.9 and Xe driver

--------------Bv8zz6f9B88KdLNUc0pUQvE0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkFmdGVyIHVwZ3JhZGluZyB0byA2LjE2LjkgdGhpcyBtb3JuaW5nLCBteSBs
YXB0b3AgY2FuJ3QgYm9vdC4gSSBjYW5ub3QgDQpnZXQgYW55IGxvZ3MgYmVjYXVzZSB0aGUg
a2VybmVsIHNlZW1zIHRvIGZyZWV6ZSB2ZXJ5IGVhcmx5LCBldmVuIGJlZm9yZSANCkknbSBh
c2tlZCBmb3IgdGhlIGZ1bGwgZGlzayBlbmNyeXB0aW9uIHBhc3NwaHJhc2UuDQoNClRoaXMg
aXMgYSByZWdyZXNzaW9uIGZyb20gNi4xNi44IHRvIDYuMTYuOS4NCg0KSSBkaWQgYSBnaXQg
YmlzZWN0IGluIHRoZSBzdGFibGUvbGludXggYW5kIHRoaXMgaXMgdGhlIGNvbW1pdCBjYXVz
aW5nIA0KdGhlIGlzc3VlIGZvciBtZToNCg0KOTcyMDdhNGZlZDUzNDhmZjVjNWU3MWE3MzAw
ZGI5YjYzODY0MDg3OSBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdA0KY29tbWl0IDk3MjA3YTRm
ZWQ1MzQ4ZmY1YzVlNzFhNzMwMGRiOWI2Mzg2NDA4NzkgKEhFQUQpDQpBdXRob3I6IERhbmll
bGUgQ2VyYW9sbyBTcHVyaW8gPGRhbmllbGUuY2VyYW9sb3NwdXJpb0BpbnRlbC5jb20+DQpE
YXRlOiAgIFdlZCBKdW4gMjUgMTM6NTQ6MDYgMjAyNSAtMDcwMA0KDQogICAgIGRybS94ZS9n
dWM6IEVuYWJsZSBleHRlbmRlZCBDQVQgZXJyb3IgcmVwb3J0aW5nDQoNCiAgICAgWyBVcHN0
cmVhbSBjb21taXQgYTdmZmNlYTg2MzFhZjkxNDc5Y2FiMTBhYTdmYmZkMDcyMmYwMWQ5YSBd
DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDYyNTIwNTQwNS4xNjUzMjEy
LTMtZGFuaWVsZS5jZXJhb2xvc3B1cmlvQGludGVsLmNvbS8NCg0KSG93IHRvIHJlcHJvZHVj
ZToNCg0KMS4gVXBncmFkZSB0byA2LjE2LjkNCjIuIEVuYWJsZSB0aGUgWGUgZHJpdmVyIGJ5
IHBhc3NpbmcgaTkxNS5mb3JjZV9wcm9iZT0hN2Q1NSANCnhlLmZvcmNlX3Byb2JlPTdkNTUN
CjMuIFJlYm9vdA0KDQpCZXN0IHJlZ2FyZHMsDQpJecOhbg0KDQotLSANCkl5w6FuIE3DqW5k
ZXogVmVpZ2ENCkdQRyBLZXk6IDIwNEMgNDYxRiBCQThDIDgxRDEgMDMyNyAgRTY0NyA0MjJF
IDM2OTQgMzExRSA1QUMxDQoNCg==

--------------Bv8zz6f9B88KdLNUc0pUQvE0--

--------------dnSgrBGw2pAPx7gtbe9QyB3f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEIExGH7qMgdEDJ+ZHQi42lDEeWsEFAmjXGoIACgkQQi42lDEe
WsGeMg//V1/IlZOJicsTn3ReQWxr14M4xZRFdnaNPQYbEtmxv5Omrubu3PWpepfo
m/JtM3W6vup+Q8cTGWSW+OdgiRu2r162oSDu5wG29u8smzL8xr1r9MrGDI7YQ2HV
WwXBBNNSfY9fFNLKuYBIJsq5cV1Wl4YQGKwIx/mDV1QedSHetW7O3BIIQqgXNmEZ
AB3ZlWaJrejruY39YoJfJ2BFlYI7DmaySxZEzMYDNxiEg41AkJd6Jklm9HD28Vga
5uLeqfQO0aQv4rM0f8PKed/ykMIbNeEO1YyT9g5niP0IXKX+fArvB7GtWUhh8OwY
zy3paJE0UGGbgEFopnyDr1i9DjTcK5ceAYq/B0Vgpo7ahhknmmpOrsZb1RCtn1/h
rjVi3D4RE5YyjGcJ8WpSZIUm3X77Hn0q/m4AY9Z/Ly+iAeUTQERFrG3X3VNkScSX
RJ7KOkXo1IrHBLfaMEyKOX0yWFwvGgBkC4c0u1w42MAXe6TFkAGxDRKL6j1VENCc
wqaJGaR1FdZnc9HzUhE2rHTOr+h8WBtwK6zV13nYxe9IRvXVC0kU6SQsVy0mTWj1
e1wKSuKp2cp3pKrWzPKXR3ugZH006ssmiRh845wRMSKUk/XH6wNC7CcAj9xf06jp
T8mZcdxwWUAhBFnxRg1v162+7HLQG9qWRMsX0v3tOTBs9zSDYs0=
=kxv8
-----END PGP SIGNATURE-----

--------------dnSgrBGw2pAPx7gtbe9QyB3f--

