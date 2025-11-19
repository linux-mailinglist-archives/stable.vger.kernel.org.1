Return-Path: <stable+bounces-195157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F09ACC6D5EF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573434FE2D7
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63728BA83;
	Wed, 19 Nov 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="otH4H8cm"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BD537E9
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539762; cv=none; b=ogmQTfYQR6I0rSpsk4XlOcPE7Fz1/NN8YVb88F8cMolWyT8VZwe74jYaNanzR6UdtV+x7c+B3xTmuJuiMQZ+cDuhclc21CjsI1+pFqH3agDNo81m5APgROlut3yEpd2oM7lP/Umv3ocZYWxRlCx8SGU+11QI3vQnq2CJ0uurFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539762; c=relaxed/simple;
	bh=mQpdoblp1UsRytLKRtL9BfvqS5ejpdz/QrhW8EaEAgc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=igiQqmuqLSyxya3SocPot7O1JU9/PsARdS356uXJa2umS3P18HMMN451sF75yknbej1aO3WohciahHuDyZ/Bbio7muD2pzS6ugkigRGtdyekncS2RlnLZdM6ACYc75GzGkTGrVGA90PUFnBoUXI/6/l4nCSzVNj/m3anuonHs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=otH4H8cm; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 5AJ89Bga017899-5AJ89Bgc017899
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 19 Nov 2025 11:09:11 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 19 Nov
 2025 11:09:10 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 19 Nov 2025 11:09:10 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] be2net: Use the wrb_params instead the NULL pointer
Thread-Topic: [PATCH] be2net: Use the wrb_params instead the NULL pointer
Thread-Index: AQHcWSvI5bb6Mbx930qi3deNPY+LyQ==
Date: Wed, 19 Nov 2025 08:09:10 +0000
Message-ID: <20251119080900.133383-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 11/18/2025 10:39:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA722F684307DC448359CCCCDDC25A82@crpt.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhaUEgEHgtFGAkcCwANGygEAQYdEBwNGxwBBg9GBxoPSFhIWkhZWkhZUVpGWV5QRl5YRlxIUEhYSFhIWkhYSFhIWEhaUEgEHgtFGAkcCwANGygEAQYdEBwNGxwBBg9GBxoPSFhIWlpIGxwJCgQNKB4PDRpGAw0aBg0ERgcaD0hY
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=mQpdoblp1UsRytLKRtL9BfvqS5ejpdz/QrhW8EaEAgc=;
 b=otH4H8cmvqdGgu4kurqRb1TMV6FfNol2yKkfUwf8RpH8vMKp9Fw9BfFCSezxnv8/ErupwWIzshVR
	U6AW+6bfgW8ilAN43ZFcbnzAhaozcqTQg/wOSlborpnps6B+xwW4MGcohtRR0mYg+kFgL2AhES3n
	Dpfh5kYg8e8fFexRe9ZRSJZ0zPTBJqtSfazt8k5aetz4wk0x96KMExbLn0BzoKMlO9CBFL+8bvjm
	Wbz5Fdfp/u86DvL+J9hTcfMVwZRpSVU6/b5qra+tYiMniJZvlQLvGZ07SNlghI6TGzuSEgN9moNI
	wMr27I7Ft9DxCvBfyZwu9MpXh0YTUMTwh29LaQ==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KYmVfaW5zZXJ0
