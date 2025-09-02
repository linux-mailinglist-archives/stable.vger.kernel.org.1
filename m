Return-Path: <stable+bounces-176937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0415B3F67D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF4218820FB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89062E6125;
	Tue,  2 Sep 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="t55qTCJX"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800582E1EE3
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797661; cv=none; b=AQjlK1VPSaAXode+kzrJ8Ic+DX7htD0XB27tY43xeZLgA8/MdIDWi1GjxleuwoOmryWg7QUDXD9JeZe8xFal7wYrOAsF2HhBeeP78gwpJgawxXNdMio4tHXPIlvjaTxS9kdgaFE989jRkZJTNfwc/4oF0/8LfGI3Fqd+R1tWik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797661; c=relaxed/simple;
	bh=i9l/rgnPAtlUENAjzuFtyfflxMFailwPSZNpnt7r1zI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u8ovTscREZ5lYxRr0kkuKsX7xsQS73Q44Z3m6wSF5RMX8LJRjzU7YvESdwFTgPqhE/oRDRcuLWBFYr30CS6gNrUdLxRLHoxlAuhNZx+tlsy2pQQTK8xuF/7BPr2jBKtx0vrBbpZu3D2f4USU2XLY10aUKe14uEIm3/a/qtHgHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=t55qTCJX; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756797659; x=1788333659;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=i9l/rgnPAtlUENAjzuFtyfflxMFailwPSZNpnt7r1zI=;
  b=t55qTCJXkZECBCZwNG1lzd0klhjOiN++Sy5JXhYTYEXdSfMogPSMfaRj
   qkZBsHff3esX/SWow9pnclnxNX+GlQUolpZPrHZZ6cUmup+Q+Y03BqldM
   B60gxxqOyTGaqTarReZ2nP80Y8SO6d8CmB3a+SNel4yefk7gnEPFegJ/n
   2pScpr8hh1zJc6lCtyZWJEzuzjgOm/1yzOUScGKdbms8MDjyBHpBG0K1u
   1AYUiMd68Po/penmYJzb6icK3jNJN4ESB1GYvECv5VmZfMivIClopS8qC
   j96kl4v3TC/q9JyHvMJ59vAyC74ykkw9hzNsc+gUEMgtaJDbi1ShYf71p
   g==;
X-CSE-ConnectionGUID: //Gg6BqTRIGFAYq3pFpj9A==
X-CSE-MsgGUID: qYdlX/hqR6KpWoSQvIFqcA==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1391192"
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file handles
Thread-Topic: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file handles
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:20:49 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:8261]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.1:2525] with esmtp (Farcaster)
 id a30b8583-c9a2-406b-abf3-cc3e207811eb; Tue, 2 Sep 2025 07:20:49 +0000 (UTC)
X-Farcaster-Flow-ID: a30b8583-c9a2-406b-abf3-cc3e207811eb
Received: from EX19D030EUC001.ant.amazon.com (10.252.61.228) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 07:20:46 +0000
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19D030EUC001.ant.amazon.com (10.252.61.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 07:20:46 +0000
Received: from EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520]) by
 EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520%3]) with mapi id
 15.02.2562.020; Tue, 2 Sep 2025 07:20:46 +0000
From: "Manthey, Norbert" <nmanthey@amazon.de>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com"
	<syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>, "amir73il@gmail.com"
	<amir73il@gmail.com>, "dima@arista.com" <dima@arista.com>, "Yagmurlu, Oemer
 Erdinc" <oeygmrl@amazon.de>
Thread-Index: AQHcG1Yrbva7dpqUgkWkv8Y4BEtyHLR+vaiAgAAB24CAAL4CgA==
Date: Tue, 2 Sep 2025 07:20:46 +0000
Message-ID: <ac90cc6067bc7a50d7eb0d606b3dc3718f35b9d9.camel@amazon.de>
References: <2025011112-racing-handbrake-a317@gregkh>
	 <20250901153559.14799-1-nmanthey@amazon.de>
	 <20250901153559.14799-2-nmanthey@amazon.de>
	 <2025090114-bodacious-daffodil-2f2e@gregkh>
	 <2025090116-repent-living-b7de@gregkh>
