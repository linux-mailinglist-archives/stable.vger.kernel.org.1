Return-Path: <stable+bounces-195163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45209C6E13C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3D5172E19B
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F634D928;
	Wed, 19 Nov 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="ejtmpWyK"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A234CFCB;
	Wed, 19 Nov 2025 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549626; cv=none; b=NuPv4UHnY7ygSpXZkd3Se+Sh+Gfj7W7uxuX9cJjUr+8QJRQ59T0Qs3TleydrtZnh9lvLUDo6GPG5oBtYLEIxVhevLxt1U69O5yHh0u4UkSKyTDNNReQbnq6uzKzpHZU77M8/VSFOIK2ThLkoXSsk8Jqw+5kCI46ZcJHoenIOiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549626; c=relaxed/simple;
	bh=r8NQXmkDGFK45wMHuCWwoJWze6DIL4Jbz9p+2HOcp/o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vn4y196lZmYUtAfXXowQfDF66gjFaThSESjAwPxrjFb6ApKfBmgucVt+bb8Vrc7EWigOxH+qfRc5c5kvtioTAG107E5K+ppSNKJsDfIHPowmGFScylK88TY5Cjh7L7LnPGA57GuNk8dazvYdMElepavL47mig/Qr+BhkFmYUy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=ejtmpWyK; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTPS id 5AJApD1P015814-5AJApD1R015814
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:51:13 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 19 Nov
 2025 13:51:12 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 19 Nov 2025 13:51:12 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Sriharsha Basavapatna
	<sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Venkata Duvvuru
	<VenkatKumar.Duvvuru@Emulex.Com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] be2net: pass wrb_params in case of OS2BMC
Thread-Topic: [PATCH net] be2net: pass wrb_params in case of OS2BMC
Thread-Index: AQHcWUJr/pH3Et6rekuGUHy0xRHHsg==
Date: Wed, 19 Nov 2025 10:51:12 +0000
Message-ID: <20251119105015.194501-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 11/18/2025 10:39:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AAC07FCABA36D47B99B9BEAA47F1486@crpt.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhaXkgJAgEcRgMACRgJGgwNKAoaBwkMCwcFRgsHBUhYSFpIWVpIWVFaRlleUEZeWEZbSFBIWEhYSFFIWEhYSFhIWl5ICQIBHEYDAAkYCRoMDSgKGgcJDAsHBUYLBwVIWEhaWUgJBgwaDR9DBg0cDA0eKAQdBgZGCwBIWEhZUUgMCR4NBSgMCR4NBQQHDhxGBg0cSFhIWVFIDQwdBQkSDRwoDwcHDwQNRgsHBUhYSFldSAMdCgkoAw0aBg0ERgcaD0hYSFpQSAQBBh0QRQMNGgYNBCgeDw0aRgMNGgYNBEYHGg9IWEhaUEgEHgtFGBoHAg0LHCgEAQYdEBwNGxwBBg9GBxoPSFhIWV9IGAkKDQYBKBoNDAAJHEYLBwVIWEhbWEg+DQYDCRwjHQUJGkYsHR4eHRodKA0FHQQNEEYLBwVIWA==
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=r8NQXmkDGFK45wMHuCWwoJWze6DIL4Jbz9p+2HOcp/o=;
 b=ejtmpWyK3YYi/4wHcCWgLa/WMvB3Aa4S/mFVSwPGpDEs8p4I5jh3NuFzmSw+tRkd6N70ojzON4zE
	3vVfUx/un5npcgUV7lCWVFekeKkPrQjb9dGRNxGynrmgJM+7S3uKY70a4Hh2PZIPHA2xr3ToQ4Qs
	v/vfspGiXIo3PBgWrwhU9HsZdcbtvAOjRzzw2KiOlxzCVvBkTsj1OxjIzON8mq45Xa8rlWWifoIC
	zmnMF7gJowE45V8kB32cFuZEIuCBTmeVYfZXLubyfBwScAd7dZfTUxMVSqqXxdcefzY4kEyK/+Zb
	FFwZ4NY0AyGU3uyX+aVyKDm1lzawBaL3Y7wjlQ==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KYmVfaW5zZXJ0
