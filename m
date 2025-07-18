Return-Path: <stable+bounces-163344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D99AB09EAB
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 11:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099323BE5CF
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434212951CA;
	Fri, 18 Jul 2025 09:07:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948E20E71D;
	Fri, 18 Jul 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829660; cv=none; b=QF4Dl9CD3E7DgoY4ijfQFTppstFhQcbl9gC+rDR2k1pBHTJaCYDy9GKqUTwFO4XIObf0m8DB67z3EbNz6y6AKpPrKWxQa2phKpxtFgi/PQrbfwyjrbltM85+beXTEvrG3V2Jf09TJXkSkSTdmr0s2miMW+014gnm5U/tYDmTEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829660; c=relaxed/simple;
	bh=YQLwoyyIeAKIJtTp3X9MJofesezWV6RQD6/ZBkdPkkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u9rH4BI4YKf01CxBdKKKefWcl3HhtSRob6eAOphBzRTQvCtWFZRcHs1zHgNy+6EnbxAotSmEO1Fq0lanovaM7YqhzIGdIvewljrzvaEVzRi3jiEp2Jfn2cP4j6aACOX/XsXNMlizcgCqP/l/5p+rxeuet9SzCQUS1RpgMuIbYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 18 Jul
 2025 11:07:26 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%6]) with mapi id
 15.01.2507.057; Fri, 18 Jul 2025 11:07:26 +0200
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
Thread-Index: AQHb8Xe2qza52xx55UmGbnkg6Pc/lrQyK2OAgACAvYCAAG9BgIABo0uAgABxOICAAlJmgA==
Date: Fri, 18 Jul 2025 09:07:26 +0000
Message-ID: <55147f36-822b-4026-a091-33b909d1eea8@actia.se>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
 <20250714163505.44876e62@kernel.org>
 <74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
 <20250715065403.641e4bd7@kernel.org>
 <fbd03180-cca0-4a0f-8fd9-4daf5ff28ff5@actia.se>
 <20250716143959.683df283@kernel.org>
