Return-Path: <stable+bounces-104323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC09F2D13
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115091881D5A
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60F20102A;
	Mon, 16 Dec 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DpRG0KXR"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC02AF03;
	Mon, 16 Dec 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341724; cv=none; b=nRCw1gifyFsyCVMBosjIcjTNuSRIudgUhmsl33h7jVfQC7qd3AlBvz905aBwELp8g7pB4vXGPsmb60WxwcANHc1h7ZE1wazY5CJvqV66inHgrKKb5AQLveWlE1Rny3bC3stYyy2NlMWzVwy8J6So/qxtGe6seR7tHUbRGRRy6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341724; c=relaxed/simple;
	bh=TPhIZlVaq2DqrJ6uhJgGWWzBLtWixstsmW6LhSeSavo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FL/vzUCuPdc5/0hRaqmwNYEVfRLeK2MyTtK3vGmK4udFuN3jVeNXNoae9WQtRKwr7wM2Uobh0LxnhUVvhC62zBTIqySY7JQCRTicOv9EvoRdAXjVghQxzziCWXVP+T7MdFlYecQ/K0VjkdnExTmLGFPg6ZyKSYDyn2fhIodAYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DpRG0KXR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BG9ZEmO42950541, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734341714; bh=TPhIZlVaq2DqrJ6uhJgGWWzBLtWixstsmW6LhSeSavo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DpRG0KXReL8evmlN+F4uir7kHYivdJlYnJWLi/NFWT0Dh1oWkk4j7fX/tqP8MG4to
	 4m9jTLOyxoZwpTxxIwZsBoQPBkzbkJF3XSqh/WAlTPsstLnOyQm7XmvnMoB8UdHbuQ
	 eymwxk4bVy01wio9yoifWgy74mHZtq3mUAE5dF463IgU6XUK0figMZhNLKYu2KHNgP
	 HcQfNuyohzZHUM2lS923cLu8uQPIr7FeChocdv+9wVB4PVqKAh9CQm5bnV0i2OPm1i
	 k3aEFvs4ciaywuLcIYSkm9JlyrZomiti80+dSwaFA3t70HhtLP6A6pJKhlsXl951/0
	 dRjWwbEsBbbSA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BG9ZEmO42950541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 17:35:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Dec 2024 17:35:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Dec 2024 17:35:14 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Mon, 16 Dec 2024 17:35:14 +0800
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
Thread-Index: AQHbTvIxtyWK99B6LkqZbi3R9/JZE7LonTDg
Date: Mon, 16 Dec 2024 09:35:13 +0000
Message-ID: <a96a5ec1b8d54b9b805d546512641dec@realtek.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
In-Reply-To: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