In-Reply-To: <2025090116-repent-living-b7de@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADEB445FA1422F4AAC50FD8017ECA1D3@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI1LTA5LTAxIGF0IDIyOjAwICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhl
IG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4NCj4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIE1vbiwgU2VwIDAxLCAyMDI1IGF0IDA5OjU0OjAzUE0g
KzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBNb24sIFNlcCAwMSwgMjAy
NSBhdCAwMzozNTo1OVBNICswMDAwLCBOb3JiZXJ0IE1hbnRoZXkgd3JvdGU6DQo+ID4gPiBGcm9t
OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPg0KPiA+ID4gDQo+ID4gPiBjb21t
aXQgOTc0ZTNmZTBhYzYxZGU4NTAxNWJiZTVhNDk5MGNmNDEyN2IzMDRiMiB1cHN0cmVhbS4NCj4g
PiA+IA0KPiA+ID4gRW5jb2RpbmcgZmlsZSBoYW5kbGVzIGlzIHVzdWFsbHkgcGVyZm9ybWVkIGJ5
IGEgZmlsZXN5c3RlbSA+ZW5jb2RlX2ZoKCkNCj4gPiA+IG1ldGhvZCB0aGF0IG1heSBmYWlsIGZv
ciB2YXJpb3VzIHJlYXNvbnMuDQo+ID4gPiANCj4gPiA+IFRoZSBsZWdhY3kgdXNlcnMgb2YgZXhw
b3J0ZnNfZW5jb2RlX2ZoKCksIG5hbWVseSwgbmZzZCBhbmQNCj4gPiA+IG5hbWVfdG9faGFuZGxl
X2F0KDIpIHN5c2NhbGwgYXJlIHJlYWR5IHRvIGNvcGUgd2l0aCB0aGUgcG9zc2liaWxpdHkNCj4g
PiA+IG9mIGZhaWx1cmUgdG8gZW5jb2RlIGEgZmlsZSBoYW5kbGUuDQo+ID4gPiANCj4gPiA+IFRo
ZXJlIGFyZSBhIGZldyBvdGhlciB1c2VycyBvZiBleHBvcnRmc19lbmNvZGVfe2ZoLGZpZH0oKSB0
aGF0DQo+ID4gPiBjdXJyZW50bHkgaGF2ZSBhIFdBUk5fT04oKSBhc3NlcnRpb24gd2hlbiAtPmVu
Y29kZV9maCgpIGZhaWxzLg0KPiA+ID4gUmVsYXggdGhvc2UgYXNzZXJ0aW9ucyBiZWNhdXNlIHRo
ZXkgYXJlIHdyb25nLg0KPiA+ID4gDQo+ID4gPiBUaGUgc2Vjb25kIGxpbmtlZCBidWcgcmVwb3J0
IHN0YXRlcyBjb21taXQgMTZhYWM1YWQxZmE5ICgib3ZsOiBzdXBwb3J0DQo+ID4gPiBlbmNvZGlu
ZyBub24tZGVjb2RhYmxlIGZpbGUgaGFuZGxlcyIpIGluIHY2LjYgYXMgdGhlIHJlZ3Jlc3Npbmcg
Y29tbWl0LA0KPiA+ID4gYnV0IHRoaXMgaXMgbm90IGFjY3VyYXRlLg0KPiA+ID4gDQo+ID4gPiBU
aGUgYWZvcmVtZW50aW9uZWQgY29tbWl0IG9ubHkgaW5jcmVhc2VzIHRoZSBjaGFuY2VzIG9mIHRo
ZSBhc3NlcnRpb24NCj4gPiA+IGFuZCBhbGxvd3MgdHJpZ2dlcmluZyB0aGUgYXNzZXJ0aW9uIHdp
dGggdGhlIHJlcHJvZHVjZXIgdXNpbmcgb3ZlcmxheWZzLA0KPiA+ID4gaW5vdGlmeSBhbmQgZHJv
cF9jYWNoZXMuDQo+ID4gPiANCj4gPiA+IFRyaWdnZXJpbmcgdGhpcyBhc3NlcnRpb24gd2FzIGFs
d2F5cyBwb3NzaWJsZSB3aXRoIG90aGVyIGZpbGVzeXN0ZW1zIGFuZA0KPiA+ID4gb3RoZXIgcmVh
c29ucyBvZiAtPmVuY29kZV9maCgpIGZhaWx1cmVzIGFuZCBtb3JlIHBhcnRpY3VsYXJseSwgaXQg
d2FzDQo+ID4gPiBhbHNvIHBvc3NpYmxlIHdpdGggdGhlIGV4YWN0IHNhbWUgcmVwcm9kdWNlciB1
c2luZyBvdmVybGF5ZnMgdGhhdCBpcw0KPiA+ID4gbW91bnRlZCB3aXRoIG9wdGlvbnMgaW5kZXg9
b24sbmZzX2V4cG9ydD1vbiBhbHNvIG9uIGtlcm5lbHMgPCB2Ni42Lg0KPiA+ID4gVGhlcmVmb3Jl
LCBJIGFtIG5vdCBsaXN0aW5nIHRoZSBhZm9yZW1lbnRpb25lZCBjb21taXQgYXMgYSBGaXhlcyBj
b21taXQuDQo+ID4gPiANCj4gPiA+IEJhY2twb3J0IGhpbnQ6IHRoaXMgcGF0Y2ggd2lsbCBoYXZl
IGEgdHJpdmlhbCBjb25mbGljdCBhcHBseWluZyB0bw0KPiA+ID4gdjYuNi55LCBhbmQgb3RoZXIg
dHJpdmlhbCBjb25mbGljdHMgYXBwbHlpbmcgdG8gc3RhYmxlIGtlcm5lbHMgPCB2Ni42Lg0KPiA+
ID4gDQo+ID4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2VjMDdmNmY1Y2U2MmI4NTg1NzlmQHN5emth
bGxlci5hcHBzcG90bWFpbC5jb20NCj4gPiA+IFRlc3RlZC1ieTogc3l6Ym90K2VjMDdmNmY1Y2U2
MmI4NTg1NzlmQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gPiA+IENsb3NlczogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdW5pb25mcy82NzFmZDQwYy4wNTBhMDIyMC40NzM1YS4w
MjRmLkdBRUBnb29nbGUuY29tLw0KPiA+ID4gUmVwb3J0ZWQtYnk6IERtaXRyeSBTYWZvbm92IDxk
aW1hQGFyaXN0YS5jb20+DQo+ID4gPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LQ0KPiA+ID4gZnNkZXZlbC9DQUdyYndEVEx0NmRyQjllYVVhZ25RVmdkUEJtaExmcXF4QWYz
RitKdXF5X282b1A4dXdAbWFpbC5nbWFpbC5jb20vDQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdt
YWlsLmNvbT4NCj4gPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDEyMTkx
MTUzMDEuNDY1Mzk2LTEtYW1pcjczaWxAZ21haWwuY29tDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4g
DQo+ID4gSSBuZXZlciBzaWduZWQgb2ZmIG9uIHRoZSBvcmlnaW5hbCBjb21taXQsIHNvIHdoeSB3
YXMgdGhpcyBhZGRlZD8NCg0KVGhpcyBjaGVycnktcGljayBpcyBub3QgZm9yIHRoZSB1cHN0cmVh
bSBjb21taXQsIGJ1dCBmb3IgdGhlIGJhY2twb3J0IG9uIHRoZSA2LjYgdHJlZS4gVGhlDQpyZXNw
ZWN0aXZlIGNvbW1pdCBoYXNoIGlzIGdpdmVuIGluIHRoZSBiYWNrcG9ydCBsaW5lLiBJcyB0aGlz
IGFkZGl0aW9uYWwgaW5mb3JtYXRpb24geW91IHdvdWxkIGxpa2UNCnRvIGhhdmUgaW4gdGhlIGNv
bW1pdCBtZXNzYWdlPw0KDQo+ID4gDQo+ID4gPiANCj4gPiA+IChmdXp6eSBwaWNrZWQgZnJvbSBj
b21taXQgZjQ3YzgzNGE5MTMxYWU2NGJlZTNjNDYyZjRlNjEwYzY3YjBhMDAwZikNCj4gPiA+IEFw
cGxpZWQgd2l0aCBMTE0tYWRqdXN0ZWQgaHVua3MgZm9yIDEgZnVuY3Rpb25zIGZyb20gdXMuYW1h
em9uLm5vdmENCj4gPiA+IC0gQ2hhbmdlZCB0aGUgZnVuY3Rpb24gY2FsbCBmcm9tIGBleHBvcnRm
c19lbmNvZGVfZmlkYCB0byBgZXhwb3J0ZnNfZW5jb2RlX2lub2RlX2ZoYCB0byBtYXRjaA0KPiA+
ID4gdGhlIGRlc3RpbmF0aW9uIGNvZGUuDQo+IA0KPiBXYWl0LCB0aGF0IHdhcyBqdXN0IGZ1enog
bWF0Y2hpbmcsIHRoZSByZWFsIGJvZHkgZGlkbid0IGV2ZW4gY2hhbmdlLg0KPiANCj4gPiA+IC0g
UmVtb3ZlZCB0aGUgd2FybmluZyBtZXNzYWdlIGFzIHBlciB0aGUgcGF0Y2guDQo+IA0KPiBJIGRv
IG5vdCB1bmRlcnN0YW5kIHRoaXMgY2hhbmdlLCB3aGF0IGV4YWN0bHkgd2FzIHRoaXM/DQoNCkkg
bmVlZCB0byByZXdyaXRlIChoZXJlOiBkcm9wKSB0aGlzIG1hbnVhbGx5LsKgVGhlIExMTSB3YXMg
YWxzbyBkZXNjcmliaW5nIHRoZSBjb250ZW50IG9mIHRoZQ0Kb3JpZ2luYWwgcGF0Y2gsIG5vdCBv
bmx5IHRoZSBkaWZmIGl0IGNyZWF0ZWQuwqANCg0KPiANCj4gPiBQbGVhc2UgcHV0IHRoaXMgaW4g
dGhlIHByb3BlciBwbGFjZSwgYW5kIGluIHRoZSBwcm9wZXIgZm9ybWF0LCBpZiB5b3UNCj4gPiB3
YW50IHRvIGFkZCAibm90ZXMiIHRvIHRoZSBiYWNrcG9ydC4NCg0KSUlVQywgdGhlIGNoYW5nZXMg
YXBwbGllZCB0byB0aGUgcGF0Y2ggc28gdGhhdCBpdCBhcHBsaWVzIHNob3VsZCBjb21lIGFib3Zl
IG15IFNPQiwgbm8/IFdoYXQncyB0aGUNCmZvcm1hdCByZXF1aXJlbWVudCAoZXhjZXB0IHRoZSA4
MC0xMDAgY2hhciBsaW1pdCk/DQoNCkkgYW0gYXdhcmUgb2YgdGhlIGRpc2N1c3Npb25zIGFib3V0
IEFJIGdlbmVyYXRlZCBjb2RlLiBJIHdhbnRlZCB0byBleHBsaWNpdGx5IG1lbnRpb24gdGhlIEFJ
IHVzZSwgaWYNCml0IHdhcyB1c2VkIGFzIGJhY2twb3J0aW5nIGhlbHBlci4gRG8geW91IHN1Z2dl
c3QgdG8gc3RpbGwgbW92ZSB0aGlzIGludG8gdGhlIG5vdGVzIHNlY3Rpb24gb2YgdGhlDQpjb21t
aXQgYW5kIHNlbnQgcGF0Y2gsIGluc3RlYWQgb2YgaGF2aW5nIHRoaXMgaW4gdGhlIGNvbW1pdCBp
dHNlbGY/DQoNCj4gPiANCj4gPiBCdXQgcmVhbGx5LCBpdCB0b29rIGEgTExNIHRvIGRldGVybWlu
ZSBhbiBhYmkgY2hhbmdlP8KgIFRoYXQgZmVlbHMgbGlrZQ0KPiA+IHRvdGFsIG92ZXJraWxsIGFz
IHlvdSB0aGVuIGhhZCB0byBhY3R1YWxseSBtYW51YWxseSBjaGVjayBpdCBhcyB3ZWxsLg0KPiA+
IEJ1dCBoZXksIGl0J3MgeW91ciBjcHUgY3ljbGVzIHRvIGJ1cm4sIG5vdCBtaW5lLi4uDQoNCkkg
cHJlZmVyIHJldmlld2luZyB0aGUgY29kZSBpbnN0ZWFkIG9mIHdyaXRpbmcvbWFzc2FnaW5nIGFs
bCBvZiBpdCwgYW5kIG9uIHN1Y2Nlc3MgaGF2ZSB0aGUgY2hhbmdlDQp0ZXN0ZWQvdmFsaWRhdGVk
IGF1dG9tYXRpY2FsbHkgYmVmb3JlIEkgcmV2aWV3aW5nLg0KDQo+IA0KPiANCj4gQWdhaW4sIHRv
dGFsIG92ZXJraWxsLCAxIG1pbnV0ZSBkb2luZyBhIHNpbXBsZSBnaXQgbWVyZ2UgcmVzb2x1dGlv
bg0KPiB3b3VsZCBoYXZlIGRvbmUgdGhlIHNhbWUgdGhpbmcsIHJpZ2h0Pw0KDQpGb3IgdGhpcyBl
eGFtcGxlLCB5ZXMsIEkgYWdyZWUuIFRoZXJlIGFyZSBtb3JlIGNvbXBsZXggY29tbWl0cyB3aGVy
ZSB0aGlzIHdvcmtzIGFzIHdlbGwuDQoNCj4gDQo+IGNvbmZ1c2VkIGFzIHRvIHdoeSB0aGlzIHRv
b2sgYSB3aG9sZSBuZXcgdG9vbD/CoCBXZSBoYXZlIGdvb2QgbWVyZ2UNCj4gcmVzb2x1dGlvbiB0
b29scyBmb3IgZ2l0IHRoZXNlIGRheXMsIHdoYXQncyB3cm9uZyB3aXRoIHVzaW5nIG9uZSBvZiB0
aGUNCj4gbWFueSBvbmVzIG91dCB0aGVyZT8NCg0KVGhlcmUgaXMgbm90aGluZyB3cm9uZyB1c2lu
ZyBhbnkgb3RoZXIgdG9vbC4gVGhlIGdpdC1sbG0tcGljayB0b29sIGFsbG93cyB0byBhdXRvbWF0
aWNhbGx5IGJhY2twb3J0DQptb3JlIGNvbW1pdHMgYW5kIHN1cHBvcnRzIHVzZXIgc3BlY2lmaWVk
IHZhbGlkYXRpb24gZm9yIHRoZSBjaGFuZ2VzLiBUaGUgTExNIGlzIG9ubHkgdGhlIGxhc3QNCmF0
dGVtcHQuIEEgaHVtYW4gbmVlZHMgdG8gcmV2aWV3IHRoZSBvdXRwdXQgZWl0aGVyIHdheSwgYW5k
IGV2ZW50dWFsbHkgZG8gdGhlDQpiYWNrcG9ydMKgaW50ZXJhY3RpdmVseS4NCg0KQmVzdCwNCk5v
cmJlcnQNCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0KDQoKCgpBbWF6b24gV2Vi
IFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3Ry
LiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2Vy
LCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


