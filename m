Return-Path: <stable+bounces-203253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B6CD7D76
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 03:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3AB1308CDF3
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D115245019;
	Tue, 23 Dec 2025 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k1WuLttV"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0E241139;
	Tue, 23 Dec 2025 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456000; cv=none; b=BfcNhpHPhRKeTOjZMYTxkXuFHloPqrhumEbLgjMasiNwO/gPCoNreoBbc9NK46RGSMgesnBq9qeSDUKHg1pnX/sd9gDn1yyztnftOauD1lheF3JOXhNSi8xM92aVnfqDofc0/gIYtIPB5YtIKq4VFOViDNtwgBK+6rHm9mc4480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456000; c=relaxed/simple;
	bh=648rRg+hOSzNRKw+yyVAoSREWX+JjCJ6kudABfFJIgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kwA22na2aVBsLx1p5mPFk2JoOsQX83MiDSO+cL9viLCL28Mn1p6lvkl0/pZDeYzrmUkkawf7qH6VDt7OORUh7WYFYUb1t6vFiIWzpwNOCvZC28dIGmdKh2uOnpSf3ev9/vKPTPZDBkTRIou+E/d6gZ2UfaktbgycK5kGxHoAEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k1WuLttV; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=648rRg+hOSzNRKw+yyVAoSREWX+JjCJ6kudABfFJIgA=; b=k
	1WuLttVr8CaHsW3abU+U3K/+BTAmC7cmD0J4n1ngjyzfucS4kumtSNOmLqUQtoKK
	RaxVi+n5adlcvvohD0Aln5HHbB/KYshIzD3qPuTux+oA4jzjHzAMjR9g6Dnw2iPq
	SGRkz3n4a6zB9TTM/xFQObA7mDXhQQqtzpfcCxW5c8=
Received: from yangshiguang1011$163.com (
 [2408:8607:1b00:8:31a3:f19c:feca:995b] ) by ajax-webmail-wmsvr-40-136
 (Coremail) ; Tue, 23 Dec 2025 10:12:48 +0800 (CST)
Date: Tue, 23 Dec 2025 10:12:48 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, dakr@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, yangshiguang@xiaomi.com,
	stable@vger.kernel.org
Subject: Re:Re: Re: [PATCH] debugfs: Fix NULL pointer dereference at
 debugfs_read_file_str
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <2025122221-gag-malt-75ba@gregkh>
References: <20251222093615.663252-2-yangshiguang1011@163.com>
 <2025122234-crazy-remix-3098@gregkh>
 <17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com>
 <2025122221-gag-malt-75ba@gregkh>
