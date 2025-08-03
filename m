Return-Path: <stable+bounces-165969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E72B196C4
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AF13B6181
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA42205ABA;
	Sun,  3 Aug 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IBmQkMoW"
X-Original-To: stable@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27731F2371
	for <stable@vger.kernel.org>; Sun,  3 Aug 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260720; cv=none; b=bCiE61CtNNZdGgWaNtPONfl9nGSdhlMX9/ow4UVZf98hFITU5uubLfnMQN2S+yc1WmyhcoBHKgs3zkQsSsTesXQRkHGm/xJwQ1qVzy6mNPyB1XDXCiyuoOvRbL18tkI51GAOBCAL7b1Bhpgx55IJuOFy1HIGo64odnU5bu+3fKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260720; c=relaxed/simple;
	bh=LIp5x/wrLnj5LDfNAbSJGrVDRdtDKxhunEIF9CZFEU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZElVGpm39B1t3J+n2w/9K2XZc3wKzmRgC5B/36UXgMAA9saRu6qCM+qgEg1CJa+q3k4TTTd6L+XL6SFvTT9B/WSxcSnzC/ho0+LV5LLDSwna89U0NXp3Bpw3eUv7rsak8DMLzdrFVeFWXSeZS9wrSvozHodNkar7L7wZMCrjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IBmQkMoW; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A23CD2C0132;
	Mon,  4 Aug 2025 10:38:34 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1754260714;
	bh=LIp5x/wrLnj5LDfNAbSJGrVDRdtDKxhunEIF9CZFEU8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IBmQkMoWIn17vniDBJVzH9SJBhoI/5x/3tOW9nyNv9suzEBrOF82L+pb2C95Q5Ywn
	 z44sB1QwKS4qvcWULnw/mdIttXoEmuxgWf3birtMSwkdM0cKQiryOf4SfQezPjdftG
	 GcA77r0/Q4JGnM4jFpvgeDzWlfsuJnETecZhclMuUweoJjNkKcqN+mXAIK2aH24h14
	 +j7K6ylf7cFVDS+yWMjgsm5D5KZMP8NbU5QPKLZTmBdk/RGdOkyRs9z4ePunwUhclN
	 K01DK7xw3Urf5fsXZj9VjcRQ4RqT9LvKQC7UKIXbsbmOfQst8CKxOMdx7deWiy+zSw
	 aXfcS2z1J3GsQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B688fe4ea0001>; Mon, 04 Aug 2025 10:38:34 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 4 Aug 2025 10:38:34 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Mon, 4 Aug 2025 10:38:34 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Sven Eckelmann <sven@narfation.org>, Andi Shyti <andi.shyti@kernel.org>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonas Jelonek
	<jelonek.jonas@gmail.com>, Harshal Gohel <hg@simonwunderlich.de>, "Simon
 Wunderlich" <sw@simonwunderlich.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] i2c: rtl9300: Add missing count byte for SMBus
 Block Ops
Thread-Topic: [PATCH v2 3/4] i2c: rtl9300: Add missing count byte for SMBus
 Block Ops
Thread-Index: AQHcBJeB9wi/GaEjvU+G4p+6iPxcmrRQvFcA
Date: Sun, 3 Aug 2025 22:38:34 +0000
Message-ID: <cea34edf-ece8-48a3-a8b9-c0f7e6415886@alliedtelesis.co.nz>
References: <20250803-i2c-rtl9300-multi-byte-v2-0-9b7b759fe2b6@narfation.org>
 <20250803-i2c-rtl9300-multi-byte-v2-3-9b7b759fe2b6@narfation.org>
In-Reply-To: <20250803-i2c-rtl9300-multi-byte-v2-3-9b7b759fe2b6@narfation.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A0FDE8F0024C54A88E867DE2F38A1CA@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=688fe4ea a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=svCTMBYCAAAA:8 a=lMPDrijngE3T-lQOz8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=lbQUARmhvTNeubMQCRFT:22
X-SEG-SpamProfiler-Score: 0

