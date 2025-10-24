Return-Path: <stable+bounces-189219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E241C05379
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68AC5053D1
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A5307AC6;
	Fri, 24 Oct 2025 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="i3op79m3"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74519307AC4;
	Fri, 24 Oct 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296218; cv=none; b=uC54VbCKtfATDfSBNfkvpvSJBxMfWzWyrYTEzhb+MzQQ8zltS2XGc5B3SS2cZrNf4bSjCMO+fIqaMxRvD7pxmp+3d0YoDyi1okH5a1uw4+NGHG9sqKWyl67OovJsx1ldeat4OEnq9c+xRwnmxOmkIu6M/FLLN/K9EjwPIluxsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296218; c=relaxed/simple;
	bh=8MUGiBaLgC629PZoPqwQRzUuxycUZinfow4Niq33llo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDIx0wgal9U6OfWs2fmb5cf1t9rCemrbAoU7cBlPIELrJHM8mnpVyDAX0CgwdQsXVpYJUF4/+bSBgsBPKGCkjvWiPyuQ/ImcXP2KuX48qF4crYsXbG5b3QjoQMMGMSLv84mOLyTyUSusQMIiFk0ExUHiQ0Vl6VDM0yZIkjca994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=i3op79m3; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 7045B10B8170;
	Fri, 24 Oct 2025 11:56:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 7045B10B8170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1761296211; bh=8MUGiBaLgC629PZoPqwQRzUuxycUZinfow4Niq33llo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=i3op79m30YlhF21BMWOcF04//FOFjasmpLuRwuYdCSadkntAdgZ/Wh/5KzdOasooy
	 Mc+aqRdJ71OQQCuwHf7kro4KNQO55oDRkZLp0/BO3Wx1jHsHTiIASPEcM7eiN+DkJh
	 BIlk2vsoSbVAP5I02kaPuFIJWzuId8KiJqKbKf6c=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 6CB683109F02;
	Fri, 24 Oct 2025 11:56:51 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] Bluetooth: MGMT: Fix OOB access in
 parse_adv_monitor_pattern()
Thread-Topic: [PATCH net] Bluetooth: MGMT: Fix OOB access in
 parse_adv_monitor_pattern()
Thread-Index: AQHcQdQDH+4einvhvkqzls1fGNBfVLTPiQWAgAAe4ICAAAYDAIABJGoA
Date: Fri, 24 Oct 2025 08:56:50 +0000
Message-ID: <19f34b57-a7b7-41e5-8c6c-9e99d7607032@infotecs.ru>
References: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
 <CABBYNZKUNecJNPmrVFdkkOhG1A8C_32pUOdh0ZDWkCNkAugDdQ@mail.gmail.com>
 <3935eaf3-3a58-4b2d-b0ee-4c6c641b5343@infotecs.ru>
 <CABBYNZJLtTiFZ-1LchJ7Cy1JT=vuDmkkRHjrUY92jC740ihs5w@mail.gmail.com>
