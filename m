Return-Path: <stable+bounces-179234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1EB5288A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877F8565595
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57925485A;
	Thu, 11 Sep 2025 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="RiAFrEvj"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF26178372;
	Thu, 11 Sep 2025 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571226; cv=none; b=TBUaHmuBek801RfcgHKWueliayOdlge64buNGQ+uoo91Gk/yjuBoTVvp+j/5DogzzNr61T6yPP3D2j19rrvPfN67iIBxAs0btmOBu4fJUNeLOSel33pJZcTH1zcB1sLwbaekhqkrX7GvdyWdc/BGnS2Z0RfASpvXq/BnmPgFwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571226; c=relaxed/simple;
	bh=Rd/zyPwRxZk0R7aXyuI7LZNuG4ltnWdMo8eFSAGvums=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjmZDKCM23rOBKLUxEsym61uEyAILxonYy9Sxmu+Ekd7DYg03EwgKiipgKay0Zkijo8kpTLgeoGy5vI2i6orOTthR/I7Jf58tp88qjngHk6DauYC1rn4jJ4jtOK7NNyG5W1jYjvRaeSFRio3VXTcuJTwlywd9Fiv69q5F5oEum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=RiAFrEvj; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757571225; x=1789107225;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Rd/zyPwRxZk0R7aXyuI7LZNuG4ltnWdMo8eFSAGvums=;
  b=RiAFrEvjCgTNcupUSuufPFM3Yx/DKCTZ9VtyG34dcaCJu31D1VMzs0IX
   V5/nOTyy3n0gu6zoqyIIcRzGYO09kcVM7ijNBuyrYnDKnUa6Gw1zIoekj
   EbvfuKbHWtPgMU9rPM6qR2eibNluHKpRXZaQIzOb3eMzvrXOOLbc4I2Dc
   yPN9iaO2QDwDLWiqt0PdRdgbD/Kmu4l0XFu1wBfzQO0NU2Dy/YNj+ParF
   4MWkzY0xoOk/+6dvFtaCuxnf7HMNM0GhFxi1WamUz3O98h8jXMveax9CJ
   SXoVs5owv6Qeb5QjB5Zo/pD5OnSVyS/XBprZikJA3LFNKW++v6sPncq0S
   Q==;
X-CSE-ConnectionGUID: LFQOPYTPQFKMfvgYTj0Q/A==
X-CSE-MsgGUID: vTdcenLPSNiInKJXfGztSw==
X-IronPort-AV: E=Sophos;i="6.18,256,1751241600"; 
   d="scan'208";a="1838185"
Subject: RE: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow checks
Thread-Topic: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow checks
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 06:13:34 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:1748]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.14.93:2525] with esmtp (Farcaster)
 id 1011adb8-4646-4d00-906a-0b591a6b3797; Thu, 11 Sep 2025 06:13:34 +0000 (UTC)
X-Farcaster-Flow-ID: 1011adb8-4646-4d00-906a-0b591a6b3797
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 06:13:34 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 06:13:33 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Thu, 11 Sep 2025 06:13:33 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
	"post@mikaelkw.online" <post@mikaelkw.online>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chocron,
 Jonathan" <jonnyc@amazon.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Farber, Eliav" <farbere@amazon.com>
Thread-Index: AQHcInjMD5K1PZTplE6DLl3oGc4tIbSNe74AgAAD8ZA=
Date: Thu, 11 Sep 2025 06:13:33 +0000
Message-ID: <f524c24888924a999c3bb90de0099b78@amazon.com>
References: <20250910173138.8307-1-farbere@amazon.com>
 <2025091131-tractor-almost-6987@gregkh>
In-Reply-To: <2025091131-tractor-almost-6987@gregkh>
Accept-Language: en-US
Content-Language: en-US
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

