Return-Path: <stable+bounces-181819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A38BA607F
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98D8188CB9B
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B682D29C7;
	Sat, 27 Sep 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iyanmv.com header.i=@iyanmv.com header.b="tHLUJ8zU"
X-Original-To: stable@vger.kernel.org
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587032E0B69
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758982817; cv=none; b=nnVfmYu3kIMrZunrRGXE2yJWeD8sm5td4duo1mIW4fRLii1Yljtw3pT9zt3C4HDivk1BZb9GkRWzvP3XsERgYp0pNdwSodwJ3SMTnVzOKk5YuIWP/bVdabOGeV73HKTD6ZVTkf+dNZCvoPQrdpibNiU1yZa4qvnqoCxBtxGUdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758982817; c=relaxed/simple;
	bh=u/aFZEeB1E+Rq+glcc1onQp64X8cmqYISYhciilIgdY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SfIa9lupR13niKPdkX07OFhS4B2dudR6XXMMiqWCTqxSZQOZMxxlbwvFsmZlvn4X0UZJHenPbeSANugbzmckIB5fhmrfYmUOqKe6PQHHgAfFapO+1oagQfB6dBWVVv9k6UHHvNjSWcRRvhdu4Mu18AF3Nxo4UDogIOTcmJWbWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iyanmv.com; spf=pass smtp.mailfrom=iyanmv.com; dkim=pass (2048-bit key) header.d=iyanmv.com header.i=@iyanmv.com header.b=tHLUJ8zU; arc=none smtp.client-ip=162.0.218.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iyanmv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iyanmv.com
Received: from MTA-12-4.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4cYqNW4pglz2xcC
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 14:20:11 +0000 (UTC)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4cYqNN2fdpz3hhVv;
	Sat, 27 Sep 2025 10:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iyanmv.com; s=default;
	t=1758982804; bh=u/aFZEeB1E+Rq+glcc1onQp64X8cmqYISYhciilIgdY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=tHLUJ8zU1oC59Ace4FGwF6ihTSKHBRAZuKCTamZ0W9eVEev6yZki9QdC92jFuWyiI
	 kLN0uX6RaPLgUme1KhoQrHtiqRxYIDI3RS2gJGFDGRIDYGqmXzUPtYBkQJUx0P4PsC
	 lnR7GVU9dZEf4Okd53lmZLATravcBhgZIahwBCb/nO/RJsXxzysO0oZNGKV4HoeQ5M
	 t2O1Pdx9rjhU6jsqR8+IJxATzJl6ZJvf3xgbicIXYHgqq9uA0mAYelPzBa2MOmtD84
	 jO+5TzTfY8ncgau5W/diGQGX6ejHubO6d0JpVqc99lx5KwJhOh9SOHb8Ao+g5l0Zai
	 XeVFNPGID8A0A==
Received: from [10.59.223.244] (mob-194-230-148-174.cgn.sunrise.net [194.230.148.174])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sat, 27 Sep 2025 10:19:58 -0400 (EDT)
Message-ID: <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
Date: Sat, 27 Sep 2025 16:19:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
To: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
Content-Language: en-US
In-Reply-To: <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FtzT8p0XJFBd0rm32PLPoACu"
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4cYqNW4pglz2xcC

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FtzT8p0XJFBd0rm32PLPoACu
Content-Type: multipart/mixed; boundary="------------xyw6Hd0QOJr01ek7spqCaNTr";
 protected-headers="v1"
From: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org
Message-ID: <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
In-Reply-To: <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>

