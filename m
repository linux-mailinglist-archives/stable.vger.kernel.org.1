Return-Path: <stable+bounces-269319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+wRCdEoP2oRPgkAu9opvQ
	(envelope-from <stable+bounces-269319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:35:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFC6D0B47
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:35:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="M FuYDbB";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269319-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269319-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C55AC302844E
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609E1E5018;
	Sat, 27 Jun 2026 01:35:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EC1862;
	Sat, 27 Jun 2026 01:35:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524107; cv=none; b=fKkUT6yonK3cywIInqJ0paj+CJqB/4ugiAUJ4PQVoVbQweewMGX3Ru9VBCE819K3yiPsFdh4kMmeFXBbP+JWnPYFNG0DjznhTinXT18PCNhdRCTUdOS+iTPgT8Nz85lNuCUBpbR3X3/K/bJ9/UMjO7fQfUskwB9GBhHefKLVdac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524107; c=relaxed/simple;
	bh=Tb4mkgwkssPLXJiYfu/jOACoVboaAQeU7BWVfYbFvw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SmYF4jr9TH5IdDD+6ETSdOWN/nKtWx6sSazxfJxhvxmHxMluFLrfNxeH0OSU8NYXM9L9v0iKRo7GDk/9bslvTWed+LAjMzOLBtLgu0o7r/ho80W4hmS9MmohJ8s2Qf6wKoQR3jN7h6A7z+v0JyBzz+7RQU2pTZ8AF7fuSdVrPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MFuYDbBs; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Tb4mkgwkssPLXJiYfu/jOACoVboaAQeU7BWVfYbFvw8=; b=M
	FuYDbBsjQbFS364Uz/pYaajSmsY6AOjVBL3SRqzO1KjbZ9u4SmYqOZ3bfafeePBj
	Yc8xmn87NFwg9ghqYJIGHsSJZUiBnFy1z4dZfY4aZn8AJJyfHiSh9XI4Fb7Rz5xQ
	dTFGdj8EIkirCgw7zuWf6hfrAtsjAeN2RcDfnKfreI=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-147 (Coremail) ; Sat, 27 Jun 2026 09:34:05 +0800
 (CST)
Date: Sat, 27 Jun 2026 09:34:05 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kees@kernel.org, stable@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:[PATCH v4 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO
 access via malicious MFA
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260624032425.384325-3-w15303746062@163.com>
References: <20260624032425.384325-1-w15303746062@163.com>
 <20260624032425.384325-3-w15303746062@163.com>
X-NTES-SC: AL_Qu2TAPmZu0gv4yCRZekfmU0Qguw9Xcq5uPkj34FWN5t8jC7r5g0gdH1HN0D9/fyMLRmBvx2pbClL28FCUaBxQLggbHZVBnmIiEvhyExhweS/cw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20246781.61e.19f06b66729.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kygvCgD3X7GNKD9q8e4RAA--.134W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAA2Xe2o-KI1CXAAA3P
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269319-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xidian.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41BFC6D0B47

CgpBdCAyMDI2LTA2LTI0IDExOjI0OjI1LCB3MTUzMDM3NDYwNjJAMTYzLmNvbSB3cm90ZToKPkZy
b206IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KPgo+VGhlIGli
bWFzbSBkcml2ZXIgcmVhZHMgZHluYW1pYyBNZXNzYWdlIEZyYW1lIEFkZHJlc3NlcyAoTUZBKSBm
cm9tCj5oYXJkd2FyZSBxdWV1ZXMgYW5kIHVzZXMgdGhlbSBkaXJlY3RseSBhcyBvZmZzZXRzIHRv
IGRlcmVmZXJlbmNlIEkyTwo+bWVzc2FnZXMgdmlhIGdldF9pMm9fbWVzc2FnZSgpLgo+Cj5JZiBh
IG1hbGZvcm1lZCBvciBmdXp6ZWQgZGV2aWNlIHByb3ZpZGVzIGEgbWFsaWNpb3VzIE1GQSwgaXQg
Y2FuIGNhdXNlCj50aGUgZHJpdmVyIHRvIGFjY2VzcyBtZW1vcnkgZmFyIGJleW9uZCB0aGUgbWFw
cGVkIEJBUiwgbGVhZGluZyB0byBhbgo+b3V0LW9mLWJvdW5kcyAoT09CKSBhY2Nlc3MgYW5kIHBv
dGVudGlhbCBrZXJuZWwgcGFuaWMgZHVyaW5nIHJ1bnRpbWUuCj4KPkZpeCB0aGlzIGJ5IHZhbGlk
YXRpbmcgdGhlIHRhcmdldCBvZmZzZXQgYWdhaW5zdCB0aGUgYWN0dWFsIG1hcHBlZCBzaXplCj5i
ZWZvcmUgZGVyZWZlcmVuY2luZy4gVGhpcyB2YWxpZGF0aW9uIHN0cmljdGx5IGFjY291bnRzIGZv
ciBib3RoIHRoZQo+aTJvX2hlYWRlciBhbmQgdGhlIGR5bmFtaWMgcGF5bG9hZCBzaXplIHVzaW5n
IHNhZmUgc3VidHJhY3Rpb24gdG8gcHJldmVudAo+aW50ZWdlciBvdmVyZmxvdyBieXBhc3Nlcy4K
Pgo+SWYgdGhlIGJvdW5kcyBjaGVjayBmYWlscywgdGhlIGludmFsaWQgTUZBIGlzIHJlbGVhc2Vk
IGJhY2sgdG8gdGhlCj5pbmJvdW5kIHF1ZXVlIHZpYSBzZXRfbWZhX2luYm91bmQoKSB0byBwcmV2
ZW50IGEgaGFyZHdhcmUgbWFpbGJveCBkZWFkbG9jay4KPgoKSGkgYWxsLAoKVGhlIGF1dG9tYXRl
ZCByZXZpZXcgYm90IHJlY2VudGx5IHJhaXNlZCBhIHZhbGlkIHBvaW50IChsaW5rOiAKaHR0cHM6
Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNjI0MDMyNDI1LjM4NDMyNS0xLXcxNTMwMzc0
NjA2MiU0MDE2My5jb20pCnJlZ2FyZGluZyB0aGUgZXJyb3IgcGF0aCBoZXJlIGluIFBhdGNoIDIu
IEkgd291bGQgbGlrZSB0byBzZWVrIHRoZSAKbWFpbnRhaW5lcnMnIGd1aWRhbmNlIG9uIGEgc3Ry
aWN0IHRyYWRlLW9mZiBpbnRyb2R1Y2VkIGhlcmUuCgpJbiB0aGUgY3VycmVudCB2NCBwYXRjaCwg
aWYgZ2V0X2kyb19tZXNzYWdlKCkgZmFpbHMgdGhlIGJvdW5kcwpjaGVjaywgdGhlIGRyaXZlciBj
YWxscyBzZXRfbWZhX2luYm91bmQoKSB0byByZWxlYXNlIHRoZSBNRkEKYmFjayB0byB0aGUgaGFy
ZHdhcmUgaW5ib3VuZCBxdWV1ZS4KCldlIGZhY2UgYSBkaWxlbW1hIGJldHdlZW4gaG9zdCBhdmFp
bGFiaWxpdHkgYW5kIGhhcmR3YXJlIHNhZmV0eToKCjEuIEtlZXAgdjQgYmVoYXZpb3IgKFJldHVy
biB0aGUgTUZBKToKVGhpcyBwcmV2ZW50cyB0aGUgaG9zdCBkcml2ZXIncyBjb21tYW5kIHF1ZXVl
IGZyb20gZGVhZGxvY2tpbmcKZHVlIHRvIHNsb3QgZXhoYXVzdGlvbi4gSG93ZXZlciwgYXMgdGhl
IGJvdCBjb3JyZWN0bHkgbm90ZWQsCndyaXRpbmcgaXQgYmFjayB0byB0aGUgSU5CT1VORF9RVUVV
RV9QT1JUIHN1Ym1pdHMgYW4gdW5pbml0aWFsaXplZApmcmFtZSB0byB0aGUgU2VydmljZSBQcm9j
ZXNzb3IsIHJpc2tpbmcgdW5kZWZpbmVkIGhhcmR3YXJlIHN0YXRlcy4KCjIuIERyb3AgdGhlIE1G
QSBlbnRpcmVseToKVGhpcyBwcmV2ZW50cyB0aGUgaGFyZHdhcmUgZnJvbSBleGVjdXRpbmcgdW5p
bml0aWFsaXplZCBjb21tYW5kcy4KSG93ZXZlciwgaXQgcGVybWFuZW50bHkgbGVha3MgdGhlIGlu
Ym91bmQgcXVldWUgc2xvdC4gSWYgbWFsZm9ybWVkCk1GQXMgYXJlIGNvbnRpbnVvdXNseSBwcm92
aWRlZCwgdGhlIGhhcmR3YXJlIHF1ZXVlIHdpbGwgZXhoYXVzdCwKY2F1c2luZyBhIGRldGVybWlu
aXN0aWMgZGVhZGxvY2sgb24gdGhlIGhvc3QgZHJpdmVyIHNpZGUuCgpDb3VsZCB0aGUgbWFpbnRh
aW5lcnMgcGxlYXNlIGFkdmlzZSB3aGljaCBmYWlsdXJlIG1vZGUgaXMgcHJlZmVycmVkCmZvciB0
aGlzIHN1YnN5c3RlbSBpbiB0aGUgcHJlc2VuY2Ugb2YgbWFsZm9ybWVkIGhhcmR3YXJlPyBJIHdp
bGwKcHJlcGFyZSB0aGUgbmV4dCB2ZXJzaW9uIGJhc2VkIG9uIHlvdXIgZGVjaXNpb24uCgpUaGFu
a3MsCk1pbmd5dQoK

