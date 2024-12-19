Return-Path: <stable+bounces-105255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012D9F7277
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 03:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679F4161309
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 02:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED224D8DA;
	Thu, 19 Dec 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NmK0vUNR"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DCA31;
	Thu, 19 Dec 2024 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573962; cv=none; b=gjYMunnaCXLawuQeBTjC2l1Y8Gx9GwXMlsjeHAAbKYtnjlcAmyGCuFaWOvqM9v0RiLu2TyvALsgydPsmt6xIhG0jAXp8LjIIRZ3l7gWMwqH3r3X/JAyFYEFtBFRwizjZ5b3scIeEoKw+RZ9R6QoghkewJI5i4BxNph5c+sKZGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573962; c=relaxed/simple;
	bh=RSvJNtuKwHazwUBlxNiBVY2u7YCmPiJ65iB5FToBfHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQFte3Mv2GxjPxeyFJ3IrJM7mrqgxM+WlX5XeY3Cn93KESgQ6l1oqWGl05fgpcq/uGhaXmS8H2QLpKGM2zMUKVKVso7iw4xfIHnK8DxVKetjToNGPeP8HOg2rk+t2ohRP1ohG9fSYV2nOfJR39PK+TRpPKfMr2oWilGLrpUrukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NmK0vUNR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ25tQxA3235062, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734573955; bh=RSvJNtuKwHazwUBlxNiBVY2u7YCmPiJ65iB5FToBfHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NmK0vUNRm/WALnmRw7zQ/xYwMygtPhAPsIvhSpza04S66+g1ecYSpWGB9l80gW6ed
	 QKtVHxj6FTAXG2F1Lu3L98oZHoZ8lA5O9MdT6vIxxIEYs6QVQDxjF5bjDbvvoKCvW5
	 u51eqY/Yetc18rZLag2L0iTY7mestsWcMUwOiG7hXaxGrXTRVDchuBKJPSDH3Xvvio
	 RIUXh5hiqstTDpVSizVLBFlb+gV4yuMqnHiWU758IqznBxoEa7+RRvrUpW9rH6oYvF
	 9BaZY2YwApYc54c19Tx24IHDG1U7FLcxhKtNoKF8jXBET1Q9lEiMKjG6AbMM4nSgWe
	 joLce595mBnYg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ25tQxA3235062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 10:05:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 10:05:55 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 10:05:54 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 10:05:54 +0800
From: Kailang <kailang@realtek.com>
To: Evgeny Kapun <abacabadabacaba@gmail.com>,
        Linux Sound Mailing List
	<linux-sound@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux Regressions Mailing List
	<regressions@lists.linux.dev>,
        Linux Stable Mailing List
	<stable@vger.kernel.org>
Subject: RE: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
Thread-Topic: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
Thread-Index: AQHbTvIxtyWK99B6LkqZbi3R9/JZE7LoH/qQgAPUPYCAAOIHMA==
Date: Thu, 19 Dec 2024 02:05:54 +0000
Message-ID: <ff166dfd38db410d8a82489ff487b437@realtek.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
 <b4763f69b4004b19ab5c5e0a8f675282@realtek.com>
 <0625722b-5404-406a-b571-ff79693fe980@gmail.com>
