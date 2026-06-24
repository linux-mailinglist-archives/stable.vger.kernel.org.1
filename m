Return-Path: <stable+bounces-268136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FVTEH6KtO2rUbAgAu9opvQ
	(envelope-from <stable+bounces-268136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:12:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D26BD3C1
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=fMqa0fqp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268136-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268136-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8E330B9470
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795D3B8BD4;
	Wed, 24 Jun 2026 10:08:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B03B83F9
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:08:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295732; cv=none; b=HLQ4ylAnCof3DsS8PdGKLE0uSOtAZzm0n12pKyWq1xxJszJxi5ybx5KPew/jLQl0y9f0pDHIXfdYA5fJfZlx7qAMaaUt1D44aD5PzsMgjZ+/n3bS2vbZ3yJfXVZ3Tv6XZlqUv9Ar7oP1dE/kDgTXR1/GW8feGpEMEZcMdlHMPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295732; c=relaxed/simple;
	bh=+v7S37E0dY5/4t3avKqI3VqYZwq7Lsh9Mz4eOk+nSno=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=rTxEKaAysBTDX65sGTIUgCYjs5+YuTnizVynXGNr39pP2+H4H4TatmU9eFQjO56yPlbbIvCa3O/s0C18uA5UOc15rRnOuxSdYNT2+1XU0Tq0XOLqUaZQIPmvlYJlkzLAeT03aJOY/HnlBUhXg3ixw92KA8WkTPbfhMncMPCe54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fMqa0fqp; arc=none smtp.client-ip=54.92.39.34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782295664;
	bh=+v7S37E0dY5/4t3avKqI3VqYZwq7Lsh9Mz4eOk+nSno=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=fMqa0fqp1fo0dhrdvdu6x5wTXsKF29PSE5Wizc657IrQ1auHkidNRuL0jcwW58YqT
	 F8Qd+r3xSZIYsoRgTpoV5rswgmI2mKeZxn7UhlnPEYLAPAJiEfjhpMGbP6kZ/GVxjm
	 dx+iIhSPjpj/I9WkvOzZv5+V0GPZWd5VIGVZDsyo=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRdFc3p2pDC+jQy+RNMWdI0Y5ii4Iz6wLU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: OHVu3/xI3m804vI7Ai0ywxH/GLrEw/Xa3VCxSyRykJo=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1782295661t3e371744
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?MDAxMDcwODI=?=" <00107082@163.com>, "=?utf-8?B?aWtsYXR6Y28=?=" <iklatzco@gmail.com>, "=?utf-8?B?cGF0Y2hlcw==?=" <patches@lists.linux.dev>, "=?utf-8?B?cGV0ZXJ6?=" <peterz@infradead.org>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?eWVvcmV1bS55dW4=?=" <yeoreum.yun@arm.com>
Subject: Re: [PATCH] perf: Fix dangling cgroup pointer in cpuctx backport
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 24 Jun 2026 18:07:41 +0800
X-Priority: 3
Message-ID: <tencent_5FDA609363B90C6249A050FD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <2026062455-obtrusive-sandbox-d6d1@gregkh>
	<20260624095920.2558406-1-guanwentao@uniontech.com>
	<2026062404-unusual-nutmeg-87d5@gregkh>
In-Reply-To: <2026062404-unusual-nutmeg-87d5@gregkh>
X-QQ-ReplyHash: 705459129
X-BIZMAIL-ID: 16212402345110046153
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 24 Jun 2026 18:07:42 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NBxOuQH3x7tHK47B0Gbh2ByzuEYLKphe40naw3wmdG0WzHFlro6VuoIX
	no9pPx90uI+TBncykxmnNzsRWjGA7a8GtT6oVA0mdGHGQ0E/H0beapOXNQMqPTTqLu+x2QQ
	0sb5N2dhKkxroepD7F+MPJEHpnh3Hj6IeLBMx4I5oqMwxF/aFZMzPceqWmzYl/Vv8yDKOsL
	N/SndiGdLtLHaSsvTtjOz0+ShYTLdH4S00EN4wVgIBZoX+ut0DVZMAaiLpGL3H/biD+xzIu
	uaeSNBP+x8eIKbyY0go/2S5nW6UZVju8Xz753EHh5UWYey2ihQCKjf5v12XuBoVrwRIINPX
	dEricExkSf02vUoYJFj6sTadpBYq5WJCC40pjV76dBWOkTzl0ZMqCYRNY470proTPyOcoGV
	UWXn8csQb4sgLflXR2220hWR9f6j7koujx9b2n+qZaGTOIEuZO+Qc3hawuqc0WcrAXpSGL/
	wjeq1W1plR2CMiSJrroCuELqDePfoi7REnNa42NVGTXOrJurm8PJvQFOmNJiTInMh7cDX7U
	Zgfisaal/V3A9jnBGZjYjA/gvokC4jddbnpgXSHQlR65M+BTPnVl0TCXfqV/Y1za0dAsJ3s
	9b/rRyrFHXSWfEAaRm5LhXrVVUOHgbuODvmrHeuRYJiGEzwHuaz1/NegYvDiQktWtT6M1qn
	OEZ3pr8VSrrUB02dyXRJqBkUdTw0jXogBWJENkpmys29dWIMgzA9UUTNtGc+RfpAaIf2JKb
	iZGb/43mMfbc/8N7GrxTMItl0gF2+jLQXX115NFzEKf7hmtEHKR5P8/qtCHN45utYCGS2NM
	QMZkf69kwN6oegJWgZl48UTTkID+BstzN22Xk0NDXLCe05CjtPDLUe4PRHripVlbjNv+HEe
	FlQBoxRrFFN5dYfUrjAkxMCQOThX70iBo9r7H2qm7GUXYhpUXMIzHPZ/GUTQpmBZPr5i92i
	iGM33hY4+u07rO0yYDtg69IqmaznJll+tcdB+6mQCPiB2wSpJYodr7AxaSzR5ypypqelw6f
	aNYBYKGlJBKEf1EP2F5yCURckSHCTc8TWtoGXEBQItGE9Dk7w12wUKP4u/Np7jTaJDOTjtN
	A7mLQCF5NQ3v7ISSdt8b6P17lVpfd7lWf0fjGuSoGmVfuhiItpaaD/bXBSuAT5oazCA+Cxz
	xNvx
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268136-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:00107082@163.com,m:iklatzco@gmail.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[163.com,gmail.com,lists.linux.dev,infradead.org,kernel.org,vger.kernel.org,arm.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:from_mime,qq.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C30D26BD3C1

PiBPbiBXZWQsIEp1biAyNCwgMjAyNiBhdCAwNTo1OToyMVBNICswODAwLCBXZW50YW8gR3Vh
biB3cm90ZToNCj4gPiByZWNlbnRseSBiYWNrcG9ydCBvZiAoInBlcmY6IEZpeCBkYW5nbGlu
ZyBjZ3JvdXAgcG9pbnRlciBpbiBjcHVjdHgiKQ0KPiA+IHVzZSBhIG1pZGRsZSB2ZXJzaW9u
LCBzbyBhbGlnbmVkIHdpdGggdGhlIHVwc3RyZWFtIGNvbW1pdDoNCj4gPiAzYjdhMzRhZWJi
ZGYyYTRiNzI5NTIwNWJmMGM2NTQyOTQyODNlYzgyDQo+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFdlbnRhbyBHdWFuIDxndWFud2VudGFvQHVuaW9udGVjaC5jb20+DQo+ID4gLS0tDQo+
ID4gIGtlcm5lbC9ldmVudHMvY29yZS5jIHwgNSArKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9ldmVudHMvY29yZS5jIGIva2VybmVsL2V2ZW50cy9jb3JlLmMNCj4gPiBp
bmRleCBhNDE4N2RlYTY0MDJhLi43M2E4NmRiMDZjYzliIDEwMDY0NA0KPiA+IC0tLSBhL2tl
cm5lbC9ldmVudHMvY29yZS5jDQo+ID4gKysrIGIva2VybmVsL2V2ZW50cy9jb3JlLmMNCj4g
PiBAQCAtMjM4NCwxMCArMjM4NCw5IEBAIF9fcGVyZl9yZW1vdmVfZnJvbV9jb250ZXh0KHN0
cnVjdCBwZXJmX2V2ZW50ICpldmVudCwNCj4gPiAgKi8NCj4gPiAgaWYgKGZsYWdzICYgREVU
QUNIX0VYSVQpDQo+ID4gIHN0YXRlID0gUEVSRl9FVkVOVF9TVEFURV9FWElUOw0KPiA+IC0g
aWYgKGZsYWdzICYgREVUQUNIX0RFQUQpIHsNCj4gPiAtIGV2ZW50LT5wZW5kaW5nX2Rpc2Fi
bGUgPSAxOw0KPiA+ICsgaWYgKGZsYWdzICYgREVUQUNIX0RFQUQpDQo+ID4gIHN0YXRlID0g
UEVSRl9FVkVOVF9TVEFURV9ERUFEOw0KPiA+IC0gfQ0KPiA+ICsNCj4gPiAgZXZlbnRfc2No
ZWRfb3V0KGV2ZW50LCBjdHgpOw0KPiA+IA0KPiA+ICBpZiAoZXZlbnQtPnN0YXRlID4gUEVS
Rl9FVkVOVF9TVEFURV9PRkYpDQo+ID4gLS0NCj4gPiAyLjMwLjINCj4gPg0KPiANCj4gV2hh
dCBrZXJuZWwgdHJlZShzKSBpcyB0aGlzIGZvcj8gIFdoYXQgZ2l0IGlkIGRvZXMgdGhpcyBm
aXg/DQoxLiB2Ni42LjE0MyBhbmQgdjYuMTIuOTQNCjIuIA0KYWUxYWRhMGFmMTYyNDlhM2Vk
MTVlMzNmYTY3MTlhNmEyZjk2ZjUzNyBpbiB2Ni42LjE0Mw0KNDZmNTYyM2Y5YjBlZjY2MTI3
ZTFkZTE2ZmI4NTc4NTBjZGIxNGU2OCBpbiB2Ni4xMi45NA0KDQpCUnMNCldlbnRhbyBHdWFu



