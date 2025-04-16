Return-Path: <stable+bounces-132888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B2A90FA4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 01:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26743BA5DE
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDC2356C3;
	Wed, 16 Apr 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="POSLl4gc"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E59230D3D;
	Wed, 16 Apr 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846443; cv=none; b=jnE4Q5rbYd0r6stIikvD73h1kMbCrs3zcLLqID2KutLlSvrDhaCQeZIPhSqUYGk8RK/8K0gYw7hYDHeH91GfnCarvWMO6SsxVqPQ7anqWR6BEqauaoD2Rx4MLG80APO82NDSCclaLRSR/+m6mFtcMnN7BGVSIvyboH/m6TzD4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846443; c=relaxed/simple;
	bh=g2NU8wZf7ov7zeW75JbUxhAYPOAgNEyPYBnsaU7lHY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpqkchovfTZXg7QEJ3JswJkLqJntsAhLMQJ2NEPMaDIPqQkeOhfo/yXOQke4g4XthkxqHkieYNen6BDl6ETFgVDGMDTUvXQyT853lLLceA6GGUyluZiUIXl0bUQFNiyHC7sHgAJCvcQ7fMOpX9P8feA4XFs8p6+eLWyBsJ2pS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=POSLl4gc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744846431;
	bh=g2NU8wZf7ov7zeW75JbUxhAYPOAgNEyPYBnsaU7lHY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=POSLl4gcH2AgoWTwaTKyZEidtqqKTBpgE+Fchxnbed1zy6wFTPiYor/JTmotv2SP3
	 rekBMtSioc15RyR4WLPWA7P/8uXdNE+jorg4464rDkxvN2ZRW2AzZjxygpADCQfMWN
	 Xo/o643/dOOJbIekDOFLM7ylVo7YLw59+fH9KWfuvlb4XSRQj1y5U6n0fg9wc1tAp5
	 uypoe/gm5LkArnzPmsgfQAcHz5I0B7qyIgjPlLnn3L7mRu3gWbp2atdV0CPk7uyYeD
	 P34xVqzZSpoJJJzQVNW9gpQQUAI/TtZdWvGkGfnAlR9tpc++gtThvBypbOnCTbiQ4Z
	 UZWiJABXp8uPA==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D187564323;
	Thu, 17 Apr 2025 07:33:49 +0800 (AWST)
Message-ID: <6f01162ca2024c8bc4f22e0be2f33e8724238f80.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/7] soc: aspeed: lpc-snoop: Don't disable channels that
 aren't enabled
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Andrew Geissler
 <geissonator@yahoo.com>, Ninad Palsule <ninad@linux.ibm.com>, Patrick
 Venture <venture@google.com>, Robert Lippert <roblip@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Apr 2025 09:03:45 +0930
In-Reply-To: <20250416141506.2d910334@endymion>
References: 
	<20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
	 <20250411-aspeed-lpc-snoop-fixes-v1-2-64f522e3ad6f@codeconstruct.com.au>
	 <20250416141506.2d910334@endymion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTA0LTE2IGF0IDE0OjE1ICswMjAwLCBKZWFuIERlbHZhcmUgd3JvdGU6Cj4g
