Return-Path: <stable+bounces-64768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636C6942FEF
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9468D1C222FF
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA91AED5B;
	Wed, 31 Jul 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="SCQXD0oq"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779602233B;
	Wed, 31 Jul 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431902; cv=none; b=hMmEkrv7vUCVjXlq7+hM8bFvIga3M86HCqa5aORir/rVRlKGPvn0mWjf9PVmIM/BkAvBJq0p43QA9zOdYCq/b09Ij9ANA1XX8wxWmodGMBM++XvQzOxh9tBLMxpVz16nQizwcwhlqLVjSDNOwKgpOE+2d4FT7zyTpI3RxFLu20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431902; c=relaxed/simple;
	bh=husdTM7PKO9t72lLNKWMpa6W0Nj1EtYooEUWNFkg5P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mJ9gmPxuyWLPSxuaZSI9clCHDRM8JM4z+TZdnsYZ/SsmbHHsFaxoROursr8Vw4SgNokLUt55EdCfyIurjuBKce+irig6h2fHSVAN+H4Hw4f4SPQCPJXNyFoGKhx1wab3ipLdt4SSGO86ztd/UPJAI+PETpYeMZCqzJELapOwHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=SCQXD0oq reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=W4BMaOM6JkyCMCqVxDTv6fLeC3/kYcRs6C/Sr9njQ7Q=; b=S
	CQXD0oqFy5C+VTHBVimYytJrsceK1PTZg22b8aP0grv8Ses4fegPLrRBfLamrNsv
	iU167MoiVF3XVSSWo8kMgVYutcwrMJKqiaagd2WUKkPL/0QjIHIV+Xezol2StAcv
	yUfMXXU0P0guskTp8ORi45xmHn59hT1iRw7r4nYzAI=
Received: from 00107082$163.com ( [111.35.189.52] ) by
 ajax-webmail-wmsvr-40-124 (Coremail) ; Wed, 31 Jul 2024 21:17:35 +0800
 (CST)
Date: Wed, 31 Jul 2024 21:17:35 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: liaoyu15@huawei.com, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, stable@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [Regression] 6.11.0-rc1: BUG: using smp_processor_id() in
 preemptible when suspend the system
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <87ikwm7waq.ffs@tglx>
References: <20240730142557.4619-1-00107082@163.com> <87ikwm7waq.ffs@tglx>
X-NTES-SC: AL_Qu2ZAPiYvkAu4ySaZ+kXn0oTju85XMCzuv8j3YJeN500kyTh9x0ZWlBJE1/m4tiCFCemnze0QglT2ul3bbRWZq4YsKQOVLysmbDjL8r4LpF+
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <460216e0.a699.19108f05b46.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDXvzhwOapmzpxEAA--.64302W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRctqmVOB4ulsQAEsO
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKQXQgMjAyNC0wNy0zMCAyMzowNzo0MSwgIlRob21hcyBHbGVpeG5lciIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6Cj5PbiBUdWUsIEp1bCAzMCAyMDI0IGF0IDIyOjI1LCBEYXZpZCBX
YW5nIHdyb3RlOgo+PiBXaGVuIEkgc3VzcGVuZCBteSBzeXN0ZW0sIHZpYSBgc3lzdGVtY3RsIHN1
c3BlbmRgLCBrZXJuZWwgQlVHIHNob3dzIHVwIGluIGxvZzoKPj4KPj4gIGtlcm5lbDogWyAxNzM0
LjQxMjk3NF0gc21wYm9vdDogQ1BVIDIgaXMgbm93IG9mZmxpbmUKPj4gIGtlcm5lbDogWyAxNzM0
LjQxNDk1Ml0gQlVHOiB1c2luZyBzbXBfcHJvY2Vzc29yX2lkKCkgaW4gcHJlZW1wdGlibGUgWzAw
MDAwMDAwXSBjb2RlOiBzeXN0ZW1kLXNsZWVwLzQ2MTkKPj4gIGtlcm5lbDogWyAxNzM0LjQxNDk1
N10gY2FsbGVyIGlzIGhvdHBsdWdfY3B1X19icm9hZGNhc3RfdGlja19wdWxsKzB4MWMvMHhjMAo+
Cj5UaGUgYmVsb3cgc2hvdWxkIGZpeCB0aGF0Lgo+Cj5UaGFua3MsCgpJIHRob3VnaHQgdGhlIG9m
ZmVuZGluZyBsaW5lIHdhcyBzbXBfcHJvY2Vzc29yX2lkKCkgdXNlZCBmb3IgY3B1bWFza19jbGVh
cl9jcHUsIHNvIGNvbmZ1c2VkIGJ5IHRoaXMgcGF0Y2guLi4uIG5ldmVyIG1pbmQKClNvcnJ5IGZv
ciB0aGUgZGVsYXksIEkgYXBwbGllZCB0aGUgcGF0Y2ggYW5kIGl0IGRvc2UgZml4IHRoZSBpc3N1
ZS4KCkZZSQpEYXZpZCAKCj4KPiAgICAgICAgdGdseAo+LS0tCj4tLS0gYS9rZXJuZWwvdGltZS90
aWNrLWJyb2FkY2FzdC5jCj4rKysgYi9rZXJuZWwvdGltZS90aWNrLWJyb2FkY2FzdC5jCj5AQCAt
MTE0MSw3ICsxMTQxLDYgQEAgdm9pZCB0aWNrX2Jyb2FkY2FzdF9zd2l0Y2hfdG9fb25lc2hvdCh2
bwo+ICNpZmRlZiBDT05GSUdfSE9UUExVR19DUFUKPiB2b2lkIGhvdHBsdWdfY3B1X19icm9hZGNh
c3RfdGlja19wdWxsKGludCBkZWFkY3B1KQo+IHsKPi0Jc3RydWN0IHRpY2tfZGV2aWNlICp0ZCA9
IHRoaXNfY3B1X3B0cigmdGlja19jcHVfZGV2aWNlKTsKPiAJc3RydWN0IGNsb2NrX2V2ZW50X2Rl
dmljZSAqYmM7Cj4gCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gCj5AQCAtMTE2Nyw2ICsxMTY2LDgg
QEAgdm9pZCBob3RwbHVnX2NwdV9fYnJvYWRjYXN0X3RpY2tfcHVsbChpbgo+IAkJICogZGV2aWNl
IHRvIGF2b2lkIHRoZSBzdGFydmF0aW9uLgo+IAkJICovCj4gCQlpZiAodGlja19jaGVja19icm9h
ZGNhc3RfZXhwaXJlZCgpKSB7Cj4rCQkJc3RydWN0IHRpY2tfZGV2aWNlICp0ZCA9IHRoaXNfY3B1
X3B0cigmdGlja19jcHVfZGV2aWNlKTsKPisKPiAJCQljcHVtYXNrX2NsZWFyX2NwdShzbXBfcHJv
Y2Vzc29yX2lkKCksIHRpY2tfYnJvYWRjYXN0X2ZvcmNlX21hc2spOwo+IAkJCXRpY2tfcHJvZ3Jh
bV9ldmVudCh0ZC0+ZXZ0ZGV2LT5uZXh0X2V2ZW50LCAxKTsKPiAJCX0K