--------------xyw6Hd0QOJr01ek7spqCaNTr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCk9uIDI3LzA5LzIwMjUgMTQ6NTIsIFRob3JzdGVuIExlZW1odWlzIHdyb3Rl
Og0KPiBEb2VzIDYuMTctcmM3IHdvcmsgZm9yIHlvdT8gV2UgbmVlZCB0byBrbm93IGlmIHRo
aXMgbmVlZHMgdG8gYmUgZml4ZWQgaW4NCj4ganVzdCB0aGUgc3RhYmxlIHRyZWUgb3IgaWYg
aXQgaXMgc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgYWRkcmVzc2VkIGluDQo+IG1haW5s
aW5lIGFzIHdlbGwuDQoNCjYuMTctcmM3IGJvb3RzIGZpbmUsIHNvIHRoZSBpc3N1ZSBpcyBq
dXN0IGluIHRoZSBzdGFibGUgdHJlZS4NCj4gSnVzdCB3b25kZXJpbmc6IHdoeSBhcmUgdGhv
c2UgcGFyYW1ldGVycyBuZWVkZWQ/IElzIHRoZSBoYXJkd2FyZSBub3QNCj4gZnVsbHkgc3Vw
cG9ydGVkIGJlIHRoZSB4ZSBkcml2ZXIgeWV0Pw0KDQppOTE1IGlzIHN0aWxsIHRoZSBkZWZh
dWx0IGRyaXZlciBmb3IgTWV0ZW9yIExha2UgaW50ZWdyYXRlZCBHUFVzLCBzbyANCnRoYXQn
cyB3aHkgSSBuZWVkIHRvIHBhc3MgdGhvc2UgcGFyYW1ldGVycy4gTHVuYXIgTGFrZSBhbHJl
YWR5IHVzZXMgWGUgDQpieSBkZWZhdWx0LCB0aG91Z2guIEluIG15IGV4cGVyaWVuY2UsIGZv
ciBhdCBsZWFzdCB0aGUgbGFzdCB0d28ga2VybmVsIA0KcmVsZWFzZSBjeWNsZXMsIEkndmUg
b2JzZXJ2ZWQgYmV0dGVyIGJhdHRlcnkgbGlmZSBhbmQgcGVyZm9ybWFuY2UgdXNpbmcgDQp0
aGUgWGUgZHJpdmVyLg0KDQpJIGRvIG5vdCBoYXZlIGNvbmNyZXRlIG51bWJlcnMgYWJvdXQg
cG93ZXIgdXNhZ2UgYW5kIGJhdHRlcnkgbGlmZSwganVzdCANCm15IChzdWJqZWN0aXZlKSBm
ZWVsaW5nIGFmdGVyIHVzaW5nIHRoZSBsYXB0b3AgZm9yIGEgd2VlayB3aXRoIGk5MTUgYW5k
IA0KYW5vdGhlciB3ZWVrIHdpdGggWGUuIEFib3V0IHBlcmZvcm1hbmNlLCBNaWNoYWVsIGZy
b20gUGhvcm9uaXggcmVjZW50bHkgDQpzaGFyZWQgc29tZSBiZW5jaG1hcmtzIHdpdGggYSBD
b3JlIFVsdHJhIDcgMTU1SCAoc2FtZSBDUFUgYXMgdGhlIA0KVGhpbmtwYWQgWDEgQ2FyYm9u
IEdlbiAxMik6DQoNCmh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9yZXZpZXcvaW50ZWwtbXRs
LWk5MTUteGUtbGludXgNCj4gQ2lhbywgVGhvcnN0ZW4NCg0KQmVzdCwNCkl5w6FuDQoNCi0t
IA0KSXnDoW4gTcOpbmRleiBWZWlnYQ0KR1BHIEtleTogMjA0QyA0NjFGIEJBOEMgODFEMSAw
MzI3ICBFNjQ3IDQyMkUgMzY5NCAzMTFFIDVBQzENCg0K

--------------xyw6Hd0QOJr01ek7spqCaNTr--

--------------FtzT8p0XJFBd0rm32PLPoACu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEIExGH7qMgdEDJ+ZHQi42lDEeWsEFAmjX8ooACgkQQi42lDEe
WsGdmg/9EnWxWzUnOPi8IFufL6gPeZO0ZVJrzrTzg05UhD30liYZB9vwcskmrrxs
3jmBe4yqouhd6E2CI4ZaieAVf2L0U0WOZ85I7eRsxQY8SZ7KFknfv4cFpRXp0YdX
XP6WWCQtaFwcIrXkZgyY3ULQ9kx4E0phUMKHSKruv+kfYGoLCaZvj5NqKTEef1ua
ayJOZyAkbi4kMrDQA4G69jnaY299jfbBq7KPFpInIVP5/z4M8aKfkD/YXoh18+4L
b4WHrMeRB7/hd+GHgmoNmeTl2n0j7wKy/JVxfIB1IzFaUENYcTqcqNLCl4oEBvyp
PJc+F7rYYXtsZ+8MW4bPRPChATDmTER7ms9ReBG97/0X772NRKZVEaXEHLb8h9vI
A9TurH5AIvbleaKUvb/oapKq9bBUOmP3YE+fX+DINM2MXiZ4sYwW2dIUKP8s9R1p
l/XUaf4U7P+WAAfCUzhZf25cmor5JwiE79WI0kJ6HrCE9EyYthtA+B7NWvcaAaiM
rsrZiJtc69I0qtE/a1Bf3U7uFMwQ0NB0y59w2cpbi0vasCBOLGfxC5y4vPWGvKdW
VPpnnMcqdmeK5SwbD7CxTgkXDANOExiCOq4gn4LhoLQ54ifwwgmX5M9YJkqaUwJb
KamTQcks7WUQqqCa/kp0lOHyToI+s2t+wcyCJhdnTol8jcmiWEU=
=hFwr
-----END PGP SIGNATURE-----

--------------FtzT8p0XJFBd0rm32PLPoACu--

