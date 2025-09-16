Return-Path: <stable+bounces-179750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F83B5A365
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 22:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399BB7A2F0C
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14D261B70;
	Tue, 16 Sep 2025 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zw5/qLxd"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F881F419A
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055296; cv=none; b=hrjhJCtFIi368U9InE5nKk5Kfp3RCLdHBrK4MN68p6SPMf3q0AmsD5k4ZgxjzPNSmWoYJLBYLyFSf4X6A9z+YbYEUHM3jW2eoHDFaV1hdT2rftlTdm7ZSB7tHzfCPGUI4uwR27BhQNzgIlQlj5JX2PKr2r6oMzRitzEyuG4HXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055296; c=relaxed/simple;
	bh=Vt/sNXVtg1f81irD9xzblqK2xun2tfDuhCmQJ62Upy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Man64uwR65e4Ffu0SoNV1mHzUNebszizlLOU7hC/gsOZcdAizVHTqnYIPYc61gfgclQwUN+YC8BBcIFXyLGLoP4K4Ai539yKCiM/KmF4TRINC1rRANA7RY+Vr14zxZk8OKht2zy37uFRUvyE9anSbBs/5YnQwmz0VrvLGO9Zd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zw5/qLxd; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758055295; x=1789591295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vt/sNXVtg1f81irD9xzblqK2xun2tfDuhCmQJ62Upy8=;
  b=Zw5/qLxddI0ldIsBVuANt2bC6fr8dwyjGbo/0F+vqrGpexnV+x9MEMNU
   7dt/I84Ge9XuOsgdVmlQ/PYQGR1jWtPjSrv1xW9JypHbux77HHB57glc0
   VGr6beQ8+byXuKQSP5Yvk/WubaSo5f6Y9UZpUiRnohz5s2uDuz9Mj+1Q8
   mT839SPU/dn/BtK0IF7h2jYx07UDaqHhJLo9Xy6v1jYOW3GRDBXObgJpT
   qB6DE5id2FH7eZ2nzPkzHr/lzeh5NO+rFDdOdFcJmANFS3a0k9O0FjaIT
   S8KAeXJ4vPNnyrQK7Emy/65NB4hB243QlznacrbeTZGVAgZ8D6nyD0/6y
   Q==;
X-CSE-ConnectionGUID: Lvn4dq9TTEGeuZmE29Iy5Q==
X-CSE-MsgGUID: VLuMTQqhRmSEyUM/eL/WNg==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="3112618"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 20:41:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:34895]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.123:2525] with esmtp (Farcaster)
 id d8938d8c-47af-4e18-a0bb-e216567f64c0; Tue, 16 Sep 2025 20:41:34 +0000 (UTC)
X-Farcaster-Flow-ID: d8938d8c-47af-4e18-a0bb-e216567f64c0
Received: from EX19D015UWC004.ant.amazon.com (10.13.138.154) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 20:41:34 +0000
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19D015UWC004.ant.amazon.com (10.13.138.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 20:41:34 +0000
Received: from EX19D015UWC003.ant.amazon.com ([fe80::d084:6d60:a01b:9e2c]) by
 EX19D015UWC003.ant.amazon.com ([fe80::d084:6d60:a01b:9e2c%5]) with mapi id
 15.02.2562.020; Tue, 16 Sep 2025 20:41:34 +0000
From: "Jitindar Singh, Suraj" <surajjs@amazon.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 0/4] x86/speculation: Make {JMP, CALL}_NOSPEC
 Consistent
Thread-Topic: [PATCH 5.10 0/4] x86/speculation: Make {JMP, CALL}_NOSPEC
 Consistent
Thread-Index: AQHcJ0pKsA4wtaPJ7U2tQDWYdJBe4w==
Date: Tue, 16 Sep 2025 20:41:33 +0000
Message-ID: <ecfff771b6fdd3f5bcca3c29019dafb28d20abe1.camel@amazon.com>
References: <20250903225003.50346-1-surajjs@amazon.com>
	 <2025090450-plaster-shadiness-1283@gregkh>
