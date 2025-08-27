Return-Path: <stable+bounces-176466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B1FB37C26
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C0A3AB806
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D52E9EB7;
	Wed, 27 Aug 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LGzVdU1v"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F45265626;
	Wed, 27 Aug 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280826; cv=none; b=lTfQ75TmeSt9RXTOCU91Vxmnnd4S3C5REVPt695xvD2QwARhjfWHBJm45F5HFgAuSn6hfmHqIDXdS4E8NTc7qfuRvwuhAgIPC6U5+zbAGyhI93nkYrUvo/crvg8QX60TLOEAwM+GW5336e2ui19bQjhST3lRNNiitFkFeok11uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280826; c=relaxed/simple;
	bh=0MmrPy+E8embJExjeJmQiky6NuUvRVQ/YGgyEIJXCLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jYBT7TLB3HtGI62yQFPn4yLHxOPmwC2pzumhg43+/I7+v33G/L+KPhz8hLXUWOdCOqeYgtvZKBgkRwhdZETCgtcvXS0TI2qbT0WquM/m9liMJNwGaU1xwBaxRMQlhwWkxksPD2ceZkTs1EtUwdBs9lbRGP8g6/f3Xn3me1BKpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LGzVdU1v reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2Q4BVcfMJ9wvZWMC/mZ7cNqnTcVJUHQ74bJz30nxEJQ=; b=L
	GzVdU1vI/trXXe3VPhkZrntZSiOp0+sLZDHI4PjQh4amNDClKG+uCaNgiaA2K4Gm
	8hz333L/LBsNFOCPreA2udFPNEnXTkKaebazpgT6JFDVpSuoLZo7xZz0bCIhfa4s
	MIemJRxq2XaRtDbW1pjFkhOBV8Bqdjx6T46lvhojk4=
Received: from yangshiguang1011$163.com ( [1.202.162.48] ) by
 ajax-webmail-wmsvr-40-108 (Coremail) ; Wed, 27 Aug 2025 15:45:48 +0800
 (CST)
Date: Wed, 27 Aug 2025 15:45:48 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Harry Yoo" <harry.yoo@oracle.com>
Cc: "Vlastimil Babka" <vbabka@suse.cz>,
	"Matthew Wilcox" <willy@infradead.org>, akpm@linux-foundation.org,
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
	glittao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
Subject: Re:Re: [PATCH v3] mm: slub: avoid wake up kswapd in
 set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aK6U61xNpJS0qs15@hyeyoo>
References: <20250825121737.2535732-1-yangshiguang1011@163.com>
 <aKxZp_GgYVzp8Uvt@casper.infradead.org>
 <54d9e5ac-5a51-4901-9b13-4c248aada2d7@suse.cz> <aK6U61xNpJS0qs15@hyeyoo>
