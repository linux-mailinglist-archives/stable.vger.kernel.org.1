Return-Path: <stable+bounces-6445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908580EBBA
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 13:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69AB1F2134B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7175EE8B;
	Tue, 12 Dec 2023 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="Nk//3Rzg"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8FF2;
	Tue, 12 Dec 2023 04:25:42 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 7374D13ED234;
	Tue, 12 Dec 2023 15:25:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 7374D13ED234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1702383940; bh=83CzuIVbhaIyLEUA88mWIgWaPi/eOQgcDFoTRZ8bsTE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Nk//3RzgxKaWFY1/xy7L/3KYKBlw+k92T78ArohxKkDEX+K5KllfWnzwfAp+KbTFP
	 82Bk6uaQ97Awt0ybm42K75XDvxrA6Euj6cEYS8dmiS8mm2DY6zRppRXJGmNXz2RCoQ
	 VDt9YjGec1jxCBAH2GKYyO44d5omG8gVtAQfDOSQ=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 710553177CA6;
	Tue, 12 Dec 2023 15:25:40 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Daniel Starke
	<daniel.starke@siemens.com>, Jiri Slaby <jirislaby@kernel.org>, Russ Gorby
	<russ.gorby@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Topic: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Index: AQHaLPZRrftlSiHR9Eacwd+dnfCWVg==
Date: Tue, 12 Dec 2023 12:25:40 +0000
Message-ID: <4e524540-3e2c-4f27-afda-1f42465ecf18@infotecs.ru>
References: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
 <2023121232-magenta-recall-2cec@gregkh>
In-Reply-To: <2023121232-magenta-recall-2cec@gregkh>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD55A63B7A44224E8D57A3E2F9CABEAB@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/12 10:17:00 #22666118
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMTIvMTIvMjMgMTQ6NDQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gVHVlLCBE
ZWMgMTIsIDIwMjMgYXQgMTE6MTc6MjFBTSArMDAwMCwgR2F2cmlsb3YgSWxpYSB3cm90ZToNCj4+
IFN5emthbGxlciByZXBvcnRzIG1lbW9yeSBsZWFrIGlzc3VlIGF0IGdzbWxkX2F0dGFjaF9nc20o
KSBpbg0KPj4gNS4xMCBzdGFibGUgcmVsZWFzZXMuIFRoZSByZXByb2R1Y2VyIGluamVjdHMgdGhl
IG1lbW9yeSBhbGxvY2F0aW9uDQo+PiBlcnJvcnMgdG8gdHR5X3JlZ2lzdGVyX2RldmljZSgpOyBh
cyBhIHJlc3VsdCwgdHR5X2tyZWZfZ2V0KCkgaXNuJ3QgY2FsbGVkDQo+PiBhZnRlciB0aGlzIGVy
cm9yLCB3aGljaCBsZWFkcyB0byB0dHlfc3RydWN0IGxlYWsuDQo+PiBUaGUgaXNzdWUgaGFzIGJl
ZW4gZml4ZWQgYnkgdGhlIGZvbGxvd2luZyBwYXRjaGVzIHRoYXQgY2FuIGJlIGNsZWFubHkNCj4+
IGFwcGxpZWQgdG8gdGhlIDUuMTAgYnJhbmNoLg0KPj4NCj4+IEZvdW5kIGJ5IEluZm9UZUNTIG9u
IGJlaGFsZiBvZiBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyDQo+PiAobGludXh0ZXN0aW5nLm9y
Zykgd2l0aCBTeXprYWxsZXINCj4gDQo+IERvIHlvdSBhY3R1YWxseSBoYXZlIGFueSBoYXJkd2Fy
ZSBmb3IgdGhpcyBwcm90b2NvbCBydW5uaW5nIG9uIHRoZQ0KPiA1LjEwLnkga2VybmVsPyAgSG93
IHdhcyB0aGlzIHRlc3RlZD8gIFdoeSB3YXMganVzdCB0aGlzIHNwZWNpZmljIHNldCBvZg0KPiBw
YXRjaGVzIHBpY2tlZCB0byBiZSBiYWNrcG9ydGVkPw0KPiANCg0KTm8sIEkgZG9uJ3QgaGF2ZSBh
bnkgaGFyZHdhcmUgZm9yIHRoaXMgcHJvdG9jb2wuIEkgdGVzdGVkIHRoaXMgbWFudWFsbHkgDQpv
biB2aXJ0dWFsIG1hY2hpbmVzIGFuZCB1c2luZyBhIHJlcHJvZHVjZXIgKGdlbmVyYXRlZCBieSBz
eXprYWxsZXIpLg0KVGhlIGZpcnN0IHBhdGNoIGZpeGVzIHRoZSBtYWluIHByb2JsZW0obWVtb3J5
IGxlYWspLiBUaGUgdGhpcmQgcGF0Y2ggDQpmaXhlcyB0aGUgcHJvYmxlbSB3aXRoINCwIG51bGwg
cG9pbnRlciBkZXJlZmVyZW5jZS4gSSBhZGRlZCB0aGlzIHBhdGNoIA0KYmVjYXVzZSBpdCBoYXMg
YSAiZml4ZXMiIHRhZyB0aGF0IHJlZmVyZW5jZXMgdG8gdGhlIGZpcnN0IHBhdGNoLiBUaGUgDQp0
aGlyZCBwYXRjaCBjYW4ndCBiZSBhcHBsaWVkIGNsZWFubHkgd2l0aG91dCB0aGUgc2Vjb25kIHBh
dGNoLg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

