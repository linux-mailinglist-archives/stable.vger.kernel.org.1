Return-Path: <stable+bounces-92889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE809C6939
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 07:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC521F2372B
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69B170854;
	Wed, 13 Nov 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="plwpOYrE"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4C1714BC;
	Wed, 13 Nov 2024 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478983; cv=none; b=eacH5fElTsjMpwRxaTHz9SmEeAhi2OyPQtzwg35a5xCgZ+ejlpo4B9ZIy0F7fRVbnVxWtSUNdU+XCEfYhU2ed6h7Fmb65EatcsQ8iXYKXPnxsG2ohclYjNP0UsAjOz7sgTKJxYK6y0q+nnfi4pr+os53ipURyFrpyFBbbjDf6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478983; c=relaxed/simple;
	bh=PBY/30HLJQz2xdzsPOEJYe3ZB7kO0z7wb3VcORiX+Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkwbSgtJF+Bw0dONRhHIjzRYhARsPEtcWgwOYJH5ukBYbRLwP6Vo2lJSW2nEMKK0Urod4xPMmomIsH9yzJnipiiUhfx3BcSPXdOEgrWyxI6GRzY7ZG4F0bgNASWx4z0qgwkMMpUdXJL0uw/SX6Ng+YeGK6U/TI+D8fTs3wdm+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=plwpOYrE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AD6MmyE6853266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731478968; bh=PBY/30HLJQz2xdzsPOEJYe3ZB7kO0z7wb3VcORiX+Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=plwpOYrEzxsaseJw6qitztzYN+LEFt0sbuzAR/rcCN5G3E+4eUdkaZWiDJTuMzk9r
	 oz9fKQe4UHaEF6yuvgjkU1oxtcKyeIHBBm+x0P8ufO4mYRIq4fWuFhDxtXTmMfPQno
	 0CrKbEGTu//k5ZgyY1Jb8cBEMdBcymzELJYgPKR6ny1VckX72ZUuwfR0nTBTHavHLn
	 MEji3OXCu+l9wQLkkQ2OjTJZFdBCi2bFYIT1DyD/xpfTDrta7k1GL5WVLsgsvLdmp1
	 z9g+E2HgN5kJTHPg6IbV7ImZBAXWngFtgwx2UzgwvOGBkWJohTD7rQjatsnvGeKjcc
	 J60gtcqBHnlvw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AD6MmyE6853266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:22:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 14:22:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Nov 2024 14:22:48 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Wed, 13 Nov 2024 14:22:48 +0800
From: Kailang <kailang@realtek.com>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
CC: Takashi Iwai <tiwai@suse.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Linux Sound System <linux-sound@vger.kernel.org>,
        Greg KH
	<gregkh@linuxfoundation.org>
Subject: RE: No sound on speakers X1 Carbon Gen 12
Thread-Topic: No sound on speakers X1 Carbon Gen 12
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgP//e3+AgACHy9D//4FDgIAAhkBggAVELQCAAGMKAIABHpMAgBUeUJCABPsHwIAAzyaAgAJLhMA=
Date: Wed, 13 Nov 2024 06:22:48 +0000
Message-ID: <ced4ebe356ad4e5796f059df8cdef3dd@realtek.com>
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
 <b97c52ec20594eecb074d333095a4560@realtek.com>
 <CAEkK70QottpLxq-prAEPe8TtPR=QBdQWuUrjf6ZT6PipcfS9xw@mail.gmail.com>
In-Reply-To: <CAEkK70QottpLxq-prAEPe8TtPR=QBdQWuUrjf6ZT6PipcfS9xw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
Content-Type: multipart/mixed;
	boundary="_002_ced4ebe356ad4e5796f059df8cdef3ddrealtekcom_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_ced4ebe356ad4e5796f059df8cdef3ddrealtekcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgVGFrYXNoaSwNCg0KQXR0YWNoIHBhdGNoIHdpbGwgc29sdmUgaXNzdWUuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVhbiBNYXR0aGV3IE1lbmV6ZXMgPGRlYW4u
bWVuZXplc0B1dGV4YXMuZWR1Pg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMiwgMjAyNCAx
MToxOCBBTQ0KPiBUbzogS2FpbGFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4NCj4gQ2M6IFRha2Fz
aGkgSXdhaSA8dGl3YWlAc3VzZS5kZT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJlZ3Jl
c3Npb25zQGxpc3RzLmxpbnV4LmRldjsgSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBwZXJleC5jej47
IFRha2FzaGkgSXdhaQ0KPiA8dGl3YWlAc3VzZS5jb20+OyBMaW51eCBTb3VuZCBTeXN0ZW0gPGxp
bnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZz47IEdyZWcNCj4gS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiBTdWJqZWN0OiBSZTogTm8gc291bmQgb24gc3BlYWtlcnMgWDEgQ2FyYm9u
IEdlbiAxMg0KPiANCj4gDQo+IEV4dGVybmFsIG1haWwuDQo+IA0KPiANCj4gDQo+IFllcywgaXQg
d29ya3MhDQo=

--_002_ced4ebe356ad4e5796f059df8cdef3ddrealtekcom_
Content-Type: application/octet-stream; name="0000-x1-gen12-speaker.patch"
Content-Description: 0000-x1-gen12-speaker.patch
Content-Disposition: attachment; filename="0000-x1-gen12-speaker.patch";
	size=2204; creation-date="Fri, 08 Nov 2024 02:53:31 GMT";
	modification-date="Tue, 12 Nov 2024 06:16:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NWI2NGJmYzI2YzQ5MmNhMmZiZmYxNzE4ZmRmNDBmN2RhNDk5YjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMTIgTm92IDIwMjQgMTQ6MDM6NTMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIHVwZGF0ZSBzZXQgR1BJTzMgdG8gZGVmYXVsdCBmb3IgVGhpbmtwYWQg