In-Reply-To: <2025090450-plaster-shadiness-1283@gregkh>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <70C6EDE999DFF94B96432EADA18D31FF@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDE0OjAwICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBDQVVU
SU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRp
b24uIERvDQo+IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
Y2FuIGNvbmZpcm0gdGhlIHNlbmRlcg0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
PiANCj4gDQo+IA0KPiBPbiBXZWQsIFNlcCAwMywgMjAyNSBhdCAwMzo0OTo1OVBNIC0wNzAwLCBT
dXJhaiBKaXRpbmRhciBTaW5naCB3cm90ZToNCj4gPiBUaGUgNCBwYXRjaGVzIGluIHRoaXMgc2Vy
aWVzIG1ha2UgdGhlIEpNUF9OT1NQRUMgYW5kIENBTExfTk9TUEVDDQo+ID4gbWFjcm9zIHVzZWQN
Cj4gPiBpbiB0aGUga2VybmVsIGNvbnNpc3RlbnQgd2l0aCB3aGF0IGlzIGdlbmVyYXRlZCBieSB0
aGUgY29tcGlsZXIuDQo+ID4gDQo+ID4gKCJ4ODYsbm9zcGVjOiBTaW1wbGlmeSB7Sk1QLENBTEx9
X05PU1BFQyIpIHdhcyBtZXJnZWQgaW4gdjYuMCBhbmQNCj4gPiB0aGUgcmVtYWluaW5nDQo+ID4g
MyBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIHdlcmUgbWVyZ2VkIGluIHY2LjE1LiBBbGwgNCB3ZXJl
IGluY2x1ZGVkDQo+ID4gaW4ga2VybmVscw0KPiA+IHY1LjE1KyBhcyBwcmVyZXF1aXNpdGVzIGZv
ciB0aGUgYmFja3BvcnQgb2YgdGhlIElUUyBtaXRpZ2F0aW9ucw0KPiA+IFsxXS4NCj4gPiANCj4g
PiBOb25lIG9mIHRoZXNlIHBhdGNoZXMgd2VyZSBpbmNsdWRlZCBpbiB0aGUgYmFja3BvcnQgb2Yg
dGhlIElUUw0KPiA+IG1pdGlnYXRpb25zIHRvDQo+ID4gdGhlIDUuMTAga2VybmVsIFsyXS4gVGhl
eSBhbGwgYXBwbHkgY2xlYW5seSBhbmQgYXJlIGFwcGxpY2FibGUgdG8NCj4gPiB0aGUgNS4xMA0K
PiA+IGtlcm5lbC4gVGh1cyBJIHNlZSBubyByZWFzb24gdGhhdCB0aGV5IHdlcmVuJ3QgYXBwbGll
ZCBoZXJlLCB1bmxlc3MNCj4gPiBzb21lb25lIGNhbg0KPiA+IGNvcnJlY3QgbWU/DQo+IA0KPiBE
byB0aGV5IGFjdHVhbGx5IGZpeCBhbnl0aGluZz8NCg0KVGhleSBkbyBub3QsIG5vLg0KDQo+IA0K
PiA+IEkgYW0gc2VuZGluZyB0aGVtIGZvciBpbmNsdXNpb24gaW4gdGhlIDUuMTAga2VybmVsIGFz
IHRoaXMga2VybmVsDQo+ID4gaXMgc3RpbGwNCj4gPiBhY3RpdmVseSBtYWludGFpbmVkIGZvciB0
aGVzZSBraW5kIG9mIHZ1bG5lcmFiaWxpdHkgbWl0aWdhdGlvbnMgYW5kDQo+ID4gYXMgc3VjaA0K
PiA+IGhhdmluZyB0aGVzZSBwYXRjaGVzIHdpbGwgdW5pZnkgdGhlIGhhbmRsaW5nIG9mIHRoZXNl
IGNhc2VzIHdpdGgNCj4gPiBzdWJzZXF1ZW50DQo+ID4ga2VybmVsIHZlcnNpb25zIGVhc2luZyBj
b2RlIHVuZGVyc3RhbmRpbmcgYW5kIHRoZSBlYXNlIG9mIGJhY2twb3J0cw0KPiA+IGluIHRoZQ0K
PiA+IGZ1dHVyZS4NCj4gDQo+IERvZXMgdGhpcyBhY3R1YWxseSBhbGxvdyB0aGlzIHRvIGhhcHBl
bj/CoCBJIHRoaW5rIHRoZXJlIGFyZSBhIGZldw0KPiBzcGVjdWxhdGlvbiBmaXhlcyB0aGF0IGhh
dmUgbm90IGJlZW4gYmFja3BvcnRlZCB0byB0aGlzIGtlcm5lbCB0cmVlLA0KPiBzbw0KPiB3aHkg
bm90IGp1c3QgbWFrZSB0aGlzIGFzIGEgcGFydCBvZiB0aGF0IHdvcmsgaW5zdGVhZD/CoCBKdXN0
IGFkZGluZw0KPiBpbmZhc3RydWN0dXJlIHRoYXQgZG9lc24ndCBkbyBhbnl0aGluZyBpc24ndCB1
c3VhbGx5IGEgZ29vZCBpZGVhLg0KPiANCg0KSW4gbXkgY2FzZSBhdCBsZWFzdCwgaXQgZG9lcy4g
SSBoYWQgdG8gc3BlbmQgdGltZSB3b3JraW5nIG91dCB3aHkgdGhpcw0KY29kZSB3YXMgZGlmZmVy
ZW50IGNvbXBhcmVkIHRvIG5ld2VyIHN0YWJsZSBhbmQgdXBzdHJlYW0sIGFuZA0KZGV0ZXJtaW5p
bmcgaWYgdGhpcyByZXF1aXJlZCBzcGVjaWFsIGhhbmRsaW5nIC0gd2hpY2ggd291bGQgbm90IGhh
dmUNCmJlZW4gbmVjZXNzYXJ5IGlmIHRoaXMgY29kZSB3YXMgdGhlIHNhbWUuIE90aGVyIHNwZWN1
bGF0aW9uIGZpeGVzIGRvbid0DQp0b3VjaCB0aGlzIHBhdGggd2hpY2ggaXMgd2h5IGl0IHdhcyBp
bmNsdWRlZCBpbiB0aGUgSVRTIG1pdGlnYXRpb24NCnBhdGNoIHNlcmllcyBmb3Igb3RoZXIgc3Rh
YmxlIHZlcnNpb25zLiBJdCBkb2VzIGRvIHNvbWV0aGluZywgYW55IHdoZXJlDQp0aGUgbWFjcm9z
IGFyZSB1c2VkIHRoaXMgZG9lcyBzb21ldGhpbmcgYW5kIGlzIHRoZW4gcmV3cml0dGVuIGJ5IHRo
ZQ0KYWx0ZXJuYXRpdmVzIGNvZGUuDQoNClRyeWluZyB0byBzYXZlIG15IG93biAoYW5kIGFueW9u
ZSBlbHNlcykgc2FuaXR5IGZvciBoYXZpbmcgdG8gd29yayBvdXQNCndoeSB0aGlzIGlzIGRpZmZl
cmVudCBpbiB0aGUgZnV0dXJlIGluIGFuIGFyZWEgd2hpY2ggZG9lcyBzdGlsbCBnZXQNCnJlZ3Vs
YXJseSB0b3VjaGVkIGZvciB0aGVzZSBvbGQga2VybmVscy4gVW5kZXJzdGFuZCBpdCBkb2Vzbid0
IGZpdCB0aGUNCnJlZ3VsYXIgc3RhYmxlIHBhdGNoIG1vbGQgYnV0IHdhbnRlZCB0byBoZWxwIGlu
IGNhc2UgdGhlc2Ugd2VyZSBqdXN0DQp1bmludGVudGlvbmFsbHkgbWlzc2VkIGluIHRoaXMgc3Rh
YmxlIHN0cmVhbS4gQnV0IEkgYWNrbm93bGVkZ2UgYXMgeW91DQpwb2ludCBvdXQgdGhhdCB0aGV5
IGFyZSBub3QgZml4aW5nIGFueXRoaW5nLg0KDQpTdXJhag0KDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQoNCg==

