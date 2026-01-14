Return-Path: <stable+bounces-208323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB86D1CA9E
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 07:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103E830B1CF9
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEFA3557E2;
	Wed, 14 Jan 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gLhKIejM"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5D36C598
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371920; cv=none; b=W8smQD5oM/lC55gzXXnbAGWwub1563b0j7VHck2kVcxL8O+9/cO4/P+wLN8NRIWWDfFVyeVyxIxVyQr+qkC4M2uSaozEZo0Q6DKj5pm3K6BUjr+w8OsrEhStqKop4daGzZpMHf/7Ga5g5VRzKaOfcBfKE3+hH96984X3grWGP6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371920; c=relaxed/simple;
	bh=Y6LQY2PoEdF0cY3h8H9d3uMlzwqS0f4la3EAdqB44Lk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=GMJzS39lV8ukxhwztr7vfy+MAn9Q67+leYpcJwr3C+yyNGaF3v/SY8W9fvFq2LF10XQp9nEvchWRHG2wWbwh4VYqPNsH5BPKGjEbwyF7TAIoIGto6Jx4f2fa1C+Uk2RiBSiLZ/L0+po8352tby3VJ8VQtqYYDRY0UV9ZKKS6E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gLhKIejM; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768371871;
	bh=Y6LQY2PoEdF0cY3h8H9d3uMlzwqS0f4la3EAdqB44Lk=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=gLhKIejMDzhP9MGrshqLjh76vsoxyIlhZPPwtVPodyAKZw4/y7sKCd3yOFzrZ0a3p
	 K7Roup4yjFi10XKiPh0wVA3Ze4a2VmV33ZFjPVK67gk34Mb0prEbHGVsLhuuBoA43Z
	 rkA0BujMhNIYhS9uBLSI9lioJ5ShrIrS/+rbCZWw=
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTq+JF+mJBOLfBuvx6V38wzSLJqdP2igoo=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: ZfU6ubqTDSoSEpBdiF7dh74E6318BuPySh4DUfXQxh8=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1768371855t9ef19200
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>, "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>
Subject: Re: [PATCH 6.6] Revert "LoongArch: BPF: Sign extend kfunc call arguments"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 14 Jan 2026 14:24:15 +0800
X-Priority: 3
Message-ID: <tencent_2AA9934C60F1658F28275258@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_09063379481F265B19AC7AC7@qq.com>
In-Reply-To: <tencent_09063379481F265B19AC7AC7@qq.com>
X-QQ-ReplyHash: 3650666767
X-BIZMAIL-ID: 8272568184853814656
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 14 Jan 2026 14:24:16 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OA4MoK4D0Qv3aEwFPK0XudeI6m/iay/9BsUiL423B4m3hAbBHGU18r9n
	5VmqudAzcSTn7BBqQum6rLYXQwKjpdB+SosNXk0R9oyaDZ3IrYAtIzdR/qEuz2Nycldvig+
	WdGtOQifOf3Vb9zlqHVi9d5gK9+81WENCYQrvoT/gfinqmP906AcFEhyGYq5Ktu8brVI2Eb
	tdA7QXM5N/5zaECuug28atyCIFb98RHsD18xOLmVrvifHG1DxXxVFBcKdSLogXsFDWKeZ/l
	cD9vReeROZn/3WlFfwrl/VZuCxapFbXnDtSOxvOI4cG6GI4scytKGILa5mzqB0xm0p9syEW
	6pf2KzW2V3X+M0hE+WyF4rcEyXE10n7D6dHm3OjwrnZQrSq64wZ6Ws6pIH03lwF2pd1mHjL
	Ma7hs6V0agEPFXS8zaCEbXYMTsDLTOcp8s3lGok82ZXpl0F161Nu3fzI5pHQ+oZFOEWajwm
	DdcRQoH1/ZZojkBETJaUzaUA8qmgLaRx6jmFWC8V2Af4Lw/3ZglNEDuXO3TD213oKQAoZ97
	mI2iceYNXqL5zC1UzfCoZ5kTmBI7QcOlW9mJNm/S4WPSrG350E8tY0w7o+gzQWvTsdKq8YU
	6kB9GDNEfx7t/A6IK2zacYALB8fd9S7ZabZ3UL6Hi8AQEd9eAX92nRAo+xVJB34HPJycioo
	fBFsv1ymoSnygF9REP4iYCRxAbS8CmqRscGJwkyU4/oF14Fw+9wBOhp3FQMML9N/KjJJF42
	G3tI8E9PU/3sHwXSMF0BvmhelN/mNNxjLxulJOnLobZQ9U4dvAr0VT/GPowhpfIAh5TvcNe
	c9PBUzyParo7DmkSptXTrwuPJBCXfd821mQWHnCFrEAhtQ+OqCGr2BjAtdSoUPf4jm7hTy3
	4DqpFh2us8/lQKO5XHjiFJYlr4ITkLm7Og3jy3aVI5vkJc19nXltO520BZcRmVap5zpt80u
	izw52yYtSGveUJxt1ju8qcGrIm/9rPMuB8/qGdwG+R6nCHR2zHTswFktSvWJ/qTDgcytnMZ
	U2g1fxbC8Fq4m4wPUYZhuazffUZ5QuaGIzg7lUa4rLGf5XC4J/m5ziHb5ONemtScMDEtsUV
	QElBLorKBQ9
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

