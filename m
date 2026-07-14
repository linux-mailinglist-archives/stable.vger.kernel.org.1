Return-Path: <stable+bounces-274140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WN5pGNHRVWrotwAAu9opvQ
	(envelope-from <stable+bounces-274140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D64F751549
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274140-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274140-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=xiaomi.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A40CD30358B2
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B53D666F;
	Tue, 14 Jul 2026 06:06:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9B32B9BB;
	Tue, 14 Jul 2026 06:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009160; cv=none; b=JKYxNQuTXQCPy7fQrxsRV06Sg/wMyjwN+O06NwyjPe8lDP51z3mdGpyl26sJUuHp/yKB7Ls6AcT/BPfe3B3q6YlwCIVCUoJhdZMaXBH76YUGqS4vUYWmPOfSM3Ep5+WN8u+s78XyXJaqAeJu3gj/BQ5qyoAuU16rpWV6R/Au3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009160; c=relaxed/simple;
	bh=UQEeBT4PUG+APsd/Pp+GWgdDe8bJZR7/s0Ng0Sk5cJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEcsAq9JS61Zee6tQD52eKU8hXt7L2otXo4gGvyCZNqJHEvkqYVktGJvhU/2Bx9dA7mVNo9vTbXAeGYogYrgLs8ceI7U2bK1MLVMW2I9Yjbtaw0o185ffnTTnxNO5DnbVBd1Ryz1BQ56TRtnD2h/ETx2H0XsRN57q95nnEL2aaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
X-CSE-ConnectionGUID: Cu9lQUKeTZqphWKotg8n8A==
X-CSE-MsgGUID: U5HVHNmxS3iUF6Ryp/ClQA==
X-IronPort-AV: E=Sophos;i="6.25,163,1779120000"; 
   d="scan'208";a="155936205"
From: =?utf-8?B?6ams6LaF?= <machao26@xiaomi.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "hughd@google.com" <hughd@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "kasong@tencent.com" <kasong@tencent.com>, "baohua@kernel.org"
	<baohua@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?55Sw5a2d5paM?= <tianxiaobin@xiaomi.com>, =?utf-8?B?5L+e5Lic5paM?=
	<yudongbin@xiaomi.com>, =?utf-8?B?5p2O6bmP56iL?= <xiaoyaoli@xiaomi.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFeHRlcm5hbCBNYWlsXVtQQVRDSCA2LjE4Lnkg?=
 =?utf-8?B?djJdIG1tOiBzaG1lbTogZml4IHBvdGVudGlhbCBsaXZlbG9jayBpc3N1ZSBm?=
 =?utf-8?Q?or_shmem_direct_swapin?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWwgTWFpbF1bUEFUQ0ggNi4xOC55IHYyXSBtbTog?=
 =?utf-8?B?c2htZW06IGZpeCBwb3RlbnRpYWwgbGl2ZWxvY2sgaXNzdWUgZm9yIHNobWVt?=
 =?utf-8?Q?_direct_swapin?=
Thread-Index: AQHdEBErMsmrE+zz7EKRA3z2tbO3PLZrXI5QgABv3ACAAMBdIA==
Date: Tue, 14 Jul 2026 06:05:50 +0000
Message-ID: <777ee2cd231642c682560b41b29798fb@xiaomi.com>
References: <c0b158fe3f25709543b48a9d81b1933120a9e2ba.1783648317.git.baolin.wang@linux.alibaba.com>
 <636829064b674f71a11095603edcb20a@xiaomi.com>
 <64aae758-bcf1-45f8-bb3d-bd732ada2b11@linux.alibaba.com>
In-Reply-To: <64aae758-bcf1-45f8-bb3d-bd732ada2b11@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:hughd@google.com,m:stable@vger.kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:tianxiaobin@xiaomi.com,m:yudongbin@xiaomi.com,m:xiaoyaoli@xiaomi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274140-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[machao26@xiaomi.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D64F751549

Pk9uIDcvMTMvMjYgNzo1NSBQTSwg6ams6LaFIHdyb3RlOg0KPj4+IFdoZW4gc2tpcHBpbmcgc3dh
cGNhY2hlIGZvciBzeW5jaHJvbm91cyBJTyBzd2FwIGRldmljZXMsIHN3YXBjYWNoZV9wcmVwYXJl
KCkgaXMgdXNlZCB0byBwcmV2ZW50IHBhcmFsbGVsIHN3YXBpbiBmcm9tIHByb2NlZWRpbmcgd2l0
aCB0aGUgc3dhcCBjYWNoZSBmbGFnLg0KPj4+IEhvd2V2ZXIsIG9uIFBSRUVNUFQga2VybmVscyB0
aGlzIGNhbiBsZWFkIHRvIGEgbGl2ZWxvY2ssIGFzIHJlcG9ydGVkIGJ5IENoYW9bMV06DQo+Pj4N
Cj4+PiBUaHJlYWQgQSBzdGFydHMgZGlyZWN0IHN3YXBpbiBvZiBhIHNobWVtIGZvbGlvIGFuZCBj
YWxscyBzd2FwY2FjaGVfcHJlcGFyZSgpIHRvIHNldCBTV0FQX0hBU19DQUNIRS4gSXQgbWF5IHRo
ZW4gYmUgcHJlZW1wdGVkIGluc2lkZSB3b3JraW5nc2V0X3JlZmF1bHQoKS4NCj4+PiBNZWFud2hp
bGUsIGEgaGlnaGVyIHByaW9yaXR5IHRocmVhZCBCIGFsc28gYXR0ZW1wdHMgZGlyZWN0IHN3YXBp
biBvZiB0aGUgc2FtZSBzaG1lbSBzd2FwIGVudHJ5LiBTaW5jZSBzd2FwY2FjaGVfcHJlcGFyZSgp
IGFscmVhZHkgbWFya3MgdGhlIGVudHJ5LCB0aHJlYWQgQiByZXBlYXRlZGx5IGdldHMgLUVFWElT
VCBhbmQgYnVzeS1sb29wcyB3YWl0aW5nIGZvciB0aHJlYWQgQSB0byBmaW5pc2guIEJ1dCBhcyB0
aHJlYWQgQiBydW5zIGF0IGhpZ2hlciBwcmlvcml0eSwgdGhyZWFkIEEgY2Fubm90IHByZWVtcHQg
aXQsIHJlc3VsdGluZyBpbiBzdGFydmF0aW9uIGFuZCBhIGxpdmVsb2NrLg0KPj4+DQo+Pj4gRml4
IGl0IGJ5IHlpZWxkaW5nIHRoZSBDUFUgd2l0aCBzY2hlZHVsZV90aW1lb3V0X3VuaW50ZXJydXB0
aWJsZSgxKQ0KPj4+IHdoZW4NCj4+PiBzd2FwY2FjaGVfcHJlcGFyZSgpIGZhaWxzLCBmb2xsb3dp
bmcgdGhlIHNhbWUgYXBwcm9hY2ggdXNlZCBpbiBjb21taXQgMDI5YzQ2MjhiMmViICgibW06IHN3
YXA6IGdldCByaWQgb2YgbGl2ZWxvY2sgaW4gc3dhcGluIHJlYWRhaGVhZCIpIGFuZCBjb21taXQg
MTNkZGFmMjZiZTMyICgibW0vc3dhcDogZml4IHJhY2Ugd2hlbiBza2lwcGluZyBzd2FwY2FjaGUi
KS4NCj4+Pg0KPj4+IEhvd2V2ZXIsIGNvbW1pdCAwMTYyNmExODIzICgibW06IGF2b2lkIHVuY29u
ZGl0aW9uYWwgb25lLXRpY2sgc2xlZXAgd2hlbiBzd2FwY2FjaGVfcHJlcGFyZSBmYWlscyIpIGZv
dW5kIHRoYXQgdGhlIHVuY29uZGl0aW9uYWwgb25lLXRpY2sgc2xlZXAgY2FuIGNhdXNlIFVJIHN0
dXR0ZXJpbmcgb24gbGF0ZW5jeS1zZW5zaXRpdmUgQW5kcm9pZCBkZXZpY2VzLiBTbyB3ZSBjYW4g
Zm9sbG93IHRoZSBzYW1lIGFwcHJvYWNoIGJ5IGFkZGluZyBhIHdhaXRxdWV1ZSB0byB3YWtlIHVw
IHRhc2tzIHdoZW4gbmVlZGVkLCBpbnN0ZWFkIG9mIGFsd2F5cyBzbGVlcGluZyBmb3IgYSBmdWxs
IHRpY2suDQo+Pj4NCj4+PiBOb3RlIHRoYXQgbWFpbmxpbmUgZG9lcyBub3QgaGF2ZSB0aGlzIHBv
dGVudGlhbCBpc3N1ZSwgd2hpY2ggaGFzIGFscmVhZHkgYmVlbiByZXNvbHZlZCBieSBLYWlydWkn
cyBzd2FwIHJlZmFjdG9yaW5nIHdvcmtbMl0uDQo+Pj4NCj4+PiBbMV0NCj4+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvNzAwYTJjYmY5MGEyNDg0Zjk3OWFhYzg1OGYwOGY1ZDRAeGlhb21p
LmMNCj4+PiBvbS8gWzJdDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNTE3
LXN3YXAtdGFibGUtcDQtdjUtMC04OGFlNDNlMDY0YzdADQo+Pj4gdGVuY2VudC5jb20vDQo+Pj4g
Rml4ZXM6IDFkZDQ0YzBhZjRmYSAoIm1tOiBzaG1lbTogc2tpcCBzd2FwY2FjaGUgZm9yIHN3YXBp
biBvZg0KPj4+IHN5bmNocm9ub3VzIHN3YXAgZGV2aWNlIikNCj4+PiBSZXBvcnRlZC1ieTogTWEg
Q2hhbyA8bWFjaGFvMjZAeGlhb21pLmNvbT4NCj4+PiBDbG9zZXM6DQo+Pj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzcwMGEyY2JmOTBhMjQ4NGY5NzlhYWM4NThmMDhmNWQ0QHhpYW9taS5j
DQo+Pj4gb20vDQo+Pj4gU2lnbmVkLW9mZi1ieTogQmFvbGluIFdhbmcgPGJhb2xpbi53YW5nQGxp
bnV4LmFsaWJhYmEuY29tPg0KPj4+IC0tLQ0KPj4+IENoYW5nZXMgZnJvbSB2MToNCj4+PiAtIEFk
ZCBhIHdhaXRxdWV1ZSB0byB3YWtlIHVwIHRhc2tzIHdoZW4gbmVlZGVkLg0KPj4+DQo+Pj4gSGkg
Q2hhbywgY291bGQgeW91IHRyeSB0aGlzIHBhdGNoIHRvIGNoZWNrIGlmIGZpeCB5b3VyIGlzc3Vl
PyBUaGFua3MuDQo+Pj4gLS0tDQo+Pj4gbW0vc2htZW0uYyB8IDE0ICsrKysrKysrKysrKystDQo+
Pj4gMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9tbS9zaG1lbS5jIGIvbW0vc2htZW0uYw0KPj4+IGluZGV4IDk0YzVi
MGQ3OGFjMy4uM2MzMjliNzk0YWU0IDEwMDY0NA0KPj4+IC0tLSBhL21tL3NobWVtLmMNCj4+PiAr
KysgYi9tbS9zaG1lbS5jDQo+Pj4gQEAgLTIwMDUsMTEgKzIwMDUsMTQgQEAgc3RhdGljIHN0cnVj
dCBmb2xpbyAqc2htZW1fYWxsb2NfYW5kX2FkZF9mb2xpbyhzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwN
Cj4+PiAgICAgICAgIHJldHVybiBFUlJfUFRSKGVycm9yKTsNCj4+PiB9DQo+Pj4NCj4+PiArc3Rh
dGljIERFQ0xBUkVfV0FJVF9RVUVVRV9IRUFEKHNobWVtX3N3YXBjYWNoZV93cSk7DQo+Pj4gKw0K
Pj4+IHN0YXRpYyBzdHJ1Y3QgZm9saW8gKnNobWVtX3N3YXBfYWxsb2NfZm9saW8oc3RydWN0IGlu
b2RlICppbm9kZSwNCj4+PiAgICAgICAgICAgICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsIHBnb2ZmX3QgaW5kZXgsDQo+Pj4gICAgICAgICAgICAgICAgIHN3cF9lbnRyeV90IGVudHJ5
LCBpbnQgb3JkZXIsIGdmcF90IGdmcCkgIHsNCj4+PiAgICAgICAgIHN0cnVjdCBzaG1lbV9pbm9k
ZV9pbmZvICppbmZvID0gU0hNRU1fSShpbm9kZSk7DQo+Pj4gKyAgICAgICBERUNMQVJFX1dBSVRR
VUVVRSh3YWl0LCBjdXJyZW50KTsNCj4+PiAgICAgICAgIGludCBucl9wYWdlcyA9IDEgPDwgb3Jk
ZXI7DQo+Pj4gICAgICAgICBzdHJ1Y3QgZm9saW8gKm5ldzsNCj4+PiAgICAgICAgIGdmcF90IGFs
bG9jX2dmcDsNCj4+PiBAQCAtMjA2Niw2ICsyMDY5LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgZm9saW8g
KnNobWVtX3N3YXBfYWxsb2NfZm9saW8oc3RydWN0IGlub2RlICppbm9kZSwNCj4+PiAgICAgICAg
IGlmIChzd2FwY2FjaGVfcHJlcGFyZShlbnRyeSwgbnJfcGFnZXMpKSB7DQo+Pj4gICAgICAgICAg
ICAgICAgIGZvbGlvX3B1dChuZXcpOw0KPj4+ICAgICAgICAgICAgICAgICBuZXcgPSBFUlJfUFRS
KC1FRVhJU1QpOw0KPj4+ICsgICAgICAgICAgICAgICAvKiBSZWxheCBhIGJpdCB0byBwcmV2ZW50
IHJhcGlkIHJlcGVhdGVkIHBhZ2UgZmF1bHRzICovDQo+Pj4gKyAgICAgICAgICAgICAgIGFkZF93
YWl0X3F1ZXVlKCZzaG1lbV9zd2FwY2FjaGVfd3EsICZ3YWl0KTsNCj4+PiArICAgICAgICAgICAg
ICAgc2NoZWR1bGVfdGltZW91dF91bmludGVycnVwdGlibGUoMSk7DQo+Pj4gKyAgICAgICAgICAg
ICAgIHJlbW92ZV93YWl0X3F1ZXVlKCZzaG1lbV9zd2FwY2FjaGVfd3EsICZ3YWl0KTsNCj4+PiAg
ICAgICAgICAgICAgICAgLyogVHJ5IHNtYWxsZXIgZm9saW8gdG8gYXZvaWQgY2FjaGUgY29uZmxp
Y3QgKi8NCj4+PiAgICAgICAgICAgICAgICAgZ290byBmYWxsYmFjazsNCj4+PiAgICAgICAgIH0N
Cj4+PiBAQCAtMjQyMyw2ICsyNDMwLDggQEAgc3RhdGljIGludCBzaG1lbV9zd2FwaW5fZm9saW8o
c3RydWN0IGlub2RlICppbm9kZSwgcGdvZmZfdCBpbmRleCwNCj4+PiAgICAgICAgIGlmIChza2lw
X3N3YXBjYWNoZSkgew0KPj4+ICAgICAgICAgICAgICAgICBmb2xpby0+c3dhcC52YWwgPSAwOw0K
Pj4+ICAgICAgICAgICAgICAgICBzd2FwY2FjaGVfY2xlYXIoc2ksIHN3YXAsIG5yX3BhZ2VzKTsN
Cj4+PiArICAgICAgICAgICAgICAgaWYgKHdhaXRxdWV1ZV9hY3RpdmUoJnNobWVtX3N3YXBjYWNo
ZV93cSkpDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgd2FrZV91cCgmc2htZW1fc3dhcGNh
Y2hlX3dxKTsNCj4+PiAgICAgICAgIH0gZWxzZSB7DQo+Pj4gICAgICAgICAgICAgICAgIHN3YXBf
Y2FjaGVfZGVsX2ZvbGlvKGZvbGlvKTsNCj4+PiAgICAgICAgIH0NCj4+PiBAQCAtMjQ0Miw4ICsy
NDUxLDExIEBAIHN0YXRpYyBpbnQgc2htZW1fc3dhcGluX2ZvbGlvKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHBnb2ZmX3QgaW5kZXgsDQo+Pj4gICAgICAgICBpZiAoZm9saW8pDQo+Pj4gICAgICAgICAg
ICAgICAgIGZvbGlvX3VubG9jayhmb2xpbyk7DQo+Pj4gZmFpbGVkX25vbG9jazoNCj4+PiAtICAg
ICAgIGlmIChza2lwX3N3YXBjYWNoZSkNCj4+PiArICAgICAgIGlmIChza2lwX3N3YXBjYWNoZSkg
ew0KPj4+ICAgICAgICAgICAgICAgICBzd2FwY2FjaGVfY2xlYXIoc2ksIGZvbGlvLT5zd2FwLA0K
Pj4+IGZvbGlvX25yX3BhZ2VzKGZvbGlvKSk7DQo+Pj4gKyAgICAgICAgICAgICAgIGlmICh3YWl0
cXVldWVfYWN0aXZlKCZzaG1lbV9zd2FwY2FjaGVfd3EpKQ0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHdha2VfdXAoJnNobWVtX3N3YXBjYWNoZV93cSk7DQo+Pj4gKyAgICAgICB9DQo+Pj4g
ICAgICAgICBpZiAoZm9saW8pDQo+Pj4gICAgICAgICAgICAgICAgIGZvbGlvX3B1dChmb2xpbyk7
DQo+Pj4gICAgICAgICBwdXRfc3dhcF9kZXZpY2Uoc2kpOw0KPj4+IC0tDQo+Pj4gMi40Ny4zDQo+
Pg0KPj4gV2UgaGF2ZSBjb25kdWN0ZWQgc3RyZXNzIHRlc3RzIG9uIG92ZXIgMTAgcGNzIGZvciA0
MCBob3VycyBlYWNoLCBhbmQgbm8gcmVsZXZhbnQgaXNzdWVzIGhhdmUgYmVlbiByZXByb2R1Y2Vk
Lg0KPg0KPlRoYW5rcyBmb3IgdGVzdGluZy4gQ291bGQgeW91IGFkZCB5b3VyICdUZXN0ZWQtYnk6
JyB0YWc/DQoNCldlIGhhdmUgY29uZHVjdGVkIHN0cmVzcyB0ZXN0cyBvbiBvdmVyIDEwIHBjcyBm
b3IgNDAgaG91cnMgZWFjaCwgYW5kIG5vIHJlbGV2YW50IGlzc3VlcyBoYXZlIGJlZW4gcmVwcm9k
dWNlZC4NClRlc3RlZC1ieTogTWEgQ2hhbyA8bWFjaGFvMjZAeGlhb21pLmNvbT4NCiMvKioqKioq
5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5bCP57Gz5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM
5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE
44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G
5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CB5oiW5pWj5Y+R77yJ
5pys6YKu5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+3
5oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu2
77yBIFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBw
ZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9m
IHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywg
YnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVj
dGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwg
aW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1l
ZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=

