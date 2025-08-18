Return-Path: <stable+bounces-169906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF0B296BA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 04:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DC719634D8
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 02:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B21F3BB5;
	Mon, 18 Aug 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="pH/+TQP2"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84D13774D;
	Mon, 18 Aug 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482906; cv=none; b=PxICgdQlZq33zKpz8OHzWYAj0IqBWU2oG9ya2IArHzLoJfZF3H/fwNf/4GN8w7/3cM0S8LqmfDkCzypY/R12hrj0J3xS5xIy7qbkTGAuH2+wOD9tmUCZDNX1Fuw3gVzh5nKAYj2pmmhTcFBOx/uZRxBV312GqVlMQ/nvusfP5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482906; c=relaxed/simple;
	bh=T8R4zGbfsi1YFjJuZKt9SelbqSBHX074ydVWLE5Rv4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=PxK6Hlu8KGolWVM1WspBTwCcH+mSGDiUhn67cPfsGh3XjgDAT+uP3z0xz0RS+8VoKfK4qgLpNeaU2zcIMfV7kGcmRD/Bl9SbicPM8Z1yye/vlOEd6hXcnZqMkpOu28zE+EZmcXKEkWeuNVu0mjnVW0QqhjQCIgF3ZblYdw1rdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=pH/+TQP2 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=F/Sy0BpnIh6PqHd8jHrC/bdREDVQrvz7gyX0VaCC2Gw=; b=p
	H/+TQP21CHoVgTJ+86UHsRAaQXsK5OxFobCYBMWTRbvCg7iFdZTsmR9BmSSt3FL7
	I57t3g4RQGS56Ftt4imFpsJEtieizAXWuC1AAUbAGmUneb7iq6zWJC6moAIXw6CL
	xgLHL9649PnKfHe9xdC5oybQtiq3MP2Nns8F8He/1Y=
Received: from yangshiguang1011$163.com (
 [2408:8607:1b00:8:9e7b:efff:fe4e:6d16] ) by ajax-webmail-wmsvr-40-116
 (Coremail) ; Mon, 18 Aug 2025 10:07:40 +0800 (CST)
Date: Mon, 18 Aug 2025 10:07:40 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Harry Yoo" <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>
Subject: Re:Re: Re: [PATCH v2] mm: slub: avoid wake up kswapd in
 set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aKBhdAsHypo1Q3pC@harry>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry>
 <14b4d82.262b.198b25732bb.Coremail.yangshiguang1011@163.com>
 <aKBhdAsHypo1Q3pC@harry>