PiBPbiBXZWQsIFNlcCAxMCwgMjAyNSBhdCAwNTozMTozOFBNICswMDAwLCBFbGlhdiBGYXJiZXIg
d3JvdGU6DQo+PiBGaXggYSBjb21waWxhdGlvbiBmYWlsdXJlIHdoZW4gd2FybmluZ3MgYXJlIHRy
ZWF0ZWQgYXMgZXJyb3JzOg0KPj4NCj4+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAw
ZS9ldGh0b29sLmM6IEluIGZ1bmN0aW9uIOKAmGUxMDAwX3NldF9lZXByb23igJk6DQo+PiAuL2lu
Y2x1ZGUvbGludXgvb3ZlcmZsb3cuaDo3MToxNTogZXJyb3I6IGNvbXBhcmlzb24gb2YgZGlzdGlu
Y3QgcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QgWy1XZXJyb3JdDQo+PiAgICA3MSB8ICAodm9p
ZCkgKCZfX2EgPT0gX19kKTsgICBcDQo+PiAgICAgICB8ICAgICAgICAgICAgICAgXn4NCj4+IGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9ldGh0b29sLmM6NTgyOjY6IG5vdGU6IGlu
IGV4cGFuc2lvbiBvZiBtYWNybyDigJhjaGVja19hZGRfb3ZlcmZsb3figJkNCj4+ICAgNTgyIHwg
IGlmIChjaGVja19hZGRfb3ZlcmZsb3coZWVwcm9tLT5vZmZzZXQsIGVlcHJvbS0+bGVuLCAmdG90
YWxfbGVuKSB8fA0KPj4gICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPj4NCj4+IFRv
IGZpeCB0aGlzLCBjaGFuZ2UgdG90YWxfbGVuIGFuZCBtYXhfbGVuIGZyb20gc2l6ZV90IHRvIHUz
MiBpbiANCj4+IGUxMDAwX3NldF9lZXByb20oKS4NCj4+IFRoZSBjaGVja19hZGRfb3ZlcmZsb3co
KSBoZWxwZXIgcmVxdWlyZXMgdGhhdCB0aGUgZmlyc3QgdHdvIG9wZXJhbmRzIA0KPj4gYW5kIHRo
ZSBwb2ludGVyIHRvIHRoZSByZXN1bHQgKHRoaXJkIG9wZXJhbmQpIGFsbCBoYXZlIHRoZSBzYW1l
IHR5cGUuDQo+PiBPbiA2NC1iaXQgYnVpbGRzLCB1c2luZyBzaXplX3QgY2F1c2VkIGEgbWlzbWF0
Y2ggd2l0aCB0aGUgdTMyIGZpZWxkcw0KPj4gZWVwcm9tLT5vZmZzZXQgYW5kIGVlcHJvbS0+bGVu
LCBsZWFkaW5nIHRvIHR5cGUgY2hlY2sgZmFpbHVyZXMuDQo+Pg0KPj4gRml4ZXM6IGNlODgyOWQz
ZDQ0YiAoImUxMDAwZTogZml4IGhlYXAgb3ZlcmZsb3cgaW4gZTEwMDBfc2V0X2VlcHJvbSIpDQo+
PiBTaWduZWQtb2ZmLWJ5OiBFbGlhdiBGYXJiZXIgPGZhcmJlcmVAYW1hem9uLmNvbT4NCj4+IC0t
LQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9ldGh0b29sLmMgfCAyICst
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9ldGh0b29s
LmMgDQo+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9ldGh0b29sLmMNCj4+
IGluZGV4IDRhY2E4NTQ3ODNlMi4uNTg0Mzc4MjkxZjNmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2V0aHRvb2wuYw0KPj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2V0aHRvb2wuYw0KPj4gQEAgLTU1OSw3ICs1NTksNyBA
QCBzdGF0aWMgaW50IGUxMDAwX3NldF9lZXByb20oc3RydWN0IG5ldF9kZXZpY2UgDQo+PiAqbmV0
ZGV2LCAgew0KPj4gICAgICAgc3RydWN0IGUxMDAwX2FkYXB0ZXIgKmFkYXB0ZXIgPSBuZXRkZXZf
cHJpdihuZXRkZXYpOw0KPj4gICAgICAgc3RydWN0IGUxMDAwX2h3ICpodyA9ICZhZGFwdGVyLT5o
dzsNCj4+IC0gICAgIHNpemVfdCB0b3RhbF9sZW4sIG1heF9sZW47DQo+PiArICAgICB1MzIgdG90
YWxfbGVuLCBtYXhfbGVuOw0KPj4gICAgICAgdTE2ICplZXByb21fYnVmZjsNCj4+ICAgICAgIGlu
dCByZXRfdmFsID0gMDsNCj4+ICAgICAgIGludCBmaXJzdF93b3JkOw0KPj4gLS0NCj4+IDIuNDcu
Mw0KPj4NCj4NCj4gV2h5IGlzIHRoaXMgbm90IG5lZWRlZCBpbiBMaW51cydzIHRyZWU/DQpLZXJu
ZWwgNS4xMC4yNDMgZW5mb3JjZXMgdGhlIHNhbWUgdHlwZSwgYnV0IHRoaXMgZW5mb3JjZW1lbnQg
aXMNCmFic2VudCBmcm9tIDUuMTUuMTkyIGFuZCBsYXRlcjoNCi8qDQogKiBGb3Igc2ltcGxpY2l0
eSBhbmQgY29kZSBoeWdpZW5lLCB0aGUgZmFsbGJhY2sgY29kZSBiZWxvdyBpbnNpc3RzIG9uDQog
KiBhLCBiIGFuZCAqZCBoYXZpbmcgdGhlIHNhbWUgdHlwZSAoc2ltaWxhciB0byB0aGUgbWluKCkg
YW5kIG1heCgpDQogKiBtYWNyb3MpLCB3aGVyZWFzIGdjYydzIHR5cGUtZ2VuZXJpYyBvdmVyZmxv
dyBjaGVja2VycyBhY2NlcHQNCiAqIGRpZmZlcmVudCB0eXBlcy4gSGVuY2Ugd2UgZG9uJ3QganVz
dCBtYWtlIGNoZWNrX2FkZF9vdmVyZmxvdyBhbg0KICogYWxpYXMgZm9yIF9fYnVpbHRpbl9hZGRf
b3ZlcmZsb3csIGJ1dCBhZGQgdHlwZSBjaGVja3Mgc2ltaWxhciB0bw0KICogYmVsb3cuDQogKi8N
CiNkZWZpbmUgY2hlY2tfYWRkX292ZXJmbG93KGEsIGIsIGQpIF9fbXVzdF9jaGVja19vdmVyZmxv
dygoewlcDQogDQo+IEFsc28sIHdoeSBpcyBpdCBub3QgY2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc/DQpBZGRlZCB0byBjYy4NCg0KLS0tDQpSZWdhcmRzLCBFbGlhdg0K