In-Reply-To: <CABBYNZJLtTiFZ-1LchJ7Cy1JT=vuDmkkRHjrUY92jC740ihs5w@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EDD695305789B4F89E79E3ED00B420C@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/10/24 07:22:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/24 06:56:00 #27793616
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMTAvMjMvMjUgMTg6MzAsIEx1aXogQXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+IEhpIEls
aWEsDQo+IA0KPiBPbiBUaHUsIE9jdCAyMywgMjAyNSBhdCAxMTowOOKAr0FNIElsaWEgR2F2cmls
b3YNCj4gPElsaWEuR2F2cmlsb3ZAaW5mb3RlY3MucnU+IHdyb3RlOg0KPj4NCj4+IEhpLCBMdWl6
LCB0aGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQo+Pg0KPj4gT24gMTAvMjMvMjUgMTY6MTgsIEx1
aXogQXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+Pj4gSGkgSWxpYSwNCj4+Pg0KPj4+IE9uIE1v
biwgT2N0IDIwLCAyMDI1IGF0IDExOjEy4oCvQU0gSWxpYSBHYXZyaWxvdg0KPj4+IDxJbGlhLkdh
dnJpbG92QGluZm90ZWNzLnJ1PiB3cm90ZToNCj4+Pj4NCj4+Pj4gSW4gdGhlIHBhcnNlX2Fkdl9t
b25pdG9yX3BhdHRlcm4oKSBmdW5jdGlvbiwgdGhlIHZhbHVlIG9mDQo+Pj4+IHRoZSAnbGVuZ3Ro
JyB2YXJpYWJsZSBpcyBjdXJyZW50bHkgbGltaXRlZCB0byBIQ0lfTUFYX0VYVF9BRF9MRU5HVEgo
MjUxKS4NCj4+Pj4gVGhlIHNpemUgb2YgdGhlICd2YWx1ZScgYXJyYXkgaW4gdGhlIG1nbXRfYWR2
X3BhdHRlcm4gc3RydWN0dXJlIGlzIDMxLg0KPj4+PiBJZiB0aGUgdmFsdWUgb2YgJ3BhdHRlcm5b
aV0ubGVuZ3RoJyBpcyBzZXQgaW4gdGhlIHVzZXIgc3BhY2UNCj4+Pj4gYW5kIGV4Y2VlZHMgMzEs
IHRoZSAncGF0dGVybnNbaV0udmFsdWUnIGFycmF5IGNhbiBiZSBhY2Nlc3NlZA0KPj4+PiBvdXQg
b2YgYm91bmQgd2hlbiBjb3BpZWQuDQo+Pj4+DQo+Pj4+IEluY3JlYXNpbmcgdGhlIHNpemUgb2Yg
dGhlICd2YWx1ZScgYXJyYXkgaW4NCj4+Pj4gdGhlICdtZ210X2Fkdl9wYXR0ZXJuJyBzdHJ1Y3R1
cmUgd2lsbCBicmVhayB0aGUgdXNlcnNwYWNlLg0KPj4+PiBDb25zaWRlcmluZyB0aGlzLCBhbmQg
dG8gYXZvaWQgT09CIGFjY2VzcyByZXZlcnQgdGhlIGxpbWl0cyBmb3IgJ29mZnNldCcNCj4+Pj4g
YW5kICdsZW5ndGgnIGJhY2sgdG8gdGhlIHZhbHVlIG9mIEhDSV9NQVhfQURfTEVOR1RILg0KPj4+
Pg0KPj4+PiBGb3VuZCBieSBJbmZvVGVDUyBvbiBiZWhhbGYgb2YgTGludXggVmVyaWZpY2F0aW9u
IENlbnRlcg0KPj4+PiAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCj4+Pj4NCj4+Pj4g
Rml4ZXM6IGRiMDg3MjJmYzdkNCAoIkJsdWV0b290aDogaGNpX2NvcmU6IEZpeCBtaXNzaW5nIGlu
c3RhbmNlcyB1c2luZyBIQ0lfTUFYX0FEX0xFTkdUSCIpDQo+Pj4+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IElsaWEgR2F2cmlsb3YgPElsaWEuR2F2cmls
b3ZAaW5mb3RlY3MucnU+DQo+Pj4+IC0tLQ0KPj4+PiAgaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL21n
bXQuaCB8IDIgKy0NCj4+Pj4gIG5ldC9ibHVldG9vdGgvbWdtdC5jICAgICAgICAgfCA2ICsrKy0t
LQ0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvbWdtdC5oIGIv
aW5jbHVkZS9uZXQvYmx1ZXRvb3RoL21nbXQuaA0KPj4+PiBpbmRleCA3NGVkZWEwNjk4NWIuLjRi
MDdjZTZkZmQ2OSAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL21nbXQu
aA0KPj4+PiArKysgYi9pbmNsdWRlL25ldC9ibHVldG9vdGgvbWdtdC5oDQo+Pj4+IEBAIC03ODAs
NyArNzgwLDcgQEAgc3RydWN0IG1nbXRfYWR2X3BhdHRlcm4gew0KPj4+PiAgICAgICAgIF9fdTgg
YWRfdHlwZTsNCj4+Pj4gICAgICAgICBfX3U4IG9mZnNldDsNCj4+Pj4gICAgICAgICBfX3U4IGxl
bmd0aDsNCj4+Pj4gLSAgICAgICBfX3U4IHZhbHVlWzMxXTsNCj4+Pj4gKyAgICAgICBfX3U4IHZh
bHVlW0hDSV9NQVhfQURfTEVOR1RIXTsNCj4+Pg0KPj4+IFdoeSBub3QgdXNlIEhDSV9NQVhfRVhU
X0FEX0xFTkdUSCBhYm92ZT8gT3IgcGVyaGFwcyBldmVuIG1ha2UgaXQNCj4+PiBvcGFxdWUgc2lu
Y2UgdGhlIGFjdHVhbCBzaXplIGlzIGRlZmluZWQgYnkgbGVuZ3RoIC0gb2Zmc2V0Lg0KPj4+DQo+
Pg0KPj4gQXMgSSBzZWUgaXQsIHVzZXIgcHJvZ3JhbXMgcmVseSBvbiB0aGlzIHNpemUgb2YgdGhl
IHN0cnVjdHVyZSwgYW5kIGlmIHRoZSBzaXplIGlzIGNoYW5nZWQsIHRoZXkgd2lsbCBiZSBicm9r
ZW4uDQo+PiBFeGNlcnB0IGZyb20gYmx1ZXogdG9vbHMgc291cmNlczoNCj4+IC4uLg0KPj4gc3Ry
dWN0dXJlIG9mIG1nbXRfYWR2X3BhdHRlcm4gew0KPj4gdWludDhfdCBhZCB0eXBlOw0KPj4gICAg
ICAgICB1aW50OF90IG9mZnNldDsNCj4+ICAgICAgICAgbGVuZ3RoIG9mIHVpbnQ4X3Q7DQo+PiAg
ICAgICAgIHVpbnQ4X3QgdmFsdWVbMzFdOw0KPj4gfSBfX3BhY2tlZDsNCj4+IC4uLg0KPiANCj4g
V2VsbCBpdCBpcyBicm9rZW4gZm9yIEVBIGFscmVhZHksIHNvIHRoZSBxdWVzdGlvbiBpcyBzaG91
bGQgd2UgbGVhdmUNCj4gaXQgdG8ganVzdCBoYW5kbGUgbGVnYWN5IGFkdmVydGlzZW1lbnQgb3Ig
bm90PyANCg0KRnJvbSBhIHNlY3VyaXR5IHBvaW50IG9mIHZpZXcsIGl0IGlzIGJldHRlciB0byBm
aXggdGhlIHByb2JsZW0gb2YgT09CIGFjY2VzcyBvZiB0aGUgJ3ZhbHVlJyBhcnJheQ0KaW4gYWxs
IGtlcm5lbHMgc3RhcnRpbmcgZnJvbSB2ZXJzaW9uIDYuNisuDQoNClRoZXJlIGFyZSB0d28gc29s
dXRpb25zOiANCjEpIFRoZSBzaW1wbGVzdCBzb2x1dGlvbi4gSW5jcmVhc2UgdGhlIHNpemUgdG8g
dGhlICd2YWx1ZScgYXJyYXkgaW4gdGhlICdtZ210X2Fkdl9wYXR0ZXJuJyBzdHJ1Y3R1cmUsDQpi
dXQgdGhpcyB0eXBlIG9mIGNvbW1hbmQgd2lsbCBub3Qgd29yazoNCg0KJGJ0bWdtdA0KJG1lbnUg
bW9uaXRvcg0KJGFkZC1wYXR0ZXJuIDE2OjA6MDEwMjAzMDQwNTA2MDcwODA5MDANCg0KMikgRG8g
YXMgc3VnZ2VzdGVkIGluIHRoaXMgcGF0Y2gNCg0KIA0KPiBBdCBzb21lIHBvaW50IEkgd2FzDQo+
IGFjdHVhbGx5IGp1c3QgY29uc2lkZXJpbmcgcmVtb3ZpbmcvZGVwcmVjYXRpbmcgdGhlIHN1cHBv
cnQgb2YgdGhpcw0KPiBjb21tYW5kIGFsdG9nZXRoZXIgc2luY2UgdGhlcmUgZXhpc3RzIGEgc3Rh
bmRhcmQgd2F5IHRvIGRvDQo+IGFkdmVydGlzZW1lbnQgbW9uaXRvcmluZyBjYWxsZWQgTW9uaXRv
cmluZyBBZHZlcnRpc2VycyBpbnRyb2R1Y2VkIGluDQo+IDYuMDoNCj4gDQo+IGh0dHBzOi8vd3d3
LmJsdWV0b290aC5jb20vY29yZS1zcGVjaWZpY2F0aW9uLTYtZmVhdHVyZS1vdmVydmlldy8/dXRt
X3NvdXJjZT1pbnRlcm5hbCZ1dG1fbWVkaXVtPWJsb2cmdXRtX2NhbXBhaWduPXRlY2huaWNhbCZ1
dG1fY29udGVudD1ub3ctYXZhaWxhYmxlLW5ldy12ZXJzaW9uLW9mLXRoZS1ibHVldG9vdGgtY29y
ZS1zcGVjaWZpY2F0aW9uDQo+IA0KDQpJdCBzZWVtcyB0byBtZSB0aGF0IGl0J3MgYmV0dGVyIHRv
IHJlbW92ZS9kZXByZWNhdGUgdGhlIHN1cHBvcnQgb2YgdGhlIGNvbW1hbmQNCmluIHRoZSBuZXh0
IHZlcnNpb24gb2YgdGhlIGtlcm5lbC4NCg0KPiBUaGUgdGhlIHN0YW5kYXJkIG1vbml0b3Jpbmcg
bGlzdCBkb2Vzbid0IHNlZW0gdG8gYmUgYWJsZSB0byBkbw0KPiBmaWx0ZXJpbmcgb24gdGhlIGRh
dGEgaXRzZWxmLCB3aGljaCBJIHRoaW5rIHRoZSB3aGVyZSB0aGUgZGVjaXNpb24NCj4gYmFzZWQg
ZmlsdGVyaW5nIHVzZWQsIHNvIGl0IGlzIG5vdCByZWFsbHkgY29tcGF0aWJsZSB3aXRoIHRoZSBN
Uw0KPiB2ZW5kb3IgY29tbWFuZHMuDQo+IA0KPj4NCj4+Pj4gIH0gX19wYWNrZWQ7DQo+Pj4+DQo+
Pj4+ICAjZGVmaW5lIE1HTVRfT1BfQUREX0FEVl9QQVRURVJOU19NT05JVE9SICAgICAgIDB4MDA1
Mg0KPj4+PiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9tZ210LmMgYi9uZXQvYmx1ZXRvb3Ro
L21nbXQuYw0KPj4+PiBpbmRleCBhM2QxNmVlY2UwZDIuLjUwMDAzM2I3MGE5NiAxMDA2NDQNCj4+
Pj4gLS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMNCj4+Pj4gKysrIGIvbmV0L2JsdWV0b290aC9t
Z210LmMNCj4+Pj4gQEAgLTUzOTEsOSArNTM5MSw5IEBAIHN0YXRpYyB1OCBwYXJzZV9hZHZfbW9u
aXRvcl9wYXR0ZXJuKHN0cnVjdCBhZHZfbW9uaXRvciAqbSwgdTggcGF0dGVybl9jb3VudCwNCj4+
Pj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGF0dGVybl9jb3VudDsgaSsrKSB7DQo+Pj4+ICAg
ICAgICAgICAgICAgICBvZmZzZXQgPSBwYXR0ZXJuc1tpXS5vZmZzZXQ7DQo+Pj4+ICAgICAgICAg
ICAgICAgICBsZW5ndGggPSBwYXR0ZXJuc1tpXS5sZW5ndGg7DQo+Pj4+IC0gICAgICAgICAgICAg
ICBpZiAob2Zmc2V0ID49IEhDSV9NQVhfRVhUX0FEX0xFTkdUSCB8fA0KPj4+PiAtICAgICAgICAg
ICAgICAgICAgIGxlbmd0aCA+IEhDSV9NQVhfRVhUX0FEX0xFTkdUSCB8fA0KPj4+PiAtICAgICAg
ICAgICAgICAgICAgIChvZmZzZXQgKyBsZW5ndGgpID4gSENJX01BWF9FWFRfQURfTEVOR1RIKQ0K
Pj4+PiArICAgICAgICAgICAgICAgaWYgKG9mZnNldCA+PSBIQ0lfTUFYX0FEX0xFTkdUSCB8fA0K
Pj4+PiArICAgICAgICAgICAgICAgICAgIGxlbmd0aCA+IEhDSV9NQVhfQURfTEVOR1RIIHx8DQo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgKG9mZnNldCArIGxlbmd0aCkgPiBIQ0lfTUFYX0FEX0xF
TkdUSCkNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE1HTVRfU1RBVFVTX0lO
VkFMSURfUEFSQU1TOw0KPj4+Pg0KPj4+PiAgICAgICAgICAgICAgICAgcCA9IGttYWxsb2Moc2l6
ZW9mKCpwKSwgR0ZQX0tFUk5FTCk7DQo+Pj4+IC0tDQo+Pj4+IDIuMzkuNQ0KPj4+DQo+Pj4NCj4+
Pg0KPj4NCj4gDQo+IA0KDQo=

