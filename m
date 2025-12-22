Return-Path: <stable+bounces-203218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC588CD60AE
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 13:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F08C7300A9FE
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AADD2DA776;
	Mon, 22 Dec 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ntNWdAQ8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666329AB11;
	Mon, 22 Dec 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407333; cv=none; b=RqkbVtmBVbHfp/I7nFx1A0o8NJ1MhuLHn4fe55t/30Cyx+vELHQuxcZwEnf/u/+NPFshMa4iSKaPOmW9rBrA6a849qzJit0cCJQ/6YOaou6jnyqLr2gUeQkTKjITXZTyAIz68bMcocIfvU95OLnZVY1PO965GXCNkcPy1tCz1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407333; c=relaxed/simple;
	bh=OQa+9TeKlZnu91zSw+qiWaLi8TMWxwkiVjYlyzEX3Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YX8AFZIvHGplGTY3lfS3ceutXQ0Oz8m9xR+FdKfd6IVcSRnKrvhQW9gWLfurcuoda/ko0P12jH20J9uxIhcEU0h3ymZa+hr3LYYn9WyZeq0EbcbMvWhyUXgVEAYMRfhgbqtH4W/TRMlXnhWv8qLX8UA8SMBH5Vq8FD5zvHrTaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ntNWdAQ8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OQa+9TeKlZnu91zSw+qiWaLi8TMWxwkiVjYlyzEX3Zk=; b=n
	tNWdAQ8UzPeUEQAvk99/an0FGybHQ9rD2Cf/c+7gcY4dopTQRQTLUwhPVn/5KG+X
	1aCH7T5pnZKy6CXQospeMFDMAlwxydV3MpZ4nQ2NlXDGbXU9cCrMpfGd6Ajt7jv1
	nAymObWr01LBSmL9cJUqlDkH0LA9uSGmIMO4p1zPtE=
Received: from yangshiguang1011$163.com (
 [2408:8607:1b00:8:82a8:bf06:7ff9:2b1a] ) by ajax-webmail-wmsvr-40-136
 (Coremail) ; Mon, 22 Dec 2025 20:41:33 +0800 (CST)
Date: Mon, 22 Dec 2025 20:41:33 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, dakr@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, yangshiguang@xiaomi.com,
	stable@vger.kernel.org
Subject: Re:Re: [PATCH] debugfs: Fix NULL pointer dereference at
 debugfs_read_file_str
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <2025122234-crazy-remix-3098@gregkh>
References: <20251222093615.663252-2-yangshiguang1011@163.com>
 <2025122234-crazy-remix-3098@gregkh>
