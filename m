Return-Path: <stable+bounces-87710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7C9AA0DA
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DF61C20C35
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F719C556;
	Tue, 22 Oct 2024 11:09:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178C19AD93
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595343; cv=none; b=n2xWbyG4Ccd/TuAZDrgw8uPZ/lDSHsj/EXa0fM27pDbRH28Ui1ke6OY0ANL0AVdJXXKVE1epiuogAvcsKMAZZQkr3VFYwHHhh23JIT6sM18ibUG/3+KgsuqK7ezyTnobFJCwEOu1B0mBcX9iULLTZ/ZTokDNNay/9Je2JQ/MskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595343; c=relaxed/simple;
	bh=j/P5XcejjQdLAmnOA9ZylcRGFZcZRVaRls4QqwxeTnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cCuQzgWiIHyhPkt+Q0yoYUQYjptyu1uKl5qMhhK24+KawoZi9H4LYNy9pz7AynKdmwIS3GsiIwF9zQS5JDqh0CVtNMogp3vI3apQXnuCehKEhnpbIsY1N8iD147ysCHV4/wUi/8dLlyzmWu0xP5Qriy5Rpzfl/eDS0OOWUh0hNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-9-IRasUf_yOseRZNZNNpdKww-1; Tue, 22 Oct 2024 12:07:47 +0100
X-MC-Unique: IRasUf_yOseRZNZNNpdKww-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 22 Oct
 2024 12:07:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 22 Oct 2024 12:07:46 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bartosz Golaszewski' <brgl@bgdev.pl>, Jiri Slaby <jirislaby@kernel.org>
CC: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Greg KH
	<gregkh@linuxfoundation.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] lib: string_helpers: fix potential snprintf() output
 truncation
Thread-Topic: [PATCH] lib: string_helpers: fix potential snprintf() output
 truncation
Thread-Index: AQHbJFRQeh3oqbVfUku0a/hfxUzxIbKSma/Q
Date: Tue, 22 Oct 2024 11:07:46 +0000
Message-ID: <bb500daac1dc4cd9abd3f5e39f9329be@AcuMS.aculab.com>
References: <20241021100421.41734-1-brgl@bgdev.pl>
 <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
 <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
In-Reply-To: <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogQmFydG9zeiBHb2xhc3pld3NraQ0KPiBTZW50OiAyMiBPY3RvYmVyIDIwMjQgMDg6MzAN
Cj4gDQo+IE9uIFR1ZSwgT2N0IDIyLCAyMDI0IGF0IDk6MTXigK9BTSBKaXJpIFNsYWJ5IDxqaXJp
c2xhYnlAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiAyMS4gMTAuIDI0LCAxMjowNCwg
QmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gPiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdz
a2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz4NCj4gPiA+DQo+ID4gPiBUaGUgb3V0
cHV0IG9mICIuJTAzdSIgd2l0aCB0aGUgdW5zaWduZWQgaW50IGluIHJhbmdlIFswLCA0Mjk0OTY2
Mjk1XSBtYXkNCj4gPiA+IGdldCB0cnVuY2F0ZWQgaWYgdGhlIHRhcmdldCBidWZmZXIgaXMgbm90
IDEyIGJ5dGVzLg0KPiA+DQo+ID4gUGVyaGFwcywgaWYgeW91IGVsYWJvcmF0ZSBvbiBob3cgJ3Jl
bWFpbmRlcicgY2FuIGJlY29tZSA+IDk5OT8NCj4gPg0KPiANCj4gWWVhaCwgSSBndWVzcyBpdCBj
YW4ndC4gTm90IHN1cmUgd2hhdCB3ZSBkbyBhYm91dCBzdWNoIGZhbHNlDQo+IHBvc2l0aXZlcywg
ZG8gd2UgaGF2ZSBzb21lIGNvbW1vbiB3YXkgdG8gc3VwcHJlc3MgdGhlbT8NCg0KVGhlIG9ubHkg
d2F5IEkndmUgZm91bmQgaXMgdG8gJ2xhdW5kZXInIHRoZSBidWZmZXIgc2l6ZSB1c2luZw0KT1BU
SU1JU0VSX0hJREVfVkFSKCkuDQpBbHRob3VnaCBJIGNhbiBpbWFnaW5lIGFuIHVwZGF0ZSB0byBn
Y2MgdGhhdCBjaGVja3Mgc2l6ZW9mIChidWZmZXIpDQphcyB3ZWxsIC0gc28gdGhhdCB3b3VsZCBh
bHNvIG5lZWQgbGF1bmRlcmluZy4NCg0KWW91IGFjdHVhbGx5IHdhbnQ6DQojZGVmaW5lIE9QVElN
RVJfSElERV9WQUwoeCkgXA0KICAoeyBfX2F1dG9fdHlwZSBfeCA9IHg7IE9QVElNRVJfSElERV9W
QVIoX3gpOyBfeDt9KQ0Kc28geW91IGNhbiBkbzoNCglzbnByaW50ZihPUFRJTUlTRVJfSElERV9W
QUwoYnVmZmVyKSwgT1BUT01JU0VSX0hJREVfVkFMKHNpemVvZiBidWZmZXIpLCBmbXQsIC4uLikN
Cg0KUGVyaGFwcyB0aGF0IGNvdWxkIGJlIHNucHJpbnRfdHJ1bmNhdGUoKSA/DQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=


