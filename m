Return-Path: <stable+bounces-91893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66B9C145C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 03:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E991C2102E
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 02:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6977770F5;
	Fri,  8 Nov 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QCzCMMBG"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B8EBE;
	Fri,  8 Nov 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034728; cv=none; b=uhGGqcgMqZAvZMSxRYB8lcZSafBpj/JGss06sdRGF+5jbu7lnRwSWMJA/vKeziFdNU2hXIoP7B8lxvgqFIsaT7Ca2bl5lq22nk+3R3vaX0o9hcwtWURqHqtScHDnwN2+25p6jvQctVxMnxHyq6emt6GJ8+CsOYjNdRHt8ma/vPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034728; c=relaxed/simple;
	bh=RRbWmNOXdYVlv6WNGhx+DUWPGotPHAWZVcDIx4lJOT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxwZReCDqamx5j38rV5jTcWFuEvixLewX3Zn52IammYbGtNGae9aW2H9dOjnCgS/4GVAQbssLvh8DagUO3LCOofgjXV7AqkGbx9Y1NHCLol06wD1CdO6Q3FRLt+WGO77cRksBKIp4wM+qsWdttHiHX9G3/DVVHGGFVXrJIkmbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QCzCMMBG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A82wYY811269055, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731034714; bh=RRbWmNOXdYVlv6WNGhx+DUWPGotPHAWZVcDIx4lJOT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QCzCMMBGPMq4FZaf9aVpnPAIZJoXlmUPUdkvNv9f4/3oYAkozrCHDpkXDf0Wu97ht
	 +xN2qeLlV7mEI/ML1zDR7IrG/mWCzHiQn/OfmbLc9tvwVcruTP6Nc2uYl9fXM6sZ3U
	 2g8R9BqLxO2iQ2SfpDnQY0CQiJGkdfIL7eHfayi4mJNKfIV6lQTzbdxWqILd+gSeAe
	 hYuQTPGUv12LYzI6O4YyAeO1Zgxdy0ph1+6c/rLNtMU3SDoT2c/qdSdZhZNTkbkjwp
	 lodOvpzwpuuxeqQiGdw8O23YwojJlV09Q4Dcz9pcXJtV6DL+Lzx9JxIvWW7HY4bFqu
	 vCje6PfoN6usQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A82wYY811269055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:58:34 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:58:34 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 10:58:34 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 10:58:34 +0800
From: Kailang <kailang@realtek.com>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>,
        Takashi Iwai
	<tiwai@suse.de>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Linux Sound System
	<linux-sound@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: RE: No sound on speakers X1 Carbon Gen 12
Thread-Topic: No sound on speakers X1 Carbon Gen 12
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgP//e3+AgACHy9D//4FDgIAAhkBggAVELQCAAGMKAIABHpMAgBUeUJA=
Date: Fri, 8 Nov 2024 02:58:33 +0000
Message-ID: <f42f84204f8d413ea79f13f9c1d745d9@realtek.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
 <2024101613-giggling-ceremony-aae7@gregkh>
 <433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
 <87bjzktncb.wl-tiwai@suse.de>
 <CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
 <87cyjzrutw.wl-tiwai@suse.de>
 <CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
 <87ttd8jyu3.wl-tiwai@suse.de>
 <CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
 <87h697jl6c.wl-tiwai@suse.de>
 <CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
 <87ed4akd2a.wl-tiwai@suse.de> <87bjzekcva.wl-tiwai@suse.de>
 <CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
 <877ca2j60l.wl-tiwai@suse.de> <43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
 <87ldyh6eyu.wl-tiwai@suse.de> <18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
 <87h6956dgu.wl-tiwai@suse.de> <c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
 <CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
 <87ldyctzwt.wl-tiwai@suse.de>
 <CAEkK70RAek2Y-syVt3S+3Q-kiriO24e8qQGDTrqC-Xt4kHzbCA@mail.gmail.com>
In-Reply-To: <CAEkK70RAek2Y-syVt3S+3Q-kiriO24e8qQGDTrqC-Xt4kHzbCA@mail.gmail.com>
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

