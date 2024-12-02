Return-Path: <stable+bounces-95938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B899DFBC2
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2ABBB20EE5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958B1F9409;
	Mon,  2 Dec 2024 08:18:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A474430
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127518; cv=none; b=uuDCuz51TQCW9v8mbu7IGjrCSxskGPi9TNngtwvUOf7/hep01tJStbNPMk59QeJak3I9KutHsUlTUiSVLGirz1NdN1SMUhIRjRCv/KH3QK3IGDjzjhhhFla5WT02ddBMIeEtgluuFiB0V94mOC32Sj4ASgCSfuDSmnSaYHgoi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127518; c=relaxed/simple;
	bh=ReWIu+SyAkv15E2qSKduhEEPr7OW9FuqBsoOCivd9W4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DXEit7ah7TkVl6fgWCjpJfHzeZcoOylzux4qx8EihR2PMhoLZuvgDPhw8Xk3DaDbKRJyIkxfcgtiAuuX8LrThuNhWgIKitNrZwUheHhU4Y7XclH4YpoecS5jeoCligVcjH6RCngDQYg9gmEz4gCefP1s9oUKOQX2C+x/MKVojyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-26-XoLKLSZoNi6PIY7yenUkHg-1; Mon, 02 Dec 2024 08:18:28 +0000
X-MC-Unique: XoLKLSZoNi6PIY7yenUkHg-1
X-Mimecast-MFC-AGG-ID: XoLKLSZoNi6PIY7yenUkHg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 2 Dec
 2024 08:17:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 2 Dec 2024 08:17:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>, Oliver Neukum
	<oneukum@suse.com>
CC: "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Greg Thelen
	<gthelen@google.com>, John Sperbeck <jsperbeck@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH net] net: usb: usbnet: fix name regression
