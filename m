Return-Path: <stable+bounces-92069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD69C38C1
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 07:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA4B21427
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9D115533B;
	Mon, 11 Nov 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t5meYp7r"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BF1487F4;
	Mon, 11 Nov 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308246; cv=none; b=WeTRif1vQnvGJvp5CVl1cFaUXlbKqMEbO+zmyT8lKV5TYGATIieMuYaJUT7/XMYrcKPAJjKKETAiZnueZwL2Ry3RNIvd+fmiQbqgD6QTXhj5aOUmMo9XeiSvHkOYksLFzw+yALFqTz/A2oOUQg1lx4CopUBYryOVjdxnvXRYhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308246; c=relaxed/simple;
	bh=m4+r7LyH9BxJ48rRa60Sz0Y0ckhi8vilqjl9Z7hpVxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=GI4QV1CNpAKO1djRypWMKx1vvSygDXH5tGK4H0J+tDWnURYSyRN1hxfVvAOVByQtxJPtNb20v5wqNgzzJl08pndhA9DnC/DEfBoDVgBseQrF/Toh+QrwxvYf1+wOolKMMagK3S3QXJiheZNhGx4MKaVmd8Z1U9nI0AvKHMevg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t5meYp7r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB6vGamD1783243, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731308236; bh=m4+r7LyH9BxJ48rRa60Sz0Y0ckhi8vilqjl9Z7hpVxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=t5meYp7rLncF9MpTQlg1U0U6aV3vSKoJkoXCciHPVdZKtd5pqpD9FGtt9iXbgEAWA
	 MvPJBX9dn0DbnmO0O2kRtGyjlvERh/Rg+8TLHYTwbqI7iDXPwfwP3ikBAWrxUpfwEk
	 hShQ+UhB5T/5YEIj8sb7BK2WzlU4okJ3eDkf6UiXZ8MT68KCznclNizHVmAfvUsin6
	 Pbt0UCDBVmugk1O1worYP9UL6LU4Azq+v9pl7afkJ61EI7gUrRJJVgqFsdbZMXZCup
	 gK+BMgnDwU+XJmCBPEOjUpfIBbry6kTTZh+FcLQvIjkcJ/faHPlNTM3+JZkMLEdN+y
	 xWIR53t23HUQw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB6vGamD1783243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:57:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 14:57:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Nov 2024 14:57:17 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Mon, 11 Nov 2024 14:57:16 +0800
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
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgP//e3+AgACHy9D//4FDgIAAhkBggAVELQCAAGMKAIABHpMAgBUeUJCABPsHwA==
Date: Mon, 11 Nov 2024 06:57:16 +0000
Message-ID: <b97c52ec20594eecb074d333095a4560@realtek.com>
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

