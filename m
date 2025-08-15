Return-Path: <stable+bounces-169774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A1B2849F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B621B64739
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C63101B3;
	Fri, 15 Aug 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KAS/HPTs"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4D2E5D31
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277326; cv=none; b=RQwueK1+fOgDuXNiR0JFRV32JMDTHQ7P6OwF3RqaPecgjOdi5rexBT/0WcOqLNai7RuaMiy/1f7rBLfYvQL9N7v4c7uevoKbk168TNNGmgcAK1M99JvMV4syQA25jskmMKgWIEpbqGgUxCV2Rb3ZxWrGw+wIc5FPjNcrmdnabmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277326; c=relaxed/simple;
	bh=/QWBgvaK9iyfFR3/kOnkwp/V2SEcTgIIO5dVwovvJcU=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=JYhlshjttGgk8NQZq4pmfDaeB/CyAtdclU6jXMLJzLrd9zYiT5cliIUWRi/b5WWWEtBUK3Yi9Y1z47HM8trCKabRtljgoDrRo+0vuJu8K7pMl8mnN6WFZInL1JKNcBVLpgoEOg0f1ky+Z7xsgR0JHEU6ByBxFtaYtiM7lOeXugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KAS/HPTs; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755277306;
	bh=/QWBgvaK9iyfFR3/kOnkwp/V2SEcTgIIO5dVwovvJcU=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=KAS/HPTseUpWJ23KUpN2ysa7iuc+mPOvvX+MTlAGqK+t1mA+rIFWVt8NmMMumlN0C
	 Ny/xtlTDr2RAV238Rud/yMZXPIGpqfiueJjCZU4FiR5drX5D0w9MrS4XquMtXE7X2S
	 7B1wRdr2zKsyRIwE/dGQL7TCjGKHQiOTd7YVniOA=
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqST8P4pfj07qMXF4/5ZWt1w6Ju1N7Ss7e8=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: b9zk2Ah4stOaBgWYPRYwLTJATQn5q34fzuJXcpO9s4M=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1755277304t1db31ed0
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6] sched/fair: Fix frequency selection for non-invariant case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 16 Aug 2025 01:01:44 +0800
X-Priority: 3
Message-ID: <tencent_7A3AC9F50BB7F1803289E2C9@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>
	<2025081504-overplay-unaired-854e@gregkh>
In-Reply-To: <2025081504-overplay-unaired-854e@gregkh>
X-QQ-ReplyHash: 1511660931
X-BIZMAIL-ID: 1067032699564228893
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 16 Aug 2025 01:01:45 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M8JnMGwRo1mQjh1Ci93LJyl4L56qEelbhUlN9rHCV/9p0En+AcjclSHJ
	WtB70QBjNQlEHja0hrAh5i+8wVF8LXi4WxXDTmDhA49JUyLrRCKFOdrQdJyS4WomKBhzvjy
	NH54JReNxbZ9/tE1X/G/NVxRyPZ4bQa/Qb9iPFcDSIzVRipQ0u+vvfAqJnyWMFqcYgfmzHE
	2FtuU4OBQWCP52NaWJE9p/ueySZQGrKsZgfaF7FCGuMvPgKAVl4fDotkD58X8sAUocGrB8Z
	HjiwViuyUadwZsQLClrmJHzQHYDhv6WGHjv7OlQC2UQqhllwu/luQYG5eFBjgC9Sxlb5F35
	YHz5z+iLqY3DpFfbeujgG/8AV+BOcc5vie9xoynDk3hJ2W+gmdm9a5FXtmnrXlgGnCxiSsj
	ev/IIWusi4Uk7jt8mFrcGGpSwZal/+UpbCk2qoUp32mbEmCXUfNachCFapbJ1eqPTdIUjUh
	3QRR4ZkE/Of3AB/ZhvxS4gGo7Zm3FP5ZqcVKejjHszgBY/tDyyXUQHpo8b734DXWHHMeff2
	WSxqJHwF7rldKZOXLgJk1hXZA4S9qHZMpTufMFn1PWNPQwwL7GvF47iEbqcqG6FdioH6IQ5
	LfFtLq9DbUuqtdaGO/PatGCppnoIoadh5npi95bHgWcRgRJBmfA9Ph5/VG2q0oiKnbYWs0t
	+qKKuvtLMt22Kt2IxYCKKgq9jVA7IAKFvjO+xXrcka+WSdt+0T0lAx9Pc8u0/+Y82kAKJkd
	ZOrbeKlR+UqbzRg0QfGmMX243bF0UFziLuFtavk2X4jl6GqQC+gBLBighu+5a+jsYfPcIMK
	dE4P/HSE/L99m7XLITWWThWmAg4BjdBn6KcVLif2yv9wF7lSIdChJ3JtLq/l+AWLTmskxWq
	D57Q4PLltzmB7g9BZu99K4dFTjn9afDqp6O6mVLvS10n62UdP9GnkuFOOKKsJky2pZSzDet
	DLYiC3G+Q3u0XaXLliJaRbKhyaUdJC2bIMSXifamMckToN8o1W/ORynUxJoRqNx/rRcEa5k
	t4t6zlK2PbcTN6jWEeyyu6o6DrA3l2k1E583VAtvDo2Lj6kW3aHezvt1m0La15MCMZXFN2f
	A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

