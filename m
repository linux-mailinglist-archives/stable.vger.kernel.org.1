Return-Path: <stable+bounces-105273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E1B9F7348
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 04:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD381889C3C
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 03:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3E8633F;
	Thu, 19 Dec 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ObOXIR4f"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF983D3B8;
	Thu, 19 Dec 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734578389; cv=none; b=D29Dv8r+ivddCWMJV+So+SLnXEL5/U8X7Sac4PvzkOdzCaFAUJgzQqgNLOKL6ur/vv2xxTnUvQgAwGFGUjHfkM9jGGDpJEhtCUJkTEisBJYT6V9v+Wk/x/TCetaW7lf6tWgnL0yAQAumvKNRFVqA65KfgFBrE52vY0HRU2Ub3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734578389; c=relaxed/simple;
	bh=03mUOzYDUJlGeFx48tbJDrkv7nrtRcnvzo6NqNWmu4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8kaXqv82hsTPzy5gPPrKDqbCe46P8e61dbhnD7Yupo/kNvZcNy5EoO1LYnhiIN40edM7XvJRNYrrY01DVheSBoH+ZYLjX6wURR03xUWyWrswJPVpbdnGduy3Mtv4DCeETaIMTu+fXmML2enFrL2UEJK/+fdKfXcZUrRU7E+Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ObOXIR4f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ3JeMJ23325710, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734578380; bh=03mUOzYDUJlGeFx48tbJDrkv7nrtRcnvzo6NqNWmu4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ObOXIR4ftAkMh8yhIaZIkXmo75QBcRNTQxNTkHKSISC+VB+BgeKUYS2CVKGSVlarf
	 eGmhEQAh2s80dv/XaDFgbpWga+5rh7ip0AfRUfxWbOoYGx9f+EV2mHsgiFmqW1jycU
	 1gkGSrSze41HbQiF06aIarWi2wmy+lW54vV9vU6+MGhzNvd0NFXG0idlM/Epx5fSuf
	 upk4lcr2qQ7bbUUTDWMHB0DFHElwiP6pzDlNOJVM5jsgrRSVCqt4V1UyZqgmQ48eC3
	 4HPh6uAyEU08fdVGMYRU/gDzcOCbOZjpdEGT1wOCCfBYxPvUsGJTY6WitRDG2ABXLw
	 LF/J+CDGOzwxA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ3JeMJ23325710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 11:19:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 11:19:37 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 11:19:37 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 11:19:37 +0800
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
Thread-Index: AQHbTvIxtyWK99B6LkqZbi3R9/JZE7LoH/qQgAPUPYCAAPY/MA==
Date: Thu, 19 Dec 2024 03:19:37 +0000
Message-ID: <145cf1784c9d4bdbab8f0c398148209b@realtek.com>
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