d2l0aCBBTEMxMzE4CgpJZiB1c2VyIG5vIHVwZGF0ZSBCSU9TLCB0aGUgc3BlYWtlciB3aWxsIG5v
IHNvdW5kLgpUaGlzIHBhdGNoIHN1cHBvcnQgb2xkIEJJT1MgdG8gaGF2ZSBzb3VuZCBmcm9tIHNw
ZWFrZXIuCgpGaXhlczogMWU3MDc3NjlkZjA3ICgiQUxTQTogaGRhL3JlYWx0ZWsgLSBTZXQgR1BJ
TzMgdG8gZGVmYXVsdCBhdCBTNCBzdGF0ZSBmb3IgVGhpbmtwYWQgd2l0aCBBTEMxMzE4IikKU2ln
bmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYwppbmRleCA3NGNhMGJiNmMwOTEuLmQ4M2IyOWY5YTcwZiAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKQEAgLTc0NTAsNyArNzQ1MCw2IEBAIHN0YXRpYyB2b2lkIGFsYzI4N19hbGMxMzE4X3Bs
YXliYWNrX3BjbV9ob29rKHN0cnVjdCBoZGFfcGNtX3N0cmVhbSAqaGluZm8sCiAJCQkJICAgc3Ry
dWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJCQkJICAgaW50IGFjdGlvbikKIHsK
LQlhbGNfd3JpdGVfY29lZl9pZHgoY29kZWMsIDB4MTAsIDB4ODgwNik7IC8qIENoYW5nZSBNTEsg
dG8gR1BJTzMgKi8KIAlzd2l0Y2ggKGFjdGlvbikgewogCWNhc2UgSERBX0dFTl9QQ01fQUNUX09Q
RU46CiAJCWFsY193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAweDAwLCAweDk1NGYpOyAv
KiB3cml0ZSBncGlvMyB0byBoaWdoICovCkBAIC03NDY0LDcgKzc0NjMsNiBAQCBzdGF0aWMgdm9p
ZCBhbGMyODdfYWxjMTMxOF9wbGF5YmFja19wY21faG9vayhzdHJ1Y3QgaGRhX3BjbV9zdHJlYW0g
KmhpbmZvLAogc3RhdGljIHZvaWQgYWxjMjg3X3M0X3Bvd2VyX2dwaW8zX2RlZmF1bHQoc3RydWN0
IGhkYV9jb2RlYyAqY29kZWMpCiB7CiAJaWYgKGlzX3M0X3N1c3BlbmQoY29kZWMpKSB7Ci0JCWFs
Y193cml0ZV9jb2VmX2lkeChjb2RlYywgMHgxMCwgMHg4ODA2KTsgLyogQ2hhbmdlIE1MSyB0byBH
UElPMyAqLwogCQlhbGNfd3JpdGVfY29lZmV4X2lkeChjb2RlYywgMHg1YSwgMHgwMCwgMHg1NTRm
KTsgLyogd3JpdGUgZ3BpbzMgYXMgZGVmYXVsdCB2YWx1ZSAqLwogCX0KIH0KQEAgLTc0NzMsOSAr
NzQ3MSwxNyBAQCBzdGF0aWMgdm9pZCBhbGMyODdfZml4dXBfbGVub3ZvX3RoaW5rcGFkX3dpdGhf
YWxjMTMxOChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAkJCSAgICAgICBjb25zdCBzdHJ1Y3Qg
aGRhX2ZpeHVwICpmaXgsIGludCBhY3Rpb24pCiB7CiAJc3RydWN0IGFsY19zcGVjICpzcGVjID0g
Y29kZWMtPnNwZWM7CisgICAgICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY29lZl9mdyBjb2Vmc1td
ID0geworCQlXUklURV9DT0VGKDB4MjQsIDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAw
KSwgV1JJVEVfQ09FRigweDI2LCAweEMzMDApLAorCQlXUklURV9DT0VGKDB4MjgsIDB4MDAwMSks
IFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwKKwkJV1JJVEVfQ09FRigweDI0LCAweDAwMTMpLCBX
UklURV9DT0VGKDB4MjUsIDB4MDAwMCksIFdSSVRFX0NPRUYoMHgyNiwgMHhDMzAxKSwKKwkJV1JJ
VEVfQ09FRigweDI4LCAweDAwMDEpLCBXUklURV9DT0VGKDB4MjksIDB4YjAyMyksCisgICAgICAg
IH07CiAKIAlpZiAoYWN0aW9uICE9IEhEQV9GSVhVUF9BQ1RfUFJFX1BST0JFKQogCQlyZXR1cm47
CisJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHgxMCwgMTw8MTEsIDE8PDExKTsKKwlhbGNf
cHJvY2Vzc19jb2VmX2Z3KGNvZGVjLCBjb2Vmcyk7CiAJc3BlYy0+cG93ZXJfaG9vayA9IGFsYzI4
N19zNF9wb3dlcl9ncGlvM19kZWZhdWx0OwogCXNwZWMtPmdlbi5wY21fcGxheWJhY2tfaG9vayA9
IGFsYzI4N19hbGMxMzE4X3BsYXliYWNrX3BjbV9ob29rOwogfQo=

--_002_ced4ebe356ad4e5796f059df8cdef3ddrealtekcom_--

