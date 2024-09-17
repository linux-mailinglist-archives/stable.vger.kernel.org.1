Return-Path: <stable+bounces-76577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CD97AF00
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0F1C21484
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611F167D80;
	Tue, 17 Sep 2024 10:38:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF9166F2E;
	Tue, 17 Sep 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569493; cv=none; b=QFTTgschIHqWUjSoB/XOnczsT1wHaxHikovBuxmZ6ck/VhfIXecb1rP77yHbdyNF+8ovGpB+eoLit/IdFt4K9s13sDD7HZnXFuvFI14EUPu55fhZsHz6FrD+bdeAfkyD2goBzccJZqE/shKB6W/fqc2BeAoDQLz9F7l9VZVMVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569493; c=relaxed/simple;
	bh=qUyC053BFLbdvh1TwSeAnDW+JocofleEoV+3f6rWh/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ljuohh6yL4HSCGfaAG6CR/6fjo7RGzjbbEhA4XZAj/I4wO+k/cdri/w5cHhMniJuaZngJg9aK9s4adNqNNd/eNofl4V1S597eDkp24dPMVtK3DKzkZWnSiwKbc+2hEjwRSN5gcH/vAqoXF+JnrIDUzXHETfZ5QXfbntTo3F2kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 17 Sep
 2024 13:38:06 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 17 Sep 2024 13:38:06 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Karina Yankevich <k.yankevich@omp.ru>, "rafael@kernel.org"
	<rafael@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, Sergey Yudin <s.yudin@omp.ru>,
	"mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 5.10] xhci: check virt_dev is valid before dereferencing
 it
Thread-Topic: [PATCH 5.10] xhci: check virt_dev is valid before dereferencing
 it