UGxlYXNlIGFsc28gZG8gaXQgb24gb2xkZXIga2VybmVsLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEV2Z2VueSBLYXB1biA8YWJhY2FiYWRhYmFjYWJhQGdtYWlsLmNv
bT4NCj4gU2VudDogU3VuZGF5LCBEZWNlbWJlciAxNSwgMjAyNCA5OjA3IFBNDQo+IFRvOiBMaW51
eCBTb3VuZCBNYWlsaW5nIExpc3QgPGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6
IEthaWxhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+OyBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+OyBMaW51eA0KPiBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnPjsgTGludXggUmVncmVzc2lvbnMgTWFpbGluZw0KPiBMaXN0IDxyZWdyZXNzaW9uc0Bs
aXN0cy5saW51eC5kZXY+OyBMaW51eCBTdGFibGUgTWFpbGluZyBMaXN0DQo+IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUkVHUkVTU0lPTl0gRGlzdG9ydGVkIHNvdW5kIG9u
IEFjZXIgQXNwaXJlIEExMTUtMzEgbGFwdG9wDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4g
DQo+IA0KPiANCj4gSSBhbSB1c2luZyBhbiBBY2VyIEFzcGlyZSBBMTE1LTMxIGxhcHRvcC4gV2hl
biBydW5uaW5nIG5ld2VyIGtlcm5lbA0KPiB2ZXJzaW9ucywgc291bmQgcGxheWVkIHRocm91Z2gg
aGVhZHBob25lcyBpcyBkaXN0b3J0ZWQsIGJ1dCB3aGVuIHJ1bm5pbmcNCj4gb2xkZXIgdmVyc2lv
bnMsIGl0IGlzIG5vdC4NCj4gDQo+IEtlcm5lbCB2ZXJzaW9uOiBMaW51eCB2ZXJzaW9uIDYuMTIu
NSAodXNlckBob3N0bmFtZSkgKGdjYyAoRGViaWFuDQo+IDE0LjIuMC04KSAxNC4yLjAsIEdOVSBs
ZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIuNDMuNTAuMjAyNDEyMTApICMxIFNNUA0KPiBQ
UkVFTVBUX0RZTkFNSUMgU3VuIERlYyAxNSAwNTowOToxNiBJU1QgMjAyNCBPcGVyYXRpbmcgU3lz
dGVtOiBEZWJpYW4NCj4gR05VL0xpbnV4IHRyaXhpZS9zaWQNCj4gDQo+IE5vIHNwZWNpYWwgYWN0
aW9ucyBhcmUgbmVlZGVkIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUuIFRoZSBzb3VuZCBpcyBkaXN0
b3J0ZWQgYWxsDQo+IHRoZSB0aW1lLCBhbmQgaXQgZG9lc24ndCBkZXBlbmQgb24gYW55dGhpbmcg
YmVzaWRlcyB1c2luZyBhbiBhZmZlY3RlZCBrZXJuZWwNCj4gdmVyc2lvbi4NCj4gDQo+IEl0IHNl
ZW1zIHRvIGJlIGNhdXNlZCBieSBjb21taXQNCj4gMzRhYjViYmM2ZTgyMjE0ZDdmNzM5M2ViYTI2
ZDE2NGIzMDNlYmI0ZQ0KPiAoQUxTQTogaGRhL3JlYWx0ZWsgLSBBZGQgSGVhZHNldCBNaWMgc3Vw
cG9ydGVkIEFjZXIgTkIgcGxhdGZvcm0pLg0KPiBJbmRlZWQsIGlmIEkgcmVtb3ZlIHRoZSBlbnRy
eSB0aGF0IHRoaXMgY29tbWl0IGFkZHMsIHRoZSBpc3N1ZSBkaXNhcHBlYXJzLg0KPiANCj4gbHNw
Y2kgb3V0cHV0IGZvciB0aGUgZGV2aWNlIGluIHF1ZXN0aW9uOg0KPiANCj4gMDA6MGUuMCBNdWx0
aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXIgWzA0MDFdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDZWxlcm9u
L1BlbnRpdW0NCj4gU2lsdmVyIFByb2Nlc3NvciBIaWdoIERlZmluaXRpb24gQXVkaW8gWzgwODY6
MzE5OF0gKHJldiAwNikNCj4gICAgICBTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEld
IERldmljZSBbMTAyNToxMzYwXQ0KPiAgICAgIEZsYWdzOiBidXMgbWFzdGVyLCBmYXN0IGRldnNl
bCwgbGF0ZW5jeSAwLCBJUlEgMTMwDQo+ICAgICAgTWVtb3J5IGF0IGExMjE0MDAwICg2NC1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10NCj4gICAgICBNZW1vcnkgYXQgYTEwMDAwMDAg
KDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MU1dDQo+ICAgICAgQ2FwYWJpbGl0aWVz
OiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzDQo+ICAgICAgQ2FwYWJpbGl0aWVzOiBb
ODBdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVuPTE0IDw/Pg0KPiAgICAgIENhcGFi
aWxpdGllczogWzYwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsNCj4g
ICAgICBDYXBhYmlsaXRpZXM6IFs3MF0gRXhwcmVzcyBSb290IENvbXBsZXggSW50ZWdyYXRlZCBF
bmRwb2ludCwgSW50TXNnTnVtDQo+IDANCj4gICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogc25k
X2hkYV9pbnRlbA0KPiAgICAgIEtlcm5lbCBtb2R1bGVzOiBzbmRfaGRhX2ludGVsLCBzbmRfc29j
X2F2cywgc25kX3NvZl9wY2lfaW50ZWxfYXBsDQoNCg==

