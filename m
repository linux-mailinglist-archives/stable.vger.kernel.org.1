Return-Path: <stable+bounces-106040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12AD9FB8C0
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 03:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8C11627E8
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 02:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A949813C816;
	Tue, 24 Dec 2024 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YF/OG5Ww"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2102FB6;
	Tue, 24 Dec 2024 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735008895; cv=none; b=np/0d1Wm3twQeK2csyOmSog8CtlfGidibTXrYeYXSjG0CHERECXwPF2TysSekY4pvkWr1p5oZsu1klVzqWPW2CL5GJtuKMN3qVj3GnNRaojySlqieVTIYvGjLVngfqyYaia5nViMtV/ugWloAPXVCVP5mMx2sF8SYnvU6c4dbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735008895; c=relaxed/simple;
	bh=xWS3vrD8hACtXK4k8pMX7q+Vj94Gb4GP2O+23x0XvNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmfXmitryI6lo8qbNzv7m8VUSM1XGkzAXtSbno9n0YAaCrJm/kVbqTJoDsQhvC6lsDi4ixlZxIOOc3+iRsgnPZTumKH1Nex3bDtLZXUbkaxg2AHrSEw/GX/55umwtiDsn/M/hbDx+bORFVcrD8YNEjLow2O1bvBgizDKDuFmkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YF/OG5Ww; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BO2sjYE32799716, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735008885; bh=xWS3vrD8hACtXK4k8pMX7q+Vj94Gb4GP2O+23x0XvNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=YF/OG5WwGtcW4D/WJ7NE+etukVeRT66eDsZ9QzQ1ISx/bj9VCCYeV1N8bno+uQ49g
	 QcubdElEWAndvP9XKxYNLgD7rRcgMwMKM3bhy/g++5hMDLG2FnOwO+HwHgnopJ7BcP
	 SFCAK2Wmx5U2561mVIOvB7S+ltwZLh+mMVViIhvO+eH8Zi/HRJfbxPENPBYa9NWSRy
	 9TptdxInk5XNcGNrmxuJnKqqqt0pkqa3uawUXbIVQDbVZJ0FPkyUACusmTCfQgNveT
	 WZkbYXNt3MYewwizKccLdyz6CLsbepv0onggBjFFjHWziHCmp093uEJTieXH+qNJa8
	 2edrGu85Y6KYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BO2sjYE32799716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 10:54:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Dec 2024 10:54:45 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Dec 2024 10:54:45 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Tue, 24 Dec 2024 10:54:45 +0800
From: Kailang <kailang@realtek.com>
To: Evgeny Kapun <abacabadabacaba@gmail.com>, Takashi Iwai <tiwai@suse.de>
CC: Linux Sound Mailing List <linux-sound@vger.kernel.org>,
        "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Regressions Mailing List
	<regressions@lists.linux.dev>,
        Linux Stable Mailing List
	<stable@vger.kernel.org>
Subject: RE: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
Thread-Topic: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
Thread-Index: AQHbTvIxtyWK99B6LkqZbi3R9/JZE7LtROwAgAQfxYCAAA3tgIAB5qEAgAFmuDA=
Date: Tue, 24 Dec 2024 02:54:45 +0000
Message-ID: <58300a2a06e34f3e89bf7a097b3cd4ca@realtek.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
 <8734ijwru5.wl-tiwai@suse.de>
 <57883f2e-49cd-4aa4-9879-7dcdf7fec6df@gmail.com>
 <87ldw89l7e.wl-tiwai@suse.de>
 <fc506097-9d04-442c-9efd-c9e7ce0f3ace@gmail.com>
In-Reply-To: <fc506097-9d04-442c-9efd-c9e7ce0f3ace@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
Content-Type: multipart/mixed;
	boundary="_002_58300a2a06e34f3e89bf7a097b3cd4carealtekcom_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_58300a2a06e34f3e89bf7a097b3cd4carealtekcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpQbGVhc2UgdGVzdCBhdHRhY2ggcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogRXZnZW55IEthcHVuIDxhYmFjYWJhZGFiYWNhYmFAZ21haWwuY29tPg0KPiBT
