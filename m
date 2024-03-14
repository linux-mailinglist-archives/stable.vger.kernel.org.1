Return-Path: <stable+bounces-28125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631CA87B950
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958EE1C2179B
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74967C41;
	Thu, 14 Mar 2024 08:31:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8E679F3;
	Thu, 14 Mar 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405117; cv=none; b=AQg5VMq8rTX5KMmgsWa0aKtXgiP3VWYrj7lXwcst7YAUOGiwLoHw9cdL2TUs/U1q1+R91jLkqYsqhJY9ol/cC8sMo+v+7oCmAMe2oXztU5rKnK5vNjSGJG3WV0dFUAvtxqbVAggO+XAI5l1euXgNj2/zgxBr8+6YighzeY/v4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405117; c=relaxed/simple;
	bh=zb1QEqmI6ZbtSaKHQpUGGWKDKghREVVAkBnJmi/i9sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ct3ifd+loLqY+WPf2BHHZZlBtbd0WCWHWd8QtDNdgVxNbpexiTJQM4fmLjAvRv7DBw42/m6afgOvdUD/icAdnfhvCnh1BwPIcEhVlZHN/355ZKTZKT/47Xr4pdviLh1GItskSNHZQMtg+0cIKW0E6LGFHXRQLALpDAQpmlm9l/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com; spf=pass smtp.mailfrom=hihonor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hihonor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4TwKs12YKczblSvt;
	Thu, 14 Mar 2024 16:13:41 +0800 (CST)
Received: from a001.hihonor.com (10.68.28.182) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 14 Mar
 2024 16:14:19 +0800
Received: from w025.hihonor.com (10.68.28.69) by a001.hihonor.com
 (10.68.28.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 14 Mar
 2024 16:14:19 +0800
Received: from w025.hihonor.com ([fe80::5770:e914:c15d:4346]) by
 w025.hihonor.com ([fe80::5770:e914:c15d:4346%14]) with mapi id
 15.02.1258.025; Thu, 14 Mar 2024 16:14:19 +0800
From: yuanlinyu <yuanlinyu@hihonor.com>
To: Oliver Neukum <oneukum@suse.com>, Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1] usb: f_mass_storage: reduce chance to queue disable ep
Thread-Topic: [PATCH v1] usb: f_mass_storage: reduce chance to queue disable
 ep
Thread-Index: AQHadd1DBEawBTTN7U63+22niyjmfrE2V6OAgACK6iA=
Date: Thu, 14 Mar 2024 08:14:19 +0000
Message-ID: <ee024edfcb4447fb884878b15fe202f0@hihonor.com>
References: <20240314065949.2627778-1-yuanlinyu@hihonor.com>
 <2233fe16-ca3e-4a5e-bc69-a2447ddd2e82@suse.com>
