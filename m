Return-Path: <stable+bounces-144561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CCCAB924C
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 00:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D3816F203
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E7288C9A;
	Thu, 15 May 2025 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fk44wA45"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B3E55B;
	Thu, 15 May 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747348140; cv=none; b=Zmll42Mej/Ftj2wDLCUPmgPttVKK8A0QH0tXz/VbyESHOkq3HnjWjBN9QZxLIkVPlcqb8vv3tt4rCEwhuuGIY4B+NEPxQLE5A80UEXOpq8Ex17WPzPA36bbIoOzJ4biSsVW0gXC3tL2fP1/pqj/e8qMkPIdWTJPpW6aPNjENZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747348140; c=relaxed/simple;
	bh=3j49X7ylBCwmdaUflrhLyH28SbNIQMG8C6USoXMDC6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JleVmonsPc0w5cqWVWeSdoPo5UcPRPQdVc+FBA8FHAelZ/sqihGJWwRgRVo1RSQ3+FZhqUc1mOF3O3W2vas3nepniQTVBzI43qvGgk9Mk4ngHdrtSc1ge8dn7JC2sDH+00ykJTGIO72uisHkI2zJm1fyY4miWGPQHCfEERjRU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fk44wA45; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747348139; x=1778884139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3j49X7ylBCwmdaUflrhLyH28SbNIQMG8C6USoXMDC6I=;
  b=Fk44wA451HTk2C4qLbP2fyEmLD/KmhcjDm3x+hEdgDZCqAf5qd0F9LtH
   XUXKahe9Vch9OWW06RcuFDrVyGn4R7vwAQ6Hw71nRmcNPFpYyLwr6sr0M
   z7xrjnvXkTMWWQB2SRvdecmNNf7TXTTchjTf9ikkPnAHRrISOX2lW1x0w
   HeCJ443wFHNG0f5Lx5XMBHWXKT6Wy1mUNqwWPNrnjSfN5Sfggf/0RqadT
   Eib5Q7pzxjWki6XkleHfMqqZFZhg2kcFPfWoPudif9WOBlr7p8HPsQlgM
   ThK3AL323kMrSHeEEZ6/h/hTsvVXMllsKHKp2T3b2cfDHcIylRiP/XWm3
   w==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="723235557"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:28:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:33171]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id ed2bae08-5f3a-462d-a842-8236c48a5326; Thu, 15 May 2025 22:28:56 +0000 (UTC)