In-Reply-To: <0625722b-5404-406a-b571-ff79693fe980@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQpIZWFkcGhvbmUgb3IgSGVhZHNldC4gV2hpY2ggZGlkIHlvdSB1c2U/DQpJIGRvbid0IGtub3cg
eW91ciBwbGF0Zm9ybSBoYXMgaGVhZHNldCBtaWMgc3VwcG9ydCBvciBub3QuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXZnZW55IEthcHVuIDxhYmFjYWJhZGFiYWNh
YmFAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTksIDIwMjQgNDozNCBB
TQ0KPiBUbzogS2FpbGFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT47IExpbnV4IFNvdW5kIE1haWxp
bmcgTGlzdA0KPiA8bGludXgtc291bmRAdmdlci5rZXJuZWwub3JnPg0KPiBDYzogVGFrYXNoaSBJ
d2FpIDx0aXdhaUBzdXNlLmRlPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4IFJlZ3Jlc3Npb25zIE1haWxpbmcgTGlzdA0K
PiA8cmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2PjsgTGludXggU3RhYmxlIE1haWxpbmcgTGlz
dA0KPiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtSRUdSRVNTSU9O
XSBEaXN0b3J0ZWQgc291bmQgb24gQWNlciBBc3BpcmUgQTExNS0zMSBsYXB0b3ANCj4gDQo+IA0K
PiBFeHRlcm5hbCBtYWlsLg0KPiANCj4gDQo+IA0KPiBIaSBLYWlsYW5nLA0KPiANCj4gSGVyZSBh
cmUgdGhlIHJlc3VsdHMgb2YgcnVubmluZyB0aGUgc2NyaXB0IG9uIGtlcm5lbCB2ZXJzaW9ucyA2
LjEyLjUNCj4gKGFmZmVjdGVkKSBhbmQgNi43LjExIChub3QgYWZmZWN0ZWQpLg0KPiANCj4gT24g
MTIvMTYvMjQgMDQ6MDcsIEthaWxhbmcgd3JvdGU6DQo+ID4gSGkgS2FwdW4sDQo+ID4NCj4gPiBQ
bGVhc2UgcnVuIGF0dGFjaCBzY3JpcHQgYXMgYmVsb3cuDQo+ID4NCj4gPiAuL2Fsc2EtaW5mby5z
aCAtLW5vLXVwbG9hZA0KPiA+DQo+ID4gVGhlbiBzZW5kIGJhY2sgdGhlIHJlc3VsdC4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBFdmdlbnkgS2FwdW4g
PGFiYWNhYmFkYWJhY2FiYUBnbWFpbC5jb20+DQo+ID4+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIg
MTUsIDIwMjQgOTowNyBQTQ0KPiA+PiBUbzogTGludXggU291bmQgTWFpbGluZyBMaXN0IDxsaW51
eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4+IENjOiBLYWlsYW5nIDxrYWlsYW5nQHJlYWx0
ZWsuY29tPjsgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjsNCj4gPj4gTGludXggS2VybmVs
IE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4DQo+ID4+
IFJlZ3Jlc3Npb25zIE1haWxpbmcgTGlzdCA8cmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2Pjsg
TGludXggU3RhYmxlDQo+ID4+IE1haWxpbmcgTGlzdCA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4N
Cj4gPj4gU3ViamVjdDogW1JFR1JFU1NJT05dIERpc3RvcnRlZCBzb3VuZCBvbiBBY2VyIEFzcGly
ZSBBMTE1LTMxIGxhcHRvcA0KPiA+Pg0KPiA+Pg0KPiA+PiBFeHRlcm5hbCBtYWlsLg0KPiA+Pg0K
PiA+Pg0KPiA+Pg0KPiA+PiBJIGFtIHVzaW5nIGFuIEFjZXIgQXNwaXJlIEExMTUtMzEgbGFwdG9w
LiBXaGVuIHJ1bm5pbmcgbmV3ZXIga2VybmVsDQo+ID4+IHZlcnNpb25zLCBzb3VuZCBwbGF5ZWQg
dGhyb3VnaCBoZWFkcGhvbmVzIGlzIGRpc3RvcnRlZCwgYnV0IHdoZW4NCj4gPj4gcnVubmluZyBv
bGRlciB2ZXJzaW9ucywgaXQgaXMgbm90Lg0KPiA+Pg0KPiA+PiBLZXJuZWwgdmVyc2lvbjogTGlu
dXggdmVyc2lvbiA2LjEyLjUgKHVzZXJAaG9zdG5hbWUpIChnY2MgKERlYmlhbg0KPiA+PiAxNC4y
LjAtOCkgMTQuMi4wLCBHTlUgbGQgKEdOVSBCaW51dGlscyBmb3IgRGViaWFuKSAyLjQzLjUwLjIw
MjQxMjEwKQ0KPiA+PiAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIFN1biBEZWMgMTUgMDU6MDk6MTYg
SVNUIDIwMjQgT3BlcmF0aW5nDQo+IFN5c3RlbToNCj4gPj4gRGViaWFuIEdOVS9MaW51eCB0cml4
aWUvc2lkDQo+ID4+DQo+ID4+IE5vIHNwZWNpYWwgYWN0aW9ucyBhcmUgbmVlZGVkIHRvIHJlcHJv
ZHVjZSB0aGUgaXNzdWUuIFRoZSBzb3VuZCBpcw0KPiA+PiBkaXN0b3J0ZWQgYWxsIHRoZSB0aW1l
LCBhbmQgaXQgZG9lc24ndCBkZXBlbmQgb24gYW55dGhpbmcgYmVzaWRlcw0KPiA+PiB1c2luZyBh
biBhZmZlY3RlZCBrZXJuZWwgdmVyc2lvbi4NCj4gPj4NCj4gPj4gSXQgc2VlbXMgdG8gYmUgY2F1
c2VkIGJ5IGNvbW1pdA0KPiA+PiAzNGFiNWJiYzZlODIyMTRkN2Y3MzkzZWJhMjZkMTY0YjMwM2Vi
YjRlDQo+ID4+IChBTFNBOiBoZGEvcmVhbHRlayAtIEFkZCBIZWFkc2V0IE1pYyBzdXBwb3J0ZWQg
QWNlciBOQiBwbGF0Zm9ybSkuDQo+ID4+IEluZGVlZCwgaWYgSSByZW1vdmUgdGhlIGVudHJ5IHRo
YXQgdGhpcyBjb21taXQgYWRkcywgdGhlIGlzc3VlIGRpc2FwcGVhcnMuDQo+ID4+DQo+ID4+IGxz
cGNpIG91dHB1dCBmb3IgdGhlIGRldmljZSBpbiBxdWVzdGlvbjoNCj4gPj4NCj4gPj4gMDA6MGUu
MCBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXIgWzA0MDFdOiBJbnRlbCBDb3Jwb3JhdGlvbg0K
PiA+PiBDZWxlcm9uL1BlbnRpdW0gU2lsdmVyIFByb2Nlc3NvciBIaWdoIERlZmluaXRpb24gQXVk
aW8gWzgwODY6MzE5OF0gKHJldg0KPiAwNikNCj4gPj4gICAgICAgU3Vic3lzdGVtOiBBY2VyIElu
Y29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MTM2MF0NCj4gPj4gICAgICAgRmxhZ3M6IGJ1
cyBtYXN0ZXIsIGZhc3QgZGV2c2VsLCBsYXRlbmN5IDAsIElSUSAxMzANCj4gPj4gICAgICAgTWVt
b3J5IGF0IGExMjE0MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10NCj4g
Pj4gICAgICAgTWVtb3J5IGF0IGExMDAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtz
aXplPTFNXQ0KPiA+PiAgICAgICBDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2
ZXJzaW9uIDMNCj4gPj4gICAgICAgQ2FwYWJpbGl0aWVzOiBbODBdIFZlbmRvciBTcGVjaWZpYyBJ
bmZvcm1hdGlvbjogTGVuPTE0IDw/Pg0KPiA+PiAgICAgICBDYXBhYmlsaXRpZXM6IFs2MF0gTVNJ
OiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQrDQo+ID4+ICAgICAgIENhcGFiaWxp
dGllczogWzcwXSBFeHByZXNzIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LA0KPiA+
PiBJbnRNc2dOdW0NCj4gPj4gMA0KPiA+PiAgICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogc25k
X2hkYV9pbnRlbA0KPiA+PiAgICAgICBLZXJuZWwgbW9kdWxlczogc25kX2hkYV9pbnRlbCwgc25k
X3NvY19hdnMsDQo+ID4+IHNuZF9zb2ZfcGNpX2ludGVsX2FwbA0K