T24gRnJpLCAxMSBBcHIgMjAyNSAxMDozODozMiArMDkzMCwgQW5kcmV3IEplZmZlcnkgd3JvdGU6
Cj4gPiBNaXRpZ2F0ZSBlLmcuIHRoZSBmb2xsb3dpbmc6Cj4gPiAKPiA+IMKgwqDCoCAjIGVjaG8g
MWU3ODkwODAubHBjLXNub29wID4gL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy9hc3BlZWQtCj4g
PiBscGMtc25vb3AvdW5iaW5kCj4gPiDCoMKgwqAgLi4uCj4gPiDCoMKgwqAgW8KgIDEyMC4zNjM1
OTRdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQo+ID4g
YXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDA0IHdoZW4gd3JpdGUKPiA+IMKgwqDCoCBbwqAgMTIw
LjM3Mzg2Nl0gWzAwMDAwMDA0XSAqcGdkPTAwMDAwMDAwCj4gPiDCoMKgwqAgW8KgIDEyMC4zNzc5
MTBdIEludGVybmFsIGVycm9yOiBPb3BzOiA4MDUgWyMxXSBTTVAgQVJNCj4gPiDCoMKgwqAgW8Kg
IDEyMC4zODMzMDZdIENQVTogMSBVSUQ6IDAgUElEOiAzMTUgQ29tbTogc2ggTm90IHRhaW50ZWQK
PiA+IDYuMTUuMC1yYzEtMDAwMDktZzkyNjIxN2JjN2Q3ZC1kaXJ0eSAjMjAgTk9ORQo+ID4gwqDC
oMKgIC4uLgo+ID4gwqDCoMKgIFvCoCAxMjAuNjc5NTQzXSBDYWxsIHRyYWNlOgo+ID4gwqDCoMKg
IFvCoCAxMjAuNjc5NTU5XcKgIG1pc2NfZGVyZWdpc3RlciBmcm9tCj4gPiBhc3BlZWRfbHBjX3Nu
b29wX3JlbW92ZSsweDg0LzB4YWMKPiA+IMKgwqDCoCBbwqAgMTIwLjY5MjQ2Ml3CoCBhc3BlZWRf
bHBjX3Nub29wX3JlbW92ZSBmcm9tCj4gPiBwbGF0Zm9ybV9yZW1vdmUrMHgyOC8weDM4Cj4gPiDC
oMKgwqAgW8KgIDEyMC43MDA5OTZdwqAgcGxhdGZvcm1fcmVtb3ZlIGZyb20KPiA+IGRldmljZV9y
ZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE4OC8weDIwMAo+ID4gwqDCoMKgIC4uLgo+ID4gCj4g
PiBGaXhlczogOWY0ZjlhZTgxZDBhICgiZHJpdmVycy9taXNjOiBhZGQgQXNwZWVkIExQQyBzbm9v
cCBkcml2ZXIiKQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IENjOiBKZWFuIERl
bHZhcmUgPGpkZWx2YXJlQHN1c2UuZGU+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgSmVmZmVy
eSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvc29j
L2FzcGVlZC9hc3BlZWQtbHBjLXNub29wLmMgfCAxMSArKysrKysrKysrKwo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvYXNwZWVkL2FzcGVlZC1scGMtc25vb3AuYwo+ID4gYi9kcml2ZXJzL3NvYy9hc3BlZWQvYXNw
ZWVkLWxwYy1zbm9vcC5jCj4gPiBpbmRleAo+ID4gYmZhNzcwZWM1MWE4ODkyNjBkMTFjMjZlNjc1
ZjMzMjBiZjcxMGE1NC4uZTlkOWE4ZTYwYTZmMDYyYzBiNTNjOWMwMgo+ID4gZTVkNzM3Njg0NTM5
OThkIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9zb2MvYXNwZWVkL2FzcGVlZC1scGMtc25vb3Au
Ywo+ID4gKysrIGIvZHJpdmVycy9zb2MvYXNwZWVkL2FzcGVlZC1scGMtc25vb3AuYwo+ID4gQEAg
LTU4LDYgKzU4LDcgQEAgc3RydWN0IGFzcGVlZF9scGNfc25vb3BfbW9kZWxfZGF0YSB7Cj4gPiDC
oH07Cj4gPiDCoAo+ID4gwqBzdHJ1Y3QgYXNwZWVkX2xwY19zbm9vcF9jaGFubmVsIHsKPiA+ICvC
oMKgwqDCoMKgwqDCoGJvb2wgZW5hYmxlZDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qga2Zp
Zm/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmaWZvOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHdhaXRf
cXVldWVfaGVhZF90wqDCoMKgwqDCoMKgwqB3cTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
bWlzY2RldmljZcKgwqDCoMKgwqDCoMKgbWlzY2RldjsKPiA+IEBAIC0xOTAsNiArMTkxLDkgQEAg
c3RhdGljIGludCBhc3BlZWRfbHBjX2VuYWJsZV9zbm9vcChzdHJ1Y3QKPiA+IGFzcGVlZF9scGNf
c25vb3AgKmxwY19zbm9vcCwKPiA+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgYXNwZWVk
X2xwY19zbm9vcF9tb2RlbF9kYXRhICptb2RlbF9kYXRhID0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7Cj4gPiDCoAo+ID4g
K8KgwqDCoMKgwqDCoMKgaWYgKGxwY19zbm9vcC0+Y2hhbltjaGFubmVsXS5lbmFibGVkKQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUJVU1k7Cj4gCj4gVGhpcyBp
c24ndCBzdXBwb3NlZCB0byBoYXBwZW4sIHJpZ2h0P8KgCgpObywgbm90IHN1cHBvc2VkIHRvIGhh
cHBlbi4KCj4gV0FSTl9PTigpIG1heSBiZSBhcHByb3ByaWF0ZS4KCkFjay4KCj4gCj4gPiArCj4g
PiDCoMKgwqDCoMKgwqDCoMKgaW5pdF93YWl0cXVldWVfaGVhZCgmbHBjX3Nub29wLT5jaGFuW2No
YW5uZWxdLndxKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBDcmVhdGUgRklGTyBkYXRhc3RydWN0
dXJlICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmMgPSBrZmlmb19hbGxvYygmbHBjX3Nub29wLT5j
aGFuW2NoYW5uZWxdLmZpZm8sCj4gPiBAQCAtMjM2LDYgKzI0MCw4IEBAIHN0YXRpYyBpbnQgYXNw
ZWVkX2xwY19lbmFibGVfc25vb3Aoc3RydWN0Cj4gPiBhc3BlZWRfbHBjX3Nub29wICpscGNfc25v
b3AsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ21hcF91cGRhdGVfYml0
cyhscGNfc25vb3AtPnJlZ21hcCwgSElDUkIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaGljcmJfZW4sIGhpY3JiX2Vu
KTsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqBscGNfc25vb3AtPmNoYW5bY2hhbm5lbF0uZW5h
YmxlZCA9IHRydWU7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiDCoAo+
ID4gwqBlcnJfbWlzY19kZXJlZ2lzdGVyOgo+ID4gQEAgLTI0OCw2ICsyNTQsOSBAQCBzdGF0aWMg
aW50IGFzcGVlZF9scGNfZW5hYmxlX3Nub29wKHN0cnVjdAo+ID4gYXNwZWVkX2xwY19zbm9vcCAq
bHBjX3Nub29wLAo+ID4gwqBzdGF0aWMgdm9pZCBhc3BlZWRfbHBjX2Rpc2FibGVfc25vb3Aoc3Ry
dWN0IGFzcGVlZF9scGNfc25vb3AKPiA+ICpscGNfc25vb3AsCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50IGNoYW5uZWwpCj4gPiDCoHsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghbHBjX3Nub29wLT5j
aGFuW2NoYW5uZWxdLmVuYWJsZWQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAoY2hhbm5lbCkgewo+ID4g
wqDCoMKgwqDCoMKgwqDCoGNhc2UgMDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmVnbWFwX3VwZGF0ZV9iaXRzKGxwY19zbm9vcC0+cmVnbWFwLCBISUNSNSwKPiA+IEBAIC0y
NjMsNiArMjcyLDggQEAgc3RhdGljIHZvaWQgYXNwZWVkX2xwY19kaXNhYmxlX3Nub29wKHN0cnVj
dAo+ID4gYXNwZWVkX2xwY19zbm9vcCAqbHBjX3Nub29wLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqAKPiA+ICvC
oMKgwqDCoMKgwqDCoGxwY19zbm9vcC0+Y2hhbltjaGFubmVsXS5lbmFibGVkID0gZmFsc2U7Cj4g
PiArwqDCoMKgwqDCoMKgwqAvKiBDb25zaWRlciBpbXByb3Zpbmcgc2FmZXR5IHdydCBjb25jdXJy
ZW50IHJlYWRlcihzKSAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoG1pc2NfZGVyZWdpc3RlcigmbHBj
X3Nub29wLT5jaGFuW2NoYW5uZWxdLm1pc2NkZXYpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGtmaWZv
X2ZyZWUoJmxwY19zbm9vcC0+Y2hhbltjaGFubmVsXS5maWZvKTsKPiA+IMKgfQo+ID4gCj4gCj4g
QWNrZWQtYnk6IEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5kZT4KPiAKClRoYW5rcywKCkFu
ZHJldwo=


