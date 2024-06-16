Return-Path: <stable+bounces-52302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74F909C4D
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 09:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDACC1F21351
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE9181330;
	Sun, 16 Jun 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kleine-koenig.org header.i=@kleine-koenig.org header.b="FJa4uS+g"
X-Original-To: stable@vger.kernel.org
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2739181310;
	Sun, 16 Jun 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.41.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523750; cv=none; b=j6GQgjrcIaLItmMYc8P/PEMW6+XJUdv0kG2Tr1c38SyFxL7z+RfTd7miYykkNwIsmMcW6YGJY/CHb1WWUJAo9QkwvBWfNvSNx+wzOcZh99SNCZE8mZ6EBZ/NsgUve0xoeNxFQKXfv6g+ZZi35xNqPz86a/Gt4Hya2B5qMstqcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523750; c=relaxed/simple;
	bh=wRqCuN9nCVqp6rgbDtEqWYaj+AzZ7J93vIC6dlOIcmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7PFUQ/au30tv9ALIwLuZ2lyTMLoKrYvuEIM64+GlorP85emdqx08yoYnXkigVF3CzXS7pARcff/BsNLjpITpQ1p4rezDUX5Y9PhwXRIh4XUxhxFUKvEV7zu+5nYlTSEwzKYUXZIhV+Nw/+QJVB+xV9Q4E2CXshBYsZkv1REgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org; spf=pass smtp.mailfrom=kleine-koenig.org; dkim=pass (2048-bit key) header.d=kleine-koenig.org header.i=@kleine-koenig.org header.b=FJa4uS+g; arc=none smtp.client-ip=162.55.41.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kleine-koenig.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kleine-koenig.org;
	s=2022; t=1718523169;
	bh=wRqCuN9nCVqp6rgbDtEqWYaj+AzZ7J93vIC6dlOIcmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FJa4uS+gR9lkkRchFFLqPH3hq4oTB5firbvC3X+M6o+5ZgmFxHvCJ+WuKTTySZ7s0
	 TKGERvQTpA5QsIK3XhinVLNEcc4690WsxM3bgs3lNkPnh3OC2TDqQVcM6lSXTUVpWe
	 AHK1puNtBz1f91tOKypW4hlAEi6mz4WREzAkjDSqCC6/xxqoHqOhi8PWwbmmM7uH37
	 Fl5oaukwLJUPpEqtvPmkE0T0KWNQ4NSlq1v/RoAgwqvqBBVXUDgQJ1TfUagwWTV0Gt
	 9YXfYIzcDGQOVTE0L2sPSGinvfYV2umo/2zrAMVygJWH0Aav4vGIaaDARCxMOdb8eD
	 Mr3yNHeU4csMA==
Received: from localhost (localhost [127.0.0.1])
	by algol.kleine-koenig.org (Postfix) with ESMTP id A1D92E66A50;
	Sun, 16 Jun 2024 09:32:49 +0200 (CEST)
Received: from algol.kleine-koenig.org ([IPv6:::1])
 by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavis, port 10024)
 with ESMTP id QcX_4OihaZ4i; Sun, 16 Jun 2024 09:32:49 +0200 (CEST)
Received: from [IPV6:2a02:8071:b783:6940:3886:c8fd:3fff:b697] (unknown [IPv6:2a02:8071:b783:6940:3886:c8fd:3fff:b697])
	by algol.kleine-koenig.org (Postfix) with ESMTPSA;
	Sun, 16 Jun 2024 09:32:48 +0200 (CEST)
Message-ID: <5aaa6ea3-b8f8-4e72-91a1-01de8bbcdc3d@kleine-koenig.org>
Date: Sun, 16 Jun 2024 09:32:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "driver core: platform: Emit a warning if a remove callback
 returned non-zero" has been added to the 5.10-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240616021857.1688223-1-sashal@kernel.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
