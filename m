Return-Path: <stable+bounces-181841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71FBA6FAE
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 13:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849A117BA20
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0EF29ACDD;
	Sun, 28 Sep 2025 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iyanmv.com header.i=@iyanmv.com header.b="iIe9Lzn/"
X-Original-To: stable@vger.kernel.org
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845A35950
	for <stable@vger.kernel.org>; Sun, 28 Sep 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058227; cv=none; b=UjjfZcDo1iAi8dssGPCsORm+kx3bCC16kQP/jGiJTAs6JA0EzHAvqo0hrqGfGmRGSLu2zGz4OncW7Wf0Ce9xBsp2aPHEKZEyo4p/87lVRLSM9Ib57lq9CPwSQ8r+gPoW+6hVKue3/M2ZlywDp8ShZc2xBv+T/VBb6nYH4hu7P4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058227; c=relaxed/simple;
	bh=a/TGHaNmSB/SspzCyEVsastyjIzuA7jN1ADD7CrCWi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/o7AWcqzAm7DHDXentHV99BMn4TvUQSEDv/TYxqrCdcPravswQiRU9sVeHLseJ8iLlSeAn5htDXjRrCqHmaqvaKbw0jRXzo5iHQEtYMvKVpiCpFG7boEEbK8M8At7h9rU86bQ6baeJ2Qq1Fvv1pYcUIf5jhB5TMTBFi1+vgDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iyanmv.com; spf=pass smtp.mailfrom=iyanmv.com; dkim=pass (2048-bit key) header.d=iyanmv.com header.i=@iyanmv.com header.b=iIe9Lzn/; arc=none smtp.client-ip=162.0.218.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iyanmv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iyanmv.com
