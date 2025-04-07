Return-Path: <stable+bounces-128459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8062A7D623
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9E17A9BA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2F22756A;
	Mon,  7 Apr 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="HZPp6fLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6B225402
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010825; cv=none; b=gnanHYJagLt99DBdxTecCxgiIipaojHZO/fidGyQfe/uN26O41+rFV08Xd1zBTgtAu6iB4ueIZ7TL3MAhNyR4zkGn/xROlm3ArHmWZfiw+3+UDcMgmxmk8UXQe8df8W9X+yJAN19pRty1SWPgQok5MtGUg2i8fwuMMq248Xko7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010825; c=relaxed/simple;
	bh=UwqAfuutWFDOCyTXI9GwcHKbcjXrFBCC/I282eRBqBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GViTX5eEo/YgsNlbFtInNKEPI8LucFPuefzJDUQjglJcCXbTnfTxM2Ken309grhhLbUDcII6EFwDbPjocJ5PvdWQcwYDVE1LHX1ZDBTy+u8Bx8IH3h1MSgLtGXlPyWqO3q0byYWLWPbdUOPf/EH4HXWNdZKpR9+U+nEKC6SY1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=HZPp6fLI; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1744010824; x=1775546824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UwqAfuutWFDOCyTXI9GwcHKbcjXrFBCC/I282eRBqBA=;
  b=HZPp6fLI7+DyUGXn8FyxGf7PJs24YRXlGSPaybceLz4T52Tym4FytNu3
   e/ABFzLom+nk0kN1y9isaARXg3fBUx5sEfQ35o1rFiyYgE3g/UH7C6+mx
   X5n9dOcsI3nWVKwDYSjBKjjYdcGPj1EoJjtjwwe+eThyImlMRPIK64sDs
   E=;
X-IronPort-AV: E=Sophos;i="6.15,193,1739836800"; 
   d="scan'208";a="480898781"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:27:01 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:65053]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.64:2525] with esmtp (Farcaster)
 id 4fa85a5d-9c13-4a90-bbb3-9e3253e95079; Mon, 7 Apr 2025 07:27:00 +0000 (UTC)
X-Farcaster-Flow-ID: 4fa85a5d-9c13-4a90-bbb3-9e3253e95079
Received: from EX19D002EUC003.ant.amazon.com (10.252.51.218) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 07:26:59 +0000
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19D002EUC003.ant.amazon.com (10.252.51.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 07:26:59 +0000
Received: from EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520]) by
 EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520%3]) with mapi id
 15.02.1544.014; Mon, 7 Apr 2025 07:26:59 +0000
From: "Manthey, Norbert" <nmanthey@amazon.de>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "sashal@kernel.org" <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Thread-Topic: Improving Linux Commit Backporting
Thread-Index: AQHbp45zKa2Y2e2Xm0qaoatRIWBEfg==
Date: Mon, 7 Apr 2025 07:26:59 +0000
Message-ID: <94605fedd3f066efbe09f21fd1e0533cc6a1c5b9.camel@amazon.de>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
	 <2025040348-living-blurred-eb56@gregkh>
	 <2025040348-grant-unstylish-a78b@gregkh>
	 <2025040311-overstate-satin-1a8f@gregkh>