ZW50OiBNb25kYXksIERlY2VtYmVyIDIzLCAyMDI0IDk6MjkgUE0NCj4gVG86IFRha2FzaGkgSXdh
aSA8dGl3YWlAc3VzZS5kZT4NCj4gQ2M6IExpbnV4IFNvdW5kIE1haWxpbmcgTGlzdCA8bGludXgt
c291bmRAdmdlci5rZXJuZWwub3JnPjsgS2FpbGFuZw0KPiA8a2FpbGFuZ0ByZWFsdGVrLmNvbT47
IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBMaW51eCBSZWdyZXNzaW9ucyBNYWlsaW5nIExpc3QNCj4gPHJlZ3Jlc3Npb25zQGxpc3Rz
LmxpbnV4LmRldj47IExpbnV4IFN0YWJsZSBNYWlsaW5nIExpc3QNCj4gPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUkVHUkVTU0lPTl0gRGlzdG9ydGVkIHNvdW5kIG9u
IEFjZXIgQXNwaXJlIEExMTUtMzEgbGFwdG9wDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4g
DQo+IA0KPiANCj4gPj4gT3IgZG8geW91IG5lZWQgYWxzYS1pbmZvIHdpdGggYSBuZXcga2VybmVs
LCBidXQgd2l0aCB0aGUgb2ZmZW5kaW5nDQo+ID4+IGNvbW1pdCByZXZlcnRlZD8NCj4gPiBZZXMs
IHRoYXQnbGwgYmUgdGhlIGJlc3QgZm9yIGVsaW1pbmF0aW5nIG90aGVyIHBvc3NpYmxlIGFydGlm
YWN0cy4NCj4gDQo+IEhlcmUgYXJlIHR3byBhbHNhLWluZm8gb3V0cHV0cyBmb3IgdGhlIHNhbWUg
a2VybmVsIHZlcnNpb24sIGV4Y2VwdCB0aGF0IG9uZSBoYXMNCj4gdGhlIHByb2JsZW1hdGljIGNv
bW1pdCByZXZlcnRlZC4NCg==

--_002_58300a2a06e34f3e89bf7a097b3cd4carealtekcom_
Content-Type: application/octet-stream; name="0000-acer-a115.patch"
Content-Description: 0000-acer-a115.patch
Content-Disposition: attachment; filename="0000-acer-a115.patch"; size=904;
	creation-date="Tue, 24 Dec 2024 02:52:43 GMT";
	modification-date="Tue, 24 Dec 2024 02:51:38 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggNjFiYTVkYzM1YjhiLi4yOTM0Nzk5YjZlMDcgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCkBAIC0xMDE1OCw2ICsxMDE1OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgaGRhX3F1aXJrIGFsYzI2OV9maXh1cF90YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTAy
NSwgMHgxMzA4LCAiQWNlciBBc3BpcmUgWjI0LTg5MCIsIEFMQzI4Nl9GSVhVUF9BQ0VSX0FJT19I
RUFEU0VUX01JQyksCiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MTMyYSwgIkFjZXIgVHJhdmVs
TWF0ZSBCMTE0LTIxIiwgQUxDMjMzX0ZJWFVQX0FDRVJfSEVBRFNFVF9NSUMpLAogCVNORF9QQ0lf
UVVJUksoMHgxMDI1LCAweDEzMzAsICJBY2VyIFRyYXZlbE1hdGUgWDUxNC01MVQiLCBBTEMyNTVf
RklYVVBfQUNFUl9IRUFEU0VUX01JQyksCisJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MTM2MCwg
IkFjZXIgQXNwaXJlIEExMTUiLCBBTEMyNTVfRklYVVBfQUNFUl9NSUNfTk9fUFJFU0VOQ0UpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDI1LCAweDE0MWYsICJBY2VyIFNwaW4gU1A1MTMtNTROIiwgQUxD
MjU1X0ZJWFVQX0FDRVJfTUlDX05PX1BSRVNFTkNFKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyNSwg
MHgxNDJiLCAiQWNlciBTd2lmdCBTRjMxNC00MiIsIEFMQzI1NV9GSVhVUF9BQ0VSX01JQ19OT19Q
UkVTRU5DRSksCiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MTQzMCwgIkFjZXIgVHJhdmVsTWF0
ZSBCMzExUi0zMSIsIEFMQzI1Nl9GSVhVUF9BQ0VSX01JQ19OT19QUkVTRU5DRSksCg==

--_002_58300a2a06e34f3e89bf7a097b3cd4carealtekcom_--