SGkgRGVhbiwNCg0KQ291bGQgeW91IHRlc3QgdGhlIHBhdGNoPw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEthaWxhbmcNCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA4
LCAyMDI0IDEwOjU5IEFNDQo+IFRvOiAnRGVhbiBNYXR0aGV3IE1lbmV6ZXMnIDxkZWFuLm1lbmV6
ZXNAdXRleGFzLmVkdT47IFRha2FzaGkgSXdhaQ0KPiA8dGl3YWlAc3VzZS5kZT4NCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldjsgSmFyb3Ns
YXYgS3lzZWxhDQo+IDxwZXJleEBwZXJleC5jej47IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5j
b20+OyBMaW51eCBTb3VuZCBTeXN0ZW0NCj4gPGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZz47
IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTdWJqZWN0OiBSRTogTm8g
c291bmQgb24gc3BlYWtlcnMgWDEgQ2FyYm9uIEdlbiAxMg0KPiANCj4gSGkgRGVhbiwNCj4gDQo+
IEkgY2hlY2sgaXNzdWVzIHdpdGggb3VyIHNpdGUgbWFjaGluZS4NCj4gSSBndWVzcyB5b3VyIEJJ
T1MgZGlkbid0IHVwZGF0ZSB0byBuZXdlciB2ZXJzaW9uLg0KPiANCj4gSWYgQklPUyBubyB1cGRh
dGUsIHlvdSBuZWVkIHRvIGFkZCBiZWxvdyBwYXRjaC4NCj4gDQo+IGRpZmYgLS1naXQgYS9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5j
DQo+IGluZGV4IDc0Y2EwYmI2YzA5MS4uMTI2YjY4MTQwZTdlIDEwMDY0NA0KPiAtLS0gYS9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYw0KPiArKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYw0KPiBAQCAtNzQ1MCw3ICs3NDUwLDYgQEAgc3RhdGljIHZvaWQNCj4gYWxjMjg3X2Fs
YzEzMThfcGxheWJhY2tfcGNtX2hvb2soc3RydWN0IGhkYV9wY21fc3RyZWFtICpoaW5mbywNCj4g
IAkJCQkgICBzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4gIAkJCQkgICBp
bnQgYWN0aW9uKQ0KPiAgew0KPiAtCWFsY193cml0ZV9jb2VmX2lkeChjb2RlYywgMHgxMCwgMHg4
ODA2KTsgLyogQ2hhbmdlIE1MSyB0byBHUElPMyAqLw0KPiAgCXN3aXRjaCAoYWN0aW9uKSB7DQo+
ICAJY2FzZSBIREFfR0VOX1BDTV9BQ1RfT1BFTjoNCj4gIAkJYWxjX3dyaXRlX2NvZWZleF9pZHgo
Y29kZWMsIDB4NWEsIDB4MDAsIDB4OTU0Zik7IC8qIHdyaXRlIGdwaW8zIHRvDQo+IGhpZ2ggKi8g
QEAgLTc0NjQsNyArNzQ2Myw2IEBAIHN0YXRpYyB2b2lkDQo+IGFsYzI4N19hbGMxMzE4X3BsYXli
YWNrX3BjbV9ob29rKHN0cnVjdCBoZGFfcGNtX3N0cmVhbSAqaGluZm8sICBzdGF0aWMNCj4gdm9p
ZCBhbGMyODdfczRfcG93ZXJfZ3BpbzNfZGVmYXVsdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykg
IHsNCj4gIAlpZiAoaXNfczRfc3VzcGVuZChjb2RlYykpIHsNCj4gLQkJYWxjX3dyaXRlX2NvZWZf
aWR4KGNvZGVjLCAweDEwLCAweDg4MDYpOyAvKiBDaGFuZ2UgTUxLIHRvIEdQSU8zDQo+ICovDQo+
ICAJCWFsY193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAweDAwLCAweDU1NGYpOyAvKiB3
cml0ZSBncGlvMyBhcw0KPiBkZWZhdWx0IHZhbHVlICovDQo+ICAJfQ0KPiAgfQ0KPiBAQCAtNzQ3
Myw5ICs3NDcxLDE3IEBAIHN0YXRpYyB2b2lkDQo+IGFsYzI4N19maXh1cF9sZW5vdm9fdGhpbmtw
YWRfd2l0aF9hbGMxMzE4KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLA0KPiAgCQkJICAgICAgIGNv
bnN0IHN0cnVjdCBoZGFfZml4dXAgKmZpeCwgaW50IGFjdGlvbikgIHsNCj4gIAlzdHJ1Y3QgYWxj
X3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsNCj4gKyAgICAgICAgc3RhdGljIGNvbnN0IHN0cnVj
dCBjb2VmX2Z3IGNvZWZzW10gPSB7DQo+ICsgICAgICAgICAgICAgICAgV1JJVEVfQ09FRigweDI0
LCAweDAwMTMpLCBXUklURV9DT0VGKDB4MjUsIDB4MDAwMCksDQo+IFdSSVRFX0NPRUYoMHgyNiwg
MHhDMzAwKSwNCj4gKyAgICAgICAgICAgICAgICBXUklURV9DT0VGKDB4MjgsIDB4MDAwMSksIFdS
SVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwNCj4gKyAgICAgICAgICAgICAgICBXUklURV9DT0VGKDB4
MjQsIDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAwKSwNCj4gV1JJVEVfQ09FRigweDI2
LCAweEMzMDEpLA0KPiArICAgICAgICAgICAgICAgIFdSSVRFX0NPRUYoMHgyOCwgMHgwMDAxKSwg
V1JJVEVfQ09FRigweDI5LCAweGIwMjMpLA0KPiArICAgICAgICB9Ow0KPiANCj4gIAlpZiAoYWN0
aW9uICE9IEhEQV9GSVhVUF9BQ1RfUFJFX1BST0JFKQ0KPiAgCQlyZXR1cm47DQo+ICsgICAgICAg
IGFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4MTAsIDE8PDExLCAxPDwxMSk7DQo+ICsgICAg
ICAgIGFsY19wcm9jZXNzX2NvZWZfZncoY29kZWMsIGNvZWZzKTsNCj4gIAlzcGVjLT5wb3dlcl9o
b29rID0gYWxjMjg3X3M0X3Bvd2VyX2dwaW8zX2RlZmF1bHQ7DQo+ICAJc3BlYy0+Z2VuLnBjbV9w
bGF5YmFja19ob29rID0NCj4gYWxjMjg3X2FsYzEzMThfcGxheWJhY2tfcGNtX2hvb2s7ICB9DQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRGVhbiBNYXR0aGV3
IE1lbmV6ZXMgPGRlYW4ubWVuZXplc0B1dGV4YXMuZWR1Pg0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBP
Y3RvYmVyIDI2LCAyMDI0IDg6MjMgQU0NCj4gPiBUbzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPg0KPiA+IENjOiBLYWlsYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPjsgc3RhYmxlQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY7IEphcm9zbGF2IEt5
c2VsYSA8cGVyZXhAcGVyZXguY3o+OyBUYWthc2hpDQo+ID4gSXdhaSA8dGl3YWlAc3VzZS5jb20+
OyBMaW51eCBTb3VuZCBTeXN0ZW0NCj4gPiA8bGludXgtc291bmRAdmdlci5rZXJuZWwub3JnPjsg
R3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gU3ViamVjdDogUmU6IE5v
IHNvdW5kIG9uIHNwZWFrZXJzIFgxIENhcmJvbiBHZW4gMTINCj4gPg0KPiA+DQo+ID4gRXh0ZXJu
YWwgbWFpbC4NCj4gPg0KPiA+DQo+ID4NCj4gPiBJIGdldCB0aGUgc2FtZSBvdXRwdXQ6IGF4aW9t
IC9ob21lL2RlYW4gIyBoZGEtdmVyYiAvZGV2L3NuZC9od0MwRDANCj4gPiAweDVhIFNFVF9DT0VG
X0lOREVYIDB4MDAgbmlkID0gMHg1YSwgdmVyYiA9IDB4NTAwLCBwYXJhbSA9IDB4MCB2YWx1ZSA9
DQo+ID4gMHgwIGF4aW9tIC9ob21lL2RlYW4gIyBoZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgMHg1
YSBHRVRfUFJPQ19DT0VGDQo+ID4gMHgwMCBuaWQgPSAweDVhLCB2ZXJiID0gMHhjMDAsIHBhcmFt
ID0gMHgwIHZhbHVlID0gMHgwDQo+ID4NCj4gPiBPbiBGcmksIDI1IE9jdCAyMDI0IGF0IDAyOjE2
LCBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIEZy
aSwgMjUgT2N0IDIwMjQgMDM6MjI6MzggKzAyMDAsDQo+ID4gPiBEZWFuIE1hdHRoZXcgTWVuZXpl
cyB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSSBnZXQgdGhlIHNhbWUgdmFsdWVzIGZvciBib3Ro
DQo+ID4gPiA+DQo+ID4gPiA+IGF4aW9tIC9ob21lL2RlYW4vbGludXgtNi4xMS4zL3NvdW5kL3Bj
aS9oZGEgIyBoZGEtdmVyYg0KPiA+ID4gPiAvZGV2L3NuZC9od0MwRDAgMHg1YSBTRVRfQ09FRl9J
TkRFWCAweDAwIG5pZCA9IDB4NWEsIHZlcmIgPSAweDUwMCwNCj4gPiA+ID4gcGFyYW0gPSAweDAg
dmFsdWUgPSAweDANCj4gPiA+DQo+ID4gPiBIZXJlIE9LLCBidXQuLi4NCj4gPiA+DQo+ID4gPiA+
IGF4aW9tIC9ob21lL2RlYW4vbGludXgtNi4xMS4zL3NvdW5kL3BjaS9oZGEgIyBoZGEtdmVyYg0K
PiA+ID4gPiAvZGV2L3NuZC9od0MwRDAgMHg1YSBTRVRfUFJPQ19DT0VGIDB4MDANCj4gPiA+DQo+
ID4gPiAuLi4gaGVyZSBydW4gR0VUX1BST0NfQ09FRiBpbnN0ZWFkLCBpLmUuIHRvIHJlYWQgdGhl
IHZhbHVlLg0KPiA+ID4NCj4gPiA+DQo+ID4gPiB0aGFua3MsDQo+ID4gPg0KPiA+ID4gVGFrYXNo
aQ0K

