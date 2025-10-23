Return-Path: <stable+bounces-189141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A24C020A0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF1E856296E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542283314C3;
	Thu, 23 Oct 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="gusB6v8n"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612430C345;
	Thu, 23 Oct 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232137; cv=none; b=feZa34SKEQmSRANvl1uVFbVMZG8u1SANFOL+3FhW5P/ppd+v3/ZtAJDk0jYBg1bMEIol/DnUNwVsPQC7MbuDXrwAN7fQ4n8CfR+2m4fxx/v2WpME/NcHNY0YkodyXRvu1ZPkwNskgJVa5Y1yXjETJddVXaJQ72ARNxXsg0q+oWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232137; c=relaxed/simple;
	bh=IaS3sVzbOjfycQYMbx5rtAzNnT1VcRiBekM5Z7Cz508=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rg57/GckwXk92q/vNnFgyxkODHSsspnVtDvnjHNu3VkDEOwMhClmUzPeCCwTQcnA0qjvOWP670Dqc2yIanjzoFbLu0XRUnJxbvvgRwtOBC5QeOxTfjdABwpVStvPzydzMxAoU7ibwmUBWFgDtfWvjPYiEKF80479LzSeGGyTrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=gusB6v8n; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 01F1410C780C;
	Thu, 23 Oct 2025 18:08:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 01F1410C780C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1761232124; bh=IaS3sVzbOjfycQYMbx5rtAzNnT1VcRiBekM5Z7Cz508=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gusB6v8nMWwMFsxnDJYCQKRZdpA0AZdGvo8NePwf/1vc3P5pesv+vrxTbyY9PK4eM
	 WaRMf2LwI4lWPeTs971ng21VEjRXj9D2kNBVBJlpdxxDxr8bg9lzops9HbZLiCx8L/
	 ytAIzpFuGWfE3hMrDJ2DEwgzIulpfISCyPzMHlk4=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id F31E530DB794;
	Thu, 23 Oct 2025 18:08:43 +0300 (MSK)
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
Thread-Index: AQHcQdQDH+4einvhvkqzls1fGNBfVLTPiQWAgAAe4IA=
Date: Thu, 23 Oct 2025 15:08:43 +0000
Message-ID: <3935eaf3-3a58-4b2d-b0ee-4c6c641b5343@infotecs.ru>
References: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
 <CABBYNZKUNecJNPmrVFdkkOhG1A8C_32pUOdh0ZDWkCNkAugDdQ@mail.gmail.com>
In-Reply-To: <CABBYNZKUNecJNPmrVFdkkOhG1A8C_32pUOdh0ZDWkCNkAugDdQ@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F9C7C04FF76C4581F2E42AFFB108B8@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/10/23 14:22:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/23 13:21:00 #27792304
X-KLMS-AntiVirus-Status: Clean, skipped

