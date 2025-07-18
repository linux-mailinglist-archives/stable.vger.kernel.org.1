Return-Path: <stable+bounces-163356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B7B0A0AC
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400A61AA46CB
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9829C343;
	Fri, 18 Jul 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fyg+6pdC"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE6221297;
	Fri, 18 Jul 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834554; cv=none; b=auN2WqivWp3NhmppTjyiUR3o7uEjHwvv5bVz1qS5MgizQNr0vIaxuSmXuHvrCJ1mMenH/fHeB2YPoZuGBM4ZJYtF8SAvl8V1Dv7m9T+PQ4qR3bCIK7ZTdKhGRcsfkyzm9nOC+Fph9qX2WwbAwcVw/UOn5ALLe6FNIaxOxm5z5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834554; c=relaxed/simple;
	bh=xjrDRr782sePSQVOCVhimtrQA1KZ/CJ2tMd/Ps4topo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WnbudKp4HSio8N0Nap12kPMwsH12uM0wuMPBscuQZubkqYdiKaBUcQxQNtZ8Frmxfw0S/nhrIfSqX1im5K4TSARJDQyyk34Sd301JSr5QacIWYWU49U0BwkoRdhkrxDom0ooDprzzthtOEpRo9Eig5EPy6krmLjppJTMw1RG4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fyg+6pdC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56IASePkA1422390, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752834520; bh=xjrDRr782sePSQVOCVhimtrQA1KZ/CJ2tMd/Ps4topo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fyg+6pdCoZzV7MRxScrjoffWCQgTxmaweRPIGeCPbvuOSXh0Ev+Td++Xyb8XmMumC
	 vQ+qijFgwx2QLPc0l+7YxT9me6XIFbj0B2/UPv0zRxIdNMiyp2lq2nkncGShgGPxKF
	 vKBKiSlnaMS0+nUhFxVNlDxX+f1Cwv99gH9/zd9sDgaVGTkqKUA2PKYq6L4pN1r9HC
	 8kkIL6pzQPFwmYX8kWAo4DgSl94W6DY6lzusO/uM8yDYWxE+QtO90dWpBE4ib+SoeD
	 /hS2/xdMlE6WkkvECR/U29mOCoUm1YCKQ0eyCWQNfDxBsCqQ7HoyrMaQnpSxggirDz
	 hb6O4QEJr7nCQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56IASePkA1422390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:28:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 18:28:41 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Jul 2025 18:28:40 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Fri, 18 Jul 2025 18:28:40 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Gwendal Grignou <gwendal@google.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>, "gfl3162@gmail.com" <gfl3162@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        Linux Kernel
	<linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when card is present
