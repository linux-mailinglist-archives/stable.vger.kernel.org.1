Return-Path: <stable+bounces-177723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D12B43BDA
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D128A00962
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2B5278158;
	Thu,  4 Sep 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="jiO1xggp"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDC2F616E;
	Thu,  4 Sep 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989562; cv=none; b=rmsDY56skFCDKF+j77XKtGDiMlOhC8G4bERIJGsHMQiYSR2cQiyy6dbjvrriZwyHauey87RJjk8+Y0ginzuRFODxGlh1mbguzjdZW/6SRBtQETEwXmwEmjy2QiwiDSqddXpfQNXg3nquMmP0p5ovq7u9sy672MZm53evsyfBaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989562; c=relaxed/simple;
	bh=ULScby5e7nfE21eIVPMtirUeTHzPiyrQ91q0FcQlkHM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GW7n/P9YB1e7NXWDK331v0VdlRmhwpeZURa5qfnomVpA2LQL3nPPbc9p97KqqNmvPa5wP3ATtWp1FFrFDiPuMwzSP7FNXRZkhA/4S+sVcuIHyH4qXRuZjVZwvBAxbQywc3PhH3LSeulB56ojeQqtoIXEkyDyAeGS8ViGiQj7POQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jiO1xggp; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756989559; x=1788525559;
  h=from:to:cc:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding:subject;
  bh=ULScby5e7nfE21eIVPMtirUeTHzPiyrQ91q0FcQlkHM=;
  b=jiO1xggpOhwae79eENcry3QlWuKF9JxxDe90CbKke9ytfsnlFEOf/i9o
   0z0OMOr+7PGUTzvvMV1/hrM/GfPhuKe/vzdq1lCga1z5heh+Poe/zATX7
   c42L2OCSGly76yU3l/UyUjDvop/a75cVYEijqt8HFXlFS9VmU3GJ5rSTw
   rJ2Oy1pVEEjuWnVoKzsZ6vojYD7U/b1S+7ty7q2C2guIaPqw2bEn+Jm9N
   E7ZaOUssAjYE3PJ8xxLTsk7VuvNQGSP1qofnCNMfE4nql3QH1GMhAU6d1
   RM2TikGsLzI0f6srhG5wAm1XJwmuTiOQNwl9nPFEg9+V69yftr3CqtxNn
   Q==;
X-CSE-ConnectionGUID: zSYct0lzSkaIIBnxJlsWUQ==
X-CSE-MsgGUID: siHY+fGUQ/eEuX1zssW6cw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1639693"
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Topic: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:39:08 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:13862]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.43.161:2525] with esmtp (Farcaster)
 id 2da87af0-5385-40d0-9937-3670b0b57a6f; Thu, 4 Sep 2025 12:39:08 +0000 (UTC)