In-Reply-To: <20250716143959.683df283@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B14450647162
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB2E981C6FEE5142B25F14FA1DDD663E@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSmFrdWIsDQoNCk9uIDcvMTYvMjUgMTE6MzkgUE0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBPbiBXZWQsIDE2IEp1bCAyMDI1IDE0OjU0OjQ2ICswMDAwIEpvaG4gRXJuYmVyZyB3cm90ZToN
Cj4+IEkgZW5kZWQgdXAgd2l0aCB0aGUgZm9sbG93aW5nIGxvZzoNCj4+DQo+PiBbICAgMjMuODIz
Mjg5XSBjZGNfZXRoZXIgMS0xLjE6MS44IHd3YW4wOiBuZXR3b3JrIGNvbm5lY3Rpb24gMA0KPj4g
WyAgIDIzLjgzMDg3NF0gY2RjX2V0aGVyIDEtMS4xOjEuOCB3d2FuMDogdW5saW5rIHVyYiBzdGFy
dDogNSBkZXZmbGFncz0xODgwDQo+PiBbICAgMjMuODQwMTQ4XSBjZGNfZXRoZXIgMS0xLjE6MS44
IHd3YW4wOiB1bmxpbmsgdXJiIGNvdW50ZWQgNQ0KPj4gWyAgIDI1LjM1Njc0MV0gY2RjX2V0aGVy
IDEtMS4xOjEuOCB3d2FuMDogbmV0d29yayBjb25uZWN0aW9uIDENCj4+IFsgICAyNS4zNjQ3NDVd
IGNkY19ldGhlciAxLTEuMToxLjggd3dhbjA6IG5ldHdvcmsgY29ubmVjdGlvbiAwDQo+PiBbICAg
MjUuMzcxMTA2XSBjZGNfZXRoZXIgMS0xLjE6MS44IHd3YW4wOiB1bmxpbmsgdXJiIHN0YXJ0OiA1
IGRldmZsYWdzPTg4MA0KPj4gWyAgIDI1LjM3ODcxMF0gY2RjX2V0aGVyIDEtMS4xOjEuOCB3d2Fu
MDogbmV0d29yayBjb25uZWN0aW9uIDENCj4+IFsgICA1MS40MjI3NTddIHJjdTogSU5GTzogcmN1
X3NjaGVkIHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gQ1BVDQo+PiBbICAgNTEuNDI5MDgxXSByY3U6
ICAgICAwLS4uLi46ICg2NDk5IHRpY2tzIHRoaXMgR1ApDQo+PiBpZGxlPWRhN2MvMS8weDQwMDAw
MDAwMDAwMDAwMDAgc29mdGlycT0yMDY3LzIwNjcgZnFzPTI2NjgNCj4+IFsgICA1MS40Mzk3MTdd
IHJjdTogICAgICAgICAgICAgIGhhcmRpcnFzICAgc29mdGlycXMgICBjc3cvc3lzdGVtDQo+PiBb
ICAgNTEuNDQ1ODk3XSByY3U6ICAgICAgbnVtYmVyOiAgICA2MjA5NiAgICAgIDU5MDE3ICAgICAg
ICAgICAgMA0KPj4gWyAgIDUxLjQ1MjEwN10gcmN1OiAgICAgY3B1dGltZTogICAgICAgIDAgICAg
ICAxMTM5NyAgICAgICAgIDE0NzAgICA9PT4NCj4+IDEyOTk2KG1zKQ0KPj4gWyAgIDUxLjQ1OTg1
Ml0gcmN1OiAgICAgKHQ9NjUwMCBqaWZmaWVzIGc9MjM5NyBxPTY2MyBuY3B1cz0yKQ0KPj4NCj4+
ICAgRnJvbSBhIFVTQiBjYXB0dXJlIHdoZXJlIHRoZSBzdGFsbCBkaWRuJ3QgaGFwcGVuIEkgY2Fu
IHNlZToNCj4+ICogQSBidW5jaCBvZiBDRENfTkVUV09SS19DT05ORUNUSU9OIGV2ZW50cyB3aXRo
IERpc2Nvbm5lY3RlZCBzdGF0ZSAoMCkuDQo+PiAqIFRoZW4gYSBDRENfTkVUV09SS19DT05ORUNU
SU9OIGV2ZW50IHdpdGggQ29ubmVjdGVkIHN0YXRlICgxKSBvbmNlIHRoZQ0KPj4gV1dBTiBpbnRl
cmZhY2UgaXMgdHVybmVkIG9uIGJ5IHRoZSBtb2RlbS4NCj4+ICogRm9sbG93ZWQgYnkgYSBEaXNj
b25uZWN0ZWQgaW4gdGhlIG5leHQgVVNCIElOVFIgcG9sbC4NCj4+ICogRm9sbG93ZWQgYnkgYSBD
b25uZWN0ZWQgaW4gdGhlIG5leHQgVVNCIElOVFIgcG9sbC4NCj4+IChJJ20gbm90IHN1cmUgaWYg
SSBjYW4gYWNoaWV2ZSBhIGRpZmZlcmVudCB0aW1pbmcgd2l0aCBlbm91Z2ggY2FwdHVyZXMNCj4+
IG9yIGEgZmFzdGVyIHN5c3RlbSkNCj4+DQo+PiBXaGljaCBtYWtlcyB0aGUgb2ZmIGFuZCBvbiBM
SU5LX0NIQU5HRSBldmVudHMgcmFjZSBvbiBvdXIgc3lzdGVtIChBUk02NA0KPj4gYmFzZWQsIGlN
WDhRWFApIGFzIHRoZXkgY2Fubm90IGJlIGhhbmRsZWQgZmFzdCBlbm91Z2guIE5vdGhpbmcgc3Rv
cHMNCj4+IHVzYm5ldF9saW5rX2NoYW5nZSgpIGZyb20gYmVpbmcgY2FsbGVkIHdoaWxlIHRoZSBk
ZWZlcnJlZCB3b3JrIGlzIHJ1bm5pbmcuDQo+Pg0KPj4gQXMgT2xpdmVyIHBvaW50cyBvdXQgdXNi
bmV0X3Jlc3VtZV9yeCgpIGNhdXNlcyBzY2hlZHVsaW5nIHdoaWNoIHNlZW1zDQo+PiB1bm5lY2Vz
c2FyeSBvciBtYXliZSBldmVuIGluYXBwcm9wcmlhdGUgZm9yIGFsbCBjYXNlcyBleGNlcHQgd2hl
biB0aGUNCj4+IGNhcnJpZXIgd2FzIHR1cm5lZCBvbiBkdXJpbmcgdGhlIHJhY2UuDQo+Pg0KPj4g
SSBnYXZlIHRoZSBaVEUgbW9kZW0gcXVpcmsgYSBnbyBhbnl3YXksIGRlc3BpdGUgdGhlIGNvbW1l
bnQgZXhwbGFpbmluZyBhDQo+PiBkaWZmZXJlbnQgc2l0dWF0aW9uIHRoYW4gd2hhdCBJIGFtIHNl
ZWluZywgYW5kIGl0IGhhcyBubyBvYnNlcnZhYmxlDQo+PiBlZmZlY3Qgb24gdGhpcyBSQ1Ugc3Rh
bGwuDQo+Pg0KPj4gQ3VycmVudGx5IGRyYXdpbmcgYSBibGFuayBvbiB3aGF0IHRoZSBjb3JyZWN0
IGZpeCB3b3VsZCBiZS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGFuYWx5c2lzLCBJIHRoaW5rIEkg
bWF5IGhhdmUgbWlzcmVhZCB0aGUgY29kZS4NCj4gV2hhdCBJIHdhcyBzYXlpbmcgaXMgdGhhdCB3
ZSBhcmUgcmVzdG9yaW5nIHRoZSBjYXJyaWVyIHdoaWxlDQo+IHdlIGFyZSBzdGlsbCBwcm9jZXNz
aW5nIHRoZSBwcmV2aW91cyBjYXJyaWVyIG9mZiBldmVudCBpbg0KPiB0aGUgd29ya3F1ZXVlLiBN
eSB0aGlua2luZyB3YXMgdGhhdCBpZiB3ZSBkZWZlcnJlZCB0aGUNCj4gbmV0aWZfY2Fycmllcl9v
bigpIHRvIHRoZSB3b3JrcXVldWUgdGhpcyByYWNlIGNvdWxkbid0IGhhcHBlbi4NCj4gDQo+IHVz
Ym5ldF9iaCgpIGFscmVhZHkgY2hlY2tzIG5ldGlmX2NhcnJpZXJfb2soKSAtIHdlJ3JlIGtpbmRh
IGR1cGxpY2F0aW5nDQo+IHRoZSBjYXJyaWVyIHN0YXRlIHdpdGggdGhpcyBSWF9QQVVTRUQgd29y
a2Fyb3VuZC4NCj4gDQo+IEkgZG9uJ3QgZmVlbCBzdHJvbmdseSBhYm91dCB0aGlzLCBidXQgZGVm
ZXJyaW5nIHRoZSBjYXJyaWVyX29uKCkNCj4gdGhlIHRoZSB3b3JrcXVldWUgd291bGQgYmUgYSBj
bGVhbmVyIHNvbHV0aW9uIElNTy4NCj4gDQoNCkkndmUgYmVlbiB0aGlua2luZyBhYm91dCB0aGlz
IGlkZWEsIGJ1dCBJJ20gY29uY2VybmVkIGZvciB0aGUgb3Bwb3NpdGUgDQpkaXJlY3Rpb24uIEkg
Y2Fubm90IHRoaW5rIG9mIGEgd2F5IHRvIGZ1bGx5IGd1YXJhbnRlZSB0aGF0IHRoZSBjYXJyaWVy
IA0KaXNuJ3QgdHVybmVkIG9uIGFnYWluIGluY29ycmVjdGx5IGlmIGFuIG9mZiBnZXRzIHF1ZXVl
ZC4NCg0KVGhlIG1vc3QgSSBjYW1lIHVwIHdpdGggd2FzIGFkZGluZyBhbiBleHRyYSBmbGFnIGJp
dCB0byBzZXQgY2FycmllciBvbiwgDQphbmQgdGhlbiB0ZXN0X2FuZF9jbGVhcl9iaXQoKSBpdCBp
biB0aGUgX19oYW5kbGVfbGlua19jaGFuZ2UoKSBmdW5jdGlvbi4NCkFuZCBhbHNvIGNsZWFyX2Jp
dCgpIGluIHRoZSB1c2JuZXRfbGlua19jaGFuZ2UoKSBmdW5jdGlvbiBpZiBhbiBvZmYgDQphcnJp
dmVzLiBJIGNhbm5vdCBjb252aW5jZSBteXNlbGYgdGhhdCB0aGVyZSBpc24ndCBhIHdheSBmb3Ig
dGhhdCB0byBnbyANCnNpZGV3YXlzLiBCdXQgcGVyaGFwcyB0aGF0IHdvdWxkIGJlIHJvYnVzdCBl
bm91Z2g/DQoNCkkndmUgYWxzbyBjb25zaWRlcmVkIHRoZSBwb3NzaWJpbGl0eSBvZiBqdXN0IG5v
dCByZS1zdWJtaXR0aW5nIHRoZSBJTlRSIA0KcG9sbCBVUkIgdW50aWwgdGhlIGxhc3Qgb25lIHdh
cyBmdWxseSBwcm9jZXNzZWQgd2hlbiBoYW5kbGluZyBhIGxpbmsgDQpjaGFuZ2UuIEJ1dCB0aGF0
IG1pZ2h0IGNhdXNlIGhhdm9jIHdpdGggQVNJWCBhbmQgU2llcnJhIGRldmljZXMgYXMgdGhleSAN
CmFyZSBjYWxsaW5nIHVzYm5ldF9saW5rX2NoYW5nZSgpIGluIG90aGVyIHdheXMgdGhhbiB0aHJv
dWdoIHRoZSANCi5zdGF0dXMtY2FsbGJhY2suIEkgZG9uJ3QgaGF2ZSBhbnkgb2YgdGhlc2UgZGV2
aWNlcyBzbyBJIGNhbm5vdCB0ZXN0IA0KdGhlbSBmb3IgcmVncmVzc2lvbnMuIFNvIHRoaXMgcGF0
aCBmZWVscyBxdWl0ZSBkYW5nZXJvdXMuDQpXaXRoIGEgc3ViLWRyaXZlciBwcm9wZXJ0eSB0byBl
bmFibGUgdGhpcyBiZWhhdmlvciBpdCBtaWdodCB3b3JrIG91dD8NCg0KVGhhbmtzISAvLyBKb2hu
IEVybmJlcmc=