X-Farcaster-Flow-ID: ed2bae08-5f3a-462d-a842-8236c48a5326
Received: from EX19D015UWC002.ant.amazon.com (10.13.138.161) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:28:56 +0000
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19D015UWC002.ant.amazon.com (10.13.138.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:28:56 +0000
Received: from EX19D015UWC003.ant.amazon.com ([fe80::d084:6d60:a01b:9e2c]) by
 EX19D015UWC003.ant.amazon.com ([fe80::d084:6d60:a01b:9e2c%5]) with mapi id
 15.02.1544.014; Thu, 15 May 2025 22:28:55 +0000
From: "Jitindar Singh, Suraj" <surajjs@amazon.com>
To: "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Thread-Topic: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Thread-Index: AQHbxei+2+hDRI+2X0aMj4Gszp0Lnw==
Date: Thu, 15 May 2025 22:28:55 +0000
Message-ID: <11e9589a1489d9a7d9cca99a2c0673ae99e8166e.camel@amazon.com>
References: <20250514220835.370700-1-surajjs@amazon.com>
	 <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
	 <20250514233022.t72lijzi4ipgmmpj@desk>
	 <20250515093652.GBaCW1tARiE2jkVs_d@fat_crate.local>
	 <20250515170633.sn27zil2wie54yhn@desk>
	 <20250515172355.GIaCYjK_fz-n71Aruz@fat_crate.local>
	 <20250515173830.uulahmrm37vyjopx@desk>
In-Reply-To: <20250515173830.uulahmrm37vyjopx@desk>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F4A4BB367E8464DBA827D448AC17970@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA1LTE1IGF0IDEwOjM4IC0wNzAwLCBQYXdhbiBHdXB0YSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbw0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXINCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4gDQo+IA0KPiANCj4gT24gVGh1LCBNYXkgMTUsIDIwMjUgYXQgMDc6MjM6NTVQTSArMDIw
MCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+IE9uIFRodSwgTWF5IDE1LCAyMDI1IGF0IDEw
OjA2OjMzQU0gLTA3MDAsIFBhd2FuIEd1cHRhIHdyb3RlOg0KPiA+ID4gQXMgSSBzYWlkIGFib3Zl
LCBhIG1pdGlnYXRpb24gdW5pbnRlbnRpb25hbGx5IG1ha2UgYW5vdGhlcg0KPiA+ID4gbWl0aWdh
dGlvbg0KPiA+ID4gaW5lZmZlY3RpdmUuDQo+ID4gDQo+ID4gSSBhY3R1YWxseSBkaWRuJ3QgbmVl
ZCBhbiBhbmFseXNpcyAtIG15IHBvaW50IGlzOiBpZiB5b3UncmUgZ29pbmcNCj4gPiB0byB3YXJu
DQo+ID4gYWJvdXQgaXQsIHRoZW4gbWFrZSBpdCBiaWcgc28gdGhhdCBpdCBnZXRzIGNhdWdodC4N
Cj4gPiANCj4gPiA+IFllcywgbWF5YmUgYSBXQVJOX09OKCkgY29uZGl0aW9uYWwgdG8gc2FuaXR5
IGNoZWNrcyBmb3INCj4gPiA+IHJldGJsZWVkL1NSU08uDQo+ID4gDQo+ID4gWWVzLCB0aGF0Lg0K
PiA+IA0KPiA+IEF0IGxlYXN0Lg0KPiA+IA0KPiA+IFRoZSBuZXh0IHN0ZXAgd291bGQgYmUgaWYg
dGhpcyB3aG9sZSAibGV0J3Mgc2V0IGEgdGh1bmsgd2l0aG91dA0KPiA+IG92ZXJ3cml0aW5nDQo+
ID4gYSBwcmV2aW91c2x5IHNldCBvbmUiIGNhbiBiZSBmaXhlZCBkaWZmZXJlbnRseS4NCj4gPiAN
Cj4gPiBGb3Igbm93LCB0aG91Z2gsIHRoZSAqbGVhc3QqIHdoYXQgc2hvdWxkIGJlIGRvbmUgaGVy
ZSBpcyBjYXRjaCB0aGUNCj4gPiBjcml0aWNhbA0KPiA+IGNhc2VzIHdoZXJlIGEgbWl0aWdhdGlv
biBpcyByZW5kZXJlZCBpbmVmZmVjdGl2ZS4gQW5kIHdhcm5pbmcgSm9lDQo+ID4gTm9ybWFsIFVz
ZXINCj4gPiBhYm91dCBpdCBkb2Vzbid0IGJyaW5nIGFueXRoaW5nLiBXZSBkbyBkZWNpZGUgZm9y
IHRoZSB1c2VyIHdoYXQgaXMNCj4gPiBzYWZlIG9yDQo+ID4gbm90LCBwcmFjdGljYWxseS4gQXQg
bGVhc3QgdGhpcyBoYXMgYmVlbiB0aGUgc3RyYXRlZ3kgdW50aWwgbm93Lg0KPiA+IA0KPiA+IFNv
IHRoZSBnb2FsIGhlcmUgc2hvdWxkIGJlIHRvIG1ha2UgSm9lIGNhdGNoIHRoaXMgYW5kIHRlbGwg
dXMgdG8NCj4gPiBmaXggaXQuDQo+ID4gDQo+ID4gTWFrZXMgc2Vuc2U/DQo+IA0KPiBBYnNvbHV0
ZWx5IG1ha2VzIHNlbnNlLg0KPiANCj4gU3VyYWosIGRvIHdhbnQgdG8gcmV2aXNlIHRoaXMgcGF0
Y2g/IE9yIGVsc2UgSSBjYW4gZG8gaXQgdG9vLg0KDQpIYXBweSB0byByZXZpc2UgaXQuDQoNClRv
IGJlIGNsZWFyLCBiYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nIHRoZSByZXF1ZXN0IGlzIHRvIG1h
a2UgdGhlDQp3YXJuaW5nIG1vcmUgb2J2aW91cyB3aXRoIGEgV0FSTigpPw0K