X3ZsYW5faW5fcGt0KCkgaXMgY2FsbGVkIHdpdGggdGhlIHdyYl9wYXJhbXMgYXJndW1lbnQgYmVp
bmcgTlVMTA0KYXQgYmVfc2VuZF9wa3RfdG9fYm1jKCkgY2FsbCBzaXRlLsKgIFRoaXMgbWF5IGxl
YWQgdG8gZGVyZWZlcmVuY2luZyBhIE5VTEwNCnBvaW50ZXIgd2hlbiBwcm9jZXNzaW5nIGEgd29y
a2Fyb3VuZCBmb3Igc3BlY2lmaWMgcGFja2V0LCBhcyBjb21taXQNCmJjMGMzNDA1YWJiYiAoImJl
Mm5ldDogZml4IGEgVHggc3RhbGwgYnVnIGNhdXNlZCBieSBhIHNwZWNpZmljIGlwdjYNCnBhY2tl
dCIpIHN0YXRlcy4NCg0KVGhlIGNvcnJlY3Qgd2F5IHdvdWxkIGJlIHRvIHBhc3MgdGhlIHdyYl9w
YXJhbXMgZnJvbSBiZV94bWl0KCkuDQoNCkZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50
ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQoNCkZpeGVzOiA3NjBjMjk1ZTBlOGQg
KCJiZTJuZXQ6IFN1cHBvcnQgZm9yIE9TMkJNQy4iKQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNClNpZ25lZC1vZmYtYnk6IEFuZHJleSBWYXRvcm9waW4gPGEudmF0b3JvcGluQGNycHQucnU+
DQotLS0NCnYyOiAtIHBhc3Mgd3JiX3BhcmFtcyBmcm9tIGluc2lkZSBiZV94bWl0KCnCoCAoSmFr
dWIgS2ljaW5za2kpDQp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjUxMTEy
MDkyMDUxLjg1MTE2My0xLWEudmF0b3JvcGluQGNycHQucnUvDQogZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZW11bGV4L2JlbmV0L2JlX21haW4uYyB8IDcgKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9lbXVsZXgvYmVuZXQvYmVfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZW11bGV4L2JlbmV0L2JlX21haW4uYw0KaW5kZXggY2IwMDRmZDE2MjUyLi41YmIzMWM4ZmFiMzkg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9lbXVsZXgvYmVuZXQvYmVfbWFpbi5j
DQorKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9lbXVsZXgvYmVuZXQvYmVfbWFpbi5jDQpAQCAt
MTI5Niw3ICsxMjk2LDggQEAgc3RhdGljIHZvaWQgYmVfeG1pdF9mbHVzaChzdHJ1Y3QgYmVfYWRh
cHRlciAqYWRhcHRlciwgc3RydWN0IGJlX3R4X29iaiAqdHhvKQ0KIAkJKGFkYXB0ZXItPmJtY19m
aWx0X21hc2sgJiBCTUNfRklMVF9NVUxUSUNBU1QpDQogDQogc3RhdGljIGJvb2wgYmVfc2VuZF9w
a3RfdG9fYm1jKHN0cnVjdCBiZV9hZGFwdGVyICphZGFwdGVyLA0KLQkJCSAgICAgICBzdHJ1Y3Qg
c2tfYnVmZiAqKnNrYikNCisJCQkgICAgICAgc3RydWN0IHNrX2J1ZmYgKipza2IsDQorCQkJICAg
ICAgIHN0cnVjdCBiZV93cmJfcGFyYW1zICp3cmJfcGFyYW1zKQ0KIHsNCiAJc3RydWN0IGV0aGhk
ciAqZWggPSAoc3RydWN0IGV0aGhkciAqKSgqc2tiKS0+ZGF0YTsNCiAJYm9vbCBvczJibWMgPSBm
YWxzZTsNCkBAIC0xMzYwLDcgKzEzNjEsNyBAQCBzdGF0aWMgYm9vbCBiZV9zZW5kX3BrdF90b19i
bWMoc3RydWN0IGJlX2FkYXB0ZXIgKmFkYXB0ZXIsDQogCSAqIHRvIEJNQywgYXNpYyBleHBlY3Rz
IHRoZSB2bGFuIHRvIGJlIGlubGluZSBpbiB0aGUgcGFja2V0Lg0KIAkgKi8NCiAJaWYgKG9zMmJt
YykNCi0JCSpza2IgPSBiZV9pbnNlcnRfdmxhbl9pbl9wa3QoYWRhcHRlciwgKnNrYiwgTlVMTCk7
DQorCQkqc2tiID0gYmVfaW5zZXJ0X3ZsYW5faW5fcGt0KGFkYXB0ZXIsICpza2IsIHdyYl9wYXJh
bXMpOw0KIA0KIAlyZXR1cm4gb3MyYm1jOw0KIH0NCkBAIC0xMzg3LDcgKzEzODgsNyBAQCBzdGF0
aWMgbmV0ZGV2X3R4X3QgYmVfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2Rl
dmljZSAqbmV0ZGV2KQ0KIAkvKiBpZiBvczJibWMgaXMgZW5hYmxlZCBhbmQgaWYgdGhlIHBrdCBp
cyBkZXN0aW5lZCB0byBibWMsDQogCSAqIGVucXVldWUgdGhlIHBrdCBhIDJuZCB0aW1lIHdpdGgg
bWdtdCBiaXQgc2V0Lg0KIAkgKi8NCi0JaWYgKGJlX3NlbmRfcGt0X3RvX2JtYyhhZGFwdGVyLCAm
c2tiKSkgew0KKwlpZiAoYmVfc2VuZF9wa3RfdG9fYm1jKGFkYXB0ZXIsICZza2IsICZ3cmJfcGFy
YW1zKSkgew0KIAkJQkVfV1JCX0ZfU0VUKHdyYl9wYXJhbXMuZmVhdHVyZXMsIE9TMkJNQywgMSk7
DQogCQl3cmJfY250ID0gYmVfeG1pdF9lbnF1ZXVlKGFkYXB0ZXIsIHR4bywgc2tiLCAmd3JiX3Bh
cmFtcyk7DQogCQlpZiAodW5saWtlbHkoIXdyYl9jbnQpKQ0KLS0gDQoyLjQzLjANCg==