X-NTES-SC: AL_Qu2eBP6Tv08v7iadbekfmUgRj+k6WsK3s/sn3oNfP5B+jCLp1RAuT3NTGmvR89CDKD2NnQiHYDh85sR+ZaZKQoML7HSsXXB4Qm/WIcirldzZ5g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6e1ab9d8.6595.198ea7d7a78.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgD3v1ett65oVdEiAA--.1986W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiEA625WiuiUfH0QAGsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkF0IDIwMjUtMDgtMjcgMTM6MTc6MzEsICJIYXJyeSBZb28iIDxoYXJyeS55b29Ab3JhY2xl
LmNvbT4gd3JvdGU6Cj5PbiBNb24sIEF1ZyAyNSwgMjAyNSBhdCAwNTo0Mjo1MlBNICswMjAwLCBW
bGFzdGltaWwgQmFia2Egd3JvdGU6Cj4+IE9uIDgvMjUvMjUgMTQ6NDAsIE1hdHRoZXcgV2lsY294
IHdyb3RlOgo+PiA+IE9uIE1vbiwgQXVnIDI1LCAyMDI1IGF0IDA4OjE3OjM3UE0gKzA4MDAsIHlh
bmdzaGlndWFuZzEwMTFAMTYzLmNvbSB3cm90ZToKPj4gPj4gQXZvaWQgZGVhZGxvY2sgY2F1c2Vk
IGJ5IGltcGxpY2l0bHkgd2FraW5nIHVwIGtzd2FwZCBieQo+PiA+PiBwYXNzaW5nIGluIGFsbG9j
YXRpb24gZmxhZ3MuCj4+ID4gWy4uLl0KPj4gPj4gKwkvKiBQcmVlbXB0aW9uIGlzIGRpc2FibGVk
IGluIF9fX3NsYWJfYWxsb2MoKSAqLwo+PiA+PiArCWdmcF9mbGFncyAmPSB+KF9fR0ZQX0RJUkVD
VF9SRUNMQUlNKTsKPj4gPiAKPj4gPiBJZiB5b3UgZG9uJ3QgbWVhbiBfX0dGUF9LU1dBUERfUkVD
TEFJTSBoZXJlLCB0aGUgZXhwbGFuYXRpb24gbmVlZHMgdG8KPj4gPiBiZSBiZXR0ZXIuCj4+IAo+
PiBJdCB3YXMgc3VnZ2VzdGVkIGJ5IEhhcnJ5IGhlcmU6Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9hS0toVW9Va1JORGtGWVliQGhhcnJ5Cj4+IAo+PiBJIHRoaW5rIHRoZSBjb21tZW50
IGlzIGVub3VnaD8gRGlzYWJsaW5nIHByZWVtcHRpb24gbWVhbnMgd2UgY2FuJ3QgZGlyZWN0Cj4+
IHJlY2xhaW0sIGJ1dCB3ZSBjYW4gd2FrZSB1cCBrc3dhcGQuIElmIHRoZSBzbGFiIGNhbGxlciBj
b250ZXh0IGlzIHN1Y2ggdGhhdAo+PiB3ZSBjYW4ndCwgX19HRlBfS1NXQVBEX1JFQ0xBSU0gYWxy
ZWFkeSB3b24ndCBiZSBpbiB0aGUgZ2ZwX2ZsYWdzLgo+Cj5UbyBtYWtlIGl0IGEgbGl0dGxlIGJp
dCBtb3JlIHZlcmJvc2UsIHRoaXMgXl4gZXhwbGFuYXRpb24gY2FuIGJlIGFkZGVkIHRvIHRoZQoK
PmNoYW5nZWxvZz8KCgpvaywgd2lsbCBiZSBlYXNpZXIgdG8gdW5kZXJzdGFuZC4KCj4KPj4gQnV0
IEkgdGhpbmsgd2Ugc2hvdWxkIG1hc2sgb3VyIGFsc28gX19HRlBfTk9GQUlMIGFuZCBhZGQgX19H
RlBfTk9XQVJOPwo+Cgo+VGhhdCBzb3VuZHMgZ29vZC4+Cj4+ICh3ZSBzaG91bGQgZ2V0IHNvbWUg
Y29tbW9uIGhlbHBlcnMgZm9yIHRoZXNlIGtpbmRzIG9mIGdmcCBmbGFnIG1hbmlwdWxhdGlvbnMK
Pj4gYWxyZWFkeSkKPgo+QW55IGlkZWFzIGZvciBpdHMgbmFtZT8KPgo+Z2ZwX2RvbnRfdHJ5X3Rv
b19oYXJkKCksCj5nZnBfYWRqdXN0X2xpZ2h0d2VpZ2h0KCksCj5nZnBfYWRqdXN0X21heWZhaWwo
KSwKPi4uLgo+Cj5JJ20gbm90IGdvb2QgYXQgbmFtaW5nIDovCgo+CgpIb3cgYWJvdXQgdGhpcz8g
CgogICAgICAgIC8qIFByZWVtcHRpb24gaXMgZGlzYWJsZWQgaW4gX19fc2xhYl9hbGxvYygpICov
Ci0gICAgICAgZ2ZwX2ZsYWdzICY9IH4oX19HRlBfRElSRUNUX1JFQ0xBSU0pOworICAgICAgIGdm
cF9mbGFncyA9IChnZnBfZmxhZ3MgJiB+KF9fR0ZQX0RJUkVDVF9SRUNMQUlNIHwgX19HRlBfTk9G
QUlMKSkgfAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19HRlBfTk9X
QVJOOwoKID4tLSAKPkNoZWVycywKPkhhcnJ5IC8gSHllb25nZ29uCg==