X3ZsYW5faW5fcGt0KCkgaXMgY2FsbGVkIHdpdGggdGhlIHdyYl9wYXJhbXMgYXJndW1lbnQgYmVp
bmcgTlVMTA0KYXQgYmVfc2VuZF9wa3RfdG9fYm1jKCkgY2FsbCBzaXRlLsKgIFRoaXMgbWF5IGxl
YWQgdG8gZGVyZWZlcmVuY2luZyBhIE5VTEwNCnBvaW50ZXIgd2hlbiBwcm9jZXNzaW5nIGEgd29y
a2Fyb3VuZCBmb3Igc3BlY2lmaWMgcGFja2V0LCBhcyBjb21taXQNCmJjMGMzNDA1YWJiYiAoImJl
Mm5ldDogZml4IGEgVHggc3RhbGwgYnVnIGNhdXNlZCBieSBhIHNwZWNpZmljIGlwdjYNCnBhY2tl
dCIpIHN0YXRlcy4NCg0KVGhlIGNvcnJlY3Qgd2F5IHdvdWxkIGJlIHRvIHBhc3MgdGhlIHdyYl9w
YXJhbXMgZnJvbSBiZV94bWl0KCkuDQoNCkZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50
ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQoNCkZpeGVzOiA3NjBjMjk1ZTBlOGQg
KCJiZTJuZXQ6IFN1cHBvcnQgZm9yIE9TMkJNQy4iKS4NCkNjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgVmF0b3JvcGluIDxhLnZhdG9yb3BpbkBjcnB0LnJ1
Pg0KLS0tDQogZHJpdmVycy9uZXQvZXRoZXJuZXQvZW11bGV4L2JlbmV0L2JlX21haW4uYyB8IDYg
KysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2VtdWxleC9iZW5ldC9iZV9tYWlu
LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9lbXVsZXgvYmVuZXQvYmVfbWFpbi5jDQppbmRleCBj
YjAwNGZkMTYyNTIuLjYzMTA0NTU5MGQ0MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2VtdWxleC9iZW5ldC9iZV9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Vt
dWxleC9iZW5ldC9iZV9tYWluLmMNCkBAIC0xMjk2LDcgKzEyOTYsNyBAQCBzdGF0aWMgdm9pZCBi
ZV94bWl0X2ZsdXNoKHN0cnVjdCBiZV9hZGFwdGVyICphZGFwdGVyLCBzdHJ1Y3QgYmVfdHhfb2Jq
ICp0eG8pDQogCQkoYWRhcHRlci0+Ym1jX2ZpbHRfbWFzayAmIEJNQ19GSUxUX01VTFRJQ0FTVCkN
CiANCiBzdGF0aWMgYm9vbCBiZV9zZW5kX3BrdF90b19ibWMoc3RydWN0IGJlX2FkYXB0ZXIgKmFk
YXB0ZXIsDQotCQkJICAgICAgIHN0cnVjdCBza19idWZmICoqc2tiKQ0KKwkJCSAgICAgICBzdHJ1
Y3Qgc2tfYnVmZiAqKnNrYiwgc3RydWN0IGJlX3dyYl9wYXJhbXMgKndyYl9wYXJhbXMpDQogew0K
IAlzdHJ1Y3QgZXRoaGRyICplaCA9IChzdHJ1Y3QgZXRoaGRyICopKCpza2IpLT5kYXRhOw0KIAli
b29sIG9zMmJtYyA9IGZhbHNlOw0KQEAgLTEzNjAsNyArMTM2MCw3IEBAIHN0YXRpYyBib29sIGJl
X3NlbmRfcGt0X3RvX2JtYyhzdHJ1Y3QgYmVfYWRhcHRlciAqYWRhcHRlciwNCiAJICogdG8gQk1D
LCBhc2ljIGV4cGVjdHMgdGhlIHZsYW4gdG8gYmUgaW5saW5lIGluIHRoZSBwYWNrZXQuDQogCSAq
Lw0KIAlpZiAob3MyYm1jKQ0KLQkJKnNrYiA9IGJlX2luc2VydF92bGFuX2luX3BrdChhZGFwdGVy
LCAqc2tiLCBOVUxMKTsNCisJCSpza2IgPSBiZV9pbnNlcnRfdmxhbl9pbl9wa3QoYWRhcHRlciwg
KnNrYiwgd3JiX3BhcmFtcyk7DQogDQogCXJldHVybiBvczJibWM7DQogfQ0KQEAgLTEzODcsNyAr
MTM4Nyw3IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBiZV94bWl0KHN0cnVjdCBza19idWZmICpza2Is
IHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQogCS8qIGlmIG9zMmJtYyBpcyBlbmFibGVkIGFu
ZCBpZiB0aGUgcGt0IGlzIGRlc3RpbmVkIHRvIGJtYywNCiAJICogZW5xdWV1ZSB0aGUgcGt0IGEg
Mm5kIHRpbWUgd2l0aCBtZ210IGJpdCBzZXQuDQogCSAqLw0KLQlpZiAoYmVfc2VuZF9wa3RfdG9f
Ym1jKGFkYXB0ZXIsICZza2IpKSB7DQorCWlmIChiZV9zZW5kX3BrdF90b19ibWMoYWRhcHRlciwg
JnNrYiwgJndyYl9wYXJhbXMpKSB7DQogCQlCRV9XUkJfRl9TRVQod3JiX3BhcmFtcy5mZWF0dXJl
cywgT1MyQk1DLCAxKTsNCiAJCXdyYl9jbnQgPSBiZV94bWl0X2VucXVldWUoYWRhcHRlciwgdHhv
LCBza2IsICZ3cmJfcGFyYW1zKTsNCiAJCWlmICh1bmxpa2VseSghd3JiX2NudCkpDQotLSANCjIu
NDMuMA0K