In-Reply-To: <2233fe16-ca3e-4a5e-bc69-a2447ddd2e82@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWFyY2ggMTQsIDIwMjQgMzo1NCBQTQ0KPiBUbzogeXVhbmxpbnl1IDx5dWFubGlueXVAaGlo
b25vci5jb20+OyBBbGFuIFN0ZXJuDQo+IDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PjsgR3Jl
ZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IGxp
bnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MV0gdXNiOiBmX21hc3Nfc3RvcmFnZTogcmVkdWNlIGNoYW5jZSB0byBx
dWV1ZSBkaXNhYmxlIGVwDQo+IA0KPiBIaSwNCj4gDQo+IEkgYW0gc29ycnksIGJ1dCB0aGlzIGNv
bnRhaW5zIGEgbWFqb3IgaXNzdWUuDQo+IA0KPiBPbiAxNC4wMy4yNCAwNzo1OSwgeXVhbiBsaW55
dSB3cm90ZToNCj4gPiBJdCBpcyBwb3NzaWJsZSB0cmlnZ2VyIGJlbG93IHdhcm5pbmcgbWVzc2Fn
ZSBmcm9tIG1hc3Mgc3RvcmFnZSBmdW5jdGlvbiwNCj4gPg0KPiA+IC0tLS0tLS0tLS0tLVsgY3V0
IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+IFdBUk5JTkc6IENQVTogNiBQSUQ6IDM4MzkgYXQgZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmM6Mjk0DQo+IHVzYl9lcF9xdWV1ZSsweDdjLzB4MTA0
DQo+ID4gQ1BVOiA2IFBJRDogMzgzOSBDb21tOiBmaWxlLXN0b3JhZ2UgVGFpbnRlZDogRyBTICAg
ICAgV0MgTw0KPiA2LjEuMjUtYW5kcm9pZDE0LTExLWczNTRlMmE3ZTdjZDkgIzENCj4gPiBwc3Rh
dGU6IDIyNDAwMDA1IChuekN2IGRhaWYgK1BBTiAtVUFPICtUQ08gLURJVCAtU1NCUyBCVFlQRT0t
LSkNCj4gPiBwYyA6IHVzYl9lcF9xdWV1ZSsweDdjLzB4MTA0DQo+ID4gbHIgOiBmc2dfbWFpbl90
aHJlYWQrMHg0OTQvMHgxYjNjDQo+ID4NCj4gPiBSb290IGNhdXNlIGlzIG1hc3Mgc3RvcmFnZSBm
dW5jdGlvbiB0cnkgdG8gcXVldWUgcmVxdWVzdCBmcm9tIG1haW4gdGhyZWFkLA0KPiA+IGJ1dCBv
dGhlciB0aHJlYWQgbWF5IGFscmVhZHkgZGlzYWJsZSBlcCB3aGVuIGZ1bmN0aW9uIGRpc2FibGUu
DQo+ID4NCj4gPiBBcyBtYXNzIHN0b3JhZ2UgZnVuY3Rpb24gaGF2ZSByZWNvcmQgb2YgZXAgZW5h
YmxlL2Rpc2FibGUgc3RhdGUsIGxldCdzDQo+ID4gYWRkIHRoZSBzdGF0ZSBjaGVjayBiZWZvcmUg
cXVldWUgcmVxdWVzdCB0byBVREMsIGl0IG1heWJlIGF2b2lkIHdhcm5pbmcuDQo+ID4NCj4gPiBB
bHNvIHVzZSBjb21tb24gbG9jayB0byBwcm90ZWN0IGVwIHN0YXRlIHdoaWNoIGF2b2lkIHJhY2Ug
YmV0d2VlbiBtYWluDQo+ID4gdGhyZWFkIGFuZCBmdW5jdGlvbiBkaXNhYmxlLg0KPiA+DQo+ID4g
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDYuMQ0KPiA+IFNpZ25lZC1vZmYtYnk6IHl1
YW4gbGlueXUgPHl1YW5saW55dUBoaWhvbm9yLmNvbT4NCj4gTmFja2VkLWJ5OiBPbGl2ZXIgTmV1
a3VtIDxvbmV1a3VtQHN1c2UuY29tPg0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX21hc3Nfc3RvcmFnZS5jIHwgMTggKysrKysrKysrKysrKysrKystDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX21hc3Nfc3Rv
cmFnZS5jDQo+IGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfbWFzc19zdG9yYWdlLmMN
Cj4gPiBpbmRleCBjMjY1YTFmNjJmYzEuLjA1NjA4M2NiNjhjYiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9tYXNzX3N0b3JhZ2UuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX21hc3Nfc3RvcmFnZS5jDQo+ID4gQEAgLTUyMCwx
MiArNTIwLDI1IEBAIHN0YXRpYyBpbnQgZnNnX3NldHVwKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYs
DQo+ID4gICBzdGF0aWMgaW50IHN0YXJ0X3RyYW5zZmVyKHN0cnVjdCBmc2dfZGV2ICpmc2csIHN0
cnVjdCB1c2JfZXAgKmVwLA0KPiA+ICAgCQkJICAgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQo+
ID4gICB7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAgCWludAlyYzsNCj4gPg0K
PiA+IC0JaWYgKGVwID09IGZzZy0+YnVsa19pbikNCj4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZm
c2ctPmNvbW1vbi0+bG9jaywgZmxhZ3MpOw0KPiANCj4gVGFraW5nIGEgc3BpbmxvY2suDQo+IA0K
PiA+ICsJaWYgKGVwID09IGZzZy0+YnVsa19pbikgew0KPiA+ICsJCWlmICghZnNnLT5idWxrX2lu
X2VuYWJsZWQpIHsNCj4gPiArCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZnNnLT5jb21tb24t
PmxvY2ssIGZsYWdzKTsNCj4gPiArCQkJcmV0dXJuIC1FU0hVVERPV047DQo+ID4gKwkJfQ0KPiA+
ICAgCQlkdW1wX21zZyhmc2csICJidWxrLWluIiwgcmVxLT5idWYsIHJlcS0+bGVuZ3RoKTsNCj4g
PiArCX0gZWxzZSB7DQo+ID4gKwkJaWYgKCFmc2ctPmJ1bGtfb3V0X2VuYWJsZWQpIHsNCj4gPiAr
CQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZnNnLT5jb21tb24tPmxvY2ssIGZsYWdzKTsNCj4g
PiArCQkJcmV0dXJuIC1FU0hVVERPV047DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+DQo+ID4gICAJ
cmMgPSB1c2JfZXBfcXVldWUoZXAsIHJlcSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBUaGlzIGNhbiBz
bGVlcC4NCj4gDQo+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZmc2ctPmNvbW1vbi0+bG9j
aywgZmxhZ3MpOw0KPiANCj4gR2l2aW5nIHVwIHRoZSBsb2NrLg0KPiANCj4gDQo+IFNvcnJ5LCBu
b3cgZm9yIHRoZSBsb25nZXIgZXhwbGFuYXRpb24uIFlvdSdkIGludHJvZHVjZSBhIGRlYWRsb2Nr
Lg0KPiBZb3UganVzdCBjYW5ub3Qgc2xlZXAgd2l0aCBhIHNwaW5sb2NrIGhlbGQuIEl0IHNlZW1z
IHRvIG1lIHRoYXQNCg0KSSBkaWRuJ3QgcmV2aWV3IHVzYl9lcF9xdWV1ZSgpIGNsZWFybHksIGlu
IG15IHRlc3QsIEkgZGlkbid0IGhpdCBzbGVlcC4NCkJ1dCB0aGUgY29uY2VybiBpcyBnb29kLCB3
aWxsIGZpbmQgYmV0dGVyIHdheSB0byBhdm9pZCBpdC4NCg0KPiBpZiB5b3Ugd2FudCB0byBkbyB0
aGlzIGNsZWFubHksIHlvdSBuZWVkIHRvIHJldmlzaXQgdGhlIGxvY2tpbmcNCj4gdG8gdXNlIGxv
Y2tzIHlvdSBjYW4gc2xlZXAgdW5kZXIuDQo+IA0KPiAJSFRIDQo+IAkJT2xpdmVyDQo=