X-Farcaster-Flow-ID: 2da87af0-5385-40d0-9937-3670b0b57a6f
Received: from EX19D024EUA001.ant.amazon.com (10.252.50.75) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 12:39:08 +0000
Received: from EX19D024EUA004.ant.amazon.com (10.252.50.30) by
 EX19D024EUA001.ant.amazon.com (10.252.50.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 12:39:07 +0000
Received: from EX19D024EUA004.ant.amazon.com ([fe80::4608:828c:c80b:ca72]) by
 EX19D024EUA004.ant.amazon.com ([fe80::4608:828c:c80b:ca72%3]) with mapi id
 15.02.2562.020; Thu, 4 Sep 2025 12:39:07 +0000
From: "Uschakow, Stanislav" <suschako@amazon.de>
To: David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
	<trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"liam.howlett@oracle.com" <liam.howlett@oracle.com>, "osalvador@suse.de"
	<osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHcGOKArPRLx5Gss0qhHb9N9ZVPl7R+LN+AgAAH1gCABJSBfQ==
Date: Thu, 4 Sep 2025 12:39:07 +0000
Message-ID: <355102b559a747fe9a09142d46852551@amazon.de>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>,<2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
In-Reply-To: <2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGkgRGF2aWQsDQoNCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+
DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDEsIDIwMjUgMToyNiBQTQ0KPiBUbzogSmFubiBI
b3JuOyBVc2NoYWtvdywgU3RhbmlzbGF2DQo+IENjOiBsaW51eC1tbUBrdmFjay5vcmc7IHRyaXhA
cmVkaGF0LmNvbTsgbmRlc2F1bG5pZXJzQGdvb2dsZS5jb207IG5hdGhhbkBrZXJuZWwub3JnOyBh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBtdWNodW4uc29uZ0BsaW51eC5kZXY7IG1pa2Uua3Jh
dmV0ekBvcmFjbGUuY29tOyBsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbTsgbGlhbS5ob3dsZXR0
QG9yYWNsZS5jb207IG9zYWx2YWRvckBzdXNlLmRlOyB2YmFia2FAc3VzZS5jejsgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBCdWc6IFBlcmZvcm1hbmNl
IHJlZ3Jlc3Npb24gaW4gMTAxM2FmNGY1ODVmOiBtbS9odWdldGxiOiBmaXggaHVnZV9wbWRfdW5z
aGFyZSgpIHZzIEdVUC1mYXN0IHJhY2UNCj4gwqAgICANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBv
cmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5k
ZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gT24gMDEuMDku
MjUgMTI6NTgsIEphbm4gSG9ybiB3cm90ZToNCj4gPiBIaSENCj4gPg0KPiA+IE9uIEZyaSwgQXVn
IDI5LCAyMDI1IGF0IDQ6MzDigK9QTSBVc2NoYWtvdywgU3RhbmlzbGF2IDxzdXNjaGFrb0BhbWF6
b24uZGU+IHdyb3RlOg0KPiA+PiBXZSBoYXZlIG9ic2VydmVkIGEgaHVnZSBsYXRlbmN5IGluY3Jl
YXNlIHVzaW5nIGBmb3JrKClgIGFmdGVyIGluZ2VzdGluZyB0aGUgQ1ZFLTIwMjUtMzgwODUgZml4
IHdoaWNoIGxlYWRzIHRvIHRoZSBjb21taXQgYDEwMTNhZjRmNTg1ZjogbW0vaHVnZXRsYjogZml4
IGh1Z2VfcG1kX3Vuc2hhcmUoKSB2cyBHVVAtZmFzdCByYWNlYC4gT24gbGFyZ2UgbWFjaGluZXMg
d2l0aCAxLjVUQiBvZiBtZW1vcnkgd2l0aCAxOTYgY29yZXMsIHdlIGlkZW50aWZpZWQgIG1tYXBw
aW5nIG9mIDEuMlRCIG9mIHNoYXJlZCBtZW1vcnkgYW5kIGZvcmtpbmcgaXRzZWxmIGRvemVucyBv
ciBodW5kcmVkcyBvZiB0aW1lcyB3ZSBzZWUgYSBpbmNyZWFzZSBvZiBleGVjdXRpb24gdGltZXMg
b2YgYSBmYWN0b3Igb2YgNC4gVGhlIHJlcHJvZHVjZXIgaXMgYXQgdGhlIGVuZCBvZiB0aGUgZW1h
aWwuDQo+ID4NCj4gPiBZZWFoLCBldmVyeSAxRyB2aXJ0dWFsIGFkZHJlc3MgcmFuZ2UgeW91IHVu
c2hhcmUgb24gdW5tYXAgd2lsbCBkbyBhbg0KPiA+IGV4dHJhIHN5bmNocm9ub3VzIElQSSBicm9h
ZGNhc3QgdG8gYWxsIENQVSBjb3Jlcywgc28gaXQncyBub3QgdmVyeQ0KPiA+IHN1cnByaXNpbmcg
dGhhdCBkb2luZyB0aGlzIHdvdWxkIGJlIGEgYml0IHNsb3cgb24gYSBtYWNoaW5lIHdpdGggMTk2
DQo+ID4gY29yZXMuDQo+IA0KPiBXaGF0IGlzIHRoZSB1c2UgY2FzZSBmb3IgdGhpcyBleHRyZW1l
IHVzYWdlIG9mIGZvcmsoKSBpbiB0aGF0IGNvbnRleHQ/DQo+IElzIGl0IGp1c3Qgc29tZXRoaW5n
IHBlb3BsZSBub3RpY2VkIGFuZCBpdCdzIHN1Ym9wdGltYWwsIG9yIGlzIHRoaXMgYQ0KPiByZWFs
IHByb2JsZW0gZm9yIHNvbWUgdXNlIGNhc2VzPw0KPiANCg0KWWVzLCB3ZSBoYXZlIGN1c3RvbWVy
IHJlcG9ydGluZyBodWdlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25zIG9uIHRoZWlyIHdvcmtsb2Fk
cy4gSSBkb24ndCBrbm93IHRoZSBzb2Z0d2FyZSBhcmNoaXRlY3R1cmUgb3IgYWN0dWFsIHVzZSBj
YXNlIGZvciB0aGVpciBhcHBsaWNhdGlvbiB0aG91Z2guIEEgZXhlY3V0aW9uIHRpbWUgaW5jcmVh
c2Ugb2YgYXQgbGVhc3QgYSBmYWN0b3Igb2YgNCBpcyBub3RpY2VhYmxlIGV2ZW4gd2l0aCBmZXcg
Zm9ya3MoKSBvbiB0aG9zZSBtYWNoaW5lcy4NCg0KPiAtLQ0KPiBDaGVlcnMNCj4gDQo+IERhdmlk
IC8gZGhpbGRlbmINCg0KDQpUaGFua3MNCg0KU3RhbmlzbGF2DQoNCiAgICAKCgoKQW1hem9uIFdl
YiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0
ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdl
ciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1
cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3
Cg==