X-NTES-SC: AL_Qu2dBPibuEoi5SWYZukfmUgRj+k6WsK3s/sn3oNfP5B+jCnr8xo9UV1mEXzp+c2RCya0rj2OXT10yO9le4tlVowgFlVYlYGQlvbMoDKqiEIUpw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgBXnut9PElp9kNGAA--.29116W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/xtbC+h3awGlJPH1WHwAA3V
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTItMjIgMTk6NTQ6MjIsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gTW9uLCBEZWMgMjIsIDIwMjUgYXQgMDU6MzY6MTZQTSArMDgwMCwg
eWFuZ3NoaWd1YW5nMTAxMUAxNjMuY29tIHdyb3RlOgo+PiBGcm9tOiB5YW5nc2hpZ3VhbmcgPHlh
bmdzaGlndWFuZ0B4aWFvbWkuY29tPgo+PiAKPj4gQ2hlY2sgaW4gZGVidWdmc19yZWFkX2ZpbGVf
c3RyKCkgaWYgdGhlIHN0cmluZyBwb2ludGVyIGlzIE5VTEwuCj4+IAo+PiBXaGVuIGNyZWF0aW5n
IGEgbm9kZSB1c2luZyBkZWJ1Z2ZzX2NyZWF0ZV9zdHIoKSwgdGhlIHN0cmluZyBwYXJhbWV0ZXIK
Pj4gdmFsdWUgY2FuIGJlIE5VTEwgdG8gaW5kaWNhdGUgZW1wdHkvdW51c2VkL2lnbm9yZWQuCj4K
PldoeSB3b3VsZCB5b3UgY3JlYXRlIGFuIGVtcHR5IGRlYnVnZnMgc3RyaW5nIGZpbGU/ICBUaGF0
IGlzIG5vdCBvaywgd2UKPnNob3VsZCBjaGFuZ2UgdGhhdCB0byBub3QgYWxsb3cgdGhpcy4KCkhp
IGdyZWcgay1oLAoKVGhhbmtzIGZvciB5b3VyIHJlcGx5LgoKVGhpcyBpcyBkdWUgdG8gdGhlIHVz
YWdlIHN0ZXAsIHNob3VsZCB3cml0ZSBmaXJzdCBhbmQgdGhlbiByZWFkLgpIb3dldmVyLCB0aGVy
ZSBpcyBubyB3YXkgdG8gZ3VhcmFudGVlIHRoYXQgZXZlcnlvbmUgd2lsbCBrbm93IGFib3V0IHRo
aXMgc3RlcC4KCkFuZCBkZWJ1Z2ZzX2NyZWF0ZV9zdHIoKSBhbGxvd3MgcGFzc2luZyBpbiBhIE5V
TEwgc3RyaW5nLiAKVGhlcmVmb3JlLCB3aGVuIHJlYWRpbmcgYSBOVUxMIHN0cmluZywgc2hvdWxk
IHJldHVybiBhbiBpbnZhbGlkIGVycm9yIAppbnN0ZWFkIG9mIHBhbmljLgoKPgo+PiBIb3dldmVy
LCByZWFkaW5nIHRoaXMgbm9kZSB1c2luZyBkZWJ1Z2ZzX3JlYWRfZmlsZV9zdHIoKSB3aWxsIGNh
dXNlIGEKPj4ga2VybmVsIHBhbmljLgo+PiBUaGlzIHNob3VsZCBub3QgYmUgZmF0YWwsIHNvIHJl
dHVybiBhbiBpbnZhbGlkIGVycm9yLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogeWFuZ3NoaWd1YW5n
IDx5YW5nc2hpZ3VhbmdAeGlhb21pLmNvbT4KPj4gRml4ZXM6IDlhZjA0NDBlYzg2ZSAoImRlYnVn
ZnM6IEltcGxlbWVudCBkZWJ1Z2ZzX2NyZWF0ZV9zdHIoKSIpCj4+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnCj4+IC0tLQo+PiAgZnMvZGVidWdmcy9maWxlLmMgfCAzICsrKwo+PiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2ZzL2RlYnVnZnMv
ZmlsZS5jIGIvZnMvZGVidWdmcy9maWxlLmMKPj4gaW5kZXggM2VjMzMyNGMyMDYwLi5hMjJmZjBj
ZWIyMzAgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2RlYnVnZnMvZmlsZS5jCj4+ICsrKyBiL2ZzL2RlYnVn
ZnMvZmlsZS5jCj4+IEBAIC0xMDI2LDYgKzEwMjYsOSBAQCBzc2l6ZV90IGRlYnVnZnNfcmVhZF9m
aWxlX3N0cihzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKnVzZXJfYnVmLAo+PiAgCQly
ZXR1cm4gcmV0Owo+PiAgCj4+ICAJc3RyID0gKihjaGFyICoqKWZpbGUtPnByaXZhdGVfZGF0YTsK
Pj4gKwlpZiAoIXN0cikKPj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4KPldoYXQgaW4ga2VybmVsIHVz
ZXIgY2F1c2VzIHRoaXMgdG8gaGFwcGVuPyAgTGV0J3MgZml4IHRoYXQgdXAgaW5zdGVhZAo+cGxl
YXNlLgo+CgpDdXJyZW50bHkgSSBrbm93biBwcm9ibGVtYXRpYyBub2RlcyBpbiB0aGUga2VybmVs
OgoKZHJpdmVycy9pbnRlcmNvbm5lY3QvZGVidWdmcy1jbGllbnQuYzoKICAxNTU6IAlkZWJ1Z2Zz
X2NyZWF0ZV9zdHIoInNyY19ub2RlIiwgMDYwMCwgY2xpZW50X2RpciwgJnNyY19ub2RlKTsKICAx
NTY6IAlkZWJ1Z2ZzX2NyZWF0ZV9zdHIoImRzdF9ub2RlIiwgMDYwMCwgY2xpZW50X2RpciwgJmRz
dF9ub2RlKTsKZHJpdmVycy9zb3VuZHdpcmUvZGVidWdmcy5jOgogIDM2MjogCWRlYnVnZnNfY3Jl
YXRlX3N0cigiZmlybXdhcmVfZmlsZSIsIDAyMDAsIGQsICZmaXJtd2FyZV9maWxlKTsKCnRlc3Qg
Y2FzZToKMS4gY3JlYXRlIGEgTlVMTCBzdHJpbmcgbm9kZQpjaGFyICp0ZXN0X25vZGUgPSBOVUxM
OwpkZWJ1Z2ZzX2NyZWF0ZV9zdHIoInRlc3Rfbm9kZSIsIDA2MDAsIHBhcmVudF9kaXIsICZ0ZXN0
X25vZGUpOwoKMi4gcmVhZCB0aGUgbm9kZSwgbGlrZSBiZWxsb3c6CmNhdCAvc3lzL2tlcm5lbC9k
ZWJ1Zy90ZXN0X25vZGUKCj50aGFua3MsCj4KPmdyZWcgay1oCg==

