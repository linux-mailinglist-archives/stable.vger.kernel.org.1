Return-Path: <stable+bounces-223206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OzwH9GVqWnYAQEAu9opvQ
	(envelope-from <stable+bounces-223206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:40:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB977213A11
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 241B530C12A3
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1FD39F19D;
	Thu,  5 Mar 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hnASDGjt"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B64395261
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721170; cv=none; b=JcI1qrU7avVqej4IwiikeBbh/wbgHKgNhdfTIVcDEy6AURK/VvqhD8ijQ9JFVnIOC8+Xr0SUU/8ykz3CILOlVY13+Dx5bnkctD2UK7VljGAOPZcxAO36u9M22ZAXi4hC5EYxjCiDU/7exgru4oqcWuWrd0ka296hkpUiFITz4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721170; c=relaxed/simple;
	bh=dC6dpbB7XpU0IZqROywiojueD3vmaUhPObeIBtk7zHY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=EO/T6VbUc5Y2n1Pyo7mBRBLbal24UAeTnUDCGrB3UBmaLaW0sS5/tQ1qYqeCTlV516Vr1Mckp/VJZYrGC2q7XzL8mWFKJOWqnkJ4epmy1SrAegI5bvjUjfmMXveoL/CRwhuXoy30b8SPGmFiVUhQ5+y7kdWFwF5q51b3X4//0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hnASDGjt; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772721127;
	bh=dC6dpbB7XpU0IZqROywiojueD3vmaUhPObeIBtk7zHY=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=hnASDGjtHZWo7jFjj3Sw8mX8A9NEAdajWVLjFiBZY0WSvx/AkjGCGUcH6/Tla/ywW
	 L6Khuy+EB7rQAHaEtQ4w3WCRS7lWP4zapU4yltXQ4/H1vpftDJFB1Ns8NxgAGmgrQK
	 2vIufWxyyN+Edgar67MUfVT3NdQ+POQwbQ2cONqg=
EX-QQ-RecipientCnt: 4
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSHNwC2Dqd2M/t+aQldaspwowpDBZ8q7ts=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Ty+m35/u6ct/+Uf8bb3QB3Gh6tfU4I+WeYNmENZ2gxpusnTJIN2gZLKsrohvhMCk
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1772721122t4496ca49
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?cmVncmVzc2lvbnM=?=" <regressions@lists.linux.dev>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Subject: [REGRESSION v6.12.75] build failure on x86 because commit f8f73bf0f8a57
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 5 Mar 2026 22:32:01 +0800
X-Priority: 3
Message-ID: <tencent_29235CCE219D3C772285C5F8@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_1EDDBDC63EFAE9C27849E987@qq.com>
In-Reply-To: <tencent_1EDDBDC63EFAE9C27849E987@qq.com>
X-QQ-ReplyHash: 208553334
X-BIZMAIL-ID: 11680072738535138145
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 05 Mar 2026 22:32:03 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NchHDkd43sBtL6NMKFWc20rdZi6l4Jiioock3SHqcEbwkgr80lIIYbVj
	CbcV7oc1X6/j5kQtfAsuGDCnZhOFYz1dUe8+ckEMSqaw7CL1U6PLvQANNvNWwDIObr3tY+u
	m3SoAX9KNag4UVWr/jsMDCODbsxl/yL//7wbKCY0X2tdcPnpmDblsDgG0opmdwlePZ9nRjz
	v6WrvWHaqBEBxDo1vqNYM1SauiFF6ktwmnwEYPw8Y0PCKJraR39IaGsxIIWHugWhzkkjXOq
	XL4Z36HFliileQdRHHfF8gd2PkKTo1VlvP7iQXnQda5eDiIxdKVZTH1rwuLsuIq/SFOLyli
	I+xaadVWPge+VPTfj1V19Ps998+L8/sUm1YEcawjFh+B/ONQJRBLriZYAS5xweQWLI89aRn
	yUgb+ubCCCToHpV0UKz1YM7WqfXnjsfT6fONlHihlRkP4GDrCT7lGVSMgp4Mh0UzjA6G5ZH
	sm8NSQMAf5uj2Lbs3QY4gdSthUcqxRJwUiGjR+pzeVuE7Hw/fCraR0N7JopvzFymZDGsjHH
	D/JaJfsOhbSpsn+2AqRuwpFAluq4FqG2aPajhfq2dg+jDsslLeXuAVhhP9EsJMzIsX/LNMW
	pTdCyp2nJnyxn8brk3Mjmg+t64Z4s6BtjRHgyTySu0THSd4S5P90ozd+M5sVsFXYcjTUeb5
	LcBGUQlA72nMRIOHZWCnum/UjtOZMFV2tk7HPjSfA4xHLwnO/LMu7/XKwm8sdGBoU8aLULJ
	Jh5gKe3zSs3/Ah/E1MGJ4YxWL+ujezn4JFyh4SGLlZ5HwWvu8+0YHb/Ez4eOQrziXT4Y8wp
	ZO7Iha/GMN6xrgNVqwPIJ3GjKdAvu/6vON69FDmqu2NntfFw/rprw1GKshU4y+DzcUXwRqF
	hk8143sEN93VtaF/Ye/sK8h0I5tZWGpJFpMqi4CIawlyiEoQnpWYB6sCjZmKpKw7qPMYU6q
	t5kJ2F2aLRkI4MjJ0qTDdF+RwDSLsjIjMREHHEDid1jcRaXYu1tJ0HVJF/EKNwJOuU8DSJz
	fFx0+TELqMdx7cEkqIjqQy3fDE8XQopBOAVeszjwFTJvXi7xzQFao2a43KMyGRkQt4BuTCP
	Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: CB977213A11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-223206-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EXCESS_BASE64(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action

RGVhciBBbGwsDQoNCkkgZm91bmQgdjYuMTIuNzUgaGF2ZSBzYW1lIGlzc3VlIHRvbywgaXQg
Y2FuIGJlIHJlcHJvZHVjZWQgb24geDg2LA0Kd2l0aCBDT05GSUdfT0ZfRkxBVFRSRUUgbm90
IHNldChkaXNiYWxlIENPTkZJR19PRikuDQoNClRoZSByZWFzb24gaXMgbWlzcyB0aGUgbWFp
bmxpbmUgY29tbWl0IDEwZDFjNzVlZDQzOCANCigiaW1hOiB2ZXJpZnkgdGhlIHByZXZpb3Vz
IGtlcm5lbCdzIElNQSBidWZmZXIgbGllcyBpbiBhZGRyZXNzYWJsZSBSQU0iKQ0KDQpCUnMN
CldlbnRhbyBHdWFuDQoNCkxvZzoNCmFyY2gveDg2L2tlcm5lbC9zZXR1cC5jOiBJbiBmdW5j
dGlvbiDigJhpbWFfZ2V0X2tleGVjX2J1ZmZlcuKAmToNCmFyY2gveDg2L2tlcm5lbC9zZXR1
cC5jOjM4MDoxNTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKA
mGltYV92YWxpZGF0ZV9yYW5nZeKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl0NCiAgMzgwIHwgICAgICAgICByZXQgPSBpbWFfdmFsaWRhdGVfcmFuZ2UoaW1h
X2tleGVjX2J1ZmZlcl9waHlzLCBpbWFfa2V4ZWNfYnVmZmVyX3NpemUpOw0KICAgICAgfCAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KDQpjb25maWc6DQpodHRwczovL2dp
c3QuZ2l0aHViLmNvbS9vcHNpZmYvYTEzOTEwM2Q5MmIwNTUwNGMwNWU0MjYwMDk1ODI0MmQN
Cg0KY29tbWl0Og0KZ2l0IHNob3cgZjhmNzNiZjBmOGE1Nw0KY29tbWl0IGY4ZjczYmYwZjhh
NTdlZTliODY3OTI0NTZiZDQyMDc5YmM5OGM2YjcNCkF1dGhvcjogSGFyc2hpdCBNb2dhbGFw
YWxsaSA8aGFyc2hpdC5tLm1vZ2FsYXBhbGxpQG9yYWNsZS5jb20+DQpEYXRlOiAgIFR1ZSBE
ZWMgMzAgMjI6MTY6MDkgMjAyNSAtMDgwMA0KDQogICAgeDg2L2tleGVjOiBhZGQgYSBzYW5p
dHkgY2hlY2sgb24gcHJldmlvdXMga2VybmVsJ3MgaW1hIGtleGVjIGJ1ZmZlcg0KICAgIA0K
ICAgIFsgVXBzdHJlYW0gY29tbWl0IGM1NDg5ZDA0MzM3YjQ3ZTkzYzA2MjNlODE0NWZjYmEz
ZjU3MzllZmQgXQ0KICAgIA0KICAgIFdoZW4gdGhlIHNlY29uZC1zdGFnZSBrZXJuZWwgaXMg
Ym9vdGVkIHZpYSBrZXhlYyB3aXRoIGEgbGltaXRpbmcgY29tbWFuZA0KICAgIGxpbmUgc3Vj
aCBhcyAibWVtPTxzaXplPiIsIHRoZSBwaHlzaWNhbCByYW5nZSB0aGF0IGNvbnRhaW5zIHRo
ZSBjYXJyaWVkDQogICAgb3ZlciBJTUEgbWVhc3VyZW1lbnQgbGlzdCBtYXkgZmFsbCBvdXRz
aWRlIHRoZSB0cnVuY2F0ZWQgUkFNIGxlYWRpbmcgdG8gYQ0KICAgIGtlcm5lbCBwYW5pYy4N
CiAgICANCiAgICAgICAgQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFk
ZHJlc3M6IGZmZmY5Nzc5M2ZmNDcwMDANCiAgICAgICAgUklQOiBpbWFfcmVzdG9yZV9tZWFz
dXJlbWVudF9saXN0KzB4ZGMvMHg0NWENCiAgICAgICAgI1BGOiBlcnJvcl9jb2RlKDB4MDAw
MCkg4oCTIG5vdC1wcmVzZW50IHBhZ2UNCiAgICANCiAgICBPdGhlciBhcmNoaXRlY3R1cmVz
IGFscmVhZHkgdmFsaWRhdGUgdGhlIHJhbmdlIHdpdGggcGFnZV9pc19yYW0oKSwgYXMgZG9u
ZQ0KICAgIGluIGNvbW1pdCBjYmY5YzRiOTYxN2IgKCJvZjogY2hlY2sgcHJldmlvdXMga2Vy
bmVsJ3MgaW1hLWtleGVjLWJ1ZmZlcg0KICAgIGFnYWluc3QgbWVtb3J5IGJvdW5kcyIpIGRv
IGEgc2ltaWxhciBjaGVjayBvbiB4ODYuDQogICAgDQogICAgV2l0aG91dCBjYXJyeWluZyB0
aGUgbWVhc3VyZW1lbnQgbGlzdCBhY3Jvc3Mga2V4ZWMsIHRoZSBhdHRlc3RhdGlvbg0KICAg
IHdvdWxkIGZhaWwuDQogICAgDQogICAgTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcv
ci8yMDI1MTIzMTA2MTYwOS45MDcxNzAtNC1oYXJzaGl0Lm0ubW9nYWxhcGFsbGlAb3JhY2xl
LmNvbQ0KICAgIFNpZ25lZC1vZmYtYnk6IEhhcnNoaXQgTW9nYWxhcGFsbGkgPGhhcnNoaXQu
bS5tb2dhbGFwYWxsaUBvcmFjbGUuY29tPg0KICAgIEZpeGVzOiBiNjlhMmFmZDVhZmMgKCJ4
ODYva2V4ZWM6IENhcnJ5IGZvcndhcmQgSU1BIG1lYXN1cmVtZW50IGxvZyBvbiBrZXhlYyIp
DQogICAgUmVwb3J0ZWQtYnk6IFBhdWwgV2ViYiA8cGF1bC54LndlYmJAb3JhY2xlLmNvbT4N
CiAgICBSZXZpZXdlZC1ieTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4NCiAg
ICBDYzogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4NCiAgICBDYzogQXJkIEJp
ZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCiAgICBDYzogQmFvcXVhbiBIZSA8YmhlQHJl
ZGhhdC5jb20+DQogICAgQ2M6IEJvcmlzbGF2IEJldGtvdiA8YnBAYWxpZW44LmRlPg0KICAg
IENjOiBndW93ZWlrYW5nIDxndW93ZWlrYW5nLmtlcm5lbEBnbWFpbC5jb20+DQogICAgQ2M6
IEhlbnJ5IFdpbGxhcmQgPGhlbnJ5LndpbGxhcmRAb3JhY2xlLmNvbT4NCiAgICBDYzogIkgu
IFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCiAgICBDYzogSW5nbyBNb2xuYXIgPG1p
bmdvQHJlZGhhdC5jb20+DQogICAgQ2M6IEppcmkgQm9oYWMgPGpib2hhY0BzdXNlLmN6Pg0K
ICAgIENjOiBKb2VsIEdyYW5hZG9zIDxqb2VsLmdyYW5hZG9zQGtlcm5lbC5vcmc+DQogICAg
Q2M6IEpvbmF0aGFuIE1jRG93ZWxsIDxub29kbGVzQGZiLmNvbT4NCiAgICBDYzogTWlrZSBS
YXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPg0KICAgIENjOiBTb2hpbCBNZWh0YSA8c29oaWwu
bWVodGFAaW50ZWwuY29tPg0KICAgIENjOiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxp
bnV4LmlibS5jb20+DQogICAgQ2M6IFRob21hcyBHbGVpbnhlciA8dGdseEBsaW51dHJvbml4
LmRlPg0KICAgIENjOiBZaWZlaSBMaXUgPHlpZmVpLmwubGl1QG9yYWNsZS5jb20+DQogICAg
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KICAgIFNpZ25lZC1vZmYtYnk6IEFuZHJl
dyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQogICAgU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPg0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva2VybmVsL3NldHVwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYw0KaW5kZXgg
ZjFmZWE1MDZlMjBmNC4uMjM0YzRkOWU1MGI4ZiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tl
cm5lbC9zZXR1cC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYw0KQEAgLTM3Miw5
ICszNzIsMTUgQEAgaW50IF9faW5pdCBpbWFfZnJlZV9rZXhlY19idWZmZXIodm9pZCkNCiAN
CiBpbnQgX19pbml0IGltYV9nZXRfa2V4ZWNfYnVmZmVyKHZvaWQgKiphZGRyLCBzaXplX3Qg
KnNpemUpDQogew0KKyAgICAgICBpbnQgcmV0Ow0KKw0KICAgICAgICBpZiAoIWltYV9rZXhl
Y19idWZmZXJfc2l6ZSkNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsNCiANCisg
ICAgICAgcmV0ID0gaW1hX3ZhbGlkYXRlX3JhbmdlKGltYV9rZXhlY19idWZmZXJfcGh5cywg
aW1hX2tleGVjX2J1ZmZlcl9zaXplKTsNCisgICAgICAgaWYgKHJldCkNCisgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KKw0KICAgICAgICAqYWRkciA9IF9fdmEoaW1hX2tleGVjX2J1
ZmZlcl9waHlzKTsNCiAgICAgICAgKnNpemUgPSBpbWFfa2V4ZWNfYnVmZmVyX3NpemU7