SGkgRGVhbiwNCg0KSSBjaGVjayBpc3N1ZXMgd2l0aCBvdXIgc2l0ZSBtYWNoaW5lLg0KSSBndWVz
cyB5b3VyIEJJT1MgZGlkbid0IHVwZGF0ZSB0byBuZXdlciB2ZXJzaW9uLg0KDQpJZiBCSU9TIG5v
IHVwZGF0ZSwgeW91IG5lZWQgdG8gYWRkIGJlbG93IHBhdGNoLg0KDQpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
Yw0KaW5kZXggNzRjYTBiYjZjMDkxLi4xMjZiNjgxNDBlN2UgMTAwNjQ0DQotLS0gYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3JlYWx0ZWsuYw0KKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVr
LmMNCkBAIC03NDUwLDcgKzc0NTAsNiBAQCBzdGF0aWMgdm9pZCBhbGMyODdfYWxjMTMxOF9wbGF5
YmFja19wY21faG9vayhzdHJ1Y3QgaGRhX3BjbV9zdHJlYW0gKmhpbmZvLA0KIAkJCQkgICBzdHJ1
Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCiAJCQkJICAgaW50IGFjdGlvbikNCiB7
DQotCWFsY193cml0ZV9jb2VmX2lkeChjb2RlYywgMHgxMCwgMHg4ODA2KTsgLyogQ2hhbmdlIE1M
SyB0byBHUElPMyAqLw0KIAlzd2l0Y2ggKGFjdGlvbikgew0KIAljYXNlIEhEQV9HRU5fUENNX0FD
VF9PUEVOOg0KIAkJYWxjX3dyaXRlX2NvZWZleF9pZHgoY29kZWMsIDB4NWEsIDB4MDAsIDB4OTU0
Zik7IC8qIHdyaXRlIGdwaW8zIHRvIGhpZ2ggKi8NCkBAIC03NDY0LDcgKzc0NjMsNiBAQCBzdGF0
aWMgdm9pZCBhbGMyODdfYWxjMTMxOF9wbGF5YmFja19wY21faG9vayhzdHJ1Y3QgaGRhX3BjbV9z
dHJlYW0gKmhpbmZvLA0KIHN0YXRpYyB2b2lkIGFsYzI4N19zNF9wb3dlcl9ncGlvM19kZWZhdWx0
KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQ0KIHsNCiAJaWYgKGlzX3M0X3N1c3BlbmQoY29kZWMp
KSB7DQotCQlhbGNfd3JpdGVfY29lZl9pZHgoY29kZWMsIDB4MTAsIDB4ODgwNik7IC8qIENoYW5n
ZSBNTEsgdG8gR1BJTzMgKi8NCiAJCWFsY193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAw
eDAwLCAweDU1NGYpOyAvKiB3cml0ZSBncGlvMyBhcyBkZWZhdWx0IHZhbHVlICovDQogCX0NCiB9
DQpAQCAtNzQ3Myw5ICs3NDcxLDE3IEBAIHN0YXRpYyB2b2lkIGFsYzI4N19maXh1cF9sZW5vdm9f
dGhpbmtwYWRfd2l0aF9hbGMxMzE4KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLA0KIAkJCSAgICAg
ICBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwICpmaXgsIGludCBhY3Rpb24pDQogew0KIAlzdHJ1Y3Qg
YWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsNCisgICAgICAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgY29lZl9mdyBjb2Vmc1tdID0gew0KKyAgICAgICAgICAgICAgICBXUklURV9DT0VGKDB4MjQs
IDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAwKSwgV1JJVEVfQ09FRigweDI2LCAweEMz
MDApLA0KKyAgICAgICAgICAgICAgICBXUklURV9DT0VGKDB4MjgsIDB4MDAwMSksIFdSSVRFX0NP
RUYoMHgyOSwgMHhiMDIzKSwNCisgICAgICAgICAgICAgICAgV1JJVEVfQ09FRigweDI0LCAweDAw
MTMpLCBXUklURV9DT0VGKDB4MjUsIDB4MDAwMCksIFdSSVRFX0NPRUYoMHgyNiwgMHhDMzAxKSwN
CisgICAgICAgICAgICAgICAgV1JJVEVfQ09FRigweDI4LCAweDAwMDEpLCBXUklURV9DT0VGKDB4
MjksIDB4YjAyMyksDQorICAgICAgICB9Ow0KIA0KIAlpZiAoYWN0aW9uICE9IEhEQV9GSVhVUF9B
Q1RfUFJFX1BST0JFKQ0KIAkJcmV0dXJuOw0KKyAgICAgICAgYWxjX3VwZGF0ZV9jb2VmX2lkeChj
b2RlYywgMHgxMCwgMTw8MTEsIDE8PDExKTsNCisgICAgICAgIGFsY19wcm9jZXNzX2NvZWZfZnco
Y29kZWMsIGNvZWZzKTsNCiAJc3BlYy0+cG93ZXJfaG9vayA9IGFsYzI4N19zNF9wb3dlcl9ncGlv
M19kZWZhdWx0Ow0KIAlzcGVjLT5nZW4ucGNtX3BsYXliYWNrX2hvb2sgPSBhbGMyODdfYWxjMTMx
OF9wbGF5YmFja19wY21faG9vazsNCiB9DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogRGVhbiBNYXR0aGV3IE1lbmV6ZXMgPGRlYW4ubWVuZXplc0B1dGV4YXMuZWR1Pg0K
PiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAyNiwgMjAyNCA4OjIzIEFNDQo+IFRvOiBUYWthc2hp
IEl3YWkgPHRpd2FpQHN1c2UuZGU+DQo+IENjOiBLYWlsYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29t
Pjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsNCj4gcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2
OyBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6PjsgVGFrYXNoaSBJd2FpDQo+IDx0aXdh
aUBzdXNlLmNvbT47IExpbnV4IFNvdW5kIFN5c3RlbSA8bGludXgtc291bmRAdmdlci5rZXJuZWwu
b3JnPjsgR3JlZw0KPiBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBObyBzb3VuZCBvbiBzcGVha2VycyBYMSBDYXJib24gR2VuIDEyDQo+IA0KPiANCj4gRXh0
ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4gSSBnZXQgdGhlIHNhbWUgb3V0cHV0OiBheGlvbSAv
aG9tZS9kZWFuICMgaGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4NWENCj4gU0VUX0NPRUZfSU5E
RVggMHgwMCBuaWQgPSAweDVhLCB2ZXJiID0gMHg1MDAsIHBhcmFtID0gMHgwIHZhbHVlID0gMHgw
DQo+IGF4aW9tIC9ob21lL2RlYW4gIyBoZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgMHg1YSBHRVRf
UFJPQ19DT0VGIDB4MDANCj4gbmlkID0gMHg1YSwgdmVyYiA9IDB4YzAwLCBwYXJhbSA9IDB4MCB2
YWx1ZSA9IDB4MA0KPiANCj4gT24gRnJpLCAyNSBPY3QgMjAyNCBhdCAwMjoxNiwgVGFrYXNoaSBJ
d2FpIDx0aXdhaUBzdXNlLmRlPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMjUgT2N0IDIwMjQg
MDM6MjI6MzggKzAyMDAsDQo+ID4gRGVhbiBNYXR0aGV3IE1lbmV6ZXMgd3JvdGU6DQo+ID4gPg0K
PiA+ID4gSSBnZXQgdGhlIHNhbWUgdmFsdWVzIGZvciBib3RoDQo+ID4gPg0KPiA+ID4gYXhpb20g
L2hvbWUvZGVhbi9saW51eC02LjExLjMvc291bmQvcGNpL2hkYSAjIGhkYS12ZXJiDQo+ID4gPiAv
ZGV2L3NuZC9od0MwRDAgMHg1YSBTRVRfQ09FRl9JTkRFWCAweDAwIG5pZCA9IDB4NWEsIHZlcmIg
PSAweDUwMCwNCj4gPiA+IHBhcmFtID0gMHgwIHZhbHVlID0gMHgwDQo+ID4NCj4gPiBIZXJlIE9L
LCBidXQuLi4NCj4gPg0KPiA+ID4gYXhpb20gL2hvbWUvZGVhbi9saW51eC02LjExLjMvc291bmQv
cGNpL2hkYSAjIGhkYS12ZXJiDQo+ID4gPiAvZGV2L3NuZC9od0MwRDAgMHg1YSBTRVRfUFJPQ19D
T0VGIDB4MDANCj4gPg0KPiA+IC4uLiBoZXJlIHJ1biBHRVRfUFJPQ19DT0VGIGluc3RlYWQsIGku
ZS4gdG8gcmVhZCB0aGUgdmFsdWUuDQo+ID4NCj4gPg0KPiA+IHRoYW5rcywNCj4gPg0KPiA+IFRh
a2FzaGkNCg==