Thread-Topic: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
Thread-Index: AQHb90TblG9c2uNggkeqhjG4r/HTebQ3rNiA
Date: Fri, 18 Jul 2025 10:28:40 +0000
Message-ID: <b1bda1a712b64785ad4a3c1a083ca839@realtek.com>
References: <CAMHSBOWue5bwysERvoZQjSG8h32me06wwcSQGteTN=aX=5OXYg@mail.gmail.com>
In-Reply-To: <CAMHSBOWue5bwysERvoZQjSG8h32me06wwcSQGteTN=aX=5OXYg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3VzYi5jIHwgMTYgKysr
KysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9jYXJkcmVhZGVy
L3J0c3hfdXNiLmMNCj4gYi9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3VzYi5jDQo+ID4g
aW5kZXggMTQ4MTA3YTQ1NDdjLi5kMDA3YTQ0NTVjZTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9taXNjL2NhcmRyZWFkZXIvcnRzeF91c2IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9jYXJk
cmVhZGVyL3J0c3hfdXNiLmMNCj4gPiBAQCAtNjk4LDYgKzY5OCwxMiBAQCBzdGF0aWMgdm9pZCBy
dHN4X3VzYl9kaXNjb25uZWN0KHN0cnVjdCB1c2JfaW50ZXJmYWNlDQo+ICppbnRmKQ0KPiA+ICB9
DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJR19QTQ0KPiA+ICtzdGF0aWMgaW50IHJ0c3hfdXNiX3Jl
c3VtZV9jaGlsZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQo+ID4gK3sNCj4gPiAr
ICAgICAgIHBtX3JlcXVlc3RfcmVzdW1lKGRldik7DQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBydHN4X3VzYl9zdXNwZW5kKHN0cnVjdCB1c2Jf
aW50ZXJmYWNlICppbnRmLCBwbV9tZXNzYWdlX3QNCj4gbWVzc2FnZSkNCj4gPiAgew0KPiA+ICAg
ICAgICAgc3RydWN0IHJ0c3hfdWNyICp1Y3IgPQ0KPiA+IEBAIC03MTMsOCArNzE5LDEwIEBAIHN0
YXRpYyBpbnQgcnRzeF91c2Jfc3VzcGVuZChzdHJ1Y3QgdXNiX2ludGVyZmFjZQ0KPiAqaW50Ziwg
cG1fbWVzc2FnZV90IG1lc3NhZ2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhf
dW5sb2NrKCZ1Y3ItPmRldl9tdXRleCk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAvKiBEZWZlciB0aGUgYXV0b3N1c3BlbmQgaWYgY2FyZCBleGlzdHMgKi8NCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBpZiAodmFsICYgKFNEX0NEIHwgTVNfQ0QpKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGlmICh2YWwgJiAoU0RfQ0QgfCBNU19DRCkpIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV9mb3JfZWFjaF9jaGlsZCgmaW50Zi0+ZGV2
LA0KPiBOVUxMLCBydHN4X3VzYl9yZXN1bWVfY2hpbGQpOw0KPiBXaHkgbm90IGNhbGxpbmcgcnRz
eF91c2JfcmVzdW1lKCkgaGVyZT8NCg0KQmVjYXVzZSBpbiB0aGlzIHRpbWUgcnRzeF91c2IgaXMg
bm90IGluIHJ1bnRpbWVfc3VzcGVuZCwgb25seSBuZWVkIHRvIG1ha2Ugc3VyZSBjaGlsZCBpcyBu
b3QgaW4gc3VzcGVuZA0KQWN0dWFsbHkgd2hlbiB0aGUgcHJvZ3JhbSBjYW1lIGhlcmUgdGhpcyBz
dXNwZW5kIHdpbGwgYmUgcmVqZWN0ZWQgYmVjYXVzZSByZXR1cm4gLUVBR0FJTg0KDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVBR0FJTjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgLyogVGhlcmUgaXMgYW4gb25nb2luZyBvcGVyYXRpb24qLw0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUFHQUlOOw0KPiA+IEBAIC03MjQs
MTIgKzczMiw2IEBAIHN0YXRpYyBpbnQgcnRzeF91c2Jfc3VzcGVuZChzdHJ1Y3QgdXNiX2ludGVy
ZmFjZQ0KPiAqaW50ZiwgcG1fbWVzc2FnZV90IG1lc3NhZ2UpDQo+ID4gICAgICAgICByZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgcnRzeF91c2JfcmVzdW1lX2NoaWxkKHN0
cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqZGF0YSkNCj4gPiAtew0KPiA+IC0gICAgICAgcG1fcmVx
dWVzdF9yZXN1bWUoZGV2KTsNCj4gPiAtICAgICAgIHJldHVybiAwOw0KPiA+IC19DQo+ID4gLQ0K
PiA+ICBzdGF0aWMgaW50IHJ0c3hfdXNiX3Jlc3VtZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50
ZikNCj4gPiAgew0KPiA+ICAgICAgICAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKCZpbnRmLT5kZXYs
IE5VTEwsIHJ0c3hfdXNiX3Jlc3VtZV9jaGlsZCk7DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K

