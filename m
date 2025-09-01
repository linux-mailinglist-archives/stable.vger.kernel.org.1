Return-Path: <stable+bounces-176797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09CAB3DC5A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FF3BFD0D
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5B2F1FCC;
	Mon,  1 Sep 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="bkStn7t/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE7259C9C;
	Mon,  1 Sep 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715385; cv=none; b=i0b8AVEyAgWgvPDGnEVTkXO0KMUWRQsSoa0WQ9QMq5HmgCnJPFL+hE6pyTWVc3u465GZTbCw2p9CV2WqDLshvwlXE2xJo7pbAZBFqOFb3kyfQvkeT2COUQnH+16FWq0MSQD9Sck6EOAt0RKdHQmzsfdW+DRosPnrnzKLsCyF6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715385; c=relaxed/simple;
	bh=uiQGrPDGIQy2w2GoqtOwTVJzYrsAW1FwxDcYA3G+Lw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Psq5OK5VhqZvcDCuwjRV6wPKqUr9ud4yRrhLh/el4AYLnbCIbzLJ60VpyqRY4/ZTobcTnzQaM7V2xYgKhETc5EpZGY9aHa7FhsZjWdgwsIZq3I6PR4lHrYIrTRMvjotC2PnEG/GCCg95y8fxOnHZGgE3cZtcVnUZ0rARV9c+t7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=bkStn7t/ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=j5PJ2+yjz1EmUPb6Z1UJJ6UB8vR7LqQz1AQRzce8lPU=; b=b
	kStn7t/V8eq/iZd9uruH9IJ86zUK1m5DmyvuNvD0/UCPpRGXYqpVjs/QpEit2QFg
	6I+HubjY3j0rzOOszSjTm5GfkX8c3OvfWPInRgBJ+t7v2MOY5JLcNzxTslWl3XU5
	QxhVyvSj+kBPPpsv6LH7+Uqiuhbgb0HfUmMJxStwgU=
Received: from yangshiguang1011$163.com ( [1.202.162.48] ) by
 ajax-webmail-wmsvr-40-108 (Coremail) ; Mon, 1 Sep 2025 16:29:02 +0800 (CST)
Date: Mon, 1 Sep 2025 16:29:02 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Vlastimil Babka" <vbabka@suse.cz>
Cc: "David Rientjes" <rientjes@google.com>, harry.yoo@oracle.com,
	akpm@linux-foundation.org, cl@gentwo.org, roman.gushchin@linux.dev,
	glittao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
Subject: Re:Re: [PATCH v4] mm: slub: avoid wake up kswapd in
 set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <7f30ddd1-c6f7-4b2b-a2b9-875844092e28@suse.cz>
References: <20250830020946.1767573-1-yangshiguang1011@163.com>
 <c8f6933e-f733-4f86-c09d-8028ad862f33@google.com>
 <7f30ddd1-c6f7-4b2b-a2b9-875844092e28@suse.cz>
