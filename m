Return-Path: <stable+bounces-169856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F393B28CCA
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 12:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48AD16706A
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB45323CF12;
	Sat, 16 Aug 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="W25vRLbE"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1C82BCF5;
	Sat, 16 Aug 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339664; cv=none; b=qE3CiO2FNGp9WVY3sgJzbonjhoChzxbLCINoiW9zeFkDXQGtaDgi1pvVg64bFeeaAXHm0ZQR6WZyfBpjOzWrArpDWztR97uwp2XLfEGeko9q0+ngHsCTk4z4ezMvzIKfTpNy1JOrMyp60D+VB7Ro3mUcwBzMDtXbRXQ4/M1X6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339664; c=relaxed/simple;
	bh=u3vcP1lBVnENZMppNG6mdmonpAEbRBADf2rwRJ6BN5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JF7IhBSCGwBJodWSBJ8fd2ZM2wLREzsNWbb57Uip4SzcqdNd7GldMyOjhnyvFxvuYmzA3u6OrlExpNXhpkel25QhmpsztDjCFAXqe1lRGpay10ltpfI4GAMZaRTOApkEOICDBUWUTXuAG8H0HecJ7bEoY2pejoNRr/Mk8Hde4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=W25vRLbE reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=wrg0t2PbphWyz/QOYiTVFnbH1V3VtngoJhlCzXgrnEE=; b=W
	25vRLbEpbIAAA6VINlcvgN5zwSgC4GzhE+Jhli+Hz4PQKmtdC7ux4pt3xMiIcai5
	v3Q0oWvq7+xmIgVSc1WpVTn/NR9kU4h46OSoihJjPUOXZ27soar+K6MIhSdT+FmL
	bl3GiN1ppxRnDDKWrXe4aSSS0vr1EXnIB7o1aTPT3g=
Received: from yangshiguang1011$163.com (
 [2408:8607:1b00:8:9e7b:efff:fe4e:6d16] ) by ajax-webmail-wmsvr-40-116
 (Coremail) ; Sat, 16 Aug 2025 18:19:47 +0800 (CST)
Date: Sat, 16 Aug 2025 18:19:47 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Giorgi Tchankvetadze" <giorgitchankvetadze1997@gmail.com>
Cc: "Harry Yoo" <harry.yoo@oracle.com>, vbabka@suse.cz,
	akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com,
	roman.gushchin@linux.dev, glittao@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	yangshiguang <yangshiguang@xiaomi.com>
Subject: Re:Re: [PATCH v2] mm: slub: avoid wake up kswapd in
 set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <eab6a734-b134-41a4-b455-7269eaaf033e@gmail.com>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry> <eab6a734-b134-41a4-b455-7269eaaf033e@gmail.com>
