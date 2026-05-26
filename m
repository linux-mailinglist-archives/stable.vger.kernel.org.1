Return-Path: <stable+bounces-254329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL4zMzeNFWrUWQcAu9opvQ
	(envelope-from <stable+bounces-254329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:08:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF65D5D54DE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B35A3008466
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB83DDDBB;
	Tue, 26 May 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SSXcpjGy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF91B4257;
	Tue, 26 May 2026 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797294; cv=none; b=d0lV8UC68an4A/H2FZGFGm+gJ6VN2jLJZ9QamBC2A5VwB4liant/IQ7cdtCUuO/qbcAKvnGHkn0N7sUWc5Qn/lCZdOtU6MOvjbcfuhzigiASOMnMy/g5a3Xok4wy2gMIA26EZdBHC9G7udD1Gb9E2m/EWnw0F0AOC5rVf4e1m/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797294; c=relaxed/simple;
	bh=1MdOEH4FWXiWKeE/kCEFwFy+r+6+6c969EcWKnH6xAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bQ85hR97MAk+V9ZQeyT5fWdf0sZhOsT6q94CAxsYNq1+pleoJxpBUAhhX7K/SyMQCPfs5IuceUJV/T76l0z7ovQkaFZb5iqfukhtON6UkR0c+QyqTPmVlcbtM+tDt7l70AcE1AtchdoDQE4l0LDGTWmLLdNP2qp+M4HZCeuYZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SSXcpjGy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1MdOEH4FWXiWKeE/kCEFwFy+r+6+6c969EcWKnH6xAs=; b=S
	SXcpjGy+7E0J8cK0lj7yYa8DxV+7BWnmmnEW8CN5krYl37NpPqMl5BC1YSyA1iDn
	hR19hlUESi8+zav8Je9TtU237DO69f2utrpz88SsdDE+QFiJxx8Wzn6t4b0RUnwz
	poMrkd5Lb9NpXLKob2ey+dG2Sh67+65xWRffFvSRYM=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Tue, 26 May 2026 20:06:59 +0800
 (CST)
Date: Tue, 26 May 2026 20:06:59 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Sasha Levin" <sashal@kernel.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer
 to fix ABBA deadlock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260525231000.agent5-0001@kernel.org>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
 <20260525131610.608273-1-w15303746062@163.com>
 <20260525231000.agent5-0001@kernel.org>
X-NTES-SC: AL_Qu2cC/uSuEoq7yWRbOkfmU0Qguw9Xcq5uPkj34FWN5t8jCrr+ScQXEB9PUv50tuDMAuVihKOaARIx+pFfqh7RpoTF7tdhwCbHx9uN8X99aBCXA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51ff85d2.9c25.19e642e591c.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jSgvCgD3X2bjjBVqr76sAA--.13476W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wM7H2oVjOM8CQAA39
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spamd-Result: default: False [-0.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[163.com]
X-Rspamd-Queue-Id: CF65D5D54DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CkhpIFNhc2hhLAoKPkxvb2tpbmcgYXQgdGhlIGZpdmUgY29tbWl0czoKPgo+ICAtIDEvNSAoNzRh
ZmViODEyODUwKSBpcyB0aGUgb25lIHRoYXQgYWN0dWFsbHkgZml4ZXMgdGhlIEFCQkEKPiAgICBk
ZWFkbG9jayB5b3Ugb2JzZXJ2ZWQgdW5kZXIgU3l6a2FsbGVyOyBpdCBhZGRzIHRoZSBnZW5lcmlj
IHZibGFuawo+ICAgIHRpbWVyIHRoYXQgcmVwbGFjZXMgdGhlIG9wZW4tY29kZWQgdmttcyBocnRp
bWVyIHBhdGguCj4KPiAgLSAyLzUgKGQ1NGRiYjU5NjNiZCkgYWRkcyBuZXcgQ1JUQyBoZWxwZXJz
IGZvciAic2ltcGxlIHVzZSBjYXNlcyIuCj4gICAgTm8gRml4ZXM6L0NjOnN0YWJsZSwgbm8gZGVz
Y3JpYmVkIGJ1Zy4KPgo+ICAtIDMvNSAoMDJlMjY4MWZmZTFhKSBpcyBhIHJlZmFjdG9yIHRoYXQg
Y29udmVydHMgdmttcyB0byB0aGUgbmV3Cj4gICAgaGVscGVycy4gTm8gRml4ZXM6L0NjOnN0YWJs
ZSwgbm8gZGVzY3JpYmVkIGJ1Zy4KPgo+ICAtIDQvNSAoNzlhZTg1MTBiNWI4KSBpcyBhIHY3LjEt
cmMxIHRpbWVvdXQgYnVtcCB0aGF0IGRlcGVuZHMgb24gMS81Lgo+ICAgIEl0IGlzIG5vdCB5ZXQg
aW4gYW55IHJlbGVhc2VkIHN0YWJsZSwgc28gYXBwbHlpbmcgaXQgdG8gNi4xOC55Cj4gICAgd291
bGQgcHV0IGl0IG9uIGFuIExUUyBiZWZvcmUgYW55IExUUyBjb250YWlucyBpdC4KPgo+ICAtIDUv
NSAoMzk0NmQzYmE5OTM0KSBpcyBhIGRvYyBmaXggZm9yIDEvNS4KPgo+UGVyIHN0YWJsZS1rZXJu
ZWwtcnVsZXMsIHdoYXQgSSBuZWVkIHRvIHF1ZXVlIGlzIHRoZSBtaW5pbXVtIHNldCB0aGF0Cj5m
aXhlcyB0aGUgYnVnLiBDb3VsZCB5b3UgZXhwbGFpbiwgcGVyIHBhdGNoLCB3aHkgMi81Li41LzUg
YXJlIHJlcXVpcmVkCj50byBtYWtlIDEvNSB3b3JrIC8gYXJlIHJlcXVpcmVkIHRvIGFjdHVhbGx5
IGZpeCB0aGUgZGVhZGxvY2s/IElmIG9ubHkKPjEvNSBpcyBuZWVkZWQsIHBsZWFzZSByZXNlbmQg
anVzdCB0aGF0IG9uZSB3aXRoIHlvdXIgU2lnbmVkLW9mZi1ieQo+YWRkZWQgKHRoZSBjYXJyaWVk
IHBhdGNoZXMgdG9kYXkgb25seSBoYXZlIFRob21hcydzIFMtby1iLCB3aGljaAo+YnJlYWtzIHRo
ZSBjaGFpbiBvZiBjdXN0b2R5IG9uIGEgc3RhYmxlIHN1Ym1pc3Npb24pLgoKVGhhbmtzIGZvciB0
aGUgcXVpY2sgcmV2aWV3IGFuZCBmb3IgcG9pbnRpbmcgb3V0IHRoZSBtaXNzaW5nIFNpZ25lZC1v
ZmYtYnkuIEkgYXBvbG9naXplIGZvciB0aGF0IG9taXNzaW9uOyBpdCB3YXMgbXkgbWlzdGFrZSBk
dXJpbmcgdGhlIGNoZXJyeS1waWNrIHByb2Nlc3MuCgpSZWdhcmRpbmcgdGhlIGRlcGVuZGVuY3kg
Y2hhaW4sIEkgd291bGQgbGlrZSB0byBjbGFyaWZ5IHdoeSBjb21taXQgMS81IGFsb25lIGNhbm5v
dCBmaXggdGhlIGlzc3VlOgoKQ29tbWl0cyAxLzUgYW5kIDIvNSBpbnRyb2R1Y2UgdGhlIG5ldyBn
ZW5lcmljIHZibGFuayB0aW1lciBpbmZyYXN0cnVjdHVyZSB0byB0aGUgRFJNIGNvcmUgYnV0IGRv
ICpub3QqIHRvdWNoIHRoZSB2a21zIGRyaXZlciBhdCBhbGwuIApDb21taXQgMy81ICgwMmUyNjgx
ZmZlMWEpIGlzIHRoZSBhY3R1YWwgZml4IHRoYXQgbW9kaWZpZXMgYGRyaXZlcnMvZ3B1L2RybS92
a21zL3ZrbXNfY3J0Yy5jYC4gSXQgcmVtb3ZlcyB0aGUgYnVnZ3kgb3Blbi1jb2RlZCBocnRpbWVy
IHRoYXQgY2F1c2VzIHRoZSBBQkJBIGRlYWRsb2NrIGFuZCBzd2l0Y2hlcyB2a21zIHRvIHVzZSB0
aGUgbmV3IGluZnJhc3RydWN0dXJlIGludHJvZHVjZWQgaW4gMS81IGFuZCAyLzUuIAoKVGhlcmVm
b3JlLCAxLzUsIDIvNSwgYW5kIDMvNSBmb3JtIGFuIGluZGl2aXNpYmxlIHNldC4gQXBwbHlpbmcg
b25seSAxLzUgd291bGQgbGVhdmUgdGhlIGRlYWRsb2NrIGluIHZrbXMgY29tcGxldGVseSB1bnBh
dGNoZWQuCgpBcyBmb3IgNC81IGFuZCA1LzUgKHRoZSB0aW1lb3V0IGJ1bXAgYW5kIGRvYyBmaXgp
LCBNYWFydGVuIExhbmtob3JzdCAoRFJNIG1haW50YWluZXIpIGV4cGxpY2l0bHkgcmVjb21tZW5k
ZWQgcHVsbGluZyBpbiB0aGlzIGV4YWN0IDUtY29tbWl0IGxpc3QgYXMgdGhlIHByb3BlciB1cHN0
cmVhbSBmaXggZm9yIHRoaXMgc3BlY2lmaWMgdmttcyBpc3N1ZSAoc2VlIHRoZSBtYWlsaW5nIGxp
c3QgbGluayBpbiB0aGlzIHRocmVhZCkuIAoKSG93ZXZlciwgaWYgeW91IGZlZWwgNC81IGFuZCA1
LzUgaW50cm9kdWNlIHVubmVjZXNzYXJ5IHJpc2sgZm9yIHRoZSA2LjE4Lnkgc3RhYmxlIHRyZWUs
IEkgY2FuIGFic29sdXRlbHkgZHJvcCB0aGVtIGFuZCBvbmx5IHN1Ym1pdCAxLzUsIDIvNSwgYW5k
IDMvNS4gCgpJIGFtIHByZXBhcmluZyBhIHYyIHBhdGNoIHNlcmllcyBub3cgd2l0aCBteSBTaWdu
ZWQtb2ZmLWJ5IGFkZGVkIHRvIHRoZSBjaGFpbiBvZiBjdXN0b2R5LiBDb3VsZCB5b3UgbGV0IG1l
IGtub3cgaWYgeW91IHByZWZlciB0aGUgZnVsbCA1LXBhdGNoIHNlcmllcyBhcyByZWNvbW1lbmRl
ZCBieSBEUk0gbWFpbnRhaW5lcnMsIG9yIGp1c3QgdGhlIG1pbmltYWwgMy1wYXRjaCBzZXJpZXM/
CgpCZXN0IHJlZ2FyZHMsCk1pbmd5dQo=