SGkgU3ZlbiwgQW5kaSwNCg0KT24gMDQvMDgvMjAyNSAwNDo1NCwgU3ZlbiBFY2tlbG1hbm4gd3Jv
dGU6DQo+IFRoZSBleHBlY3RlZCBvbi13aXJlIGZvcm1hdCBvZiBhbiBTTUJ1cyBCbG9jayBXcml0
ZSBpcw0KPg0KPiAgICBTIEFkZHIgV3IgW0FdIENvbW0gW0FdIENvdW50IFtBXSBEYXRhIFtBXSBE
YXRhIFtBXSAuLi4gW0FdIERhdGEgW0FdIFANCj4NCj4gRXZlcnl0aGluZyBzdGFydGluZyBmcm9t
IHRoZSBDb3VudCBieXRlIGlzIHByb3ZpZGVkIGJ5IHRoZSBJMkMgc3Vic3lzdGVtIGluDQo+IHRo
ZSBhcnJheSBkYXRhLT5ibG9jay4gQnV0IHRoZSBkcml2ZXIgd2FzIHNraXBwaW5nIHRoZSBDb3Vu
dCBieXRlDQo+IChkYXRhLT5ibG9ja1swXSkgd2hlbiBzZW5kaW5nIGl0IHRvIHRoZSBSVEw5M3h4
IEkyQyBjb250cm9sbGVyLg0KPg0KPiBPbmx5IHRoZSBhY3R1YWwgZGF0YSBjb3VsZCBiZSBzZWVu
IG9uIHRoZSB3aXJlOg0KPg0KPiAgICBTIEFkZHIgV3IgW0FdIENvbW0gW0FdIERhdGEgW0FdIERh
dGEgW0FdIC4uLiBbQV0gRGF0YSBbQV0gUA0KPg0KPiBUaGlzIHdpcmUgZm9ybWF0IGlzIG5vdCBT
TUJ1cyBCbG9jayBXcml0ZSBjb21wYXRpYmxlIGJ1dCBtYXRjaGVzIHRoZSBmb3JtYXQNCj4gb2Yg
YW4gSTJDIEJsb2NrIFdyaXRlLiBTaW1wbHkgYWRkaW5nIHRoZSBjb3VudCBieXRlIHRvIHRoZSBi
dWZmZXIgZm9yIHRoZQ0KPiBJMkMgY29udHJvbGxlciBlbm91Z2ggdG8gZml4IHRoZSB0cmFuc21p
c3Npb24uDQo+DQo+IFRoaXMgYWxzbyBhZmZlY3RzIHJlYWQgYmVjYXVzZSB0aGUgSTJDIGNvbnRy
b2xsZXIgbXVzdCByZWNlaXZlIHRoZSBjb3VudA0KPiBieXRlICsgJGNvdW50ICogZGF0YSBieXRl
cy4NCj4NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiBGaXhlczogYzM2NmJlNzIw
MjM1ICgiaTJjOiBBZGQgZHJpdmVyIGZvciB0aGUgUlRMOTMwMCBJMkMgY29udHJvbGxlciIpDQo+
IFNpZ25lZC1vZmYtYnk6IFN2ZW4gRWNrZWxtYW5uIDxzdmVuQG5hcmZhdGlvbi5vcmc+DQoNClRo
aXMgY29uZmxpY3RzIHdpdGggY29tbWl0IGY0Njg2N2MwOGEyMiAoImkyYzogcnRsOTMwMDogRml4
IA0Kb3V0LW9mLWJvdW5kcyBidWcgaW4gcnRsOTMwMF9pMmNfc21idXNfeGZlciIpIHdoaWNoIGRp
ZG4ndCBnZXQgYSBGaXhlcyANCnRhZy4gVGhlIG1lcmdlIGNvbmZsaWN0IGlzIHJlYXNvbmFibHkg
c3RyYWlnaHQgZm9yd2FyZCB0byByZXNvbHZlLiBOb3QgDQpzdXJlIGhvdyB5b3Ugd2FudCB0byBo
YW5kbGUgdGhlIHBhdGNoIGZvciBzdGFibGUuDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1ydGw5MzAwLmMgfCA2ICsrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLXJ0bDkzMDAuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5jDQo+
IGluZGV4IGExMGU1ZTZlMDAwNzVmYWJiODkwNmQ1NmYwOWY1YjkxNDFmYmMwNmUuLjRlMDg0NGQ5
NzYwN2Y2NDM4NmE2ZDdhN2M0MDg2YTgxZmRkODlkNmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5jDQo+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
cnRsOTMwMC5jDQo+IEBAIC0yODQsMTUgKzI4NCwxNSBAQCBzdGF0aWMgaW50IHJ0bDkzMDBfaTJj
X3NtYnVzX3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICphZGFwLCB1MTYgYWRkciwgdW5zaWduZWQg
cw0KPiAgIAkJcmV0ID0gcnRsOTMwMF9pMmNfcmVnX2FkZHJfc2V0KGkyYywgY29tbWFuZCwgMSk7
DQo+ICAgCQlpZiAocmV0KQ0KPiAgIAkJCWdvdG8gb3V0X3VubG9jazsNCj4gLQkJcmV0ID0gcnRs
OTMwMF9pMmNfY29uZmlnX3hmZXIoaTJjLCBjaGFuLCBhZGRyLCBkYXRhLT5ibG9ja1swXSk7DQo+
ICsJCXJldCA9IHJ0bDkzMDBfaTJjX2NvbmZpZ194ZmVyKGkyYywgY2hhbiwgYWRkciwgZGF0YS0+
YmxvY2tbMF0gKyAxKTsNCj4gICAJCWlmIChyZXQpDQo+ICAgCQkJZ290byBvdXRfdW5sb2NrOw0K
PiAgIAkJaWYgKHJlYWRfd3JpdGUgPT0gSTJDX1NNQlVTX1dSSVRFKSB7DQo+IC0JCQlyZXQgPSBy
dGw5MzAwX2kyY193cml0ZShpMmMsICZkYXRhLT5ibG9ja1sxXSwgZGF0YS0+YmxvY2tbMF0pOw0K
PiArCQkJcmV0ID0gcnRsOTMwMF9pMmNfd3JpdGUoaTJjLCAmZGF0YS0+YmxvY2tbMF0sIGRhdGEt
PmJsb2NrWzBdICsgMSk7DQo+ICAgCQkJaWYgKHJldCkNCj4gICAJCQkJZ290byBvdXRfdW5sb2Nr
Ow0KPiAgIAkJfQ0KPiAtCQlsZW4gPSBkYXRhLT5ibG9ja1swXTsNCj4gKwkJbGVuID0gZGF0YS0+
YmxvY2tbMF0gKyAxOw0KPiAgIAkJYnJlYWs7DQo+ICAgDQo+ICAgCWRlZmF1bHQ6DQo+