X-NTES-SC: AL_Qu2eB/iTvUAt5iWfZOkfmUgRj+k6WsK3s/sn3oNfP5B+jD3p0T0ceV9KLFv96vuKKB6rvRGeUwZw9/RYepVacKsLtVUS5WQhAQhOCda1+4vDfw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <22a353bd.1e2b.198baeeac20.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCgvCgD3H_jsiqJo2OIbAA--.1990W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiSAGt5WiihLOQegACsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA4LTE2IDE4OjQ2OjEyLCAiSGFycnkgWW9vIiA8aGFycnkueW9vQG9yYWNsZS5j
b20+IHdyb3RlOgo+T24gU2F0LCBBdWcgMTYsIDIwMjUgYXQgMDY6MDU6MTVQTSArMDgwMCwgeWFu
Z3NoaWd1YW5nIHdyb3RlOgo+PiAKPj4gCj4+IEF0IDIwMjUtMDgtMTYgMTY6MjU6MjUsICJIYXJy
eSBZb28iIDxoYXJyeS55b29Ab3JhY2xlLmNvbT4gd3JvdGU6Cj4+ID5PbiBUaHUsIEF1ZyAxNCwg
MjAyNSBhdCAwNzoxNjo0MlBNICswODAwLCB5YW5nc2hpZ3VhbmcxMDExQDE2My5jb20gd3JvdGU6
Cj4+ID4+IEZyb206IHlhbmdzaGlndWFuZyA8eWFuZ3NoaWd1YW5nQHhpYW9taS5jb20+Cj4+ID4+
IAo+PiA+PiBGcm9tOiB5YW5nc2hpZ3VhbmcgPHlhbmdzaGlndWFuZ0B4aWFvbWkuY29tPgo+PiA+
PiAKPj4gPj4gc2V0X3RyYWNrX3ByZXBhcmUoKSBjYW4gaW5jdXIgbG9jayByZWN1cnNpb24uCj4+
ID4+IFRoZSBpc3N1ZSBpcyB0aGF0IGl0IGlzIGNhbGxlZCBmcm9tIGhydGltZXJfc3RhcnRfcmFu
Z2VfbnMKPj4gPj4gaG9sZGluZyB0aGUgcGVyX2NwdShocnRpbWVyX2Jhc2VzKVtuXS5sb2NrLCBi
dXQgd2hlbiBlbmFibGVkCj4+ID4+IENPTkZJR19ERUJVR19PQkpFQ1RTX1RJTUVSUywgbWF5IHdh
a2UgdXAga3N3YXBkIGluIHNldF90cmFja19wcmVwYXJlLAo+PiA+PiBhbmQgdHJ5IHRvIGhvbGQg
dGhlIHBlcl9jcHUoaHJ0aW1lcl9iYXNlcylbbl0ubG9jay4KPj4gPj4gCj4+ID4+IFNvIGF2b2lk
IHdha2luZyB1cCBrc3dhcGQuVGhlIG9vcHMgbG9va3Mgc29tZXRoaW5nIGxpa2U6Cj4+ID4KPj4g
PkhpIHlhbmdzaGlndWFuZywgCj4+ID4KPj4gPkluIHRoZSBuZXh0IHJldmlzaW9uLCBjb3VsZCB5
b3UgcGxlYXNlIGVsYWJvcmF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UKPj4gPnRvIHJlZmxlY3QgaG93
IHRoaXMgY2hhbmdlIGF2b2lkcyB3YWtpbmcgdXAga3N3YXBkPwo+PiA+Cj4+IAo+PiBvZiBjb3Vy
c2UuIFRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLgo+PiAKPj4gPj4gQlVHOiBzcGlubG9jayByZWN1
cnNpb24gb24gQ1BVIzMsIHN3YXBwZXIvMy8wCj4+ID4+ICBsb2NrOiAweGZmZmZmZjhhNGJmMjlj
ODAsIC5tYWdpYzogZGVhZDRlYWQsIC5vd25lcjogc3dhcHBlci8zLzAsIC5vd25lcl9jcHU6IDMK
Pj4gPj4gSGFyZHdhcmUgbmFtZTogUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIFBvcHNpY2xl
IGJhc2VkIG9uIFNNODg1MCAoRFQpCj4+ID4+IENhbGwgdHJhY2U6Cj4+ID4+IHNwaW5fYnVnKzB4
MAo+PiA+PiBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4ODAKPj4gPj4gaHJ0aW1lcl90cnlfdG9f
Y2FuY2VsKzB4OTQKPj4gPj4gdGFza19jb250ZW5kaW5nKzB4MTBjCj4+ID4+IGVucXVldWVfZGxf
ZW50aXR5KzB4MmE0Cj4+ID4+IGRsX3NlcnZlcl9zdGFydCsweDc0Cj4+ID4+IGVucXVldWVfdGFz
a19mYWlyKzB4NTY4Cj4+ID4+IGVucXVldWVfdGFzaysweGFjCj4+ID4+IGRvX2FjdGl2YXRlX3Rh
c2srMHgxNGMKPj4gPj4gdHR3dV9kb19hY3RpdmF0ZSsweGNjCj4+ID4+IHRyeV90b193YWtlX3Vw
KzB4NmM4Cj4+ID4+IGRlZmF1bHRfd2FrZV9mdW5jdGlvbisweDIwCj4+ID4+IGF1dG9yZW1vdmVf
d2FrZV9mdW5jdGlvbisweDFjCj4+ID4+IF9fd2FrZV91cCsweGFjCj4+ID4+IHdha2V1cF9rc3dh
cGQrMHgxOWMKPj4gPj4gd2FrZV9hbGxfa3N3YXBkcysweDc4Cj4+ID4+IF9fYWxsb2NfcGFnZXNf
c2xvd3BhdGgrMHgxYWMKPj4gPj4gX19hbGxvY19wYWdlc19ub3Byb2YrMHgyOTgKPj4gPj4gc3Rh
Y2tfZGVwb3Rfc2F2ZV9mbGFncysweDZiMAo+PiA+PiBzdGFja19kZXBvdF9zYXZlKzB4MTQKPj4g
Pj4gc2V0X3RyYWNrX3ByZXBhcmUrMHg1Ywo+PiA+PiBfX19zbGFiX2FsbG9jKzB4Y2NjCj4+ID4+
IF9fa21hbGxvY19jYWNoZV9ub3Byb2YrMHg0NzAKPj4gPj4gX19zZXRfcGFnZV9vd25lcisweDJi
Ywo+PiA+PiBwb3N0X2FsbG9jX2hvb2tbanRdKzB4MWI4Cj4+ID4+IHByZXBfbmV3X3BhZ2UrMHgy
OAo+PiA+PiBnZXRfcGFnZV9mcm9tX2ZyZWVsaXN0KzB4MWVkYwo+PiA+PiBfX2FsbG9jX3BhZ2Vz
X25vcHJvZisweDEzYwo+PiA+PiBhbGxvY19zbGFiX3BhZ2UrMHgyNDQKPj4gPj4gYWxsb2NhdGVf
c2xhYisweDdjCj4+ID4+IF9fX3NsYWJfYWxsb2MrMHg4ZTgKPj4gPj4ga21lbV9jYWNoZV9hbGxv
Y19ub3Byb2YrMHg0NTAKPj4gPj4gZGVidWdfb2JqZWN0c19maWxsX3Bvb2wrMHgyMmMKPj4gPj4g
ZGVidWdfb2JqZWN0X2FjdGl2YXRlKzB4NDAKPj4gPj4gZW5xdWV1ZV9ocnRpbWVyW2p0XSsweGRj
Cj4+ID4+IGhydGltZXJfc3RhcnRfcmFuZ2VfbnMrMHg1ZjgKPj4gPj4gLi4uCj4+ID4+IAo+PiA+
PiBTaWduZWQtb2ZmLWJ5OiB5YW5nc2hpZ3VhbmcgPHlhbmdzaGlndWFuZ0B4aWFvbWkuY29tPgo+
PiA+PiBGaXhlczogNWNmOTA5YzU1M2U5ICgibW0vc2x1YjogdXNlIHN0YWNrZGVwb3QgdG8gc2F2
ZSBzdGFjayB0cmFjZSBpbiBvYmplY3RzIikKPj4gPj4gLS0tCj4+ID4+IHYxIC0+IHYyOgo+PiA+
PiAgICAgcHJvcGFnYXRlIGdmcCBmbGFncyB0byBzZXRfdHJhY2tfcHJlcGFyZSgpCj4+ID4+IAo+
PiA+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwODAxMDY1MTIxLjg3Njc5
My0xLXlhbmdzaGlndWFuZzEwMTFAMTYzLmNvbSAKPj4gPj4gLS0tCj4+ID4+ICBtbS9zbHViLmMg
fCAyMSArKysrKysrKysrKy0tLS0tLS0tLS0KPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPj4gPj4gCj4+ID4+IGRpZmYgLS1naXQgYS9tbS9z
bHViLmMgYi9tbS9zbHViLmMKPj4gPj4gaW5kZXggMzAwMDM3NjNkMjI0Li5kYmE5MDViZjFlMDMg
MTAwNjQ0Cj4+ID4+IC0tLSBhL21tL3NsdWIuYwo+PiA+PiArKysgYi9tbS9zbHViLmMKPj4gPj4g
QEAgLTk2MiwxOSArOTYyLDIwIEBAIHN0YXRpYyBzdHJ1Y3QgdHJhY2sgKmdldF90cmFjayhzdHJ1
Y3Qga21lbV9jYWNoZSAqcywgdm9pZCAqb2JqZWN0LAo+PiA+PiAgfQo+PiA+PiAgCj4+ID4+ICAj
aWZkZWYgQ09ORklHX1NUQUNLREVQT1QKPj4gPj4gLXN0YXRpYyBub2lubGluZSBkZXBvdF9zdGFj
a19oYW5kbGVfdCBzZXRfdHJhY2tfcHJlcGFyZSh2b2lkKQo+PiA+PiArc3RhdGljIG5vaW5saW5l
IGRlcG90X3N0YWNrX2hhbmRsZV90IHNldF90cmFja19wcmVwYXJlKGdmcF90IGdmcF9mbGFncykK
Pj4gPj4gIHsKPj4gPj4gIAlkZXBvdF9zdGFja19oYW5kbGVfdCBoYW5kbGU7Cj4+ID4+ICAJdW5z
aWduZWQgbG9uZyBlbnRyaWVzW1RSQUNLX0FERFJTX0NPVU5UXTsKPj4gPj4gIAl1bnNpZ25lZCBp
bnQgbnJfZW50cmllczsKPj4gPj4gKwlnZnBfZmxhZ3MgJj0gR0ZQX05PV0FJVDsKPj4gPgo+PiA+
SXMgdGhlcmUgYW55IHJlYXNvbiB0byBkb3duZ3JhZGUgaXQgdG8gR0ZQX05PV0FJVCB3aGVuIHRo
ZSBnZnAgZmxhZyBhbGxvd3MKPj4gPmRpcmVjdCByZWNsYW1hdGlvbj8KPj4gPgo+PiAKPj4gSGkg
SGFycnksCj4+IAo+PiBUaGUgb3JpZ2luYWwgYWxsb2NhdGlvbiBpcyBHRlBfTk9XQUlULgo+PiBT
byBJIHRoaW5rIGl0J3MgYmV0dGVyIG5vdCB0byBpbmNyZWFzZSB0aGUgYWxsb2NhdGlvbiBjb3N0
IGhlcmUuCj4KPkkgZG9uJ3QgdGhpbmsgdGhlIGFsbG9jYXRpb24gY29zdCBpcyBpbXBvcnRhbnQg
aGVyZSwgYmVjYXVzZSBjb2xsZWN0aW5nCj5hIHN0YWNrIHRyYWNlIGZvciBlYWNoIGFsbG9jL2Zy
ZWUgaXMgcXVpdGUgc2xvdyBhbnl3YXkuIEFuZCB3ZSBkb24ndCByZWFsbHkKPmNhcmUgYWJvdXQg
cGVyZm9ybWFuY2UgaW4gZGVidWcgY2FjaGVzIChpdCBpc24ndCBkZXNpZ25lZCB0byBiZQo+cGVy
Zm9ybWFudCkuCj4KPkkgdGhpbmsgaXQgd2FzIEdGUF9OT1dBSVQgYmVjYXVzZSBpdCB3YXMgY29u
c2lkZXJlZCBzYWZlIHdpdGhvdXQKPnJlZ2FyZCB0byB0aGUgR0ZQIGZsYWdzIHBhc3NlZCwgcmF0
aGVyIHRoYW4gZHVlIHRvIHBlcmZvcm1hbmNlCj5jb25zaWRlcmF0aW9ucy4KPgpIaSBoYXJyeSwK
CklzIHRoYXQgc28/CmdmcF9mbGFncyAmPSAoR0ZQX05PV0FJVCB8IF9fR0ZQX0RJUkVDVF9SRUNM
QUlNKTsKCgo+LS0gCj5DaGVlcnMsCj5IYXJyeSAvIEh5ZW9uZ2dvbgo=