X-NTES-SC: AL_Qu2dBPieukEt7iiQYekfmUgRj+k6WsK3s/sn3oNfP5B+jCnr8xo9UV1mEXzp+c2RCya0rj2OXT10yO9le4tlVowg9y6sWm0Uvez88G3yngCXoQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2de8b181.5007.19b48fb047f.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgDnz_Kh+klpR2FHAA--.2719W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/xtbC3gCTeWlJ+qBz6QAA3U
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0xMi0yMiAyMjoxMTozOCwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gd3JvdGU6Cj5PbiBNb24sIERlYyAyMiwgMjAyNSBhdCAwODo0MTozM1BNICswODAwLCB5
YW5nc2hpZ3Vhbmcgd3JvdGU6Cj4+IAo+PiBBdCAyMDI1LTEyLTIyIDE5OjU0OjIyLCAiR3JlZyBL
SCIgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPj4gPk9uIE1vbiwgRGVjIDIy
LCAyMDI1IGF0IDA1OjM2OjE2UE0gKzA4MDAsIHlhbmdzaGlndWFuZzEwMTFAMTYzLmNvbSB3cm90
ZToKPj4gPj4gRnJvbTogeWFuZ3NoaWd1YW5nIDx5YW5nc2hpZ3VhbmdAeGlhb21pLmNvbT4KPj4g
Pj4gCj4+ID4+IENoZWNrIGluIGRlYnVnZnNfcmVhZF9maWxlX3N0cigpIGlmIHRoZSBzdHJpbmcg
cG9pbnRlciBpcyBOVUxMLgo+PiA+PiAKPj4gPj4gV2hlbiBjcmVhdGluZyBhIG5vZGUgdXNpbmcg
ZGVidWdmc19jcmVhdGVfc3RyKCksIHRoZSBzdHJpbmcgcGFyYW1ldGVyCj4+ID4+IHZhbHVlIGNh
biBiZSBOVUxMIHRvIGluZGljYXRlIGVtcHR5L3VudXNlZC9pZ25vcmVkLgo+PiA+Cj4+ID5XaHkg
d291bGQgeW91IGNyZWF0ZSBhbiBlbXB0eSBkZWJ1Z2ZzIHN0cmluZyBmaWxlPyAgVGhhdCBpcyBu
b3Qgb2ssIHdlCj4+ID5zaG91bGQgY2hhbmdlIHRoYXQgdG8gbm90IGFsbG93IHRoaXMuCj4+IAo+
PiBIaSBncmVnIGstaCwKPj4gCj4+IFRoYW5rcyBmb3IgeW91ciByZXBseS4KPj4gCj4+IFRoaXMg
aXMgZHVlIHRvIHRoZSB1c2FnZSBzdGVwLCBzaG91bGQgd3JpdGUgZmlyc3QgYW5kIHRoZW4gcmVh
ZC4KPj4gSG93ZXZlciwgdGhlcmUgaXMgbm8gd2F5IHRvIGd1YXJhbnRlZSB0aGF0IGV2ZXJ5b25l
IHdpbGwga25vdyBhYm91dCB0aGlzIHN0ZXAuCj4KPlRydWUuCj4KPj4gQW5kIGRlYnVnZnNfY3Jl
YXRlX3N0cigpIGFsbG93cyBwYXNzaW5nIGluIGEgTlVMTCBzdHJpbmcuIAo+Cj5UaGVuIHdlIHNo
b3VsZCBmaXggdGhhdCA6KQo+Cj4+IFRoZXJlZm9yZSwgd2hlbiByZWFkaW5nIGEgTlVMTCBzdHJp
bmcsIHNob3VsZCByZXR1cm4gYW4gaW52YWxpZCBlcnJvciAKPj4gaW5zdGVhZCBvZiBwYW5pYy4K
Pgo+SWYgeW91IGNhbGwgd3JpdGUgb24gYSBOVUxMIHN0cmluZywgdGhlbiB5b3UgY291bGQgY2Fs
bCBzdHJsZW4oKSBvZiB0aGF0Cj5OVUxMIHN0cmluZywgYW5kIGRvIGEgbWVtY3B5IG91dCBvZiB0
aGF0IE5VTEwgc3RyaW5nLiAgQWxsIG5vdCBnb29kCj50aGluZ3MsIHNvIHlvdXIgcXVpY2sgZml4
IGhlcmUgcmVhbGx5IGRvZXNuJ3Qgc29sdmUgdGhlIHJvb3QgcHJvYmxlbSA6KAo+CgpXZSBhbGwg
a25vdyB0aGF0IHRoZSBwcm9ibGVtIGlzIGEgTlVMTCBwb2ludGVyIGV4Y2VwdGlvbnMgdGhhdCBv
Y2N1ciBpbiBzdHJsZW4oKS4KSG93ZXZlciwgc3RybGVuKCkgaXMgYmFzaWMgZnVuY3Rpb24sIGFu
ZCB3ZSBjYW5ub3QgcGFzcyBhYm5vcm1hbCBwYXJhbWV0ZXJzLgpXZSBzaG91bGQgaW50ZXJjZXB0
IHRoZW0sIGFuZCB0aGlzIGlzIGNvbW1vbiBpbiB0aGUga2VybmVsLgpUaGF0J3Mgd2h5IEkgc3Vi
bWl0dGVkIHRoaXMgcGF0Y2guCgo+PiA+PiAgCXN0ciA9ICooY2hhciAqKilmaWxlLT5wcml2YXRl
X2RhdGE7Cj4+ID4+ICsJaWYgKCFzdHIpCj4+ID4+ICsJCXJldHVybiAtRUlOVkFMOwo+PiA+Cj4+
ID5XaGF0IGluIGtlcm5lbCB1c2VyIGNhdXNlcyB0aGlzIHRvIGhhcHBlbj8gIExldCdzIGZpeCB0
aGF0IHVwIGluc3RlYWQKPj4gPnBsZWFzZS4KPj4gPgo+PiAKPj4gQ3VycmVudGx5IEkga25vd24g
cHJvYmxlbWF0aWMgbm9kZXMgaW4gdGhlIGtlcm5lbDoKPj4gCj4+IGRyaXZlcnMvaW50ZXJjb25u
ZWN0L2RlYnVnZnMtY2xpZW50LmM6Cj4+ICAgMTU1OiAJZGVidWdmc19jcmVhdGVfc3RyKCJzcmNf
bm9kZSIsIDA2MDAsIGNsaWVudF9kaXIsICZzcmNfbm9kZSk7Cj4+ICAgMTU2OiAJZGVidWdmc19j
cmVhdGVfc3RyKCJkc3Rfbm9kZSIsIDA2MDAsIGNsaWVudF9kaXIsICZkc3Rfbm9kZSk7Cj4KPklj
aywgb2ssIHRoYXQgc2hvdWxkIGJlIGZpeGVkLgo+Cj4+IGRyaXZlcnMvc291bmR3aXJlL2RlYnVn
ZnMuYzoKPj4gICAzNjI6IAlkZWJ1Z2ZzX2NyZWF0ZV9zdHIoImZpcm13YXJlX2ZpbGUiLCAwMjAw
LCBkLCAmZmlybXdhcmVfZmlsZSk7Cj4KPlRoYXQgdG9vIHNob3VsZCBiZSBmaXhlZCwgYWxsIHNo
b3VsZCBqdXN0IGNyZWF0ZSBhbiAiZW1wdHkiIHN0cmluZyB0bwo+c3RhcnQgd2l0aC4KPgo+PiB0
ZXN0IGNhc2U6Cj4+IDEuIGNyZWF0ZSBhIE5VTEwgc3RyaW5nIG5vZGUKPj4gY2hhciAqdGVzdF9u
b2RlID0gTlVMTDsKPj4gZGVidWdmc19jcmVhdGVfc3RyKCJ0ZXN0X25vZGUiLCAwNjAwLCBwYXJl
bnRfZGlyLCAmdGVzdF9ub2RlKTsKPj4gCj4+IDIuIHJlYWQgdGhlIG5vZGUsIGxpa2UgYmVsbG93
Ogo+PiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvdGVzdF9ub2RlCj4KPldpdGggeW91ciBwYXRjaCwg
eW91IGNvdWxkIGNoYW5nZSBzdGVwIDIgdG8gZG8gYSB3cml0ZSwgYW5kIHN0aWxsIGNhdXNlCj5h
IGNyYXNoIDopCj4KClRoaXMgc2hvdWxkbid0IGhhcHBlbi4gVGhlIHdyaXRlIG5vZGUgY2FsbHMg
ZGVidWdmc193cml0ZV9maWxlX3N0cigpLgpNeSB0ZXN0IHJlc3VsdHM6CiQ6IGNhdCBkc3Rfbm9k
ZQokOiBjYXQ6IGRzdF9ub2RlOiBJbnZhbGlkIGFyZ3VtZW50CjF8JjogZWNobyAxID4gZHN0X25v
ZGUKJDogY2F0IGRzdF9ub2RlCiQ6IDEKCkFueXdheSwgcGxlYXNlIHNob3cgdGhlIHN0YWNrLgoK
PlNvIGxldCdzIGZpeCB0aGlzIHByb3Blcmx5LCBsZXQncyBqdXN0IGZhaWwgdGhlIGNyZWF0aW9u
IG9mIE5VTEwKPnN0cmluZ3MsIGFuZCBmaXggdXAgYWxsIGNhbGxlcnMuCj4KCkFzIG1lbnRpb25l
ZCBhYm92ZSwgd2Ugc2hvbGQgYWxsb3cgdGhlIGNyZWF0aW9uIG9mIE5VTEwgc3RyaW5nIG5vZGVz
CnRvIGluZGljYXRlIGVtcHR5L3VudXNlZC9pZ25vcmVkLgoKPnRoYW5rcywKPgo+Z3JlZyBrLWgK


