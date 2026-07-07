Return-Path: <stable+bounces-272339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uzlYJ91oTGpjkAEAu9opvQ
	(envelope-from <stable+bounces-272339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 04:47:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21F716E53
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 04:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=xiaomi.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272339-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272339-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B691930264C7
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A21379C24;
	Tue,  7 Jul 2026 02:47:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250E27A462;
	Tue,  7 Jul 2026 02:47:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392472; cv=none; b=LeW1DFy0Z64RbsyYjbpgCNEzJjID6zmEw/45KWVDbqIMe+6tLdg/8o3jlRcEbE3tHL4i2vIix27L9wij5SXtyjKS/MjceiRyZ9ayJlwsUJlfbzDIiYGlmhV2yCYWOxjWtJ5MRWzks9EEtv++7oEEAAo8cakgj8gXjICeEp/pIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392472; c=relaxed/simple;
	bh=8g6hfiuUrHYj45/NWVW48yJie+FBOMKbVbGTWrRUur4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgSPHke2YMWKEU4/18AbTik15u+crwnR7ymmWm1/Nld9UwyHJitQQHHWBBbuNfPWDFTBlrJ0RWgwGiO/YwpVs1Ces/dZcILI5schHAhwqUhN0noeoPuhjCqOX+WSjgEBQvRGlLh8j7hYCFtxIXLfTw+4ehfBpNXVzH3Plk/71ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
X-CSE-ConnectionGUID: +MvWi1A8TNKMbKjmX6TYCw==
X-CSE-MsgGUID: mDAC0oK7RvCKK9NcTfJWbg==
X-IronPort-AV: E=Sophos;i="6.25,151,1779120000"; 
   d="scan'208";a="155188619"
From: =?utf-8?B?6ams6LaF?= <machao26@xiaomi.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Kairui Song
	<ryncsn@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "baohua@kernel.org" <baohua@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?55Sw5a2d5paM?=
	<tianxiaobin@xiaomi.com>, =?utf-8?B?5L+e5Lic5paM?= <yudongbin@xiaomi.com>,
	=?utf-8?B?5p2O6bmP56iL?= <xiaoyaoli@xiaomi.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIIDYuMTgueV0gbW06?=
 =?utf-8?B?IHNobWVtOiBmaXggcG90ZW50aWFsIGxpdmVsb2NrIGlzc3VlIGZvciBzaG1l?=
 =?utf-8?Q?m_direct_swapin?=
Thread-Topic: [External Mail]Re: [PATCH 6.18.y] mm: shmem: fix potential
 livelock issue for shmem direct swapin
Thread-Index: AQHdDQy4jsGVhuEAD0KP7fSRFNOkF7Zf4CGAgAFtsfA=
Date: Tue, 7 Jul 2026 02:47:42 +0000
Message-ID: <1ac8eb5743e244f58efa28ea46aeb4d0@xiaomi.com>
References: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
 <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com>
 <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com>
In-Reply-To: <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-272339-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:baolin.wang@linux.alibaba.com,m:ryncsn@gmail.com,m:akpm@linux-foundation.org,m:hughd@google.com,m:stable@vger.kernel.org,m:baohua@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:tianxiaobin@xiaomi.com,m:yudongbin@xiaomi.com,m:xiaoyaoli@xiaomi.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.alibaba.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[machao26@xiaomi.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[machao26@xiaomi.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C21F716E53

PiBPbiA3LzYvMjYgMTo1OSBQTSwgS2FpcnVpIFNvbmcgd3JvdGU6DQo+PiBPbiBNb24sIEp1bCA2
LCAyMDI2IGF0IDExOjI14oCvQU0gQmFvbGluIFdhbmcNCj4+IDxiYW9saW4ud2FuZ0BsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBXaGVuIHNraXBwaW5nIHN3YXBjYWNoZSBmb3Ig
c3luY2hyb25vdXMgSU8gc3dhcCBkZXZpY2VzLA0KPj4+IHN3YXBjYWNoZV9wcmVwYXJlKCkgaXMg
dXNlZCB0byBwcmV2ZW50IHBhcmFsbGVsIHN3YXBpbiBmcm9tIHByb2NlZWRpbmcgd2l0aCB0aGUg
c3dhcCBjYWNoZSBmbGFnLg0KPj4+IEhvd2V2ZXIsIG9uIFBSRUVNUFQga2VybmVscyB0aGlzIGNh
biBsZWFkIHRvIGEgbGl2ZWxvY2ssIGFzIHJlcG9ydGVkIGJ5IENoYW9bMV06DQo+Pj4NCj4+PiBU
aHJlYWQgQSBzdGFydHMgZGlyZWN0IHN3YXBpbiBvZiBhIHNobWVtIGZvbGlvIGFuZCBjYWxscw0K
Pj4+IHN3YXBjYWNoZV9wcmVwYXJlKCkgdG8gc2V0IFNXQVBfSEFTX0NBQ0hFLiBJdCBtYXkgdGhl
biBiZSBwcmVlbXB0ZWQgaW5zaWRlIHdvcmtpbmdzZXRfcmVmYXVsdCgpLg0KPj4+IE1lYW53aGls
ZSwgYSBoaWdoZXIgcHJpb3JpdHkgdGhyZWFkIEIgYWxzbyBhdHRlbXB0cyBkaXJlY3Qgc3dhcGlu
IG9mDQo+Pj4gdGhlIHNhbWUgc2htZW0gc3dhcCBlbnRyeS4gU2luY2Ugc3dhcGNhY2hlX3ByZXBh
cmUoKSBhbHJlYWR5IG1hcmtzDQo+Pj4gdGhlIGVudHJ5LCB0aHJlYWQgQiByZXBlYXRlZGx5IGdl
dHMgLUVFWElTVCBhbmQgYnVzeS1sb29wcyB3YWl0aW5nDQo+Pj4gZm9yIHRocmVhZCBBIHRvIGZp
bmlzaC4gQnV0IGFzIHRocmVhZCBCIHJ1bnMgYXQgaGlnaGVyIHByaW9yaXR5LA0KPj4+IHRocmVh
ZCBBIGNhbm5vdCBwcmVlbXB0IGl0LCByZXN1bHRpbmcgaW4gc3RhcnZhdGlvbiBhbmQgYSBsaXZl
bG9jay4NCj4+Pg0KPj4+IEZpeCBpdCBieSB5aWVsZGluZyB0aGUgQ1BVIHdpdGggc2NoZWR1bGVf
dGltZW91dF91bmludGVycnVwdGlibGUoMSkNCj4+PiB3aGVuDQo+Pj4gc3dhcGNhY2hlX3ByZXBh
cmUoKSBmYWlscywgZm9sbG93aW5nIHRoZSBzYW1lIGFwcHJvYWNoIHVzZWQgaW4NCj4+PiBjb21t
aXRzIDAyOWM0NjI4YjJlYiAoIm1tOiBzd2FwOiBnZXQgcmlkIG9mIGxpdmVsb2NrIGluIHN3YXBp
bg0KPj4+IHJlYWRhaGVhZCIpIGFuZA0KPj4+IDEzZGRhZjI2YmUzMiAoIm1tL3N3YXA6IGZpeCBy
YWNlIHdoZW4gc2tpcHBpbmcgc3dhcGNhY2hlIikuDQo+Pj4NCj4+PiBOb3RlIHRoYXQgbWFpbmxp
bmUgZG9lcyBub3QgaGF2ZSB0aGlzIHBvdGVudGlhbCBpc3N1ZSwgd2hpY2ggaGFzDQo+Pj4gYWxy
ZWFkeSBiZWVuIHJlc29sdmVkIGJ5IEthaXJ1aSdzIHN3YXAgcmVmYWN0b3Jpbmcgd29ya1syXS4N
Cj4+Pg0KPj4+IFsxXQ0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC83MDBhMmNiZjkw
YTI0ODRmOTc5YWFjODU4ZjA4ZjVkNEB4aWFvbWkuYw0KPj4+IG9tLyBbMl0NCj4+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MTctc3dhcC10YWJsZS1wNC12NS0wLTg4YWU0M2Uw
NjRjN0ANCj4+PiB0ZW5jZW50LmNvbS8NCj4+PiBGaXhlczogMWRkNDRjMGFmNGZhICgibW06IHNo
bWVtOiBza2lwIHN3YXBjYWNoZSBmb3Igc3dhcGluIG9mDQo+Pj4gc3luY2hyb25vdXMgc3dhcCBk
ZXZpY2UiKQ0KPj4+IFJlcG9ydGVkLWJ5OiBNYSBDaGFvIDxtYWNoYW8yNkB4aWFvbWkuY29tPg0K
Pj4+IENsb3NlczoNCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNzAwYTJjYmY5MGEy
NDg0Zjk3OWFhYzg1OGYwOGY1ZDRAeGlhb21pLmMNCj4+PiBvbS8NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBCYW9saW4gV2FuZyA8YmFvbGluLndhbmdAbGludXguYWxpYmFiYS5jb20+DQo+Pj4gLS0tDQo+
Pj4gSGkgQ2hhbywgY291bGQgeW91IHRyeSB0aGlzIHBhdGNoIHRvIGNoZWNrIGlmIGl0IGZpeGVz
IHlvdXIgaXNzdWU/IFRoYW5rcy4NCj4+PiAtLS0NCj4+PiAgIG1tL3NobWVtLmMgfCAyICsrDQo+
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvbW0vc2htZW0uYyBiL21tL3NobWVtLmMNCj4+PiBpbmRleCA5NGM1YjBkNzhhYzMuLmQ0Y2I1
N2IzYjBlZiAxMDA2NDQNCj4+PiAtLS0gYS9tbS9zaG1lbS5jDQo+Pj4gKysrIGIvbW0vc2htZW0u
Yw0KPj4+IEBAIC0yMDY2LDYgKzIwNjYsOCBAQCBzdGF0aWMgc3RydWN0IGZvbGlvICpzaG1lbV9z
d2FwX2FsbG9jX2ZvbGlvKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+Pj4gICAgICAgICAgaWYgKHN3
YXBjYWNoZV9wcmVwYXJlKGVudHJ5LCBucl9wYWdlcykpIHsNCj4+PiAgICAgICAgICAgICAgICAg
IGZvbGlvX3B1dChuZXcpOw0KPj4+ICAgICAgICAgICAgICAgICAgbmV3ID0gRVJSX1BUUigtRUVY
SVNUKTsNCj4+PiArICAgICAgICAgICAgICAgLyogUmVsYXggYSBiaXQgdG8gcHJldmVudCByYXBp
ZCByZXBlYXRlZCBwYWdlIGZhdWx0cyAqLw0KPj4+ICsgICAgICAgICAgICAgICBzY2hlZHVsZV90
aW1lb3V0X3VuaW50ZXJydXB0aWJsZSgxKTsNCj4+PiAgICAgICAgICAgICAgICAgIC8qIFRyeSBz
bWFsbGVyIGZvbGlvIHRvIGF2b2lkIGNhY2hlIGNvbmZsaWN0ICovDQo+Pj4gICAgICAgICAgICAg
ICAgICBnb3RvIGZhbGxiYWNrOw0KPj4+ICAgICAgICAgIH0NCj4+PiAtLQ0KPj4+IDIuNDcuMw0K
Pj4+DQo+Pg0KPj4gVGhhbmtzISBUaGF0J3MgbXVjaCBtb3JlIHNpbXBsZXIgdGhhbiBJIGV4cGVj
dGVkLiBEbyB3ZSBuZWVkIGEgd2FrZXVwDQo+PiBxdWV1ZSBsaWtlIHRoZSBvbmUgaW4gY29tbWl0
IDAxNjI2YTE4MjMwMjQ/IFBlcmhhcHMgdGhlIHJlcG9ydGVyIGNhbg0KPj4gaGVscCBjb25maXJt
IGFuZCB0ZXN0PyBJIHBlcnNvbmFsbHkgcHJlZmVyIHRvIGtlZXAgaXQgc2ltcGxlIGlmIHNobWVt
DQo+PiB1c2VycyBhcmVuJ3QgYXMgc2Vuc2l0aXZlIGFzIGFub24gdXNlcnMuDQo+DQo+IEkgYWdy
ZWUuIEknZCBsaWtlIHRvIGtlZXAgdGhlIGJ1Z2ZpeCBhcyBzaW1wbGUgYXMgcG9zc2libGUsIGlm
IHRoZSByZXBvcnRlcidzIHNjZW5hcmlvIGlzbid0IGxhdGVuY3ktc2Vuc2l0aXZlLg0KDQpUaGFu
a3MgZm9yIHlvdXIgYW5hbHlzaXMgYW5kIHRoZSBwcm92aWRlZCBmaXggcGF0Y2guIEkgd2lsbCB0
ZXN0IGFuZCB2ZXJpZnkgaXQuIEJ5IHRoZSB3YXksIHdoZW4gaXMgdGhlIGZpeCBwYXRjaCBleHBl
Y3RlZCB0byBiZSBtZXJnZWQgaW50byB0aGUga2VybmVsPw0KIy8qKioqKirmnKzpgq7ku7blj4rl
hbbpmYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5Hp
gIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vk
vZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajp
g6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3n
moTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXo
r53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1h
aWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBm
cm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRp
dHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0
aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0
ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNz
ZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChz
KSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBk
ZWxldGUgaXQhKioqKioqLyMNCg==