Received: from MTA-10-3.privateemail.com (mta-10.privateemail.com [198.54.118.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4cZMGd0Z7zz2xQF
	for <stable@vger.kernel.org>; Sun, 28 Sep 2025 11:16:57 +0000 (UTC)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4cZMGT1psNz3hhdT;
	Sun, 28 Sep 2025 07:16:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iyanmv.com; s=default;
	t=1759058209; bh=a/TGHaNmSB/SspzCyEVsastyjIzuA7jN1ADD7CrCWi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iIe9Lzn/0e5Trq8XCFljdX+vR9A4+FbyxiyIj4jYxXjx6iqkP2fNoayGD3jGQFOyE
	 rszSQg9Dq5tau3hX5tC84k8iBpdvhSU4EfOy0YpVkPIPBZnktVgGiKXyd1TFzK3ScJ
	 0Jypt448UBCKjvQl/ABe4D8gv5H/jzG9Gf2c4iW8y21PViOL7kEeQUPPacRA0qRd0l
	 LEKitRQY24AhlE9waPHQnbCNdzIawtZhZ9gl8GT4FJ0EoUJZJFUcJk0ps2wxFyjp0i
	 keytpt4n7tUF3EaDX6o/RfaYgm3g6gR2lsmY0b1fX9ziBhit+v4lVuH5bUx9GRoEtJ
	 MQ92isihwceeA==
Received: from [192.168.69.204] (adsl-89-217-41-119.adslplus.ch [89.217.41.119])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Sun, 28 Sep 2025 07:16:42 -0400 (EDT)
Message-ID: <afd60150-7371-49f4-a95d-d9147e067757@iyanmv.com>
Date: Sun, 28 Sep 2025 13:16:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
To: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
 <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
 <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>
Content-Language: en-US, es-ES
From: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>
In-Reply-To: <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Z0c7yz0fCawqyGmbY488aY7a"
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4cZMGd0Z7zz2xQF

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Z0c7yz0fCawqyGmbY488aY7a
Content-Type: multipart/mixed; boundary="------------ki4ifLJhud3SM6JLgxL6ned4";
 protected-headers="v1"
From: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <afd60150-7371-49f4-a95d-d9147e067757@iyanmv.com>
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
 <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
 <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>
In-Reply-To: <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>

--------------ki4ifLJhud3SM6JLgxL6ned4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMDkvMjAyNSAxNjozMSwgVGhvcnN0ZW4gTGVlbWh1aXMgd3JvdGU6DQo+IFRoeC4g
Q291bGQgeW91IGFsc28gdHJ5IGlmIHJldmVydGluZyB0aGUgcGF0Y2ggZnJvbSA2LjE2Lnkg
aGVscHM/IE5vdGUsDQo+IHlvdSBtaWdodCBuZWVkIHRvIHJldmVydCAiZHJtL3hlL2d1Yzog
U2V0IFJDUy9DQ1MgeWllbGQgcG9saWN5IiBhcyB3ZWxsLA0KPiB3aGljaCBhcHBhcmVudGx5
IGRlcGVuZHMgb24gdGhlIHBhdGNoIHRoYXQgY2F1c2VzIHlvdXIgcHJvYmxlbXMuDQoNClll
cywgcmV2ZXJ0aW5nIGJvdGggZGQxYTQxNWRjZmQ1ICJkcm0veGUvZ3VjOiBTZXQgUkNTL0ND
UyB5aWVsZCBwb2xpY3kiIA0KYW5kIDk3MjA3YTRmZWQ1MyAiZHJtL3hlL2d1YzogRW5hYmxl
IGV4dGVuZGVkIENBVCBlcnJvciByZXBvcnRpbmciIGZyb20gDQo2LjE2LnkgZml4ZXMgdGhl
IGlzc3VlIGZvciBtZS4NCg0KQmVzdCwNCkl5w6FuDQoNCi0tIA0KSXnDoW4gTcOpbmRleiBW
ZWlnYQ0KR1BHIEtleTogMjA0QyA0NjFGIEJBOEMgODFEMSAwMzI3ICBFNjQ3IDQyMkUgMzY5
NCAzMTFFIDVBQzENCg==

--------------ki4ifLJhud3SM6JLgxL6ned4--

--------------Z0c7yz0fCawqyGmbY488aY7a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEIExGH7qMgdEDJ+ZHQi42lDEeWsEFAmjZGRIACgkQQi42lDEe
WsG+VhAAgbDnUCYKvGj1hUQVpz9lTsQB5vY+Vfgdasudnesj+0CoZu0tR9pWivj9
J9QuUooFA+HwVuj4/QeGOqo2GIInjy8Q2ZVYN836U8MBsF9culOXCuaSpft7YljS
MgaNcW1h7dYZ7yAN2719MuGsOLWjwbmp1hVftng2jypdvz3Do8qMGE1RZkw9i89A
knuGUMkI5wyJ6QXaSfN/tb2ocBeLGjsUwWdQH/KHxw8jy53D/pfIcXpTWrCIseKS
PocR5Q3ffEOVbAfRIDlpp9X1YTByUm/S/GOlxEYskuJ70T2BVnuCmgQcO53xSpWP
voEX1dwBGz6QXh/9sQKfYqkAS8kPv4TcdWaGHYxXFFTVfnECiNP34SBlRjTmhUkF
DliFLS+/AAewYbrq2ua3s9LM8FKvHAyc5Lmson/jwrvas5pmDX5cCA8ZNVSq12CV
woxLpxMQBC83DEA5Y66ZFQW7DjqNpKVpWYckl4lotF5TUcAjPj2qiJvTOw+FoPbd
V3KuBtUMDoikEekfzYNLPSJiJgvbtfPGHyVg+XB7O7qzqGaVylxSHbMgiYdGRL/R
tnJgfq1DRhTK+IrI8lwd6Oiab9Bs8HoHVwzvVfYxgpsXyLUQJGFUiFO/rzothKkH
qVewDDmxYDCcyLkJy4DmlIsW7I3Qre4gVHFOyMtwj8K/wJzTfik=
=3gtP
-----END PGP SIGNATURE-----

--------------Z0c7yz0fCawqyGmbY488aY7a--