SGVsbG8gQWxsLA0KDQpJIHRoaW5rIHRoZSBiZXN0IHdheSBpcyBiYWNrcG9ydCBhZGQyODAy
NDQwNWVkNjAwYWZhYTAyNzQ5OTg5ZDRmZDExOWY5MDU3LA0KKCJMb29uZ0FyY2g6IEFkZCBt
b3JlIGluc3RydWN0aW9uIG9wY29kZXMgYW5kIGVtaXRfKiBoZWxwZXJzIikNCkkgdGVzdCB3
aGVuIGNoZXJyeS1waWNrIGl0LCBpdCBidWlsZCBvay4NCg0KQlJzDQpXZW50YW8gR3Vhbg0K
DQpGcm9tIGZkNmUwOWU3ODgxM2I2MmZlMWY0YzQ5ZGMyMDI1NWI0ZTQxNDRlMmQgTW9uIFNl
cCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBIZW5ncWkgQ2hlbiA8aGVuZ3FpLmNoZW5AZ21h
aWwuY29tPg0KRGF0ZTogV2VkLCA4IE5vdiAyMDIzIDE0OjEyOjE1ICswODAwDQpTdWJqZWN0
OiBbUEFUQ0hdIExvb25nQXJjaDogQWRkIG1vcmUgaW5zdHJ1Y3Rpb24gb3Bjb2RlcyBhbmQg
ZW1pdF8qIGhlbHBlcnMNCg0KVGhpcyBwYXRjaCBhZGRzIG1vcmUgaW5zdHJ1Y3Rpb24gb3Bj
b2RlcyBhbmQgdGhlaXIgY29ycmVzcG9uZGluZyBlbWl0XyoNCmhlbHBlcnMgd2hpY2ggd2ls
bCBiZSB1c2VkIGluIGxhdGVyIHBhdGNoZXMuDQoNClNpZ25lZC1vZmYtYnk6IEhlbmdxaSBD
aGVuIDxoZW5ncWkuY2hlbkBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBIdWFjYWkgQ2hl
biA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5jbj4NCihjaGVycnkgcGlja2VkIGZyb20gY29tbWl0
IGFkZDI4MDI0NDA1ZWQ2MDBhZmFhMDI3NDk5ODlkNGZkMTE5ZjkwNTcpDQpTaWduZWQtb2Zm
LWJ5OiBXZW50YW8gR3VhbiA8Z3VhbndlbnRhb0B1bmlvbnRlY2guY29tPg0KLS0tDQogYXJj
aC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vaW5zdC5oIHwgMTMgKysrKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2xv
b25nYXJjaC9pbmNsdWRlL2FzbS9pbnN0LmggYi9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2Fz
bS9pbnN0LmgNCmluZGV4IDRmYTUzYWQ4MmVmYjMuLjk2NDI1OGUyOTcyZTkgMTAwNjQ0DQot
LS0gYS9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9pbnN0LmgNCisrKyBiL2FyY2gvbG9v
bmdhcmNoL2luY2x1ZGUvYXNtL2luc3QuaA0KQEAgLTY1LDYgKzY1LDggQEAgZW51bSByZWcy
X29wIHsNCiAgICAgICAgcmV2YmRfb3AgICAgICAgID0gMHgwZiwNCiAgICAgICAgcmV2aDJ3
X29wICAgICAgID0gMHgxMCwNCiAgICAgICAgcmV2aGRfb3AgICAgICAgID0gMHgxMSwNCisg
ICAgICAgZXh0d2hfb3AgICAgICAgID0gMHgxNiwNCisgICAgICAgZXh0d2Jfb3AgICAgICAg
ID0gMHgxNywNCiB9Ow0KIA0KIGVudW0gcmVnMmk1X29wIHsNCkBAIC01NTYsNiArNTU4LDgg
QEAgc3RhdGljIGlubGluZSB2b2lkIGVtaXRfIyNOQU1FKHVuaW9uIGxvb25nYXJjaF9pbnN0
cnVjdGlvbiAqaW5zbiwgICBcDQogREVGX0VNSVRfUkVHMl9GT1JNQVQocmV2YjJoLCByZXZi
Mmhfb3ApDQogREVGX0VNSVRfUkVHMl9GT1JNQVQocmV2YjJ3LCByZXZiMndfb3ApDQogREVG
X0VNSVRfUkVHMl9GT1JNQVQocmV2YmQsIHJldmJkX29wKQ0KK0RFRl9FTUlUX1JFRzJfRk9S
TUFUKGV4dHdoLCBleHR3aF9vcCkNCitERUZfRU1JVF9SRUcyX0ZPUk1BVChleHR3YiwgZXh0
d2Jfb3ApDQogDQogI2RlZmluZSBERUZfRU1JVF9SRUcySTVfRk9STUFUKE5BTUUsIE9QKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogc3RhdGljIGlubGluZSB2b2lkIGVt
aXRfIyNOQU1FKHVuaW9uIGxvb25nYXJjaF9pbnN0cnVjdGlvbiAqaW5zbiwgICAgICBcDQpA
QCAtNjA3LDYgKzYxMSw5IEBAIERFRl9FTUlUX1JFRzJJMTJfRk9STUFUKGx1NTJpZCwgbHU1
MmlkX29wKQ0KIERFRl9FTUlUX1JFRzJJMTJfRk9STUFUKGFuZGksIGFuZGlfb3ApDQogREVG
X0VNSVRfUkVHMkkxMl9GT1JNQVQob3JpLCBvcmlfb3ApDQogREVGX0VNSVRfUkVHMkkxMl9G
T1JNQVQoeG9yaSwgeG9yaV9vcCkNCitERUZfRU1JVF9SRUcySTEyX0ZPUk1BVChsZGIsIGxk
Yl9vcCkNCitERUZfRU1JVF9SRUcySTEyX0ZPUk1BVChsZGgsIGxkaF9vcCkNCitERUZfRU1J
VF9SRUcySTEyX0ZPUk1BVChsZHcsIGxkd19vcCkNCiBERUZfRU1JVF9SRUcySTEyX0ZPUk1B
VChsZGJ1LCBsZGJ1X29wKQ0KIERFRl9FTUlUX1JFRzJJMTJfRk9STUFUKGxkaHUsIGxkaHVf
b3ApDQogREVGX0VNSVRfUkVHMkkxMl9GT1JNQVQobGR3dSwgbGR3dV9vcCkNCkBAIC02OTUs
OSArNzAyLDEyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBlbWl0XyMjTkFNRSh1bmlvbiBsb29u
Z2FyY2hfaW5zdHJ1Y3Rpb24gKmluc24sICBcDQogICAgICAgIGluc24tPnJlZzNfZm9ybWF0
LnJrID0gcms7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogfQ0K
IA0KK0RFRl9FTUlUX1JFRzNfRk9STUFUKGFkZHcsIGFkZHdfb3ApDQogREVGX0VNSVRfUkVH
M19GT1JNQVQoYWRkZCwgYWRkZF9vcCkNCiBERUZfRU1JVF9SRUczX0ZPUk1BVChzdWJkLCBz
dWJkX29wKQ0KIERFRl9FTUlUX1JFRzNfRk9STUFUKG11bGQsIG11bGRfb3ApDQorREVGX0VN
SVRfUkVHM19GT1JNQVQoZGl2ZCwgZGl2ZF9vcCkNCitERUZfRU1JVF9SRUczX0ZPUk1BVCht
b2RkLCBtb2RkX29wKQ0KIERFRl9FTUlUX1JFRzNfRk9STUFUKGRpdmR1LCBkaXZkdV9vcCkN
CiBERUZfRU1JVF9SRUczX0ZPUk1BVChtb2RkdSwgbW9kZHVfb3ApDQogREVGX0VNSVRfUkVH
M19GT1JNQVQoYW5kLCBhbmRfb3ApDQpAQCAtNzA5LDYgKzcxOSw5IEBAIERFRl9FTUlUX1JF
RzNfRk9STUFUKHNybHcsIHNybHdfb3ApDQogREVGX0VNSVRfUkVHM19GT1JNQVQoc3JsZCwg
c3JsZF9vcCkNCiBERUZfRU1JVF9SRUczX0ZPUk1BVChzcmF3LCBzcmF3X29wKQ0KIERFRl9F
TUlUX1JFRzNfRk9STUFUKHNyYWQsIHNyYWRfb3ApDQorREVGX0VNSVRfUkVHM19GT1JNQVQo
bGR4YiwgbGR4Yl9vcCkNCitERUZfRU1JVF9SRUczX0ZPUk1BVChsZHhoLCBsZHhoX29wKQ0K
K0RFRl9FTUlUX1JFRzNfRk9STUFUKGxkeHcsIGxkeHdfb3ApDQogREVGX0VNSVRfUkVHM19G
T1JNQVQobGR4YnUsIGxkeGJ1X29wKQ0KIERFRl9FTUlUX1JFRzNfRk9STUFUKGxkeGh1LCBs
ZHhodV9vcCkNCiBERUZfRU1JVF9SRUczX0ZPUk1BVChsZHh3dSwgbGR4d3Vfb3ApDQotLSAN
CjIuMjAuMQ==