In-Reply-To: <20240616021857.1688223-1-sashal@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pbB2LYZd0ys5gebmSDAORUD8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pbB2LYZd0ys5gebmSDAORUD8
Content-Type: multipart/mixed; boundary="------------ASiS1Bz7ymRomK7IGZo5HHhN";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <5aaa6ea3-b8f8-4e72-91a1-01de8bbcdc3d@kleine-koenig.org>
Subject: Re: Patch "driver core: platform: Emit a warning if a remove callback
 returned non-zero" has been added to the 5.10-stable tree
References: <20240616021857.1688223-1-sashal@kernel.org>
In-Reply-To: <20240616021857.1688223-1-sashal@kernel.org>

--------------ASiS1Bz7ymRomK7IGZo5HHhN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gU2FzaGEsDQoNCk9uIDYvMTYvMjQgMDQ6MTgsIFNhc2hhIExldmluIHdyb3RlOg0K
PiBUaGlzIGlzIGEgbm90ZSB0byBsZXQgeW91IGtub3cgdGhhdCBJJ3ZlIGp1c3QgYWRkZWQg
dGhlIHBhdGNoIHRpdGxlZA0KPiANCj4gICAgICBkcml2ZXIgY29yZTogcGxhdGZvcm06IEVt
aXQgYSB3YXJuaW5nIGlmIGEgcmVtb3ZlIGNhbGxiYWNrIHJldHVybmVkIG5vbi16ZXJvDQo+
IA0KPiB0byB0aGUgNS4xMC1zdGFibGUgdHJlZSB3aGljaCBjYW4gYmUgZm91bmQgYXQ6DQo+
ICAgICAgaHR0cDovL3d3dy5rZXJuZWwub3JnL2dpdC8/cD1saW51eC9rZXJuZWwvZ2l0L3N0
YWJsZS9zdGFibGUtcXVldWUuZ2l0O2E9c3VtbWFyeQ0KPiANCj4gVGhlIGZpbGVuYW1lIG9m
IHRoZSBwYXRjaCBpczoNCj4gICAgICAgZHJpdmVyLWNvcmUtcGxhdGZvcm0tZW1pdC1hLXdh
cm5pbmctaWYtYS1yZW1vdmUtY2FsbC5wYXRjaA0KPiBhbmQgaXQgY2FuIGJlIGZvdW5kIGlu
IHRoZSBxdWV1ZS01LjEwIHN1YmRpcmVjdG9yeS4NCj4gDQo+IElmIHlvdSwgb3IgYW55b25l
IGVsc2UsIGZlZWxzIGl0IHNob3VsZCBub3QgYmUgYWRkZWQgdG8gdGhlIHN0YWJsZSB0cmVl
LA0KPiBwbGVhc2UgbGV0IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiBrbm93IGFib3V0IGl0
Lg0KPiANCj4gDQo+IA0KPiBjb21taXQgMmYxYWM2MGJjOTY2ODU2N2YwMjFjMzE0MzEyNTYz
OTUxMDM5Zjc3Yg0KPiBBdXRob3I6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtv
ZW5pZy5vcmc+DQo+IERhdGU6ICAgU3VuIEZlYiA3IDIyOjE1OjM3IDIwMjEgKzAxMDANCj4g
DQo+ICAgICAgZHJpdmVyIGNvcmU6IHBsYXRmb3JtOiBFbWl0IGEgd2FybmluZyBpZiBhIHJl
bW92ZSBjYWxsYmFjayByZXR1cm5lZCBub24temVybw0KPiAgICAgIA0KPiAgICAgIFsgVXBz
dHJlYW0gY29tbWl0IGU1ZTFjMjA5Nzg4MTM4ZjMzY2E2NTU4YmY5ZjU3MmY2OTA0ZjQ4NmQg
XQ0KPiAgICAgIA0KPiAgICAgIFRoZSBkcml2ZXIgY29yZSBpZ25vcmVzIHRoZSByZXR1cm4g
dmFsdWUgb2YgYSBidXMnIHJlbW92ZSBjYWxsYmFjay4gSG93ZXZlcg0KPiAgICAgIGEgZHJp
dmVyIHJldHVybmluZyBhbiBlcnJvciBjb2RlIGlzIGEgaGludCB0aGF0IHRoZXJlIGlzIGEg
cHJvYmxlbSwNCj4gICAgICBwcm9iYWJseSBhIGRyaXZlciBhdXRob3Igd2hvIGV4cGVjdHMg
dGhhdCByZXR1cm5pbmcgZS5nLiAtRUJVU1kgaGFzIGFueQ0KPiAgICAgIGVmZmVjdC4NCj4g
ICAgICANCj4gICAgICBUaGUgcmlnaHQgdGhpbmcgdG8gZG8gd291bGQgYmUgdG8gbWFrZSBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyOjpyZW1vdmUoKQ0KPiAgICAgIHJldHVybiB2b2lkLiBX
aXRoIHRoZSBpbW1lbnNlIG51bWJlciBvZiBwbGF0Zm9ybSBkcml2ZXJzIHRoaXMgaXMgaG93
ZXZlciBhDQo+ICAgICAgYmlnIHF1ZXN0IGFuZCBJIGhvcGUgdG8gcHJldmVudCBhdCBsZWFz
dCBhIGZldyBuZXcgZHJpdmVycyB0aGF0IHJldHVybiBhbg0KPiAgICAgIGVycm9yIGNvZGUg
aGVyZS4NCj4gICAgICANCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5p
ZyA8dXdlQGtsZWluZS1rb2VuaWcub3JnPg0KPiAgICAgIExpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyMTAyMDcyMTE1MzcuMTk5OTItMS11d2VAa2xlaW5lLWtvZW5pZy5v
cmcNCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPg0KPiAgICAgIFN0YWJsZS1kZXAtb2Y6IDU1YzQyMWIzNjQ0
OCAoIm1tYzogZGF2aW5jaTogRG9uJ3Qgc3RyaXAgcmVtb3ZlIGZ1bmN0aW9uIHdoZW4gZHJp
dmVyIGlzIGJ1aWx0aW4iKQ0KPiAgICAgIFNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxz
YXNoYWxAa2VybmVsLm9yZz4NCg0KVGhhdCBsb29rcyB3cm9uZy4gSWYgdGhpcyBwYXRjaCBz
aG91bGQgYmUgaW5jbHVkZWQgaW4gc3RhYmxlLCBpdCANCnNob3VsZG4ndCBiZSBiZWNhdXNl
IGl0J3MgYSBkZXBlbmRlbmN5LiA1NWM0MjFiMzY0NDggd29ya3Mgd2l0aG91dCB0aGlzIA0K
cGF0Y2ggZm9yIHN1cmUuDQoNCkVpdGhlciBiYWNrcG9ydCBlNWUxYzIwOTc4ODEgYmVjYXVz
ZSB5b3UgdGhpbmsgdGhhdCB3YXJuaW5nIHNob3VsZCBiZSBpbiANCjUuMTAueCwgb3IgZG9u
J3QgYmFja3BvcnQgaXQuDQoNCkJlc3QgcmVnYXJkcw0KVXdlDQo=

--------------ASiS1Bz7ymRomK7IGZo5HHhN--

--------------pbB2LYZd0ys5gebmSDAORUD8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZulR0ACgkQj4D7WH0S
/k6bJggAk9aZIZk54SRh1oy6gAMH6JcoenLNGGr10Ck0Try8FLMEMx9TiqcdqOe/
HZOjwurbYKR4pxuEpepuzU5WaCehgumCvrwZ4quzL7e1RkSF3sfeiKrPtoZKc6Em
z1ebzRiCSpLXfsEeqKoSfLOY/13e7GxNfv/gwRIWkyKKDJgianNp8zc/OyPg+mul
Dco3AZmqg2X6GiGPm332jkAO1HuwwrJxtet+9Lb1cecy/nIcMDpIQZ6YLvVyw9Xm
9hqKf9NBuXj2iGYxtdolrRlqea6xM0VeGeQ8jtNCIj8o4JwudWP43S8EKjfhYtr7
f3wj/PySQn7uP1A67vkudNXy0fOTfQ==
=1b8P
-----END PGP SIGNATURE-----

--------------pbB2LYZd0ys5gebmSDAORUD8--

