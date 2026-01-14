Return-Path: <stable+bounces-208322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD8D1CA55
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 07:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848A73043937
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA836215D;
	Wed, 14 Jan 2026 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="B9MET0O/"
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6F3557E2
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371280; cv=none; b=thLUyu1Qi1YzCEkPFB2LSt9huaWXjp0CXa1/VJRkEJkCkthOK2D1Krr7Zlz0RSVSbO8wspoDn6LbHcFu9aMl3l1tCD0yK4GBRHfCb2H5wZZh9VTAP1SeqYYbJlR1j6IqwFuSu/fVfft0PGwDyJd0k++wkjLt9k3nAd22O01I2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371280; c=relaxed/simple;
	bh=xKLJrf/GNkosw5wmJrAoX0PxZ2IE7x8F/PzIkUJjsxU=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=F1Zw5aibMP+NqskJpRYH+dtQLtxyOXxMNzDPKzmHBsfV6QanaSAvbzs/NoU3DKAYrLIQAne/FF0WIresiw4bR8e0uDg+E5RqBb9BmCbUj7FCGLhK+wzeR+C1czaGbrSW95gFCwkexukYohBh/Z0hQ34X5ulWFCbfpp1dw3Z6bi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=B9MET0O/; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768371208;
	bh=xKLJrf/GNkosw5wmJrAoX0PxZ2IE7x8F/PzIkUJjsxU=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=B9MET0O/N7Fn5SbwabmB7Ym8/R2KlGCwq+oVTjm+qImxFLS0gJGu0B6FzFttDmLgt
	 +Z6RY3sE4U22dxjnREivm2ZzfoS+wps7zWESZifPtTX+o1WbYNQnKjobhzXFt+f8C9
	 SxWT/ygkzOezdKk35vKl91hXy+srRdpVQ20NUfpw=
EX-QQ-RecipientCnt: 4
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTq+JF+mJBOLfBuvx6V38wzSLJqdP2igoo=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Z6PlN7wpumV3qR7xL+Mf0KW9erTXujux5YDvL8rFUUM=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1768371206t6222a041
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>, "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>
Subject:  [PATCH 6.6] Revert "LoongArch: BPF: Sign extend kfunc call arguments"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 14 Jan 2026 14:13:25 +0800
X-Priority: 3
Message-ID: <tencent_09063379481F265B19AC7AC7@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 17782895801708904327
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 14 Jan 2026 14:13:27 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NOIkHYnr7Vzd4oQmhdMzoTCa02++NYVyWMjGqgPPIqpmyV6HVuk15qy5
	x2u52QOT7Vaa5ix4rJob5IkhY/Q+OT3uYE8TwKBtyOaXL12TfdQIXAPFXEYlu2qaTAnx/58
	Bxbxuvg1vfsq7VbB2jCCBgQQg1WKN2Iy4i+QodvQbqRXE8WrNDufWAY0kysTPDZhQhsr3H/
	T0qIy37cHdpQzZZtAUkBvnvYbMp0UTbAqLn4fLz5fS4nRa+62XbX9N/dBVpVufQcNasctay
	qalkiY+PvYA7hKatcHfItRQfa6BmgDy3uVdO4UHiVz7GsuoIWOkW69w5OHLkwUIa/fdhBCE
	FmEtb5ZdJmuJKfoCQ3YhmHUzmO0L7CD9wCc8uXDVy2QbNXubjcQi1/mGry8gIT+QyMKeeXj
	5w+oiZatMDf1k9BlU9HfUb/O6fgkJz5r0ifLvlkWoSgx2quC0+AfIcJkgw41Ok66gW71jPE
	hqbC0mNrzzVz0u/gKnu3j/uR8O+PwoqjZiicPSOIDClQmLz9jx6vx+j2TOv710lqq5Cgmqv
	JWtHJFzS9xTdpuOMFVEZMUO3usbzDmP52oDXo6wfF/PRHJppaJhaXAMLeOcfwmEg5S4CJxn
	ZjY0eccfNrXvW+BX3HI0PfLpFDBo2DocW7I9t4Q+aD+MEZWPc5s28oEXoftF5P+PXD8iK47
	BSoq3JJgkzeXN0lIseOjjfoAMpZE7NA7Na0x9IJKxKsXfxPuzKceGGJEcz2gvvccfx5yz+A
	96nXCAL7RGhGdi98u1yA/YWsVuE16KhlzIM5JOfGFF0P10c6ZVyHD0Mk3ziRNEHPmuYLFUh
	5PK972R0ifEnqqYQtpmj1MwPox4X/uueE9nyY1izEN9YyNrS+ATw98/w//jJF4OIdR4SG4c
	tv0AHJ27JWLhz5lEX27PIFylcytoEw+sRp6dt5J5trSITrYu8LdljDxu0vyLdjjEJUNt+lr
	6o/97LXdY+opCeoLHzrzdtGPimXuhn2VZO+mRg3f3SdFAzTzOrKCEFWfuYnNa3gw/aNQJlq
	CsxylIHcfCy3h2vs1IBd/BtzlW9BuwuFaggRmm2SSYqGFQIGgb
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