SGksIEx1aXosIHRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KT24gMTAvMjMvMjUgMTY6MTgs
IEx1aXogQXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+IEhpIElsaWEsDQo+IA0KPiBPbiBNb24s
IE9jdCAyMCwgMjAyNSBhdCAxMToxMuKAr0FNIElsaWEgR2F2cmlsb3YNCj4gPElsaWEuR2F2cmls
b3ZAaW5mb3RlY3MucnU+IHdyb3RlOg0KPj4NCj4+IEluIHRoZSBwYXJzZV9hZHZfbW9uaXRvcl9w
YXR0ZXJuKCkgZnVuY3Rpb24sIHRoZSB2YWx1ZSBvZg0KPj4gdGhlICdsZW5ndGgnIHZhcmlhYmxl
IGlzIGN1cnJlbnRseSBsaW1pdGVkIHRvIEhDSV9NQVhfRVhUX0FEX0xFTkdUSCgyNTEpLg0KPj4g
VGhlIHNpemUgb2YgdGhlICd2YWx1ZScgYXJyYXkgaW4gdGhlIG1nbXRfYWR2X3BhdHRlcm4gc3Ry
dWN0dXJlIGlzIDMxLg0KPj4gSWYgdGhlIHZhbHVlIG9mICdwYXR0ZXJuW2ldLmxlbmd0aCcgaXMg
c2V0IGluIHRoZSB1c2VyIHNwYWNlDQo+PiBhbmQgZXhjZWVkcyAzMSwgdGhlICdwYXR0ZXJuc1tp
XS52YWx1ZScgYXJyYXkgY2FuIGJlIGFjY2Vzc2VkDQo+PiBvdXQgb2YgYm91bmQgd2hlbiBjb3Bp
ZWQuDQo+Pg0KPj4gSW5jcmVhc2luZyB0aGUgc2l6ZSBvZiB0aGUgJ3ZhbHVlJyBhcnJheSBpbg0K
Pj4gdGhlICdtZ210X2Fkdl9wYXR0ZXJuJyBzdHJ1Y3R1cmUgd2lsbCBicmVhayB0aGUgdXNlcnNw
YWNlLg0KPj4gQ29uc2lkZXJpbmcgdGhpcywgYW5kIHRvIGF2b2lkIE9PQiBhY2Nlc3MgcmV2ZXJ0
IHRoZSBsaW1pdHMgZm9yICdvZmZzZXQnDQo+PiBhbmQgJ2xlbmd0aCcgYmFjayB0byB0aGUgdmFs
dWUgb2YgSENJX01BWF9BRF9MRU5HVEguDQo+Pg0KPj4gRm91bmQgYnkgSW5mb1RlQ1Mgb24gYmVo
YWxmIG9mIExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXINCj4+IChsaW51eHRlc3Rpbmcub3JnKSB3
aXRoIFNWQUNFLg0KPj4NCj4+IEZpeGVzOiBkYjA4NzIyZmM3ZDQgKCJCbHVldG9vdGg6IGhjaV9j
b3JlOiBGaXggbWlzc2luZyBpbnN0YW5jZXMgdXNpbmcgSENJX01BWF9BRF9MRU5HVEgiKQ0KPj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IElsaWEgR2F2cmls
b3YgPElsaWEuR2F2cmlsb3ZAaW5mb3RlY3MucnU+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL25ldC9i
bHVldG9vdGgvbWdtdC5oIHwgMiArLQ0KPj4gIG5ldC9ibHVldG9vdGgvbWdtdC5jICAgICAgICAg
fCA2ICsrKy0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvbWdtdC5o
IGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL21nbXQuaA0KPj4gaW5kZXggNzRlZGVhMDY5ODViLi40
YjA3Y2U2ZGZkNjkgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvbWdtdC5o
DQo+PiArKysgYi9pbmNsdWRlL25ldC9ibHVldG9vdGgvbWdtdC5oDQo+PiBAQCAtNzgwLDcgKzc4
MCw3IEBAIHN0cnVjdCBtZ210X2Fkdl9wYXR0ZXJuIHsNCj4+ICAgICAgICAgX191OCBhZF90eXBl
Ow0KPj4gICAgICAgICBfX3U4IG9mZnNldDsNCj4+ICAgICAgICAgX191OCBsZW5ndGg7DQo+PiAt
ICAgICAgIF9fdTggdmFsdWVbMzFdOw0KPj4gKyAgICAgICBfX3U4IHZhbHVlW0hDSV9NQVhfQURf
TEVOR1RIXTsNCj4gDQo+IFdoeSBub3QgdXNlIEhDSV9NQVhfRVhUX0FEX0xFTkdUSCBhYm92ZT8g
T3IgcGVyaGFwcyBldmVuIG1ha2UgaXQNCj4gb3BhcXVlIHNpbmNlIHRoZSBhY3R1YWwgc2l6ZSBp
cyBkZWZpbmVkIGJ5IGxlbmd0aCAtIG9mZnNldC4NCj4gDQoNCkFzIEkgc2VlIGl0LCB1c2VyIHBy
b2dyYW1zIHJlbHkgb24gdGhpcyBzaXplIG9mIHRoZSBzdHJ1Y3R1cmUsIGFuZCBpZiB0aGUgc2l6
ZSBpcyBjaGFuZ2VkLCB0aGV5IHdpbGwgYmUgYnJva2VuLg0KRXhjZXJwdCBmcm9tIGJsdWV6IHRv
b2xzIHNvdXJjZXM6DQouLi4NCnN0cnVjdHVyZSBvZiBtZ210X2Fkdl9wYXR0ZXJuIHsNCnVpbnQ4
X3QgYWQgdHlwZTsNCgl1aW50OF90IG9mZnNldDsNCglsZW5ndGggb2YgdWludDhfdDsNCgl1aW50
OF90IHZhbHVlWzMxXTsNCn0gX19wYWNrZWQ7DQouLi4NCg0KDQo+PiAgfSBfX3BhY2tlZDsNCj4+
DQo+PiAgI2RlZmluZSBNR01UX09QX0FERF9BRFZfUEFUVEVSTlNfTU9OSVRPUiAgICAgICAweDAw
NTINCj4+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL21nbXQuYyBiL25ldC9ibHVldG9vdGgv
bWdtdC5jDQo+PiBpbmRleCBhM2QxNmVlY2UwZDIuLjUwMDAzM2I3MGE5NiAxMDA2NDQNCj4+IC0t
LSBhL25ldC9ibHVldG9vdGgvbWdtdC5jDQo+PiArKysgYi9uZXQvYmx1ZXRvb3RoL21nbXQuYw0K
Pj4gQEAgLTUzOTEsOSArNTM5MSw5IEBAIHN0YXRpYyB1OCBwYXJzZV9hZHZfbW9uaXRvcl9wYXR0
ZXJuKHN0cnVjdCBhZHZfbW9uaXRvciAqbSwgdTggcGF0dGVybl9jb3VudCwNCj4+ICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IHBhdHRlcm5fY291bnQ7IGkrKykgew0KPj4gICAgICAgICAgICAgICAg
IG9mZnNldCA9IHBhdHRlcm5zW2ldLm9mZnNldDsNCj4+ICAgICAgICAgICAgICAgICBsZW5ndGgg
PSBwYXR0ZXJuc1tpXS5sZW5ndGg7DQo+PiAtICAgICAgICAgICAgICAgaWYgKG9mZnNldCA+PSBI
Q0lfTUFYX0VYVF9BRF9MRU5HVEggfHwNCj4+IC0gICAgICAgICAgICAgICAgICAgbGVuZ3RoID4g
SENJX01BWF9FWFRfQURfTEVOR1RIIHx8DQo+PiAtICAgICAgICAgICAgICAgICAgIChvZmZzZXQg
KyBsZW5ndGgpID4gSENJX01BWF9FWFRfQURfTEVOR1RIKQ0KPj4gKyAgICAgICAgICAgICAgIGlm
IChvZmZzZXQgPj0gSENJX01BWF9BRF9MRU5HVEggfHwNCj4+ICsgICAgICAgICAgICAgICAgICAg
bGVuZ3RoID4gSENJX01BWF9BRF9MRU5HVEggfHwNCj4+ICsgICAgICAgICAgICAgICAgICAgKG9m
ZnNldCArIGxlbmd0aCkgPiBIQ0lfTUFYX0FEX0xFTkdUSCkNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBNR01UX1NUQVRVU19JTlZBTElEX1BBUkFNUzsNCj4+DQo+PiAgICAgICAg
ICAgICAgICAgcCA9IGttYWxsb2Moc2l6ZW9mKCpwKSwgR0ZQX0tFUk5FTCk7DQo+PiAtLQ0KPj4g
Mi4zOS41DQo+IA0KPiANCj4gDQoNCg==

