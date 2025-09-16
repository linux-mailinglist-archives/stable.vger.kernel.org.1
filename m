Return-Path: <stable+bounces-179751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897AB5A36A
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BE87A9B70
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0827A46E;
	Tue, 16 Sep 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZP8JScFS"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957F1D88A4
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055446; cv=none; b=DHmPoml8myWTShHAjuePHVczus8X7wMuRum573JoWw6fZ8KOrTAE1GwOBgL26MS2JAkjSzHyAuWBVLNYaQbYdRSL/t2evMZffcbIYjgeVu8hn5C0ysXpFfinZA3Nw7DU41Nhse5DT3axSK8uQEx5XeXOQN2xpqaQ6lzGwwkav0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055446; c=relaxed/simple;
	bh=A4oGbQVU5Q3oyJk28fk3EOYWciojRQSCL9qMWGELvlY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMowIFux6moo3uprb4yUjpw3ZPCHRxynXUHbKw3UPzpjVl+JXX4sPwzw4tF/mIPKHj4dgu6wglGaUZTJ3FkXABkxjEV+rYHOTBshOpZsPjWGOgMZTlMgbCmbTY02B+03h61QQ3plvyJX2OyLEdKqDWzBHcl4slc0i8kiTwjMWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZP8JScFS; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758055444; x=1789591444;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=A4oGbQVU5Q3oyJk28fk3EOYWciojRQSCL9qMWGELvlY=;
  b=ZP8JScFS+/+BD1P943t4oeh4tI9V0BuHs8Z+2MkDrhuvNMJg25AIshTR
   vBcqqfoxQjuuwAjE2zn6P/ZW09nsk4TEfLYzOogTbG2duoMnW0zSvuk5z
   5r6DunMg7SjXilzmMP3M4kOrO8btA4MckQadz6GxZMHzgVxauJD3mhcOJ
   cvG6QjpE/lyxyt+5WINak354TcrQbbRua7qBsLY/4uqSR5aqPDkB6DSDw
   GMJGsoATIgKHAY8wRBfsVSznP5GvvO8SyguM00Q5pNpf/yDgs8v1mAus+
   wqykcL4ZaZ6ldmvnv+l82FzbsD0Y+/cpMv3cvchmkxQMFlqaRZcitHxH3
   w==;
X-CSE-ConnectionGUID: uDGRJmT1SkKhdAdaGDk8fw==
X-CSE-MsgGUID: XyoVk3aFTLKhnh+Dl1u3vg==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2998390"
Subject: Re: [PATCH 5.10 0/4] x86/speculation: Make {JMP, CALL}_NOSPEC Consistent
Thread-Topic: [PATCH 5.10 0/4] x86/speculation: Make {JMP, CALL}_NOSPEC Consistent
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 20:44:04 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:8783]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.68:2525] with esmtp (Farcaster)
 id c9fe2d70-1cc7-4714-9845-8bee695ad865; Tue, 16 Sep 2025 20:44:04 +0000 (UTC)
X-Farcaster-Flow-ID: c9fe2d70-1cc7-4714-9845-8bee695ad865
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 20:44:03 +0000
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 20:44:03 +0000
Received: from EX19D015UWC003.ant.amazon.com ([fe80::d084:6d60:a01b:9e2c]) by
 EX19D015UWC003.ant.amazon.com ([fe80::d084:6d60:a01b:9e2c%5]) with mapi id
 15.02.2562.020; Tue, 16 Sep 2025 20:44:03 +0000
From: "Jitindar Singh, Suraj" <surajjs@amazon.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Index: AQHcHZPW4rsNDy3vUkOVh1l43J/vo7SWWh6A
Date: Tue, 16 Sep 2025 20:44:03 +0000
Message-ID: <4e344301c6c8d3eeb67c5de1a2d5be8f3fe19eb4.camel@amazon.com>
References: <20250903225003.50346-1-surajjs@amazon.com>
	 <2025090447-rectangle-dastardly-b689@gregkh>
In-Reply-To: <2025090447-rectangle-dastardly-b689@gregkh>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <52E42862B494CA45ACFA8DF53E230A2D@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDE0OjAxICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBDQVVU
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
ZCBoZXJlLCB1bmxlc3MNCj4gPiBzb21lb25lIGNhbg0KPiA+IGNvcnJlY3QgbWU/DQo+ID4gDQo+
ID4gSSBhbSBzZW5kaW5nIHRoZW0gZm9yIGluY2x1c2lvbiBpbiB0aGUgNS4xMCBrZXJuZWwgYXMg
dGhpcyBrZXJuZWwNCj4gPiBpcyBzdGlsbA0KPiA+IGFjdGl2ZWx5IG1haW50YWluZWQgZm9yIHRo
ZXNlIGtpbmQgb2YgdnVsbmVyYWJpbGl0eSBtaXRpZ2F0aW9ucyBhbmQNCj4gPiBhcyBzdWNoDQo+
ID4gaGF2aW5nIHRoZXNlIHBhdGNoZXMgd2lsbCB1bmlmeSB0aGUgaGFuZGxpbmcgb2YgdGhlc2Ug
Y2FzZXMgd2l0aA0KPiA+IHN1YnNlcXVlbnQNCj4gPiBrZXJuZWwgdmVyc2lvbnMgZWFzaW5nIGNv
ZGUgdW5kZXJzdGFuZGluZyBhbmQgdGhlIGVhc2Ugb2YgYmFja3BvcnRzDQo+ID4gaW4gdGhlDQo+
ID4gZnV0dXJlLg0KPiANCj4gQWxzbywgeW91IG9ubHkgcmVhbGx5IGhhdmUgYWJvdXQgMSBtb3Jl
IHllYXIgbGVmdCBmb3IgdGhpcyBrZXJuZWwNCj4gdmVyc2lvbiwgd2h5IG5vdCB0YWtlIHRoZSB0
aW1lIHRvIG1vdmUgYW55IHN5c3RlbXMgdGhhdCBhcmUgc29tZWhvdw0KPiBzdGlsbCB1c2luZyB0
aGlzIHRvIGEgbW9yZSBtb2Rlcm4ga2VybmVsIGluc3RlYWQ/wqAgV2hhdCdzIHByZXZlbnRpbmcN
Cj4gdGhhdCBmcm9tIGhhcHBlbmluZz8NCg0KWW91IGNhbiBsZWFkIGEgaG9yc2UgdG8gd2F0ZXIg
YnV0IHlvdSBjYW4ndCBtYWtlIGl0IGRyaW5rLg0KDQo+IA0KPiBSdW5uaW5nIGFueSB4ODYgc3lz
dGVtcyBvbiB0aGlzIG9sZCBrZXJuZWwgcmlnaHQgbm93IGlzIHByb2JhYmx5IG5vdA0KPiBhDQo+
IGdvb2QgaWRlYSBnaXZlbiB0aGUgaHVnZSBudW1iZXIgb2YgdW5maXhlZCBidWdzIGluIGl0Li4u
DQo+IA0KDQpBd2FyZSBvZiB0aGF0IGFuZCBhZ3JlZS4NCg0KU3VyYWoNCg0KPiB0aGFua3MsDQo+
IA0KPiBncmVnIGstaA0KDQo=