Thread-Topic: [PATCH net] net: usb: usbnet: fix name regression
Thread-Index: AQHbRG456Phg3HaMXk68vY32fDXRdrLSmKCA
Date: Mon, 2 Dec 2024 08:17:59 +0000
Message-ID: <e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
In-Reply-To: <Z00udyMgW6XnAw6h@atmark-techno.com>
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
X-Mimecast-MFC-PROC-ID: 3vn9QO8hW4fM2fShPW1NFigTvqTn_4EfFLfLU27m43U_1733127507
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogRG9taW5pcXVlIE1BUlRJTkVUDQo+IFNlbnQ6IDAyIERlY2VtYmVyIDIwMjQgMDM6NTAN
Cj4gDQo+IEhpLA0KPiANCj4gT2xpdmVyIE5ldWt1bSB3cm90ZSBvbiBUaHUsIE9jdCAxNywgMjAy
NCBhdCAwOToxODozN0FNICswMjAwOg0KPiA+IFRoZSBmaXggZm9yIE1BQyBhZGRyZXNzZXMgYnJv
a2UgZGV0ZWN0aW9uIG9mIHRoZSBuYW1pbmcgY29udmVudGlvbg0KPiA+IGJlY2F1c2UgaXQgZ2F2
ZSBuZXR3b3JrIGRldmljZXMgbm8gcmFuZG9tIE1BQyBiZWZvcmUgYmluZCgpDQo+ID4gd2FzIGNh
bGxlZC4gVGhpcyBtZWFucyB0aGF0IHRoZSBjaGVjayBmb3IgdGhlIGxvY2FsIGFzc2lnbm1lbnQg
Yml0DQo+ID4gd2FzIGFsd2F5cyBuZWdhdGl2ZSBhcyB0aGUgYWRkcmVzcyB3YXMgemVyb2VkIGZy
b20gYWxsb2NhdGlvbiwNCj4gPiBpbnN0ZWFkIG9mIGZyb20gb3ZlcndyaXRpbmcgdGhlIE1BQyB3
aXRoIGEgdW5pcXVlIGhhcmR3YXJlIGFkZHJlc3MuDQo+IA0KPiBTbyB3ZSBoaXQgdGhlIGV4YWN0
IGludmVyc2UgcHJvYmxlbSB3aXRoIHRoaXMgcGF0Y2g6IG91ciBkZXZpY2Ugc2hpcHMgYW4NCj4g
TFRFIG1vZGVtIHdoaWNoIGV4cG9zZXMgYSBjZGMtZXRoZXJuZXQgaW50ZXJmYWNlIHRoYXQgaGFk
IGFsd2F5cyBiZWVuDQo+IG5hbWVkIHVzYjAsIGFuZCB3aXRoIHRoaXMgcGF0Y2ggaXQgc3RhcnRl
ZCBiZWluZyBuYW1lZCBldGgxLCBicmVha2luZw0KPiB0b28gbWFueSBoYXJkY29kZWQgdGhpbmdz
IGV4cGVjdGluZyB0aGUgbmFtZSB0byBiZSB1c2IwIGFuZCBtYWtpbmcgb3VyDQo+IGRldmljZXMg
dW5hYmxlIHRvIGNvbm5lY3QgdG8gdGhlIGludGVybmV0IGFmdGVyIHVwZGF0aW5nIHRoZSBrZXJu
ZWwuDQoNCkVybSBkb2VzIHRoYXQgbWVhbiB5b3VyIG1vZGVtIGhhcyBhIGxvY2FsbHkgYWRtaW5p
c3RlcmVkIE1BQyBhZGRyZXNzPw0KSXQgcmVhbGx5IHNob3VsZG4ndC4NCg0KPiBMb25nIHRlcm0g
d2UnbGwgcHJvYmFibHkgYWRkIGFuIHVkZXYgcnVsZSBvciBzb21ldGhpbmcgdG8gbWFrZSB0aGUg
bmFtZQ0KPiBleHBsaWNpdCBpbiB1c2Vyc3BhY2UgYW5kIG5vdCByaXNrIHRoaXMgaGFwcGVuaW5n
IGFnYWluLCBidXQgcGVyaGFwcw0KPiB0aGVyZSdzIGEgYmV0dGVyIHdheSB0byBrZWVwIHRoZSBv
bGQgYmVoYXZpb3I/DQo+IA0KPiAoSW4gcGFydGljdWxhciB0aGlzIGhpdCBhbGwgc3RhYmxlIGtl
cm5lbHMgbGFzdCBtb250aCBzbyBJJ20gc3VyZSB3ZQ0KPiB3b24ndCBiZSB0aGUgb25seSBvbmVz
IGdldHRpbmcgYW5ub3llZCB3aXRoIHRoaXMuLi4gUGVyaGFwcyByZXZlcnRpbmcNCj4gYm90aCBw
YXRjaGVzIGZvciBzdGFibGUgYnJhbmNoZXMgbWlnaHQgbWFrZSBzZW5zZSBpZiBubyBiZXR0ZXIg
d2F5DQo+IGZvcndhcmQgaXMgZm91bmQgLS0gSSd2ZSBhZGRlZCBzdGFibGVAIGluIGNjIGZvciBo
ZWFkcyB1cC9vcGluaW9ucykNCj4gDQo+IA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3VzYi91c2Ju
ZXQuYw0KPiA+IEBAIC0xNzY3LDcgKzE3NjcsOCBAQCB1c2JuZXRfcHJvYmUgKHN0cnVjdCB1c2Jf
aW50ZXJmYWNlICp1ZGV2LCBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCAqcHJvZCkNCj4gPiAg
CQkvLyBjYW4gcmVuYW1lIHRoZSBsaW5rIGlmIGl0IGtub3dzIGJldHRlci4NCj4gPiAgCQlpZiAo
KGRldi0+ZHJpdmVyX2luZm8tPmZsYWdzICYgRkxBR19FVEhFUikgIT0gMCAmJg0KPiA+ICAJCSAg
ICAoKGRldi0+ZHJpdmVyX2luZm8tPmZsYWdzICYgRkxBR19QT0lOVFRPUE9JTlQpID09IDAgfHwN
Cj4gPiAtCQkgICAgIChuZXQtPmRldl9hZGRyIFswXSAmIDB4MDIpID09IDApKQ0KPiA+ICsJCSAg
ICAgLyogc29tZWJvZHkgdG91Y2hlZCBpdCovDQo+ID4gKwkJICAgICAhaXNfemVyb19ldGhlcl9h
ZGRyKG5ldC0+ZGV2X2FkZHIpKSkNCj4gDQo+IC4uLiBvciBhY3R1YWxseSBub3cgSSdtIGxvb2tp
bmcgYXQgaXQgYWdhaW4sIHBlcmhhcHMgaXMgdGhlIGNoZWNrIGp1c3QNCj4gYmFja3dhcmRzLCBv
ciBhbSBJIGdldHRpbmcgdGhpcyB3cm9uZz8NCj4gcHJldmlvdXMgY2hlY2sgd2FzIHJlbmFtZSBp
ZiAobWFjWzBdICYgMHgyID09IDApLCB3aGljaCByZWFkcyB0byBtZSBhcw0KPiAibm9ib2R5IHNl
dCB0aGUgMm5kIGJpdCINCj4gbmV3IGNoZWNrIG5vdyByZW5hbWVzIGlmICFpc196ZXJvLCBzbyBy
ZW5hbWVzIGlmIGl0IHdhcyBzZXQsIHdoaWNoIGlzDQo+IHRoZSBvcHBvc2l0ZT8uLi4NCg0KVGhl
IDJuZCBiaXQgKGFrYSBtYWNbMF0gJiAyKSBpcyB0aGUgJ2xvY2FsbHkgYWRtaW5pc3RlcmVkJyBi
aXQuDQpUaGUgaW50ZW50aW9uIG9mIHRoZSBzdGFuZGFyZCB3YXMgdGhhdCBhbGwgbWFudWZhY3R1
cmVycyB3b3VsZCBnZXQNCmEgdmFsaWQgMTQtYml0IE9VSSBhbmQgdGhlIEVFUFJPTSAob3IgZXF1
aXZhbGVudCkgd291bGQgY29udGFpbiBhbg0KYWRkcmVzc2VzIHdpdGggdGhhdCBiaXQgY2xlYXIs
IHN1Y2ggYWRkcmVzc2VzIHNob3VsZCBiZSBnbG9iYWxseSB1bmlxdWUuDQpBbHRlcm5hdGl2ZWx5
IHRoZSBsb2NhbCBuZXR3b3JrIGFkbWluaXN0cmF0b3IgY291bGQgYXNzaWduIGFuIGFkZHJlc3MN
CndpdGggdGhhdCBiaXQgc2V0LCByZXF1aXJlZCBieSBwcm90b2NvbHMgbGlrZSBERUNuZXQuDQoN
ClRoaXMgaGFzIG5ldmVyIGFjdHVhbGx5IGJlZW4gc3RyaWN0bHkgdHJ1ZSwgYSBmZXcgbWFudWZh
Y3R1cmVycyB1c2VkDQonbG9jYWxseSBhZG1pbmlzdGVyZWQgYWRkcmVzc2VzJyAoMDI6Y2Y6MWY6
eHg6eHg6eHggY29tZXMgdG8gbWluZCkNCmFuZCBzeXN0ZW1zIHR5cGljYWxseSBhbGxvdyBhbnkg
KG5vbi1icm9hZGNhc3QpIGJlIHNldC4NCg0KU28gYmFzaW5nIGFueSBkZWNpc2lvbiBvbiB3aGV0
aGVyIGEgTUFDIGFkZHJlc3MgaXMgbG9jYWwgb3IgZ2xvYmFsDQppcyBhbHdheXMgZ29pbmcgdG8g
YmUgY29uZnVzaW5nLg0KDQpMaW51eCB3aWxsIGFsbG9jYXRlIGEgcmFuZG9tIChsb2NhbGx5IGFk
bWluaXN0ZXJlZCkgYWRkcmVzcyBpZiBub25lDQppcyBmb3VuZCAtIHVzdWFsbHkgZHVlIHRvIGEg
Y29ycnVwdCBlZXByb20uDQoNCglEYXZpZA0KDQo+IA0KPiA+ICAJCQlzdHJzY3B5KG5ldC0+bmFt
ZSwgImV0aCVkIiwgc2l6ZW9mKG5ldC0+bmFtZSkpOw0KPiA+ICAJCS8qIFdMQU4gZGV2aWNlcyBz
aG91bGQgYWx3YXlzIGJlIG5hbWVkICJ3bGFuJWQiICovDQo+IA0KPiBUaGFua3MsDQo+IC0tDQo+
IERvbWluaXF1ZSBNYXJ0aW5ldA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


