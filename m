Return-Path: <stable+bounces-248968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z4+9E3rbB2ovMAMAu9opvQ
	(envelope-from <stable+bounces-248968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:50:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2E559F4E
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 633643021B01
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4C29E117;
	Sat, 16 May 2026 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iQlF63E2"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1C276038;
	Sat, 16 May 2026 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899511; cv=none; b=FOnBaCWrQXBvKYwdz/ZCKt8y4Y4UnNqtMsNAZF2dwE4jX19W7l5FTd2aj1HDW9RC30z3+LYN2xQbXYDH18VxtTKaa8+mQ8hnfr7UuaQC3/iQEXh1+SFIovr3sNfsz1OcS1dOSgMZmQqESpGKwbsX7sS1mcy4CwuM+bWzmpTkLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899511; c=relaxed/simple;
	bh=ICKCX/tLCEDtejDHyXne+nOIIbge8mBJ5uanV2vlxAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FpD0GPdx6Cmrnf5YI0SLLqgJM03ilOVk5HJ7Zov/vZgcSsh/zka221d1PWzFyTu1a1L449P1NItrSxWOH8sd/UrorIXDmTzS5tRGpT79krHWZoFMKY7r7x+aaxAFnLDBTHmMGQwPeZLBA+6JrP3OZnydtEWdRt9jIo6XGJAZ6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iQlF63E2; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ICKCX/tLCEDtejDHyXne+nOIIbge8mBJ5uanV2vlxAs=; b=i
	QlF63E2HOVlQdhbVRCWpFGeXuzsHWcjJ2+hQUSqSAsQsDWGkksq3Aps3ra/9vryD
	kFXzMGrlOuwTiO0FbSZ/8qNbyEsA0HSLsnbvOnnGfp6YA8cnnkrWOBJHZQToYEYH
	S7DVZwWgjNclOqemGbJY162x5B+FYFg5S5A8ELy5/U=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Sat, 16 May 2026 10:43:35 +0800
 (CST)
Date: Sat, 16 May 2026 10:43:35 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Greg KH" <greg@kroah.com>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
	melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable
 and timer callback
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <2026051557-thermal-petite-7da0@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
X-NTES-SC: AL_Qu2cCvSStkwq4yCbZ+kfmU0Qguw9Xcq5uPkj34FWN5t8jCDp6AkFeXhTAFnX++eoFB6+mRKZdCV3+PhceaBDXJgs/CVh6Xs9i5Zsll3yPlbkYQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD3X1LX2QdqChakAA--.278W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xcI62oH2ddrzAAA3P
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Queue-Id: A1D2E559F4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248968-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
	NEURAL_HAM(-0.00)[-0.958];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:email]
X-Rspamd-Action: no action

CkhpIEdyZWcsCgpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZSBhbmQgcmV2aWV3LgoKCkF0
IDIwMjYtMDUtMTUgMjM6MDk6NDYsICJHcmVnIEtIIiA8Z3JlZ0Brcm9haC5jb20+IHdyb3RlOgo+
T24gRnJpLCBNYXkgMTUsIDIwMjYgYXQgMDk6MTg6MjZQTSArMDgwMCwgdzE1MzAzNzQ2MDYyQDE2
My5jb20gd3JvdGU6Cj4+IEZyb206IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFu
LmVkdS5jbj4KPj4gCj4+IFtOb3RlOiBUaGlzIHBhdGNoIGFkZHJlc3NlcyBhIGxlZ2FjeSBWS01T
IGltcGxlbWVudGF0aW9uIGRlYWRsb2NrIHNwZWNpZmljCj4+IHRvIG9sZGVyIHN0YWJsZSB0cmVl
cyAoZS5nLiwgNi4xOC55KS4gTWFpbmxpbmUgaGFzIHJlbW92ZWQgdGhpcyBjb2RlIGR1cmluZwo+
PiB0aGUgZ2VuZXJpYyBEUk1fQ1JUQ19WQkxBTktfVElNRVJfRlVOQ1MgcmVmYWN0b3JpbmcuXQo+
Cj5XaHkgbm90IGFwcGx5IHRob3NlIHVwc3RyZWFtIGNvbW1pdHMgaGVyZSBhcyB3ZWxsPyAgTm8g
bmVlZCB0byBkaXZlcmdlCj5mcm9tIExpbnVzJ3MgdHJlZSwgb3RoZXJ3aXNlIHdlIHdpbGwgZW5k
IHVwIGhhdmluZyBhIG1lc3MgdGhhdCBub3RoaW5nCj5jYW4gZXZlciBiZSBiYWNrcG9ydGVkIHRv
Lgo+Cj5Ib3cgbWFueSBjb21taXRzIG5lZWQgdG8gYmUgYmFja3BvcnRlZD8gIEhhdmUgeW91IHRy
aWVkPwoKSSBoYXZlIGxvb2tlZCBpbnRvIHRoZSB1cHN0cmVhbSBjb21taXRzLiBUaGUgY29tbWl0
IHRoYXQgcmVtb3ZlZCB0aGlzIAp2dWxuZXJhYmxlIGxlZ2FjeSBjb2RlIGluIG1haW5saW5lIGlz
OgowMmUyNjgxZmZlMWEgKCJkcm0vdmttczogQ29udmVydCB0byBEUk0ncyB2YmxhbmsgdGltZXIi
KQoKSSB0cmllZCB0byBhcHBseSBpdCB0byA2LjE4LnksIGJ1dCBpdCBkb2VzIG5vdCBhcHBseSBj
bGVhbmx5LiBUaGUgcmVhc29uIAppcyB0aGF0IHRoaXMgdXBzdHJlYW0gY29tbWl0IGlzIG5vdCBh
IHNpbXBsZSBidWcgZml4LCBidXQgYSBtYXNzaXZlIApyZWZhY3RvcmluZy4gSXQgY29tcGxldGVs
eSByaXBzIG91dCB0aGUgY3VzdG9tIFZLTVMgaHJ0aW1lciBhbmQgcG9ydHMgCnRoZSBkcml2ZXIg
dG8gYSBuZXdseSBpbnRyb2R1Y2VkIERSTSBjb3JlIGluZnJhc3RydWN0dXJlIAooRFJNX0NSVENf
VkJMQU5LX1RJTUVSX0ZVTkNTIGFuZCBkcm1fdmJsYW5rX2hlbHBlci5oKS4KClRvIGJhY2twb3J0
IGNvbW1pdCAwMmUyNjgxZmZlMWEsIHdlIHdvdWxkIGZpcnN0IG5lZWQgdG8gYmFja3BvcnQgdGhl
IAplbnRpcmUgRFJNIGdlbmVyaWMgdmJsYW5rIHRpbWVyIGluZnJhc3RydWN0dXJlIHRvIDYuMTgu
eS4gVGhpcyBzZWVtcyAKdG9vIGludHJ1c2l2ZSBhbmQgdmlvbGF0ZXMgdGhlIG1pbmltYWwtcmlz
ayBwb2xpY3kgZm9yIHN0YWJsZSB0cmVlcy4KClRoZXJlZm9yZSwgc2luY2UgdGhlIGxlZ2FjeSBj
dXN0b20gaHJ0aW1lciBzdGlsbCBleGlzdHMgaW4gNi4xOC55IGFuZCAKaXMgYWN0aXZlbHkgY2F1
c2luZyBBQkJBIGRlYWRsb2NrcyAoUkNVIHN0YWxscyksIHRoaXMgbWluaW1hbGlzdGljIAphbmQg
bG9jYWxpemVkIHBhdGNoICh1c2luZyBocnRpbWVyX3RyeV90b19jYW5jZWwpIGlzIHByb3Bvc2Vk
IGFzIHRoZSAKc2FmZXN0IHdheSB0byBmaXggdGhlIGlzc3VlIHNwZWNpZmljYWxseSBmb3Igb2xk
ZXIgc3RhYmxlIGJyYW5jaGVzIAp3aXRob3V0IHB1bGxpbmcgaW4gbWFqb3IgRFJNIGNvcmUgcmVm
YWN0b3JpbmcuCgpXb3VsZCB0aGlzIGxvY2FsaXplZCBmaXggYmUgYWNjZXB0YWJsZSBmb3IgdGhl
IHN0YWJsZSB0cmVlPwoKVGhhbmtzLApNaW5neXUKCg==

