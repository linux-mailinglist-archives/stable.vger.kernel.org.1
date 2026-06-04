Return-Path: <stable+bounces-260475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VRA2BGptIWofGQEAu9opvQ
	(envelope-from <stable+bounces-260475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:19:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D6A63FCEA
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:19:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="U kVOW6B";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260475-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260475-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 422CD30BDD64
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71C543E4BF;
	Thu,  4 Jun 2026 12:15:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3643DA55;
	Thu,  4 Jun 2026 12:15:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575326; cv=none; b=S+mHfvG2AeXahEGxrlItl3+BCrC2n0pTKqUmTTyMyaWo4B1Dn1l31kurXAB7wDn1c7WP6GMpL/BhL9uDVT/mnjZdZbl5CnU2urDNxM8b8ZkT/ymacAXHojc3aGdm2Vq/vtaoniD52N+ptO0n8PGjzz2SVxMhXWwq0CjR3m/oJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575326; c=relaxed/simple;
	bh=EkyWnoWUzPKbnh692cDu96itTwqxnfJoZ0AlSUbA7fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SrAzj8+UotxvWtJa+E2E6Odf/yxO+kTyo3bdLBrvg515zTrF0H2VKvT1rAn+uprQjv3hBYWvqQR7vD5sXRWL428RY2nj6eyENywewvBWwmresRdI+yCon6RNBDU2tB9W+aSQaWx7MaFf33l1WAFXMJR5dt3Kfa72y6RNgoi2OPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UkVOW6BE; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=EkyWnoWUzPKbnh692cDu96itTwqxnfJoZ0AlSUbA7fA=; b=U
	kVOW6BEXgNTFh55qFVh962tXhzF8cpomJd1/K5sPZn3tqPaWHyz/4Ge7SRu2vzrp
	yM3IX6nNoLiyXju+/MLODHGn/mkLzLNWidjayMKvBNIrjoCqR2laeVR5V99S34zd
	mt0vHlb2NvQaW2zmpAco74GgmKg8DxNSC8FrpNxUws=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-139 (Coremail) ; Thu, 4 Jun 2026 20:14:52 +0800 (CST)
Date: Thu, 4 Jun 2026 20:14:52 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: jdelvare@suse.com, andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: Re:[PATCH v2] i2c: i801: fix hardware state machine corruption in
 error path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260512093534.348655-1-w15303746062@163.com>
References: <20260512093534.348655-1-w15303746062@163.com>
X-NTES-SC: AL_Qu2TAvmcukoi5CKRYOkfmU0Qguw9Xcq5uPkj34FWN5t8jBHo5DwgRW1dDETv98+JMgaTmhKYQh1n599XY4JFX4E5lNHAY++hl+xq5hpLf+nRrw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <47aa218a.9e42.19e928ecb94.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iygvCgDXXwo8bCFq2qMCAA--.3910W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xwN8GohbDzpgwAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jdelvare@suse.com,m:andi.shyti@kernel.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-260475-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96D6A63FCEA

CgpIaSBKZWFuLCBBbmRpLAoKSnVzdCBhIGdlbnRsZSBwaW5nIG9uIHRoaXMgdjIgcGF0Y2guIEl0
IHJldXNlcyB0aGUgZXhpc3RpbmcgJ291dCcgbGFiZWwgdG8gZml4IAp0aGUgdW51c2VkIGxhYmVs
IHdhcm5pbmcgYW5kIHVwZGF0ZXMgdGhlIGNvbW1pdCBtZXNzYWdlIGV4YWN0bHkgYXMgSmVhbiBz
dWdnZXN0ZWQuCgpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgZWxzZSBu
ZWVkZWQgZnJvbSBteSBzaWRlLCBvciBpZiAKaXQgaXMgZ29vZCB0byBiZSBxdWV1ZWQgdXAuCgpU
aGFua3MsCk1pbmd5dQoKQXQgMjAyNi0wNS0xMiAxNzozNTozNCwgdzE1MzAzNzQ2MDYyQDE2My5j
b20gd3JvdGU6Cj5Gcm9tOiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUu
Y24+Cj4KPkEgc2V2ZXJlIGxpdmVsb2NrIGFuZCBzdWJzZXF1ZW50IEh1bmcgVGFzayBwYW5pYyB3
ZXJlIG9ic2VydmVkIGluIHRoZQo+aTJjLWk4MDEgZHJpdmVyIGR1cmluZyBjb25jdXJyZW50IEZ1
enppbmcuIFRoZSBjcmFzaCBpcyBjYXVzZWQgYnkgYW4KPnVuY29uZGl0aW9uYWwgaGFyZHdhcmUg
cmVnaXN0ZXIgY2xlYW51cCBpbiB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCBvZgo+aTgwMV9hY2Nl
c3MoKS4KPgo+V2hlbiBpODAxX2NoZWNrX3ByZSgpIGZhaWxzIChlLmcuLCByZXR1cm5pbmcgLUVC
VVNZIGJlY2F1c2UgdGhlIFNNQnVzCj5jb250cm9sbGVyIGlzIGFjdGl2ZWx5IHVzZWQgYnkgQklP
Uy9BQ1BJKSwgdGhlIGtlcm5lbCBkb2VzIG5vdCBhY3R1YWxseQo+YWNxdWlyZSB0aGUgaGFyZHdh
cmUgb3duZXJzaGlwLiBIb3dldmVyLCB0aGUgY29kZSBqdW1wcyB0byB0aGUgJ291dCcKPmxhYmVs
IGFuZCBleGVjdXRlczoKPgo+ICAgIGlvd3JpdGU4KFNNQkhTVFNUU19JTlVTRV9TVFMgfCBTVEFU
VVNfRkxBR1MsIFNNQkhTVFNUUyhwcml2KSk7Cj4KPlRoaXMgZm9yY2VmdWxseSBjbGVhcnMgdGhl
IElOVVNFX1NUUyBsb2NrIGFuZCByZXNldHMgdGhlIGhhcmR3YXJlIHN0YXR1cwo+ZmxhZ3Mgd2l0
aG91dCBvd25pbmcgdGhlIGNvbnRyb2xsZXIuIERvaW5nIHNvIGludGVycnVwdHMgb25nb2luZyBC
SU9TL0FDUEkKPnRyYW5zYWN0aW9ucyBhbmQgdG90YWxseSBjb3JydXB0cyB0aGUgU01CdXMgaGFy
ZHdhcmUgc3RhdGUgbWFjaGluZS4KPgo+Q29uc2VxdWVudGx5LCBhbGwgc3Vic2VxdWVudCBpODAx
X2FjY2VzcygpIGNhbGxzIGZhaWwgYXQgdGhlIHByZS1jaGVjawo+c3RhZ2UsIHRyaWdnZXJpbmcg
YW4gZW5kbGVzcyBzdHJlYW0gb2YgIlNNQnVzIGlzIGJ1c3ksIGNhbid0IHVzZSBpdCEiCj5lcnJv
ciBsb2dzLiBPdmVyIGEgc2xvdyBzZXJpYWwgY29uc29sZSwgdGhpcyBwcmludGsgZmxvb2QgbW9u
b3BvbGl6ZXMKPnRoZSBDUFUgKENvbnNvbGUgTGl2ZWxvY2spLCBzdGFydmluZyBvdGhlciBwcm9j
ZXNzZXMgdHJ5aW5nIHRvIGFjcXVpcmUKPnRoZSBtbWFwX2xvY2sgZG93bl9yZWFkIHNlbWFwaG9y
ZSwgdWx0aW1hdGVseSB0cmlnZ2VyaW5nIHRoZSBodW5nIHRhc2sKPndhdGNoZG9nLgo+Cj5GaXgg
dGhpcyBieSBtb3ZpbmcgdGhlICdvdXQnIGxhYmVsIGJlbG93IHRoZSBoYXJkd2FyZSByZWdpc3Rl
ciBjbGVhbnVwLgo+SWYgaTgwMV9jaGVja19wcmUoKSBmYWlscywgd2Ugc2FmZWx5IGJ5cGFzcyB0
aGUgaW93cml0ZTgoKSBhbmQgb25seQo+cmVsZWFzZSB0aGUgc29mdHdhcmUgbG9ja3MgKHBtX3J1
bnRpbWUgYW5kIG11dGV4KSwgc3RyaWN0bHkgYWRoZXJpbmcgdG8KPnRoZSBydWxlIG9mIG5vdCBy
ZWxlYXNpbmcgcmVzb3VyY2VzIHRoYXQgd2VyZSBuZXZlciBhY3F1aXJlZC4KPgo+Rml4ZXM6IDFm
NzYwYjg3ZTU0YyAoImkyYzogaTgwMTogQ2FsbCBpODAxX2NoZWNrX3ByZSgpIGZyb20gaTgwMV9h
Y2Nlc3MoKSIpCj5DYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjMrCj4KPlNpZ25lZC1v
ZmYtYnk6IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KPi0tLQo+
Q2hhbmdlcyBpbiB2MjoKPiAtIFJldXNlZCBhbmQgbW92ZWQgdGhlIGV4aXN0aW5nICdvdXQnIGxh
YmVsIGluc3RlYWQgb2YgYWRkaW5nIGEgbmV3IG9uZSwKPiAgIGZpeGluZyBhIGJ1aWxkIHdhcm5p
bmcgcmVnYXJkaW5nIGFuIHVudXNlZCBsYWJlbC4KPiAtIERyb3BwZWQgdGhlIGluYWNjdXJhdGUg
bWVudGlvbiBvZiAiYW5vdGhlciB0aHJlYWQiIGluIHRoZSBjb21taXQgbWVzc2FnZSwKPiAgIGFz
IGk4MDFfYWNjZXNzKCkgaXMgc2VyaWFsaXplZCBieSBhIG11dGV4Lgo+IC0gQWRkZWQgRml4ZXMg
YW5kIENjIHN0YWJsZSB0YWdzIGFzIHN1Z2dlc3RlZC4KPgo+IGRyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtaTgwMS5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pODAxLmMgYi9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWk4MDEuYwo+aW5kZXggMzJhM2NlZjAyYzdiLi5iMjljOTll
ZDM4ODMgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWk4MDEuYwo+KysrIGIv
ZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pODAxLmMKPkBAIC05MzEsMTMgKzkzMSwxMyBAQCBzdGF0
aWMgczMyIGk4MDFfYWNjZXNzKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCwgdTE2IGFkZHIsCj4g
CSAqLwo+IAlpZiAoaHdwZWMpCj4gCQlpb3dyaXRlOChpb3JlYWQ4KFNNQkFVWENUTChwcml2KSkg
JiB+U01CQVVYQ1RMX0NSQywgU01CQVVYQ1RMKHByaXYpKTsKPi1vdXQ6Cj4gCS8qCj4gCSAqIFVu
bG9jayB0aGUgU01CdXMgZGV2aWNlIGZvciB1c2UgYnkgQklPUy9BQ1BJLAo+IAkgKiBhbmQgY2xl
YXIgc3RhdHVzIGZsYWdzIGlmIG5vdCBkb25lIGFscmVhZHkuCj4gCSAqLwo+IAlpb3dyaXRlOChT
TUJIU1RTVFNfSU5VU0VfU1RTIHwgU1RBVFVTX0ZMQUdTLCBTTUJIU1RTVFMocHJpdikpOwo+IAo+
K291dDoKPiAJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoJnByaXYtPnBjaV9kZXYtPmRldik7
Cj4gCW11dGV4X3VubG9jaygmcHJpdi0+YWNwaV9sb2NrKTsKPiAJcmV0dXJuIHJldDsKPi0tIAo+
Mi4zNC4xCg==