X-NTES-SC: AL_Qu2eB/+Ytk0j4SCdbOkfmUgRj+k6WsK3s/sn3oNfP5B+jD3p0T0ceV9KLFv96vuKKB6rvRGeUwZw9/RYepVacKsL+ubBcCt7hctOdgCiQVWVWA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <11842dc2.2720.198b2647df8.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCgvCgD3P+xDW6BoZ3YbAA--.606W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiSByr5WigMtzoyQAMsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkF0IDIwMjUtMDgtMTYgMTc6MzM6MDAsICJHaW9yZ2kgVGNoYW5rdmV0YWR6ZSIgPGdpb3Jn
aXRjaGFua3ZldGFkemUxOTk3QGdtYWlsLmNvbT4gd3JvdGU6Cj5SYXRoZXIgdGhhbiBtYXNraW5n
IHRvIEdGUF9OT1dBSVShqndoaWNoIHN0aWxsIGFsbG93cyBrc3dhcGQgdG8gYmUgCj53b2tlbqGq
bGV0oa9zIHN0cmlwIGV2ZXJ5IHJlY2xhaW0gYml0IChgX19HRlBfUkVDTEFJTWAgYW5kIAo+YF9f
R0ZQX0tTV0FQRF9SRUNMQUlNYCkgYW5kIGFkZCBgX19HRlBfTk9SRVRSWSB8IF9fR0ZQX05PV0FS
TmAuIFRoYXQgCj5ndWFyYW50ZWVzIHdlIG5ldmVyIGVudGVyIHRoZSBzbG93IHBhdGggdGhhdCBj
YWxscyBgd2FrZXVwX2tzd2FwZCgpYCwgc28gCj50aGUgdGltZXItYmFzZSBsb2NrIGNhbqGvdCBi
ZSByZS1lbnRlcmVkLgoKPgoKSGkgR2lvcmdpLApUaGFua3MgZm9yIHlvdXIgYWR2aWNlLgpCdXQg
bW9yZSBzY2VuYXJpb3MgYWxsb3cga3N3YXBkIHRvIGJlIHdva2VuIHVwLgpJdCBtaWdodCBiZSBi
ZXR0ZXIgdG8gYWxsb3cga3N3YXBkIHRvIGJlIHdva2VuIHVwLgoKPk9uIDgvMTYvMjAyNSAxMjoy
NSBQTSwgSGFycnkgWW9vIHdyb3RlOgo+PiBPbiBUaHUsIEF1ZyAxNCwgMjAyNSBhdCAwNzoxNjo0
MlBNICswODAwLCB5YW5nc2hpZ3VhbmcxMDExQDE2My5jb20gd3JvdGU6Cj4+PiBGcm9tOiB5YW5n
c2hpZ3VhbmcgPHlhbmdzaGlndWFuZ0B4aWFvbWkuY29tPgo+Pj4KPj4+IEZyb206IHlhbmdzaGln
dWFuZyA8eWFuZ3NoaWd1YW5nQHhpYW9taS5jb20+Cj4+Pgo+Pj4gc2V0X3RyYWNrX3ByZXBhcmUo
KSBjYW4gaW5jdXIgbG9jayByZWN1cnNpb24uCj4+PiBUaGUgaXNzdWUgaXMgdGhhdCBpdCBpcyBj
YWxsZWQgZnJvbSBocnRpbWVyX3N0YXJ0X3JhbmdlX25zCj4+PiBob2xkaW5nIHRoZSBwZXJfY3B1
KGhydGltZXJfYmFzZXMpW25dLmxvY2ssIGJ1dCB3aGVuIGVuYWJsZWQKPj4+IENPTkZJR19ERUJV
R19PQkpFQ1RTX1RJTUVSUywgbWF5IHdha2UgdXAga3N3YXBkIGluIHNldF90cmFja19wcmVwYXJl
LAo+Pj4gYW5kIHRyeSB0byBob2xkIHRoZSBwZXJfY3B1KGhydGltZXJfYmFzZXMpW25dLmxvY2su
Cj4+Pgo+Pj4gU28gYXZvaWQgd2FraW5nIHVwIGtzd2FwZC5UaGUgb29wcyBsb29rcyBzb21ldGhp
bmcgbGlrZToKPj4gCj4+IEhpIHlhbmdzaGlndWFuZywKPj4gCj4+IEluIHRoZSBuZXh0IHJldmlz
aW9uLCBjb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UKPj4gdG8g
cmVmbGVjdCBob3cgdGhpcyBjaGFuZ2UgYXZvaWRzIHdha2luZyB1cCBrc3dhcGQ/Cj4+IAo+Pj4g
QlVHOiBzcGlubG9jayByZWN1cnNpb24gb24gQ1BVIzMsIHN3YXBwZXIvMy8wCj4+PiAgIGxvY2s6
IDB4ZmZmZmZmOGE0YmYyOWM4MCwgLm1hZ2ljOiBkZWFkNGVhZCwgLm93bmVyOiBzd2FwcGVyLzMv
MCwgLm93bmVyX2NwdTogMwo+Pj4gSGFyZHdhcmUgbmFtZTogUXVhbGNvbW0gVGVjaG5vbG9naWVz
LCBJbmMuIFBvcHNpY2xlIGJhc2VkIG9uIFNNODg1MCAoRFQpCj4+PiBDYWxsIHRyYWNlOgo+Pj4g
c3Bpbl9idWcrMHgwCj4+PiBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4ODAKPj4+IGhydGltZXJf
dHJ5X3RvX2NhbmNlbCsweDk0Cj4+PiB0YXNrX2NvbnRlbmRpbmcrMHgxMGMKPj4+IGVucXVldWVf
ZGxfZW50aXR5KzB4MmE0Cj4+PiBkbF9zZXJ2ZXJfc3RhcnQrMHg3NAo+Pj4gZW5xdWV1ZV90YXNr
X2ZhaXIrMHg1NjgKPj4+IGVucXVldWVfdGFzaysweGFjCj4+PiBkb19hY3RpdmF0ZV90YXNrKzB4
MTRjCj4+PiB0dHd1X2RvX2FjdGl2YXRlKzB4Y2MKPj4+IHRyeV90b193YWtlX3VwKzB4NmM4Cj4+
PiBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgyMAo+Pj4gYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9u
KzB4MWMKPj4+IF9fd2FrZV91cCsweGFjCj4+PiB3YWtldXBfa3N3YXBkKzB4MTljCj4+PiB3YWtl
X2FsbF9rc3dhcGRzKzB4NzgKPj4+IF9fYWxsb2NfcGFnZXNfc2xvd3BhdGgrMHgxYWMKPj4+IF9f
YWxsb2NfcGFnZXNfbm9wcm9mKzB4Mjk4Cj4+PiBzdGFja19kZXBvdF9zYXZlX2ZsYWdzKzB4NmIw
Cj4+PiBzdGFja19kZXBvdF9zYXZlKzB4MTQKPj4+IHNldF90cmFja19wcmVwYXJlKzB4NWMKPj4+
IF9fX3NsYWJfYWxsb2MrMHhjY2MKPj4+IF9fa21hbGxvY19jYWNoZV9ub3Byb2YrMHg0NzAKPj4+
IF9fc2V0X3BhZ2Vfb3duZXIrMHgyYmMKPj4+IHBvc3RfYWxsb2NfaG9va1tqdF0rMHgxYjgKPj4+
IHByZXBfbmV3X3BhZ2UrMHgyOAo+Pj4gZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDFlZGMKPj4+
IF9fYWxsb2NfcGFnZXNfbm9wcm9mKzB4MTNjCj4+PiBhbGxvY19zbGFiX3BhZ2UrMHgyNDQKPj4+
IGFsbG9jYXRlX3NsYWIrMHg3Ywo+Pj4gX19fc2xhYl9hbGxvYysweDhlOAo+Pj4ga21lbV9jYWNo
ZV9hbGxvY19ub3Byb2YrMHg0NTAKPj4+IGRlYnVnX29iamVjdHNfZmlsbF9wb29sKzB4MjJjCj4+
PiBkZWJ1Z19vYmplY3RfYWN0aXZhdGUrMHg0MAo+Pj4gZW5xdWV1ZV9ocnRpbWVyW2p0XSsweGRj
Cj4+PiBocnRpbWVyX3N0YXJ0X3JhbmdlX25zKzB4NWY4Cj4+PiAuLi4KPj4+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiB5YW5nc2hpZ3VhbmcgPHlhbmdzaGlndWFuZ0B4aWFvbWkuY29tPgo+Pj4gRml4ZXM6
IDVjZjkwOWM1NTNlOSAoIm1tL3NsdWI6IHVzZSBzdGFja2RlcG90IHRvIHNhdmUgc3RhY2sgdHJh
Y2UgaW4gb2JqZWN0cyIpCj4+PiAtLS0KPj4+IHYxIC0+IHYyOgo+Pj4gICAgICBwcm9wYWdhdGUg
Z2ZwIGZsYWdzIHRvIHNldF90cmFja19wcmVwYXJlKCkKPj4+Cj4+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjUwODAxMDY1MTIxLjg3Njc5My0xLXlhbmdzaGlndWFuZzEwMTFA
MTYzLmNvbQo+Pj4gLS0tCj4+PiAgIG1tL3NsdWIuYyB8IDIxICsrKysrKysrKysrLS0tLS0tLS0t
LQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL21tL3NsdWIuYyBiL21tL3NsdWIuYwo+Pj4gaW5kZXggMzAw
MDM3NjNkMjI0Li5kYmE5MDViZjFlMDMgMTAwNjQ0Cj4+PiAtLS0gYS9tbS9zbHViLmMKPj4+ICsr
KyBiL21tL3NsdWIuYwo+Pj4gQEAgLTk2MiwxOSArOTYyLDIwIEBAIHN0YXRpYyBzdHJ1Y3QgdHJh
Y2sgKmdldF90cmFjayhzdHJ1Y3Qga21lbV9jYWNoZSAqcywgdm9pZCAqb2JqZWN0LAo+Pj4gICB9
Cj4+PiAgIAo+Pj4gICAjaWZkZWYgQ09ORklHX1NUQUNLREVQT1QKPj4+IC1zdGF0aWMgbm9pbmxp
bmUgZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc2V0X3RyYWNrX3ByZXBhcmUodm9pZCkKPj4+ICtzdGF0
aWMgbm9pbmxpbmUgZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc2V0X3RyYWNrX3ByZXBhcmUoZ2ZwX3Qg
Z2ZwX2ZsYWdzKQo+Pj4gICB7Cj4+PiAgIAlkZXBvdF9zdGFja19oYW5kbGVfdCBoYW5kbGU7Cj4+
PiAgIAl1bnNpZ25lZCBsb25nIGVudHJpZXNbVFJBQ0tfQUREUlNfQ09VTlRdOwo+Pj4gICAJdW5z
aWduZWQgaW50IG5yX2VudHJpZXM7Cj4+PiArCWdmcF9mbGFncyAmPSBHRlBfTk9XQUlUOwo+PiAK
Pj4gSXMgdGhlcmUgYW55IHJlYXNvbiB0byBkb3duZ3JhZGUgaXQgdG8gR0ZQX05PV0FJVCB3aGVu
IHRoZSBnZnAgZmxhZyBhbGxvd3MKPj4gZGlyZWN0IHJlY2xhbWF0aW9uPwo+PiAKPj4+ICAgCW5y
X2VudHJpZXMgPSBzdGFja190cmFjZV9zYXZlKGVudHJpZXMsIEFSUkFZX1NJWkUoZW50cmllcyks
IDMpOwo+Pj4gLQloYW5kbGUgPSBzdGFja19kZXBvdF9zYXZlKGVudHJpZXMsIG5yX2VudHJpZXMs
IEdGUF9OT1dBSVQpOwo+Pj4gKwloYW5kbGUgPSBzdGFja19kZXBvdF9zYXZlKGVudHJpZXMsIG5y
X2VudHJpZXMsIGdmcF9mbGFncyk7Cj4+PiAgIAo+Pj4gICAJcmV0dXJuIGhhbmRsZTsKPj4+ICAg
fQo+Pj4gICAjZWxzZQo+Pj4gLXN0YXRpYyBpbmxpbmUgZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc2V0
X3RyYWNrX3ByZXBhcmUodm9pZCkKPj4+ICtzdGF0aWMgaW5saW5lIGRlcG90X3N0YWNrX2hhbmRs
ZV90IHNldF90cmFja19wcmVwYXJlKGdmcF90IGdmcF9mbGFncykKPj4+ICAgewo+Pj4gICAJcmV0
dXJuIDA7Cj4+PiAgIH0KPj4+IEBAIC00NDIyLDcgKzQ0MjMsNyBAQCBzdGF0aWMgbm9pbmxpbmUg
dm9pZCBmcmVlX3RvX3BhcnRpYWxfbGlzdCgKPj4+ICAgCWRlcG90X3N0YWNrX2hhbmRsZV90IGhh
bmRsZSA9IDA7Cj4+PiAgIAo+Pj4gICAJaWYgKHMtPmZsYWdzICYgU0xBQl9TVE9SRV9VU0VSKQo+
Pj4gLQkJaGFuZGxlID0gc2V0X3RyYWNrX3ByZXBhcmUoKTsKPj4+ICsJCWhhbmRsZSA9IHNldF90
cmFja19wcmVwYXJlKEdGUF9OT1dBSVQpOwo+PiAKPj4gSSBkb24ndCB0aGluayBpdCBpcyBzYWZl
IHRvIHVzZSBHRlBfTk9XQUlUIGR1cmluZyBmcmVlPwo+PiAKPj4gTGV0J3Mgc2F5IGZpbGxfcG9v
bCgpIC0+IGttZW1fYWxsb2NfYmF0Y2goKSBmYWlscyB0byBhbGxvY2F0ZSBhbiBvYmplY3QKPj4g
YW5kIHRoZW4gZnJlZV9vYmplY3RfbGlzdCgpIGZyZWVzIGFsbG9jYXRlZCBvYmplY3RzLAo+PiBz
ZXRfdHJhY2tfcHJlcGFyZShHRlBfTk9XQUlUKSBtYXkgd2FrZSB1cCBrc3dhcGQsIGFuZCB0aGUg
c2FtZSBkZWFkbG9jawo+PiB5b3UgcmVwb3J0ZWQgd2lsbCBvY2N1ci4KPj4gCj4+IFNvIEkgdGhp
bmsgaXQgc2hvdWxkIGJlIF9fR0ZQX05PV0FSTj8KPj4gCg==

