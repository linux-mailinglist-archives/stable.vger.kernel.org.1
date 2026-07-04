Return-Path: <stable+bounces-271883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4srXLxloSGqypwAAu9opvQ
	(envelope-from <stable+bounces-271883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 03:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C3706632
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 03:55:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=VLZwnwk9;
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271883-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271883-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62B93018BD5
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 01:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A32571A9;
	Sat,  4 Jul 2026 01:55:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4B16DC28
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 01:55:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130130; cv=none; b=VOTPS4EeDd+3bWoX3k9e16sV3CwAIu/RzCc9QhZkzFKwbg3HNlhCNRXoR7Gh8pjMJDihcbpOXFbCfNX6BZAozlvK6TKwtbpNB451WbqQb4SlISDajn8WX0DG8KAG4GveTepnOnBigO9aAOxzlCFB1K/4MTAs2J73zGC3w6qHkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130130; c=relaxed/simple;
	bh=o4rf/9CgKzT9mny7t5wz2BOkDVx1G0IeipD5wm8BOSg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=qQEcOWrd3GFxAyAlM50uY4ybNO2lJkPKwnWD+U0yWo6JUWEQDkJF+K/NRam/yd8Y301fn3QCelfERAWP+pRER5unov2qRPcpjWSehvWmvjKsXiOYMWNtUgqBSPeUlsJVjcvD/e47lGnEN3wYHVnrhdDWfhbUyiePGsG4RSV065M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VLZwnwk9; arc=none smtp.client-ip=18.194.254.142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783130061;
	bh=o4rf/9CgKzT9mny7t5wz2BOkDVx1G0IeipD5wm8BOSg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=VLZwnwk9AhG/OaJ15IL0lpZLkBMRx+iUQQ0QJvSwbDULtnWRxYli8DexU9F9Pk6Ge
	 AtwUC06hXkM8NGmLa1nZjbzdhUPI+II3TcWy6C4QEh1okobecSaeFTirqLpHV1ZCN+
	 0ZKWDqRr0UeVhM/iVUH6EH3p+Exo5hYbraO8Kh30=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqQ6f7IieUZ8DoKgL9zJG7IbL7boNmGOgcs=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: sy5slbgbkOrpveN3vtpzWIsJn0DU2HSRV9x4l1UKfxg=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1783130059t617f07cf
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?QmVuIEh1dGNoaW5ncw==?=" <ben@decadent.org.uk>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?cGF0Y2hlcw==?=" <patches@lists.linux.dev>, "=?utf-8?B?UGVkcm8gVGFtbWVsYQ==?=" <pctammela@mojatatu.com>, "=?utf-8?B?U2ltb24gSG9ybWFu?=" <simon.horman@corigine.com>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>
Subject: Re: [PATCH 5.10 01/96] net/sched: act_pedit: use NLA_POLICY for parsing ex keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 4 Jul 2026 09:54:18 +0800
X-Priority: 3
Message-ID: <tencent_5E399B2E4242D50E1870F69E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260702155108.949633242@linuxfoundation.org>
	<20260702155108.985307603@linuxfoundation.org>
	<418ca29bbbb1190853136331c572470dca803800.camel@decadent.org.uk>
In-Reply-To: <418ca29bbbb1190853136331c572470dca803800.camel@decadent.org.uk>
X-QQ-ReplyHash: 935495786
X-BIZMAIL-ID: 163351916519790184
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 04 Jul 2026 09:54:20 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MXoUQUXLLXXAUfqSpgek5yrezdbBldehLVJWNVvqNri8Eme+w+w5LZKN
	BkCV8lAka9BAtg5ol4scbpQP4x46joYSRm1nNqG4Jtqzn4sQAMwDaKu36LxJSrY2u92rYz3
	5yBHNTZqeSb+cuPY83phS7uckzPf698MXEIXVs6XOpAfHzoYj+K504iNDSzFx5lmHdqnczf
	uyEDMbT/jIIB4J3Yau031aXYgNrA00QoWEb0VYFGWKQntLImlzlkNsx/E8L0Kyv01Ws4S7G
	ZNpvkNZ+DezBkhyn+CwDNinbfRNYRfTfE3bU/PBPX8QwRxX1OE7BeMmSTpicGDKQZqSRixV
	xxhwhYJTQFZeI0tK2AWdkZnKrmkhY6/Up2v+uGpBnsDj5S5Y5l2RVeKCnES4JbbyZi+4pXz
	hL639FOCwwl38EIykZ/HjlJqLAYqNafg5VAGnEHgs08dPlZmQUCa3JYr0sjp7sjpFhhJSxc
	XuElgBmoWMJh+bON870QEKWuROxxHlXlhF/H7T8IovqHPGVF9dIiFdXOQyYf0zF51yWXGV3
	nJ7rQOqqiV8B1bmOmL/4gh4XQwJrXayfNHsKdW7MHh32MWxdj3p13/L59jO8ikLRknf1xa6
	ZJu9seLo/2mm6tppUiygW4//kmY+Z8jXnRBvNd3AMMG24iBSJKXwFvrMIcfebnChMoI/Uda
	haSOKTdO57b073UwlJsDcbthCaBHAwLPi5FybGf+N5xZopFWJG3J5YO5i8clxpiBy5VkgQY
	cxAL3DnCCEY/oS2PFAKCSc+LdYBgCB/f7GFDRE6/ncKv7YgM6y9NJRa3f+6AcPsNG9FW60N
	IGkzPTRCnb2wVNyQoSt1jUZ9xruOe9CwB+Izh4Ij1nocd7RywU1SwZrCPGNl/EBTODhp6To
	IncXYeigw360CfSQ8bIIIIDEUq7EkVur6v/3T0mtU/AkFezu1rshG8APhxXfFSoyXjxO9AN
	LvWTlYPP+gHQToLaTodddVfQm3qwY+fN2a2jJKMD1waOjBgaQSC1T5vb3hs8no0B/lKxjRT
	S58KfAVV6bnMv1CY7Hjz3y3PFQanFa6MPr0AahaAGaYE2924u6CwrWDLBZP2Xcz19Rm4dui
	h49rkd1SV7M1i8AJP4Mfg/b/wu3BHKLoskKfgW91IIP
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:pctammela@mojatatu.com,m:simon.horman@corigine.com,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271883-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,qq.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A13C3706632

PiBPbiBUaHUsIDIwMjYtMDctMDIgYXQgMTg6MTggKzAyMDAsIEdyZWcgS3JvYWgtSGFydG1h
biB3cm90ZToNCj4gPiA1LjEwLXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFz
IGFueSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+ID4NCj4gPiAtLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPg0KPiA+ID5Gcm9tOiBQZWRybyBUYW1tZWxhIDxwY3RhbW1lbGFA
bW9qYXRhdHUuY29tPg0KPiA+DQo+ID4gWyBVcHN0cmVhbSBjb21taXQgNTAzNjAzNDU3MmI3
OWRhYTZkNjYwMDMzOGU4ZTgyMjllMmE0NGIwOSBdDQo+ID4NCj4gPiBUcmFuc2Zvcm0gdHdv
IGNoZWNrcyBpbiB0aGUgJ2V4JyBrZXkgcGFyc2luZyBpbnRvIG5ldGxpbmsgcG9saWNpZXMN
Cj4gPiByZW1vdmluZyBleHRyYSBpZiBjaGVja3MuDQo+IFsuLi5dDQo+IA0KPiBObyBvYmpl
Y3Rpb24sIGJ1dCB0aGlzIHNob3VsZCBhbHNvIGJlIGFwcGxpZWQgdG8gNS4xNSBhbmQgNi4x
Lg0KR29vZCBpZGVhLCBidXQgaSBhbSBub3Qgc3VyZSB0aGF0IGhlcmUgaXMgYSBsb2dpYyBj
aGFuZ2UsDQphcyBwb2xpY3kgZm9yIHN0YWJsZSB0cmVlIGl0IGJlIHNob3VsZCBhcHBsaWVk
IHRvIDUuMTUgYW5kIDYuMS4NCg0KQlJzDQpXZW50YW8gR3Vhbg==