X-NTES-SC: AL_Qu2eBPuauksv5CKfZOkfmUgRj+k6WsK3s/sn3oNfP5B+jCLp+zE7R3NTB2LO79CDEC6NnQiHawJv0ehAb5dHTZwLRzc2zXorPS8GrhfNFYzcXQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <11922bd5.7fae.1990464d9c8.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgD33xlOWbVoDEAmAA--.2284W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/xtbBMRG75Wi1Tx-TjAAEso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA5LTAxIDE2OjE1OjA0LCAiVmxhc3RpbWlsIEJhYmthIiA8dmJhYmthQHN1c2Uu
Y3o+IHdyb3RlOgo+T24gOS8xLzI1IDA5OjUwLCBEYXZpZCBSaWVudGplcyB3cm90ZToKPj4gT24g
U2F0LCAzMCBBdWcgMjAyNSwgeWFuZ3NoaWd1YW5nMTAxMUAxNjMuY29tIHdyb3RlOgo+PiAKPj4+
IEZyb206IHlhbmdzaGlndWFuZyA8eWFuZ3NoaWd1YW5nQHhpYW9taS5jb20+Cj4+PiAKPj4+IEZy
b206IHlhbmdzaGlndWFuZyA8eWFuZ3NoaWd1YW5nQHhpYW9taS5jb20+Cj4+PiAKPj4gCj4+IER1
cGxpY2F0ZSBsaW5lcy4KPj4gCj4+PiBzZXRfdHJhY2tfcHJlcGFyZSgpIGNhbiBpbmN1ciBsb2Nr
IHJlY3Vyc2lvbi4KPj4+IFRoZSBpc3N1ZSBpcyB0aGF0IGl0IGlzIGNhbGxlZCBmcm9tIGhydGlt
ZXJfc3RhcnRfcmFuZ2VfbnMKPj4+IGhvbGRpbmcgdGhlIHBlcl9jcHUoaHJ0aW1lcl9iYXNlcylb
bl0ubG9jaywgYnV0IHdoZW4gZW5hYmxlZAo+Pj4gQ09ORklHX0RFQlVHX09CSkVDVFNfVElNRVJT
LCBtYXkgd2FrZSB1cCBrc3dhcGQgaW4gc2V0X3RyYWNrX3ByZXBhcmUsCj4+PiBhbmQgdHJ5IHRv
IGhvbGQgdGhlIHBlcl9jcHUoaHJ0aW1lcl9iYXNlcylbbl0ubG9jay4KPj4+IAo+Pj4gQXZvaWQg
ZGVhZGxvY2sgY2F1c2VkIGJ5IGltcGxpY2l0bHkgd2FraW5nIHVwIGtzd2FwZCBieQo+Pj4gcGFz
c2luZyBpbiBhbGxvY2F0aW9uIGZsYWdzLiBBbmQgdGhlIHNsYWIgY2FsbGVyIGNvbnRleHQgaGFz
Cj4+PiBwcmVlbXB0aW9uIGRpc2FibGVkLCBzbyBfX0dGUF9LU1dBUERfUkVDTEFJTSBtdXN0IG5v
dCBhcHBlYXIgaW4gZ2ZwX2ZsYWdzLgo+Pj4gCj4+IAo+PiBUaGlzIG1lbnRpb25zIF9fR0ZQX0tT
V0FQRF9SRUNMQUlNLCBidXQgdGhlIHBhdGNoIGFjdHVhbGx5IG1hc2tzIG9mZiAKPj4gX19HRlBf
RElSRUNUX1JFQ0xBSU0gd2hpY2ggd291bGQgYmUgYSBoZWF2aWVyd2VpZ2h0IG9wZXJhdGlvbi4g
IERpc2FibGluZyAKPj4gZGlyZWN0IHJlY2xhaW0gZG9lcyBub3QgbmVjZXNzYXJpbHkgaW1wbHkg
dGhhdCBrc3dhcGQgd2lsbCBiZSBkaXNhYmxlZCBhcyAKPj4gd2VsbC4KPgo+WWVhaCBJIHRoaW5r
IHRoZSBjaGFuZ2Vsb2cgc2hvdWxkIHNheSBfX0dGUF9ESVJFQ1RfUkVDTEFJTS4KPgo+PiBBcmUg
eW91IG1lYW5pbmcgdG8gY2xlYXIgX19HRlBfUkVDTEFJTSBpbiBzZXRfdHJhY2tfcHJlcGFyZSgp
Pwo+Cj5ObyBiZWNhdXNlIGlmIHRoZSBjb250ZXh0IGNvbnRleHQgKGUuZy4gdGhlIGhydGltZXJz
KSBjYW4ndCBzdXBwb3J0Cj5fX0dGUF9LU1dBUERfUkVDTEFJTSBpdCB3b24ndCBoYXZlIGl0IGlu
IGdmcF9mbGFncyBhbmQgd2Ugbm93IHBhc3MgdGhlbSB0bwoKPnNldF90cmFja19wcmVwYXJlKCkg
c28gaXQgYWxyZWFkeSB3b24ndCBiZSB0aGVyZS4KCgpTcnkuIFNob3VsZCBiZSBfX0dGUF9ESVJF
Q1RfUkVDTEFJTS4gSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2gu