In-Reply-To: <2025040311-overstate-satin-1a8f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <973BD0541D05684C9A39607FF5C5A6A8@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA0LTAzIGF0IDE1OjUxICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCi4uLnNuaXAgLi4uDQo+IE9uIFRodSwgQXByIDAzLCAyMDI1IGF0IDAyOjU3
OjM0UE0gKzAxMDAsIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnwqB3cm90ZToNCj4gPiBPbiBU
aHUsIEFwciAwMywgMjAyNSBhdCAwMjo0NTozNVBNICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZ8Kgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEFwciAwMywgMjAyNSBhdCAwMToxNToyOFBN
ICswMDAwLCBNYW50aGV5LCBOb3JiZXJ0IHdyb3RlOg0KLi4uc25pcC4uLg0KPiA+ID4gPiBXZSB3
b3VsZCBsaWtlIHRvIGRpc2N1c3Mgd2hldGhlciB5b3UgY2FuIGludGVncmF0ZSB0aGlzIGltcHJv
dmVkIHRvb2wNCj4gPiA+ID4gaW50byBpbnRvIHlvdXIgZGFpbHkgd29ya2Zsb3dzLiBXZSBhbHJl
YWR5IGZvdW5kIHRoZSBzdGFibGUtdG9vbHMNCj4gPiA+ID4gcmVwb3NpdG9yeSBbMV0gd2l0aCBz
b21lIHNjcmlwdHMgdGhhdCBoZWxwIGF1dG9tYXRlIGJhY2twb3J0aW5nLiBUbw0KPiA+ID4gPiBj
b250cmlidXRlIGdpdC1mdXp6eS1waWNrIHRoZXJlLCB3ZSB3b3VsZCBuZWVkIHlvdSB0byBkZWNs
YXJlIGEgbGljZW5zZQ0KPiA+ID4gPiBmb3IgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdGhpcyByZXBv
c2l0b3J5Lg0KPiA+ID4gDQo+ID4gPiBUaGVyZSdzIG5vIG5lZWQgZm9yIHVzIHRvIGRlY2xhcmUg
dGhlIGxpY2Vuc2UgZm9yIHRoZSB3aG9sZSByZXBvLCB5b3UNCj4gPiA+IGp1c3QgbmVlZCB0byBw
aWNrIGEgbGljZW5zZSBmb3IgeW91ciBzY3JpcHQgdG8gYmUgdW5kZXIuwqAgQW55dGhpbmcNCj4g
PiA+IHRoYXQncyB1bmRlciBhIHZhbGlkIG9wZW4gc291cmNlIGxpY2Vuc2UgaXMgZmluZSB3aXRo
IG1lLg0KPiA+ID4gDQo+ID4gPiBUaGF0IGJlaW5nIHNhaWQsIEkgZGlkIGp1c3QgZ28gYW5kIGFk
ZCBTUERYIGxpY2Vuc2UgbGluZXMgdG8gYWxsIG9mIHRoZQ0KPiA+ID4gc2NyaXB0cyB0aGF0IEkg
d3JvdGUsIG9yIHRoYXQgd2FzIGFscmVhZHkgZGVmaW5lZCBpbiB0aGUgY29tbWVudHMgb2YgdGhl
DQo+ID4gPiBmaWxlcywgdG8gbWFrZSBpdCBtb3JlIG9idmlvdXMgd2hhdCB0aGV5IGFyZSB1bmRl
ci4NClRoYW5rcyENCj4gPiANCj4gPiBXYWl0LCB5b3Ugc2hvdWxkIGJlIGxvb2tpbmcgYXQgdGhl
IHNjcmlwdHMgaW4gdGhlIHN0YWJsZS1xdWV1ZS5naXQgdHJlZQ0KPiA+IGluIHRoZSBzY3JpcHRz
LyBkaXJlY3RvcnkuwqAgWW91IHBvaW50ZWQgYXQgYSBwcml2YXRlIHJlcG8gb2Ygc29tZSB0aGlu
Z3MNCj4gPiB0aGF0IFNhc2hhIHVzZXMgZm9yIGhpcyB3b3JrLCB3aGljaCBpcyBzcGVjaWZpYyB0
byBoaXMgd29ya2Zsb3cuDQpJIGhhZCBhIGxvb2sgYXQgdGhvc2Ugc2NyaXB0cyB0b28uIExvb2tz
IGxpa2UgeW91IHVzZSBnaXQgYW0sIGFuZCBhYm9ydCBpbiBjYXNlIHRoaXMgb3BlcmF0aW9uDQpm
YWlscy4NCj4gDQo+IEFsc28sIG9uZSBmaW5hbCB0aGluZ3MuwqAgRG9pbmcgYmFja3BvcnRzIHRv
IG9sZGVyIGtlcm5lbHMgaXMgYSBoYXJkZXINCj4gdGFzayB0aGFuIGRvaW5nIGl0IGZvciBuZXdl
ciBrZXJuZWxzLsKgIFRoaXMgbWVhbnMgeW91IG5lZWQgdG8gZG8gbW9yZQ0KPiB3b3JrLCBhbmQg
aGF2ZSBhIG1vcmUgZXhwZXJpZW5jZWQgZGV2ZWxvcGVyIGRvIHRoYXQgd29yaywgYXMgdGhlIG51
YW5jZXMNCj4gYXJlIHRyaWNreSBhbmQgc2xpZ2h0IGFuZCB0aGV5IG11c3QgdW5kZXJzdGFuZCB0
aGUgY29kZSBiYXNlIHJlYWxseQ0KPiB3ZWxsLg0KPiANCj4gQXR0ZW1wdGluZyB0byBhdXRvbWF0
ZSB0aGlzLCBhbmQgbWFrZSBpdCBhICJqdW5pb3IgZGV2ZWxvcGVyIiB0YXNrDQo+IGFzc2lnbm1l
bnQgaXMgcmlwZSBmb3IgZXJyb3JzIGFuZCBwcm9ibGVtcyBhbmQgdGVhcnMgKG9uIG15IHNpZGUg
YW5kDQo+IHlvdXJzLinCoCBXZSBoYXZlIGxvYWRzIG9mIGV4YW1wbGVzIG9mIHRoaXMgaW4gdGhl
IHBhc3QsIHBsZWFzZSBkb24ndA0KPiBkdXBsaWNhdGUgdGhlIGVycm9ycyBvZiBvdGhlcnMgYW5k
IHRoaW5rIHRoYXQgInNvbWVob3csIHRoaXMgdGltZSBpdA0KPiB3aWxsIGJlIGRpZmZlcmVudCEi
LCBidXQgcmF0aGVyICJsZWFybiBmcm9tIG91ciBwYXN0IG1pc3Rha2VzIGFuZCBvbmx5DQo+IG1h
a2UgbmV3IG9uZXMuIg0KV2UgdW5kZXJzdGFuZC4gV2UgbWlnaHQgbWFrZSB0aGUgdG9vbCBhdmFp
bGFibGUgdG8gaGVscCBzaW1wbGlmeSB0aGUgaHVtYW4gZWZmb3J0IG9mIGJhY2twb3J0aW5nLiBU
bw0KbWFrZSB0aGlzIG1vcmUgc3VjY2Vzc2Z1bCwgaXMgdGhlcmUgYSB3YXkgdG8gaWRlbnRpZnkg
dGhlIGVycm9ycyBhbmQgbGVhcm5pbmdzIHlvdSBtZW50aW9uIGZyb20gdGhlDQpwYXN0PyBBdm9p
ZGluZyB0aGVtIGF1dG9tYXRpY2FsbHkgZWFybHkgaW4gdGhlIHByb2Nlc3MgaGVscHMga2VlcGlu
ZyB0aGUgZXJyb3JzIGF3YXkuDQo+IA0KPiBHb29kIGx1Y2sgd2l0aCBiYWNrcG9ydGluZywgYXMg
SSBrbm93IGp1c3QgaG93IGhhcmQgb2YgYSB0YXNrIHRoaXMNCj4gcmVhbGx5IGlzLsKgIEFuZCBv
YnZpb3VzbHksIHlvdSBhcmUgbGVhcm5pbmcgdGhhdCB0b28gOikNClRoYW5rcy4NCg0KTm9yYmVy
dA0KDQo=