SXQgY2F1c2UgbG9vbmdhcmNoIGJ1aWxkIGZhaWxlZC4gaXQgbmVlZCBtZXJnZSBtb3JlIGRl
cGVuZHMsDQpzdWNoIGFzICJMb29uZ0FyY2g6IEFkZCBtb3JlIGluc3RydWN0aW9uIG9wY29k
ZXMgYW5kIGVtaXRfKiBoZWxwZXJzIg0KVGhpcyByZXZlcnRzIGNvbW1pdCBmZDQzZWRmMzU3
YTNhMWY1ZWQxYzRiZjQ1MGI2MDAwMWM5MDkxYzM5Lg0KDQpjb25maWc6IGh0dHBzOi8vZ2lz
dC5naXRodWIuY29tL29wc2lmZi9iNmM5YzMyYWRlNWY2ZDRhYmI1NDU0YTQ3NmY0YzRlMQ0K
U2lnbmVkLW9mZi1ieTogV2VudGFvIEd1YW4gPGd1YW53ZW50YW9AdW5pb250ZWNoLmNvbT4N
Ci0tLQ0KIGFyY2gvbG9vbmdhcmNoL25ldC9icGZfaml0LmMgfCAxNiAtLS0tLS0tLS0tLS0t
LS0tDQogYXJjaC9sb29uZ2FyY2gvbmV0L2JwZl9qaXQuaCB8IDI2IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0MiBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL25ldC9icGZfaml0LmMgYi9hcmNoL2xvb25nYXJj
aC9uZXQvYnBmX2ppdC5jDQppbmRleCA1NDY2MWNmZmQ2NTRmLi5jNjQwMGQ3Yjk1ZWU4IDEw
MDY0NA0KLS0tIGEvYXJjaC9sb29uZ2FyY2gvbmV0L2JwZl9qaXQuYw0KKysrIGIvYXJjaC9s
b29uZ2FyY2gvbmV0L2JwZl9qaXQuYw0KQEAgLTgzNCwyMiArODM0LDYgQEAgc3RhdGljIGlu
dCBidWlsZF9pbnNuKGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5zbiwgc3RydWN0IGppdF9j
dHggKmN0eCwgYm9vbCBleHQNCiAJCWlmIChyZXQgPCAwKQ0KIAkJCXJldHVybiByZXQ7DQog
DQotCQlpZiAoaW5zbi0+c3JjX3JlZyA9PSBCUEZfUFNFVURPX0tGVU5DX0NBTEwpIHsNCi0J
CQljb25zdCBzdHJ1Y3QgYnRmX2Z1bmNfbW9kZWwgKm07DQotCQkJaW50IGk7DQotDQotCQkJ
bSA9IGJwZl9qaXRfZmluZF9rZnVuY19tb2RlbChjdHgtPnByb2csIGluc24pOw0KLQkJCWlm
ICghbSkNCi0JCQkJcmV0dXJuIC1FSU5WQUw7DQotDQotCQkJZm9yIChpID0gMDsgaSA8IG0t
Pm5yX2FyZ3M7IGkrKykgew0KLQkJCQl1OCByZWcgPSByZWdtYXBbQlBGX1JFR18xICsgaV07
DQotCQkJCWJvb2wgc2lnbiA9IG0tPmFyZ19mbGFnc1tpXSAmIEJURl9GTU9ERUxfU0lHTkVE
X0FSRzsNCi0NCi0JCQkJZW1pdF9hYmlfZXh0KGN0eCwgcmVnLCBtLT5hcmdfc2l6ZVtpXSwg
c2lnbik7DQotCQkJfQ0KLQkJfQ0KLQ0KIAkJbW92ZV9hZGRyKGN0eCwgdDEsIGZ1bmNfYWRk
cik7DQogCQllbWl0X2luc24oY3R4LCBqaXJsLCBMT09OR0FSQ0hfR1BSX1JBLCB0MSwgMCk7
DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvbmV0L2JwZl9qaXQuaCBiL2FyY2gv
bG9vbmdhcmNoL25ldC9icGZfaml0LmgNCmluZGV4IDkzNTJlYTU1NDUzMDguLmY5YzU2OWY1
Mzk0OTEgMTAwNjQ0DQotLS0gYS9hcmNoL2xvb25nYXJjaC9uZXQvYnBmX2ppdC5oDQorKysg
Yi9hcmNoL2xvb25nYXJjaC9uZXQvYnBmX2ppdC5oDQpAQCAtODcsMzIgKzg3LDYgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGVtaXRfc2V4dF8zMihzdHJ1Y3Qgaml0X2N0eCAqY3R4LCBlbnVt
IGxvb25nYXJjaF9ncHIgcmVnLCBib28NCiAJZW1pdF9pbnNuKGN0eCwgYWRkaXcsIHJlZywg
cmVnLCAwKTsNCiB9DQogDQotLyogRW1pdCBwcm9wZXIgZXh0ZW5zaW9uIGFjY29yZGluZyB0
byBBQkkgcmVxdWlyZW1lbnRzLg0KLSAqIE5vdGUgdGhhdCBpdCByZXF1aXJlcyBhIHZhbHVl
IG9mIHNpemUgYHNpemVgIGFscmVhZHkgcmVzaWRlcyBpbiByZWdpc3RlciBgcmVnYC4NCi0g
Ki8NCi1zdGF0aWMgaW5saW5lIHZvaWQgZW1pdF9hYmlfZXh0KHN0cnVjdCBqaXRfY3R4ICpj
dHgsIGludCByZWcsIHU4IHNpemUsIGJvb2wgc2lnbikNCi17DQotCS8qIEFCSSByZXF1aXJl
cyB1bnNpZ25lZCBjaGFyL3Nob3J0IHRvIGJlIHplcm8tZXh0ZW5kZWQgKi8NCi0JaWYgKCFz
aWduICYmIChzaXplID09IDEgfHwgc2l6ZSA9PSAyKSkNCi0JCXJldHVybjsNCi0NCi0Jc3dp
dGNoIChzaXplKSB7DQotCWNhc2UgMToNCi0JCWVtaXRfaW5zbihjdHgsIGV4dHdiLCByZWcs
IHJlZyk7DQotCQlicmVhazsNCi0JY2FzZSAyOg0KLQkJZW1pdF9pbnNuKGN0eCwgZXh0d2gs
IHJlZywgcmVnKTsNCi0JCWJyZWFrOw0KLQljYXNlIDQ6DQotCQllbWl0X2luc24oY3R4LCBh
ZGRpdywgcmVnLCByZWcsIDApOw0KLQkJYnJlYWs7DQotCWNhc2UgODoNCi0JCWJyZWFrOw0K
LQlkZWZhdWx0Og0KLQkJcHJfd2FybigiYnBmX2ppdDogaW52YWxpZCBzaXplICVkIGZvciBl
eHRlbnNpb25cbiIsIHNpemUpOw0KLQl9DQotfQ0KLQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBt
b3ZlX2FkZHIoc3RydWN0IGppdF9jdHggKmN0eCwgZW51bSBsb29uZ2FyY2hfZ3ByIHJkLCB1
NjQgYWRkcikNCiB7DQogCXU2NCBpbW1fMTFfMCwgaW1tXzMxXzEyLCBpbW1fNTFfMzIsIGlt
bV82M181Mjs=


