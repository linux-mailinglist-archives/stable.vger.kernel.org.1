Return-Path: <stable+bounces-179364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F5B54EC6
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270D45860B1
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AD3064A3;
	Fri, 12 Sep 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oQ/qSowh"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F0305077;
	Fri, 12 Sep 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682462; cv=none; b=A5Qzo2KBCxPrMtsg2d87hqXgMJ0JNH6X/hiokCsS5BkzUSQSYu64Rl3VgwWXnwJLi5QbRAkIpbk0H/aGasaF8ASOky3XI9uBWGt8hUtbV7mFAG+sUWVZL2XvxJKWlOjrbqhdx4I5JJkJOItriwwNSTiewMt9VeELXX8NTvWSxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682462; c=relaxed/simple;
	bh=AhN3kcAG8s569E8YZrQ3IpCqcZPTOWGxuTdywrZKkkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fa+vFSp/UwjDqTOb744evCvBkam4zvKWZjv5RN9c3pEf8m7ymtUV+WisjG2QU1xzJA3Hz+zpu9Cu7x2HU/JN5zLlhZl1AxXmjPrpzibxzzIz1Ey2uWGEruJMzTDgN7ekdYyUPom8GBrhDheupWnjBldehinuM1jdEkDllVQ0o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oQ/qSowh; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757682460; x=1789218460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AhN3kcAG8s569E8YZrQ3IpCqcZPTOWGxuTdywrZKkkQ=;
  b=oQ/qSowhdUpAyNpv4iy/dRKXbaOq5UHbovGvMNDGMWWJXkhb/Ame/X8y
   yepx7ChyLO/e+BZawDJMXlV08LtzN2qTP2yE5z/gf+peZzPzVGv3Z3VoC
   c7mV4BH/HFoh21oIZdMe8BLj/DoaEMERR6TKMCVgX78V2/aJAr04yXz46
   fnwXQBeg3aBOSf6Ue1V7darJpviNLIdtkxYRXbs8tdI6wCGRepiQazsAJ
   g9k+yS7CsoCkR+GTh3MYD9oFw1BvOf99KTojupOeMO1ddnffMY+B3pRJj
   epAk/hKK5mwldGeT8RZGlh+8x3m7+C+M7KbrwDKIr3EdiDYuQoRj+BYuN
   Q==;
X-CSE-ConnectionGUID: 1aNlGU+5Rf6yIjIrkLsmtA==
X-CSE-MsgGUID: 8ilwknIVRdeG8d/0rLfTWQ==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2023068"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 13:07:37 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:28668]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.20.211:2525] with esmtp (Farcaster)
 id f101f8c5-b944-4295-b7d2-10d8943975ce; Fri, 12 Sep 2025 13:07:37 +0000 (UTC)
X-Farcaster-Flow-ID: f101f8c5-b944-4295-b7d2-10d8943975ce
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 13:07:36 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 13:07:35 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Fri, 12 Sep 2025 13:07:35 +0000
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
Subject: RE: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow
 checks
Thread-Topic: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow
 checks
Thread-Index: AQHcI+Y14Hz9ZqTtuk67HsScGeoBbw==
Date: Fri, 12 Sep 2025 13:07:35 +0000
Message-ID: <5614ed5db9bd412cb43a78ad656eb433@amazon.com>
References: <20250910173138.8307-1-farbere@amazon.com>
 <2025091131-tractor-almost-6987@gregkh>
 <f524c24888924a999c3bb90de0099b78@amazon.com>
 <2025091122-obsolete-earthen-8c9b@gregkh>
In-Reply-To: <2025091122-obsolete-earthen-8c9b@gregkh>
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

