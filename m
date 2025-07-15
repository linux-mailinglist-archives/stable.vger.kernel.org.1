Return-Path: <stable+bounces-161944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A31B05292
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0483B23EA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E0275118;
	Tue, 15 Jul 2025 07:16:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93416270EB0;
	Tue, 15 Jul 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563765; cv=none; b=lMLH1mpNdqS45bELoZOskWytT1+9hIU0z0Gl/eWjlecdR5yJY1q0H6rb1ljrZZbQWrmrhXw4J4ueAsU0O4rwS4mJaqOhMQsyhVA+OGrQ9xZS8C8Q2WincjVovsv8+Na/DyyPWgvnIkl4Eb50Pn1vz5oQjOW8KMFmav/kH0y1nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563765; c=relaxed/simple;
	bh=Lyytan91LGxiGOiz6/sBkllxKJCm/8j0ZtObVauBKEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5qkQyd2xRcUW7TYaQMKuUl/E5BjvQ1IH+/MKXkcGuJQjntt/OQp3tSx2Rt/kuS13bm2F8zse/p6J3mrEJ4Qt2HTIsljwl3K9eDc4OAXmm09I3SrO5Lcz1lkYJB999Nitq2NLplAaHPCtjMxgfZDQzep+qSu15f5Nv7CjYLqwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 15 Jul
 2025 09:15:52 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%6]) with mapi id
 15.01.2507.057; Tue, 15 Jul 2025 09:15:52 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Jakub Kicinski <kuba@kernel.org>
CC: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Thread-Topic: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Thread-Index: AQHb8Xe2qza52xx55UmGbnkg6Pc/lrQyK2OAgACAvYA=
Date: Tue, 15 Jul 2025 07:15:51 +0000
Message-ID: <74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
 <20250714163505.44876e62@kernel.org>
In-Reply-To: <20250714163505.44876e62@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2956B14450647564
Content-Type: text/plain; charset="utf-8"
Content-ID: <2368C8D7F7F3C84C9856F28BFA337566@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSmFrdWIsDQoNCk9uIDcvMTUvMjUgMTozNSBBTSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+
IE9uIFRodSwgMTAgSnVsIDIwMjUgMDg6NTA6NDAgKzAwMDAgSm9obiBFcm5iZXJnIHdyb3RlOg0K
Pj4gSGF2aW5nIGEgR2VtYWx0byBDaW50ZXJpb24gUExTODMtVyBtb2RlbSBhdHRhY2hlZCB0byBV
U0IgYW5kIGFjdGl2YXRpbmcgdGhlDQo+PiBjZWxsdWxhciBkYXRhIGxpbmsgd291bGQgc29tZXRp
bWVzIHlpZWxkIHRoZSBmb2xsb3dpbmcgUkNVIHN0YWxsLCBsZWFkaW5nDQo+PiB0byBhIHN5c3Rl
bSBmcmVlemU6DQo+IA0KPiBEbyB5b3Uga25vdyB3aGljaCBzdWItZHJpdmVyIGl0J3MgdXNpbmc/
DQoNClRoZSBtb2RlbSB1c2VzIGNkY19ldGhlciAoYW5kIG9wdGlvbiBmb3IgdGhlIFRUWXMpLg0K
DQo+IEknbSB3b3JyaWVkIHRoYXQgdGhpcyBpcyBzdGlsbCByYWN5Lg0KPiBTaW5jZSB1c2JuZXRf
YmggY2hlY2tzIGlmIGNhcnJpZXIgaXMgb2sgYW5kIF9faGFuZGxlX2xpbmtfY2hhbmdlKCkNCj4g
Y2hlY2tzIHRoZSBvcHBvc2l0ZSBzb21ldGhpbmcgbXVzdCBiZSBvdXQgb2Ygc3luYyBpZiBib3Ro
IHJ1bi4NCj4gTW9zdCBsaWtlbHkgc29tZXRoaW5nIHJlc3RvcmVkIHRoZSBjYXJyaWVyIHdoaWxl
IHdlJ3JlIHN0aWxsIGhhbmRsaW5nDQo+IHRoZSBwcmV2aW91cyBjYXJyaWVyIGxvc3MuDQoNClRo
ZXJlIGNvdWxkIGRlZmluaXRlbHkgYmUgb3RoZXIgZmFjdG9ycywgSSdsbCB0cnkgdG8gZGlnIHNv
bWUgaW4gDQpjZGNfZXRoZXIgYW5kIHNlZSBpZiBzb21ldGhpbmcgdGhlcmUgY291bGQgYmUgY2F1
c2luZyBwcm9ibGVtcyBmb3IgdGhlIA0KdXNibmV0IGNvcmUuDQpJIGhvbmVzdGx5IGtpbmRhIHN0
b3BwZWQgZGlnZ2luZyB3aGVuIEkgZm91bmQgdW5saW5rX3VyYnMoKSBiZWluZyANCndyYXBwZWQg
d2l0aCBhIHBhdXNlL3VucGF1c2UgYXQgYW5vdGhlciBwbGFjZSB0aWVkIHRvIGEgY29tbWl0IHNl
ZWluZyBhIA0Kc2ltaWxhciBpc3N1ZS4NCg0KVGhhbmtzISAvLyBKb2huIEVybmJlcmc=