Thread-Index: AQHbCOln/SYt17slkkiGE+zcRk3mnbJblz2A
Date: Tue, 17 Sep 2024 10:38:06 +0000
Message-ID: <204adc683e0e71f227ba3f0c6126a80d9b281768.camel@omp.ru>
References: <20240917100703.80166-1-r.smirnov@omp.ru>
In-Reply-To: <20240917100703.80166-1-r.smirnov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 9/17/2024 9:17:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <A87ECA70B94A99428A66719B7ECD3694@omp.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA5LTE3IGF0IDEzOjA3ICswMzAwLCBSb21hbiBTbWlybm92IHdyb3RlOgo+
IEZyb206IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPgo+IAo+
IGNvbW1pdCAwM2VkNTc5ZDlkNTFhYTAxODgzMGIwZGUzZThiNDYzZmFmNmI4N2RiIHVwc3RyZWFt
Lgo+IAo+IENoZWNrIHRoYXQgdGhlIHhoY2lfdmlydF9kZXYgc3RydWN0dXJlIHRoYXQgd2UgZHVn
IG91dCBiYXNlZAo+IG9uIGEgc2xvdF9pZCB2YWx1ZSBmcm9tIGEgY29tbWFuZCBjb21wbGV0aW9u
IGlzIHZhbGlkIGJlZm9yZQo+IGRlcmVmZXJlbmNpbmcgaXQuCj4gCj4gU2lnbmVkLW9mZi1ieTog
TWF0aGlhcyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb20+Cj4gTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDEyOTEzMDA0NC4yMDY4NTUtNy1tYXRoaWFzLm55
bWFuQGxpbnV4LmludGVsLmNvbQo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogUm9tYW4gU21pcm5v
diA8ci5zbWlybm92QG9tcC5ydT4KPiAtLS0KPiDCoGRyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5n
LmMgfCAxMiArKysrKysrKystLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1y
aW5nLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmluZy5jCj4gaW5kZXggZmJiN2E1YjUxZWY0
Li5hNzY5ODAzZTdkMzggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXJpbmcu
Ywo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMKPiBAQCAtMTQxNSw2ICsxNDE1
LDggQEAgc3RhdGljIHZvaWQgeGhjaV9oYW5kbGVfY21kX2NvbmZpZ19lcChzdHJ1Y3QgeGhjaV9o
Y2QgKnhoY2ksIGludCBzbG90X2lkLAo+IMKgwqDCoMKgwqDCoMKgwqAgKiBpcyBub3Qgd2FpdGlu
ZyBvbiB0aGUgY29uZmlndXJlIGVuZHBvaW50IGNvbW1hbmQuCj4gwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+IMKgwqDCoMKgwqDCoMKgwqB2aXJ0X2RldiA9IHhoY2ktPmRldnNbc2xvdF9pZF07Cj4gK8Kg
wqDCoMKgwqDCoMKgaWYgKCF2aXJ0X2RldikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuOwo+IMKgwqDCoMKgwqDCoMKgwqBjdHJsX2N0eCA9IHhoY2lfZ2V0X2lucHV0X2Nv
bnRyb2xfY3R4KHZpcnRfZGV2LT5pbl9jdHgpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWN0cmxf
Y3R4KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4aGNpX3dhcm4oeGhjaSwg
IkNvdWxkIG5vdCBnZXQgaW5wdXQgY29udGV4dCwgYmFkIHR5cGUuXG4iKTsKPiBAQCAtMTQ1OSw2
ICsxNDYxLDggQEAgc3RhdGljIHZvaWQgeGhjaV9oYW5kbGVfY21kX2FkZHJfZGV2KHN0cnVjdCB4
aGNpX2hjZCAqeGhjaSwgaW50IHNsb3RfaWQpCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB4aGNp
X3Nsb3RfY3R4ICpzbG90X2N0eDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqB2ZGV2ID0geGhjaS0+
ZGV2c1tzbG90X2lkXTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIXZkZXYpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiDCoMKgwqDCoMKgwqDCoMKgc2xvdF9jdHggPSB4
aGNpX2dldF9zbG90X2N0eCh4aGNpLCB2ZGV2LT5vdXRfY3R4KTsKPiDCoMKgwqDCoMKgwqDCoMKg
dHJhY2VfeGhjaV9oYW5kbGVfY21kX2FkZHJfZGV2KHNsb3RfY3R4KTsKPiDCoH0KPiBAQCAtMTQ3
MCwxMyArMTQ3NCwxNSBAQCBzdGF0aWMgdm9pZCB4aGNpX2hhbmRsZV9jbWRfcmVzZXRfZGV2KHN0
cnVjdCB4aGNpX2hjZCAqeGhjaSwgaW50IHNsb3RfaWQsCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCB4aGNpX3Nsb3RfY3R4ICpzbG90X2N0eDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqB2ZGV2ID0g
eGhjaS0+ZGV2c1tzbG90X2lkXTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIXZkZXYpIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGhjaV93YXJuKHhoY2ksICJSZXNldCBkZXZpY2Ug
Y29tbWFuZCBjb21wbGV0aW9uIGZvciBkaXNhYmxlZCBzbG90ICV1XG4iLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdF9pZCk7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqDC
oMKgwqDCoMKgwqDCoHNsb3RfY3R4ID0geGhjaV9nZXRfc2xvdF9jdHgoeGhjaSwgdmRldi0+b3V0
X2N0eCk7Cj4gwqDCoMKgwqDCoMKgwqDCoHRyYWNlX3hoY2lfaGFuZGxlX2NtZF9yZXNldF9kZXYo
c2xvdF9jdHgpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHhoY2lfZGJnKHhoY2ksICJDb21wbGV0
ZWQgcmVzZXQgZGV2aWNlIGNvbW1hbmQuXG4iKTsKPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXhoY2kt
PmRldnNbc2xvdF9pZF0pCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhoY2lfd2Fy
bih4aGNpLCAiUmVzZXQgZGV2aWNlIGNvbW1hbmQgY29tcGxldGlvbiAiCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgImZvciBk
aXNhYmxlZCBzbG90ICV1XG4iLCBzbG90X2lkKTsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIHZvaWQg
eGhjaV9oYW5kbGVfY21kX25lY19nZXRfZncoc3RydWN0IHhoY2lfaGNkICp4aGNpLAoKU29ycnks
IEkgYWNjaWRlbnRhbGx5IHNlbnQgYSBjb3B5IHRvIHRoZSB3cm9uZyBwbGFjZS4gSSd2ZSByZXNl
bnQgdGhlIHBhdGNoLgo=