PiBPbiBUaHUsIFNlcCAxMSwgMjAyNSBhdCAwNjoxMzozM0FNICswMDAwLCBGYXJiZXIsIEVsaWF2
IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBTZXAgMTAsIDIwMjUgYXQgMDU6MzE6MzhQTSArMDAwMCwg
RWxpYXYgRmFyYmVyIHdyb3RlOg0KPiA+ID4+IEZpeCBhIGNvbXBpbGF0aW9uIGZhaWx1cmUgd2hl
biB3YXJuaW5ncyBhcmUgdHJlYXRlZCBhcyBlcnJvcnM6DQo+ID4gPj4NCj4gPiA+PiBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvZXRodG9vbC5jOiBJbiBmdW5jdGlvbiDigJhlMTAw
MF9zZXRfZWVwcm9t4oCZOg0KPiA+ID4+IC4vaW5jbHVkZS9saW51eC9vdmVyZmxvdy5oOjcxOjE1
OiBlcnJvcjogY29tcGFyaXNvbiBvZiBkaXN0aW5jdCBwb2ludGVyIHR5cGVzIGxhY2tzIGEgY2Fz
dCBbLVdlcnJvcl0NCj4gPiA+PiAgICA3MSB8ICAodm9pZCkgKCZfX2EgPT0gX19kKTsgICBcDQo+
ID4gPj4gICAgICAgfCAgICAgICAgICAgICAgIF5+DQo+ID4gPj4gZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvZTEwMDBlL2V0aHRvb2wuYzo1ODI6Njogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1h
Y3JvIOKAmGNoZWNrX2FkZF9vdmVyZmxvd+KAmQ0KPiA+ID4+ICAgNTgyIHwgIGlmIChjaGVja19h
ZGRfb3ZlcmZsb3coZWVwcm9tLT5vZmZzZXQsIGVlcHJvbS0+bGVuLCAmdG90YWxfbGVuKSB8fA0K
PiA+ID4+ICAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gPiA+Pg0KPiA+ID4+IFRv
IGZpeCB0aGlzLCBjaGFuZ2UgdG90YWxfbGVuIGFuZCBtYXhfbGVuIGZyb20gc2l6ZV90IHRvIHUz
MiBpbg0KPiA+ID4+IGUxMDAwX3NldF9lZXByb20oKS4NCj4gPiA+PiBUaGUgY2hlY2tfYWRkX292
ZXJmbG93KCkgaGVscGVyIHJlcXVpcmVzIHRoYXQgdGhlIGZpcnN0IHR3byBvcGVyYW5kcw0KPiA+
ID4+IGFuZCB0aGUgcG9pbnRlciB0byB0aGUgcmVzdWx0ICh0aGlyZCBvcGVyYW5kKSBhbGwgaGF2
ZSB0aGUgc2FtZSB0eXBlLg0KPiA+ID4+IE9uIDY0LWJpdCBidWlsZHMsIHVzaW5nIHNpemVfdCBj
YXVzZWQgYSBtaXNtYXRjaCB3aXRoIHRoZSB1MzIgZmllbGRzDQo+ID4gPj4gZWVwcm9tLT5vZmZz
ZXQgYW5kIGVlcHJvbS0+bGVuLCBsZWFkaW5nIHRvIHR5cGUgY2hlY2sgZmFpbHVyZXMuDQo+ID4g
Pj4NCj4gPiA+PiBGaXhlczogY2U4ODI5ZDNkNDRiICgiZTEwMDBlOiBmaXggaGVhcCBvdmVyZmxv
dyBpbiBlMTAwMF9zZXRfZWVwcm9tIikNCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBFbGlhdiBGYXJi
ZXIgPGZhcmJlcmVAYW1hem9uLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+PiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2V0aHRvb2wuYyB8IDIgKy0NCj4gPiA+PiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPj4NCj4gPiA+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2V0aHRvb2wuYw0KPiA+
ID4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2V0aHRvb2wuYw0KPiA+ID4+
IGluZGV4IDRhY2E4NTQ3ODNlMi4uNTg0Mzc4MjkxZjNmIDEwMDY0NA0KPiA+ID4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9ldGh0b29sLmMNCj4gPiA+PiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvZXRodG9vbC5jDQo+ID4gPj4gQEAgLTU1
OSw3ICs1NTksNyBAQCBzdGF0aWMgaW50IGUxMDAwX3NldF9lZXByb20oc3RydWN0IG5ldF9kZXZp
Y2UNCj4gPiA+PiAqbmV0ZGV2LCAgew0KPiA+ID4+ICAgICAgIHN0cnVjdCBlMTAwMF9hZGFwdGVy
ICphZGFwdGVyID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4gPiA+PiAgICAgICBzdHJ1Y3QgZTEw
MDBfaHcgKmh3ID0gJmFkYXB0ZXItPmh3Ow0KPiA+ID4+IC0gICAgIHNpemVfdCB0b3RhbF9sZW4s
IG1heF9sZW47DQo+ID4gPj4gKyAgICAgdTMyIHRvdGFsX2xlbiwgbWF4X2xlbjsNCj4gPiA+PiAg
ICAgICB1MTYgKmVlcHJvbV9idWZmOw0KPiA+ID4+ICAgICAgIGludCByZXRfdmFsID0gMDsNCj4g
PiA+PiAgICAgICBpbnQgZmlyc3Rfd29yZDsNCj4gPiA+PiAtLQ0KPiA+ID4+IDIuNDcuMw0KPiA+
ID4+DQo+ID4gPg0KPiA+ID4gV2h5IGlzIHRoaXMgbm90IG5lZWRlZCBpbiBMaW51cydzIHRyZWU/
DQo+ID4gS2VybmVsIDUuMTAuMjQzIGVuZm9yY2VzIHRoZSBzYW1lIHR5cGUsIGJ1dCB0aGlzIGVu
Zm9yY2VtZW50IGlzDQo+ID4gYWJzZW50IGZyb20gNS4xNS4xOTIgYW5kIGxhdGVyOg0KPiA+IC8q
DQo+ID4gICogRm9yIHNpbXBsaWNpdHkgYW5kIGNvZGUgaHlnaWVuZSwgdGhlIGZhbGxiYWNrIGNv
ZGUgYmVsb3cgaW5zaXN0cyBvbg0KPiA+ICAqIGEsIGIgYW5kICpkIGhhdmluZyB0aGUgc2FtZSB0
eXBlIChzaW1pbGFyIHRvIHRoZSBtaW4oKSBhbmQgbWF4KCkNCj4gPiAgKiBtYWNyb3MpLCB3aGVy
ZWFzIGdjYydzIHR5cGUtZ2VuZXJpYyBvdmVyZmxvdyBjaGVja2VycyBhY2NlcHQNCj4gPiAgKiBk
aWZmZXJlbnQgdHlwZXMuIEhlbmNlIHdlIGRvbid0IGp1c3QgbWFrZSBjaGVja19hZGRfb3ZlcmZs
b3cgYW4NCj4gPiAgKiBhbGlhcyBmb3IgX19idWlsdGluX2FkZF9vdmVyZmxvdywgYnV0IGFkZCB0
eXBlIGNoZWNrcyBzaW1pbGFyIHRvDQo+ID4gICogYmVsb3cuDQo+ID4gICovDQo+ID4gI2RlZmlu
ZSBjaGVja19hZGRfb3ZlcmZsb3coYSwgYiwgZCkgX19tdXN0X2NoZWNrX292ZXJmbG93KCh7ICBc
DQo+DQo+IFllYWgsIHRoZSBtaW4oKSBidWlsZCB3YXJuaW5nIG1lc3MgaXMgc2xvd2x5IHByb3Bh
Z2F0aW5nIGJhY2sgdG8gb2xkZXINCj4ga2VybmVscyBvdmVyIHRpbWUgYXMgd2UgdGFrZSB0aGVz
ZSB0eXBlcyBvZiBmaXhlcyBiYWNrd2FyZHMuICBJIGNvdW50IDMNCj4gc3VjaCBuZXcgd2Fybmlu
Z3MgaW4gdGhlIG5ldyA1LjEwIHJlbGVhc2UsIG5vdCBqdXN0IHRoaXMgc2luZ2xlIG9uZS4NCj4N
Cj4gT3ZlcmFsbCwgaG93IGFib3V0IGZpeGluZyB0aGlzIHVwIHNvIGl0IGRvZXNuJ3QgaGFwcGVu
IGFueW1vcmUgYnkNCj4gYmFja3BvcnRpbmcgdGhlIG1pbigpIGxvZ2ljIGluc3RlYWQ/ICBUaGF0
IHNob3VsZCBzb2x2ZSB0aGlzIGJ1aWxkDQo+IHdhcm5pbmcsIGFuZCBrZWVwIGl0IGZyb20gaGFw
cGVuaW5nIGFnYWluIGluIHRoZSBmdXR1cmU/ICBJIGRpZCB0aGF0IGZvcg0KPiBuZXdlciBrZXJu
ZWwgYnJhbmNoZXMsIGJ1dCBuZXZlciBnb3QgYXJvdW5kIHRvIGl0IGZvciB0aGVzZS4NCg0KSSBk
aWQgYmFja3BvcnRpbmcgb2YgNCBjb21taXRzIHRvIGJyaW5nIGluY2x1ZGUvbGludXgvb3ZlcmZs
b3cuaCBpbg0KbGluZSB3aXRoIHY1LjE1LjE5MyBpbiBvcmRlciB0byBwdWxsIGNvbW1pdCAxZDFh
YzgyNDRjMjIgKCJvdmVyZmxvdzoNCkFsbG93IG1peGVkIHR5cGUgYXJndW1lbnRzIikuDQpJJ2xs
IGFsc28gY2hlY2sgd2hhdCBjYW4gYmUgZG9uZSBmb3IgaW5jbHVkZS9saW51eC9taW5tYXguaC4N
Cg0KLS0tDQpSZWdhcmRzLCBFbGlhdg0K