RnJvbSBkZGQzZjFlZDZlODhkODg1MDJkMmI0MmUxNTlhYzk3NmI0MTk0Yjc4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVmluY2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0
b3RAbGluYXJvLm9yZz4NCkRhdGU6IFN1biwgMTQgSmFuIDIwMjQgMTk6MzY6MDAgKzAxMDAN
ClN1YmplY3Q6IFtQQVRDSF0gc2NoZWQvZmFpcjogRml4IGZyZXF1ZW5jeSBzZWxlY3Rpb24g
Zm9yIG5vbi1pbnZhcmlhbnQgY2FzZQ0KDQpMaW51cyByZXBvcnRlZCBhIH41MCUgcGVyZm9y
bWFuY2UgcmVncmVzc2lvbiBvbiBzaW5nbGUtdGhyZWFkZWQNCndvcmtsb2FkcyBvbiBoaXMg
QU1EIFJ5emVuIHN5c3RlbSwgYW5kIGJpc2VjdGVkIGl0IHRvOg0KDQogIDljMGI0YmI3ZjYz
MCAoInNjaGVkL2NwdWZyZXE6IFJld29yayBzY2hlZHV0aWwgZ292ZXJub3IgcGVyZm9ybWFu
Y2UgZXN0aW1hdGlvbiIpDQoNCldoZW4gZnJlcXVlbmN5IGludmFyaWFuY2UgaXMgbm90IGVu
YWJsZWQsIGdldF9jYXBhY2l0eV9yZWZfZnJlcShwb2xpY3kpDQppcyBzdXBwb3NlZCB0byBy
ZXR1cm4gdGhlIGN1cnJlbnQgZnJlcXVlbmN5IGFuZCB0aGUgcGVyZm9ybWFuY2UgbWFyZ2lu
DQphcHBsaWVkIGJ5IG1hcF91dGlsX3BlcmYoKSwgZW5hYmxpbmcgdGhlIHV0aWxpemF0aW9u
IHRvIGdvIGFib3ZlIHRoZQ0KbWF4aW11bSBjb21wdXRlIGNhcGFjaXR5IGFuZCB0byBzZWxl
Y3QgYSBoaWdoZXIgZnJlcXVlbmN5IHRoYW4gdGhlIGN1cnJlbnQgb25lLg0KDQpBZnRlciB0
aGUgY2hhbmdlcyBpbiA5YzBiNGJiN2Y2MzAsIHRoZSBwZXJmb3JtYW5jZSBtYXJnaW4gd2Fz
IGFwcGxpZWQNCmVhcmxpZXIgaW4gdGhlIHBhdGggdG8gdGFrZSBpbnRvIGFjY291bnQgdXRp
bGl6YXRpb24gY2xhbXBpbmdzIGFuZA0Kd2UgY291bGRuJ3QgZ2V0IGEgdXRpbGl6YXRpb24g
aGlnaGVyIHRoYW4gdGhlIG1heGltdW0gY29tcHV0ZSBjYXBhY2l0eSwNCmFuZCB0aGUgQ1BV
IHJlbWFpbmVkICdzdHVjaycgYXQgbG93ZXIgZnJlcXVlbmNpZXMuDQoNClRvIGZpeCB0aGlz
LCB3ZSBtdXN0IHVzZSBhIGZyZXF1ZW5jeSBhYm92ZSB0aGUgY3VycmVudCBmcmVxdWVuY3kg
dG8NCmdldCBhIGNoYW5jZSB0byBzZWxlY3QgYSBoaWdoZXIgT1BQIHdoZW4gdGhlIGN1cnJl
bnQgb25lIGJlY29tZXMgZnVsbHkgdXNlZC4NCkFwcGx5IHRoZSBzYW1lIG1hcmdpbiBhbmQg
cmV0dXJuIGEgZnJlcXVlbmN5IDI1JSBoaWdoZXIgdGhhbiB0aGUgY3VycmVudA0Kb25lIGlu
IG9yZGVyIHRvIHN3aXRjaCB0byB0aGUgbmV4dCBPUFAgYmVmb3JlIHdlIGZ1bGx5IHVzZSB0
aGUgQ1BVDQphdCB0aGUgY3VycmVudCBvbmUuDQoNClsgbWluZ286IENsYXJpZmllZCB0aGUg
Y2hhbmdlbG9nLiBdDQoNCkZpeGVzOiA5YzBiNGJiN2Y2MzAgKCJzY2hlZC9jcHVmcmVxOiBS
ZXdvcmsgc2NoZWR1dGlsIGdvdmVybm9yIHBlcmZvcm1hbmNlIGVzdGltYXRpb24iKQ0KUmVw
b3J0ZWQtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9y
Zz4NCkJpc2VjdGVkLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+DQpSZXBvcnRlZC1ieTogV3llcyBLYXJueSA8d2thcm55QGdtYWlsLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90QGxpbmFy
by5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4N
ClRlc3RlZC1ieTogV3llcyBLYXJueSA8d2thcm55QGdtYWlsLmNvbT4NCkxpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMTQxODM2MDAuMTM1MzE2LTEtdmluY2VudC5n
dWl0dG90QGxpbmFyby5vcmcNCihjaGVycnkgcGlja2VkIGZyb20gY29tbWl0IGUzNzYxN2M4
ZTUzYTFmN2ZjYmE2ZDVlMTA0MWY0ZmQ4YTI0MjVjMjcpDQpTaWduZWQtb2ZmLWJ5OiBXZW50
YW8gR3VhbiA8Z3VhbndlbnRhb0B1bmlvbnRlY2guY29tPg0KLS0tDQpJIHRlc3RlZCB0aGUg
cGF0Y2ggdHdvIGRheXMgYWdvLCBhbmQgdGhlIHVwc3RyZWFtIGNvbW1pdCBjYW4gYmUgZGly
ZWN0bHkgYXBwbHkuDQotLS0NCi0tLQ0KIGtlcm5lbC9zY2hlZC9jcHVmcmVxX3NjaGVkdXRp
bC5jIHwgNiArKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0
aWwuYyBiL2tlcm5lbC9zY2hlZC9jcHVmcmVxX3NjaGVkdXRpbC5jDQppbmRleCBjZmU3YzYy
NWQyYWQ2Li44MTllYzFjY2MwOGNmIDEwMDY0NA0KLS0tIGEva2VybmVsL3NjaGVkL2NwdWZy
ZXFfc2NoZWR1dGlsLmMNCisrKyBiL2tlcm5lbC9zY2hlZC9jcHVmcmVxX3NjaGVkdXRpbC5j
DQpAQCAtMTU2LDcgKzE1NiwxMSBAQCB1bnNpZ25lZCBsb25nIGdldF9jYXBhY2l0eV9yZWZf
ZnJlcShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkNCiAJaWYgKGFyY2hfc2NhbGVf
ZnJlcV9pbnZhcmlhbnQoKSkNCiAJCXJldHVybiBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXE7
DQogDQotCXJldHVybiBwb2xpY3ktPmN1cjsNCisJLyoNCisJICogQXBwbHkgYSAyNSUgbWFy
Z2luIHNvIHRoYXQgd2Ugc2VsZWN0IGEgaGlnaGVyIGZyZXF1ZW5jeSB0aGFuDQorCSAqIHRo
ZSBjdXJyZW50IG9uZSBiZWZvcmUgdGhlIENQVSBpcyBmdWxseSBidXN5Og0KKwkgKi8NCisJ
cmV0dXJuIHBvbGljeS0+Y3VyICsgKHBvbGljeS0+Y3VyID4+IDIpOw0KIH0NCiANCiAvKio=


