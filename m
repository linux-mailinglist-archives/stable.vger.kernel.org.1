Return-Path: <stable+bounces-169855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25BB28CA7
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE531AE7285
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D2C28C5D1;
	Sat, 16 Aug 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="m0BWYAnD"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35728C039;
	Sat, 16 Aug 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338768; cv=none; b=Qz/J9unV9G3nfZ41m2bN2O3jRoKKDY9SyyH60u42kjbMNsmtYuDBW4fUGnOc3KsE//UePJtkvY1ZzA7pk59b4xGKgTzUkNIu3yhGPaefI7Zwopui62R5n+zx4/hec9prdHueLZ/tJ3qkX5DCMOp8a+kIjy12do7llH9XgTrsn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338768; c=relaxed/simple;
	bh=/tvCba59DndcHKT1wO2n4S6E84FC8hxSXkLUPaJM1oI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JhOsq/aPy4TxoVQHnZUVsFigUVgI9ro1+t/7HRCHpGFmbBtbT2unrDLbboQvZRS/6NwMChmhq5js/7plSZ5xJaEB9mBux0CgjZQb7IIy8FCwrcCiY7mFQmx/s8hjfc+Rjz7TV/TQeWAdm4AmyUHlHEHY76DCwf6w0n/lAfOlMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=m0BWYAnD reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=8RBZaee7DFAtQwlLxj5DjaKUkNFGSPrEBSejl/nsRSQ=; b=m
	0BWYAnD1iVKCHtD72+dacuUWLKPD3jtBzrPQceyGIWMAo+ksupPltvjHIVSWUcJL
	FpWRVYE4efVYXY7obvqR1+QXIJf7LX7mgp7QQcaUUjIRKX8xT0wy6u0auhbngRJD
	nkZJ8hjhbR9+i0y/RWj37z7zGtZhs8S5ZRtAMgYm3I=
Received: from yangshiguang1011$163.com (
 [2408:8607:1b00:8:9e7b:efff:fe4e:6d16] ) by ajax-webmail-wmsvr-40-116
 (Coremail) ; Sat, 16 Aug 2025 18:05:15 +0800 (CST)
Date: Sat, 16 Aug 2025 18:05:15 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Harry Yoo" <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>
Subject: Re:Re: [PATCH v2] mm: slub: avoid wake up kswapd in
 set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aKBAdUkCd95Rg85A@harry>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry>