DQpDb3VsZCB5b3UgcmVjb3JkIHNvdW5kIHZpYSBoZWFkcGhvbmU/DQoNCkkgd2FudCB0byBrbm93
IGhvdyB0aGUgdm9pY2UgZGlzdG9ydGlvbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBFdmdlbnkgS2FwdW4gPGFiYWNhYmFkYWJhY2FiYUBnbWFpbC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxOSwgMjAyNCA0OjM0IEFNDQo+IFRvOiBLYWlsYW5nIDxr
YWlsYW5nQHJlYWx0ZWsuY29tPjsgTGludXggU291bmQgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1z
b3VuZEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsgTGludXggUmVncmVzc2lvbnMgTWFpbGluZyBMaXN0DQo+IDxyZWdyZXNzaW9uc0BsaXN0
cy5saW51eC5kZXY+OyBMaW51eCBTdGFibGUgTWFpbGluZyBMaXN0DQo+IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1JFR1JFU1NJT05dIERpc3RvcnRlZCBzb3VuZCBv
biBBY2VyIEFzcGlyZSBBMTE1LTMxIGxhcHRvcA0KPiANCj4gDQo+IEV4dGVybmFsIG1haWwuDQo+
IA0KPiANCj4gDQo+IEhpIEthaWxhbmcsDQo+IA0KPiBIZXJlIGFyZSB0aGUgcmVzdWx0cyBvZiBy
dW5uaW5nIHRoZSBzY3JpcHQgb24ga2VybmVsIHZlcnNpb25zIDYuMTIuNQ0KPiAoYWZmZWN0ZWQp
IGFuZCA2LjcuMTEgKG5vdCBhZmZlY3RlZCkuDQo+IA0KPiBPbiAxMi8xNi8yNCAwNDowNywgS2Fp
bGFuZyB3cm90ZToNCj4gPiBIaSBLYXB1biwNCj4gPg0KPiA+IFBsZWFzZSBydW4gYXR0YWNoIHNj
cmlwdCBhcyBiZWxvdy4NCj4gPg0KPiA+IC4vYWxzYS1pbmZvLnNoIC0tbm8tdXBsb2FkDQo+ID4N
Cj4gPiBUaGVuIHNlbmQgYmFjayB0aGUgcmVzdWx0Lg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEV2Z2VueSBLYXB1biA8YWJhY2FiYWRhYmFjYWJhQGdt
YWlsLmNvbT4NCj4gPj4gU2VudDogU3VuZGF5LCBEZWNlbWJlciAxNSwgMjAyNCA5OjA3IFBNDQo+
ID4+IFRvOiBMaW51eCBTb3VuZCBNYWlsaW5nIExpc3QgPGxpbnV4LXNvdW5kQHZnZXIua2VybmVs
Lm9yZz4NCj4gPj4gQ2M6IEthaWxhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+OyBUYWthc2hpIEl3
YWkgPHRpd2FpQHN1c2UuZGU+Ow0KPiA+PiBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXgNCj4gPj4gUmVncmVzc2lvbnMgTWFpbGlu
ZyBMaXN0IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+OyBMaW51eCBTdGFibGUNCj4gPj4g
TWFpbGluZyBMaXN0IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiA+PiBTdWJqZWN0OiBbUkVH
UkVTU0lPTl0gRGlzdG9ydGVkIHNvdW5kIG9uIEFjZXIgQXNwaXJlIEExMTUtMzEgbGFwdG9wDQo+
ID4+DQo+ID4+DQo+ID4+IEV4dGVybmFsIG1haWwuDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IEkg
YW0gdXNpbmcgYW4gQWNlciBBc3BpcmUgQTExNS0zMSBsYXB0b3AuIFdoZW4gcnVubmluZyBuZXdl
ciBrZXJuZWwNCj4gPj4gdmVyc2lvbnMsIHNvdW5kIHBsYXllZCB0aHJvdWdoIGhlYWRwaG9uZXMg
aXMgZGlzdG9ydGVkLCBidXQgd2hlbg0KPiA+PiBydW5uaW5nIG9sZGVyIHZlcnNpb25zLCBpdCBp
cyBub3QuDQo+ID4+DQo+ID4+IEtlcm5lbCB2ZXJzaW9uOiBMaW51eCB2ZXJzaW9uIDYuMTIuNSAo
dXNlckBob3N0bmFtZSkgKGdjYyAoRGViaWFuDQo+ID4+IDE0LjIuMC04KSAxNC4yLjAsIEdOVSBs
ZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIuNDMuNTAuMjAyNDEyMTApDQo+ID4+ICMxIFNN
UCBQUkVFTVBUX0RZTkFNSUMgU3VuIERlYyAxNSAwNTowOToxNiBJU1QgMjAyNCBPcGVyYXRpbmcN
Cj4gU3lzdGVtOg0KPiA+PiBEZWJpYW4gR05VL0xpbnV4IHRyaXhpZS9zaWQNCj4gPj4NCj4gPj4g
Tm8gc3BlY2lhbCBhY3Rpb25zIGFyZSBuZWVkZWQgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4gVGhl
IHNvdW5kIGlzDQo+ID4+IGRpc3RvcnRlZCBhbGwgdGhlIHRpbWUsIGFuZCBpdCBkb2Vzbid0IGRl
cGVuZCBvbiBhbnl0aGluZyBiZXNpZGVzDQo+ID4+IHVzaW5nIGFuIGFmZmVjdGVkIGtlcm5lbCB2
ZXJzaW9uLg0KPiA+Pg0KPiA+PiBJdCBzZWVtcyB0byBiZSBjYXVzZWQgYnkgY29tbWl0DQo+ID4+
IDM0YWI1YmJjNmU4MjIxNGQ3ZjczOTNlYmEyNmQxNjRiMzAzZWJiNGUNCj4gPj4gKEFMU0E6IGhk
YS9yZWFsdGVrIC0gQWRkIEhlYWRzZXQgTWljIHN1cHBvcnRlZCBBY2VyIE5CIHBsYXRmb3JtKS4N
Cj4gPj4gSW5kZWVkLCBpZiBJIHJlbW92ZSB0aGUgZW50cnkgdGhhdCB0aGlzIGNvbW1pdCBhZGRz
LCB0aGUgaXNzdWUgZGlzYXBwZWFycy4NCj4gPj4NCj4gPj4gbHNwY2kgb3V0cHV0IGZvciB0aGUg
ZGV2aWNlIGluIHF1ZXN0aW9uOg0KPiA+Pg0KPiA+PiAwMDowZS4wIE11bHRpbWVkaWEgYXVkaW8g
Y29udHJvbGxlciBbMDQwMV06IEludGVsIENvcnBvcmF0aW9uDQo+ID4+IENlbGVyb24vUGVudGl1
bSBTaWx2ZXIgUHJvY2Vzc29yIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBbODA4NjozMTk4XSAocmV2
DQo+IDA2KQ0KPiA+PiAgICAgICBTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERl
dmljZSBbMTAyNToxMzYwXQ0KPiA+PiAgICAgICBGbGFnczogYnVzIG1hc3RlciwgZmFzdCBkZXZz
ZWwsIGxhdGVuY3kgMCwgSVJRIDEzMA0KPiA+PiAgICAgICBNZW1vcnkgYXQgYTEyMTQwMDAgKDY0
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KPiA+PiAgICAgICBNZW1vcnkgYXQg
YTEwMDAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MU1dDQo+ID4+ICAgICAg
IENhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMw0KPiA+PiAgICAg
ICBDYXBhYmlsaXRpZXM6IFs4MF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MTQg
PD8+DQo+ID4+ICAgICAgIENhcGFiaWxpdGllczogWzYwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8x
IE1hc2thYmxlLSA2NGJpdCsNCj4gPj4gICAgICAgQ2FwYWJpbGl0aWVzOiBbNzBdIEV4cHJlc3Mg
Um9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQsDQo+ID4+IEludE1zZ051bQ0KPiA+PiAw
DQo+ID4+ICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBzbmRfaGRhX2ludGVsDQo+ID4+ICAg
ICAgIEtlcm5lbCBtb2R1bGVzOiBzbmRfaGRhX2ludGVsLCBzbmRfc29jX2F2cywNCj4gPj4gc25k
X3NvZl9wY2lfaW50ZWxfYXBsDQo=