X-NTES-SC: AL_Qu2eB/+Yt08q4yibZekfmUgRj+k6WsK3s/sn3oNfP5B+jD3p0T0ceV9KLFv96vuKKB6rvRGeUwZw9/RYepVacKsLlpC3vEWLniawSbSmH+6ptg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <14b4d82.262b.198b25732bb.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCgvCgAXB+vbV6Bo6nQbAA--.560W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiSByr5WigMtzoyQAIsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA4LTE2IDE2OjI1OjI1LCAiSGFycnkgWW9vIiA8aGFycnkueW9vQG9yYWNsZS5j
b20+IHdyb3RlOgo+T24gVGh1LCBBdWcgMTQsIDIwMjUgYXQgMDc6MTY6NDJQTSArMDgwMCwgeWFu
Z3NoaWd1YW5nMTAxMUAxNjMuY29tIHdyb3RlOgo+PiBGcm9tOiB5YW5nc2hpZ3VhbmcgPHlhbmdz
aGlndWFuZ0B4aWFvbWkuY29tPgo+PiAKPj4gRnJvbTogeWFuZ3NoaWd1YW5nIDx5YW5nc2hpZ3Vh
bmdAeGlhb21pLmNvbT4KPj4gCj4+IHNldF90cmFja19wcmVwYXJlKCkgY2FuIGluY3VyIGxvY2sg
cmVjdXJzaW9uLgo+PiBUaGUgaXNzdWUgaXMgdGhhdCBpdCBpcyBjYWxsZWQgZnJvbSBocnRpbWVy
X3N0YXJ0X3JhbmdlX25zCj4+IGhvbGRpbmcgdGhlIHBlcl9jcHUoaHJ0aW1lcl9iYXNlcylbbl0u
bG9jaywgYnV0IHdoZW4gZW5hYmxlZAo+PiBDT05GSUdfREVCVUdfT0JKRUNUU19USU1FUlMsIG1h
eSB3YWtlIHVwIGtzd2FwZCBpbiBzZXRfdHJhY2tfcHJlcGFyZSwKPj4gYW5kIHRyeSB0byBob2xk
IHRoZSBwZXJfY3B1KGhydGltZXJfYmFzZXMpW25dLmxvY2suCj4+IAo+PiBTbyBhdm9pZCB3YWtp
bmcgdXAga3N3YXBkLlRoZSBvb3BzIGxvb2tzIHNvbWV0aGluZyBsaWtlOgo+Cj5IaSB5YW5nc2hp
Z3VhbmcsIAo+Cj5JbiB0aGUgbmV4dCByZXZpc2lvbiwgY291bGQgeW91IHBsZWFzZSBlbGFib3Jh
dGUgdGhlIGNvbW1pdCBtZXNzYWdlCj50byByZWZsZWN0IGhvdyB0aGlzIGNoYW5nZSBhdm9pZHMg
d2FraW5nIHVwIGtzd2FwZD8KPgoKb2YgY291cnNlLiBUaGFua3MgZm9yIHRoZSByZW1pbmRlci4K
Cj4+IEJVRzogc3BpbmxvY2sgcmVjdXJzaW9uIG9uIENQVSMzLCBzd2FwcGVyLzMvMAo+PiAgbG9j
azogMHhmZmZmZmY4YTRiZjI5YzgwLCAubWFnaWM6IGRlYWQ0ZWFkLCAub3duZXI6IHN3YXBwZXIv
My8wLCAub3duZXJfY3B1OiAzCj4+IEhhcmR3YXJlIG5hbWU6IFF1YWxjb21tIFRlY2hub2xvZ2ll
cywgSW5jLiBQb3BzaWNsZSBiYXNlZCBvbiBTTTg4NTAgKERUKQo+PiBDYWxsIHRyYWNlOgo+PiBz
cGluX2J1ZysweDAKPj4gX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsweDgwCj4+IGhydGltZXJfdHJ5
X3RvX2NhbmNlbCsweDk0Cj4+IHRhc2tfY29udGVuZGluZysweDEwYwo+PiBlbnF1ZXVlX2RsX2Vu
dGl0eSsweDJhNAo+PiBkbF9zZXJ2ZXJfc3RhcnQrMHg3NAo+PiBlbnF1ZXVlX3Rhc2tfZmFpcisw
eDU2OAo+PiBlbnF1ZXVlX3Rhc2srMHhhYwo+PiBkb19hY3RpdmF0ZV90YXNrKzB4MTRjCj4+IHR0
d3VfZG9fYWN0aXZhdGUrMHhjYwo+PiB0cnlfdG9fd2FrZV91cCsweDZjOAo+PiBkZWZhdWx0X3dh
a2VfZnVuY3Rpb24rMHgyMAo+PiBhdXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24rMHgxYwo+PiBfX3dh
a2VfdXArMHhhYwo+PiB3YWtldXBfa3N3YXBkKzB4MTljCj4+IHdha2VfYWxsX2tzd2FwZHMrMHg3
OAo+PiBfX2FsbG9jX3BhZ2VzX3Nsb3dwYXRoKzB4MWFjCj4+IF9fYWxsb2NfcGFnZXNfbm9wcm9m
KzB4Mjk4Cj4+IHN0YWNrX2RlcG90X3NhdmVfZmxhZ3MrMHg2YjAKPj4gc3RhY2tfZGVwb3Rfc2F2
ZSsweDE0Cj4+IHNldF90cmFja19wcmVwYXJlKzB4NWMKPj4gX19fc2xhYl9hbGxvYysweGNjYwo+
PiBfX2ttYWxsb2NfY2FjaGVfbm9wcm9mKzB4NDcwCj4+IF9fc2V0X3BhZ2Vfb3duZXIrMHgyYmMK
Pj4gcG9zdF9hbGxvY19ob29rW2p0XSsweDFiOAo+PiBwcmVwX25ld19wYWdlKzB4MjgKPj4gZ2V0
X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDFlZGMKPj4gX19hbGxvY19wYWdlc19ub3Byb2YrMHgxM2MK
Pj4gYWxsb2Nfc2xhYl9wYWdlKzB4MjQ0Cj4+IGFsbG9jYXRlX3NsYWIrMHg3Ywo+PiBfX19zbGFi
X2FsbG9jKzB4OGU4Cj4+IGttZW1fY2FjaGVfYWxsb2Nfbm9wcm9mKzB4NDUwCj4+IGRlYnVnX29i
amVjdHNfZmlsbF9wb29sKzB4MjJjCj4+IGRlYnVnX29iamVjdF9hY3RpdmF0ZSsweDQwCj4+IGVu
cXVldWVfaHJ0aW1lcltqdF0rMHhkYwo+PiBocnRpbWVyX3N0YXJ0X3JhbmdlX25zKzB4NWY4Cj4+
IC4uLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogeWFuZ3NoaWd1YW5nIDx5YW5nc2hpZ3VhbmdAeGlh
b21pLmNvbT4KPj4gRml4ZXM6IDVjZjkwOWM1NTNlOSAoIm1tL3NsdWI6IHVzZSBzdGFja2RlcG90
IHRvIHNhdmUgc3RhY2sgdHJhY2UgaW4gb2JqZWN0cyIpCj4+IC0tLQo+PiB2MSAtPiB2MjoKPj4g
ICAgIHByb3BhZ2F0ZSBnZnAgZmxhZ3MgdG8gc2V0X3RyYWNrX3ByZXBhcmUoKQo+PiAKPj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgwMTA2NTEyMS44NzY3OTMtMS15YW5n
c2hpZ3VhbmcxMDExQDE2My5jb20gCj4+IC0tLQo+PiAgbW0vc2x1Yi5jIHwgMjEgKysrKysrKysr
KystLS0tLS0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jCj4+IGlu
ZGV4IDMwMDAzNzYzZDIyNC4uZGJhOTA1YmYxZTAzIDEwMDY0NAo+PiAtLS0gYS9tbS9zbHViLmMK
Pj4gKysrIGIvbW0vc2x1Yi5jCj4+IEBAIC05NjIsMTkgKzk2MiwyMCBAQCBzdGF0aWMgc3RydWN0
IHRyYWNrICpnZXRfdHJhY2soc3RydWN0IGttZW1fY2FjaGUgKnMsIHZvaWQgKm9iamVjdCwKPj4g
IH0KPj4gIAo+PiAgI2lmZGVmIENPTkZJR19TVEFDS0RFUE9UCj4+IC1zdGF0aWMgbm9pbmxpbmUg
ZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc2V0X3RyYWNrX3ByZXBhcmUodm9pZCkKPj4gK3N0YXRpYyBu
b2lubGluZSBkZXBvdF9zdGFja19oYW5kbGVfdCBzZXRfdHJhY2tfcHJlcGFyZShnZnBfdCBnZnBf
ZmxhZ3MpCj4+ICB7Cj4+ICAJZGVwb3Rfc3RhY2tfaGFuZGxlX3QgaGFuZGxlOwo+PiAgCXVuc2ln
bmVkIGxvbmcgZW50cmllc1tUUkFDS19BRERSU19DT1VOVF07Cj4+ICAJdW5zaWduZWQgaW50IG5y
X2VudHJpZXM7Cj4+ICsJZ2ZwX2ZsYWdzICY9IEdGUF9OT1dBSVQ7Cj4KPklzIHRoZXJlIGFueSBy
ZWFzb24gdG8gZG93bmdyYWRlIGl0IHRvIEdGUF9OT1dBSVQgd2hlbiB0aGUgZ2ZwIGZsYWcgYWxs
b3dzCj5kaXJlY3QgcmVjbGFtYXRpb24/Cj4KCkhpIEhhcnJ5LAoKVGhlIG9yaWdpbmFsIGFsbG9j
YXRpb24gaXMgR0ZQX05PV0FJVC4KU28gSSB0aGluayBpdCdzIGJldHRlciBub3QgdG8gaW5jcmVh
c2UgdGhlIGFsbG9jYXRpb24gY29zdCBoZXJlLgoKCj4+ICAJbnJfZW50cmllcyA9IHN0YWNrX3Ry
YWNlX3NhdmUoZW50cmllcywgQVJSQVlfU0laRShlbnRyaWVzKSwgMyk7Cj4+IC0JaGFuZGxlID0g
c3RhY2tfZGVwb3Rfc2F2ZShlbnRyaWVzLCBucl9lbnRyaWVzLCBHRlBfTk9XQUlUKTsKPj4gKwlo
YW5kbGUgPSBzdGFja19kZXBvdF9zYXZlKGVudHJpZXMsIG5yX2VudHJpZXMsIGdmcF9mbGFncyk7
Cj4+ICAKPj4gIAlyZXR1cm4gaGFuZGxlOwo+PiAgfQo+PiAgI2Vsc2UKPj4gLXN0YXRpYyBpbmxp
bmUgZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc2V0X3RyYWNrX3ByZXBhcmUodm9pZCkKPj4gK3N0YXRp
YyBpbmxpbmUgZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc2V0X3RyYWNrX3ByZXBhcmUoZ2ZwX3QgZ2Zw
X2ZsYWdzKQo+PiAgewo+PiAgCXJldHVybiAwOwo+PiAgfQo+PiBAQCAtNDQyMiw3ICs0NDIzLDcg
QEAgc3RhdGljIG5vaW5saW5lIHZvaWQgZnJlZV90b19wYXJ0aWFsX2xpc3QoCj4+ICAJZGVwb3Rf
c3RhY2tfaGFuZGxlX3QgaGFuZGxlID0gMDsKPj4gIAo+PiAgCWlmIChzLT5mbGFncyAmIFNMQUJf
U1RPUkVfVVNFUikKPj4gLQkJaGFuZGxlID0gc2V0X3RyYWNrX3ByZXBhcmUoKTsKPj4gKwkJaGFu
ZGxlID0gc2V0X3RyYWNrX3ByZXBhcmUoR0ZQX05PV0FJVCk7Cj4KPkkgZG9uJ3QgdGhpbmsgaXQg
aXMgc2FmZSB0byB1c2UgR0ZQX05PV0FJVCBkdXJpbmcgZnJlZT8KPgo+TGV0J3Mgc2F5IGZpbGxf
cG9vbCgpIC0+IGttZW1fYWxsb2NfYmF0Y2goKSBmYWlscyB0byBhbGxvY2F0ZSBhbiBvYmplY3QK
PmFuZCB0aGVuIGZyZWVfb2JqZWN0X2xpc3QoKSBmcmVlcyBhbGxvY2F0ZWQgb2JqZWN0cywKPnNl
dF90cmFja19wcmVwYXJlKEdGUF9OT1dBSVQpIG1heSB3YWtlIHVwIGtzd2FwZCwgYW5kIHRoZSBz
YW1lIGRlYWRsb2NrCj55b3UgcmVwb3J0ZWQgd2lsbCBvY2N1ci4KPgo+U28gSSB0aGluayBpdCBz
aG91bGQgYmUgX19HRlBfTk9XQVJOPwo+CgpZZXMsIHRoaXMgZW5zdXJlcyBzYWZldHkuCgo+LS0g
Cj5DaGVlcnMsCj5IYXJyeSAvIEh5ZW9uZ2dvbgo=

