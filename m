Return-Path: <stable+bounces-223096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOUqCAlkqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:55:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6023204B12
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B69B300F5B5
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC5361647;
	Wed,  4 Mar 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY2Q5Dfd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F7374E59
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643333; cv=none; b=tnjeE9c8xXIT7YlZDF7wx95R6T2N2I+xQETQBqRlR95D8o7900AHW0ZY6vp2R8mFPowHO2P6UzFQEBCjjcl71/SWT7bWozS6a+HnGuje8N2WOW++F4NLF8PK/c7DfNBMS9/GU8o0rNY0Wc+b94N1Sk9aavZ8cd64pVECyahKkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643333; c=relaxed/simple;
	bh=S2PD1VP65to/VLj2VFIwiDZ89UjoBePlOYzLbfyVPTw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=FAhGLX612Do3nu4mJViV3Xokb/mzXpqKEonlb4ODJufUEq+t2wX+zgDp0BCFY6heoH5vyD1BO4XNwF6lppwCfHSOVYgySwPsLhPnHu9qaFS/7zJZi+g0yizKbvqIwRH78yFm4E5qIHxyMgTTcz/Y3r74y7ElqEvXB3MQkcW9qWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY2Q5Dfd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837584120eso53118915e9.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643330; x=1773248130; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2PD1VP65to/VLj2VFIwiDZ89UjoBePlOYzLbfyVPTw=;
        b=JY2Q5Dfd5SCc6jMUhXJJo0k8gL4vJQHLp9r/AgYQo9wJNmb+6fzbMtZtLHutVVS3lo
         AzIE+rE5J/Rd/YbzJJfKSQNhET8nAdBhxoqt9QIVKgwdtCCqqucm8+skO8IQc6V8n/tx
         uI94YjH31nXeXKujC17HW2mZKcXO3ehu0UH3JmfA/zJehuG+NaSteSByub+9X4hlUose
         /0/zBo/HL/CoUOYzr3FuYOQu3+I8zcvQmt2irmB6/r/lThXLhD4Oegd3EElJiFtYmZuL
         HzMTy2kVRhHa6mWAQypJOFV1JpFL7T3kh+EK4ybPSYhYAa53yLQc7p/q8oMg2uYkAwTK
         mgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643330; x=1773248130;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2PD1VP65to/VLj2VFIwiDZ89UjoBePlOYzLbfyVPTw=;
        b=kG2awrrPbng6LEIfuE2Cnp1cYfcOgo6pShUV/bnz47fZ/MPeN6N94o5dXdoCyowGS7
         ikq/IYaIJxp5xyNB6N3MBkzpv/skrGN/27xGId4XjMz6wpQqzTBBX0+F+8huNNYL1+gB
         cuqtHY3XutDWFG6bVr0rPFOtzyigU522b61Ibdqyo/mpLtp7KHAXQotm63z62fCFuoRy
         gmyjvzmS6F430s5jH4JbU3XB7PdrJUnIncz01AJemj3HCtgFR4HjiOdNeLr/Uuuhst8K
         KXs5+qHm2FgBHY1nhN6yryvOhZuIsJqo+enW+NZ9+9H82FT2AUErAjsWoOTEjfy3VcOC
         c3jQ==
X-Gm-Message-State: AOJu0YyTDMbLi1NDeysHL4OxFCP7V5ERdL24W7/dph7HXKJNAnF1A6aa
	mr60RKXgA3Ozl5cTWC+BrjsiU48gTQvL5nwVoQ318hwCazMnjj/Kxwa2qvBaw66RFbs=
X-Gm-Gg: ATEYQzytpDu5Ld7UCuSPtAxq+11l8rxW2eadMCtwfiu6apdoqiEV+CmmTi3FGfE+h2K
	yJ7+Yw5RdsTnFZ17kuM/4eJSaN8CbdwFyFTjU5lL9tx6mcwuvW08g4a6aRkq3VrBZD5+ytWCf1q
	W/ScVEli68M/zUcKUfXOE+wh5Wcpg0/+3pj6YQRXWFIGp9sAJ1ci6iz7zUh+fSRFKTB3v/lR2J1
	X1JtybZr0Sc1FcI5LFY4YbQz7+hgtWp6OgwRcsaRoe86saH5R0VSThYfQMLmvYpUcs9Ds6XusAg
	vTfskBMNLZ+qK6KCR5lrc36ENaBj16lW004IKCtAlst0+XbyuKo+57tmfPZtcwvfGKdRKnabSi8
	uP6BxjiexdiMfeDCvb05Esl/Lt00QayEapbKnIyKN8OexwZJGcoz3Y9qUUgURPUyHTk9/vMPJkU
	EFQ+xnE96rg9/PGm2iGVdUszQtPK5oRReTh55qjCvpVrpPOcBvjM5lD+QGFJqaxpL2iAV7NwO2
X-Received: by 2002:a05:600c:1c18:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-48519871aa4mr53996955e9.16.1772643329927;
        Wed, 04 Mar 2026 08:55:29 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187bf2fcsm64783575e9.4.2026.03.04.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Natarajan KV <natarajankv91@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Subject: [PATCH v3 6.6.y 7/8] netfilter: nft_set_pipapo: move cloning of match
 info to insert/removal path
Message-ID: <1772643278.pipapo-v3.7@gmail.com>
Date: Wed, 04 Mar 2026 20:55:26 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: B6023204B12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223096-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natarajankv91@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Action: no action

QWRhcHRhdGlvbiBvZiBjb21taXQgM2YxZDg4NmNjN2MzICgibmV0ZmlsdGVyOiBuZnRfc2V0X3Bp
cGFwbzogbW92ZQpjbG9uaW5nIG9mIG1hdGNoIGluZm8gdG8gaW5zZXJ0L3JlbW92YWwgcGF0aCIp
IHRvIDYuNi4xMjIuCgpDdXJyZW50bHkgcGlwYXBvX2Nsb25lKCkgaXMgY2FsbGVkIGZyb20gdGhl
IGNvbW1pdCBhbmQgYWJvcnQKY2FsbGJhY2tzLiAgY29tbWl0IGFuZCBhYm9ydCBtdXN0IG5vdCBm
YWlsLCBidXQgcGlwYXBvX2Nsb25lKCkKY2FuIGZhaWwgd2l0aCBFTk9NRU0uCgpNb3ZlIHBpcGFw
b19jbG9uZSgpIGZyb20gdGhlIGNvbW1pdC9hYm9ydCBjYWxsYmFja3MgdG8gdGhlCmluc2VydCBh
bmQgcmVtb3ZhbCBwYXRocyB2aWEgcGlwYXBvX21heWJlX2Nsb25lKCksIHdoaWNoCmNyZWF0ZXMg
dGhlIHdvcmtpbmcgY29weSBvbiBkZW1hbmQgYW5kIGNhbiBwcm9wYWdhdGUgYWxsb2NhdGlvbgpm
YWlsdXJlcy4KCmNvbW1pdCBqdXN0IHN3YXBzIGNsb25lIHRvIG1hdGNoIGFuZCBzZXRzIGNsb25l
IHRvIE5VTEwuCmFib3J0IGp1c3QgZnJlZXMgdGhlIGNsb25lLgoKRml4ZXM6IDNjNDI4N2Y2MjA0
NCAoIm5mX3RhYmxlczogQWRkIHNldCB0eXBlIGZvciBhcmJpdHJhcnkgY29uY2F0ZW5hdGlvbiBv
ZiByYW5nZXMiKQpTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFdlc3RwaGFsIDxmd0BzdHJsZW4uZGU+
ClJldmlld2VkLWJ5OiBTdGVmYW5vIEJyaXZpbyA8c2JyaXZpb0ByZWRoYXQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBQYWJsbyBOZWlyYSBBeXVzbyA8cGFibG9AbmV0ZmlsdGVyLm9yZz4KU2lnbmVkLW9m
Zi1ieTogTmF0YXJhamFuIEtWIDxuYXRhcmFqYW5rdjkxQGdtYWlsLmNvbT4KLS0tCiBuZXQvbmV0
ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMgfCA4OSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jIGIvbmV0L25ldGZp
bHRlci9uZnRfc2V0X3BpcGFwby5jCmluZGV4IDE3NmYxYTg5NTZhOS4uNTdiNDVlM2IxMWNhIDEw
MDY0NAotLS0gYS9uZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMKKysrIGIvbmV0L25ldGZp
bHRlci9uZnRfc2V0X3BpcGFwby5jCkBAIC0xMjA4LDE0ICsxMjA4LDE2IEBAIHN0YXRpYyBpbnQg
bmZ0X3BpcGFwb19pbnNlcnQoY29uc3Qgc3RydWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QgbmZ0
X3NldCAqc2V0LAogCXVuaW9uIG5mdF9waXBhcG9fbWFwX2J1Y2tldCBydWxlbWFwW05GVF9QSVBB
UE9fTUFYX0ZJRUxEU107CiAJY29uc3QgdTggKnN0YXJ0ID0gKGNvbnN0IHU4ICopZWxlbS0+a2V5
LnZhbC5kYXRhLCAqZW5kOwogCXN0cnVjdCBuZnRfcGlwYXBvX2VsZW0gKmUgPSBlbGVtLT5wcml2
LCAqZHVwOwotCXN0cnVjdCBuZnRfcGlwYXBvICpwcml2ID0gbmZ0X3NldF9wcml2KHNldCk7Ci0J
c3RydWN0IG5mdF9waXBhcG9fbWF0Y2ggKm0gPSBwcml2LT5jbG9uZTsKKwlzdHJ1Y3QgbmZ0X3Bp
cGFwb19tYXRjaCAqbSA9IHBpcGFwb19tYXliZV9jbG9uZShzZXQpOwogCXU4IGdlbm1hc2sgPSBu
ZnRfZ2VubWFza19uZXh0KG5ldCk7CiAJdTY0IHRzdGFtcCA9IG5mdF9uZXRfdHN0YW1wKG5ldCk7
CiAJc3RydWN0IG5mdF9waXBhcG9fZmllbGQgKmY7CiAJY29uc3QgdTggKnN0YXJ0X3AsICplbmRf
cDsKIAlpbnQgaSwgYnNpemVfbWF4LCBlcnIgPSAwOwogCisJaWYgKCFtKQorCQlyZXR1cm4gLUVO
T01FTTsKKwogCWlmIChuZnRfc2V0X2V4dF9leGlzdHMoZXh0LCBORlRfU0VUX0VYVF9LRVlfRU5E
KSkKIAkJZW5kID0gKGNvbnN0IHU4ICopbmZ0X3NldF9leHRfa2V5X2VuZChleHQpLT5kYXRhOwog
CWVsc2UKQEAgLTEyNjksOCArMTI3MSw2IEBAIHN0YXRpYyBpbnQgbmZ0X3BpcGFwb19pbnNlcnQo
Y29uc3Qgc3RydWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QgbmZ0X3NldCAqc2V0LAogCX0KIAog
CS8qIEluc2VydCAqLwotCXByaXYtPmRpcnR5ID0gdHJ1ZTsKLQogCWJzaXplX21heCA9IG0tPmJz
aXplX21heDsKIAogCW5mdF9waXBhcG9fZm9yX2VhY2hfZmllbGQoZiwgaSwgbSkgewpAQCAtMTYz
MCw4ICsxNjMwLDYgQEAgc3RhdGljIHZvaWQgcGlwYXBvX2djKHN0cnVjdCBuZnRfc2V0ICpzZXQs
IHN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICptKQogCQkgKiBORlRfU0VUX0VMRU1fREVBRF9CSVQu
CiAJCSAqLwogCQlpZiAoX19uZnRfc2V0X2VsZW1fZXhwaXJlZCgmZS0+ZXh0LCB0c3RhbXApKSB7
Ci0JCQlwcml2LT5kaXJ0eSA9IHRydWU7Ci0KIAkJCWdjID0gbmZ0X3RyYW5zX2djX3F1ZXVlX3N5
bmMoZ2MsIEdGUF9BVE9NSUMpOwogCQkJaWYgKCFnYykKIAkJCQlyZXR1cm47CkBAIC0xNzA5LDQ2
ICsxNzA3LDU0IEBAIHN0YXRpYyB2b2lkIHBpcGFwb19yZWNsYWltX21hdGNoKHN0cnVjdCByY3Vf
aGVhZCAqcmN1KQogc3RhdGljIHZvaWQgbmZ0X3BpcGFwb19jb21taXQoc3RydWN0IG5mdF9zZXQg
KnNldCkKIHsKIAlzdHJ1Y3QgbmZ0X3BpcGFwbyAqcHJpdiA9IG5mdF9zZXRfcHJpdihzZXQpOwot
CXN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICpuZXdfY2xvbmUsICpvbGQ7Ci0KLQlpZiAodGltZV9h
ZnRlcl9lcShqaWZmaWVzLCBwcml2LT5sYXN0X2djICsgbmZ0X3NldF9nY19pbnRlcnZhbChzZXQp
KSkKLQkJcGlwYXBvX2djKHNldCwgcHJpdi0+Y2xvbmUpOwotCi0JaWYgKCFwcml2LT5kaXJ0eSkK
LQkJcmV0dXJuOworCXN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICpvbGQ7CiAKLQluZXdfY2xvbmUg
PSBwaXBhcG9fY2xvbmUocHJpdi0+Y2xvbmUpOwotCWlmICghbmV3X2Nsb25lKQorCWlmICghcHJp
di0+Y2xvbmUpCiAJCXJldHVybjsKIAotCXByaXYtPmRpcnR5ID0gZmFsc2U7CisJaWYgKHRpbWVf
YWZ0ZXJfZXEoamlmZmllcywgcHJpdi0+bGFzdF9nYyArIG5mdF9zZXRfZ2NfaW50ZXJ2YWwoc2V0
KSkpCisJCXBpcGFwb19nYyhzZXQsIHByaXYtPmNsb25lKTsKIAogCW9sZCA9IHJjdV9hY2Nlc3Nf
cG9pbnRlcihwcml2LT5tYXRjaCk7CiAJcmN1X2Fzc2lnbl9wb2ludGVyKHByaXYtPm1hdGNoLCBw
cml2LT5jbG9uZSk7CisJcHJpdi0+Y2xvbmUgPSBOVUxMOworCiAJaWYgKG9sZCkKIAkJY2FsbF9y
Y3UoJm9sZC0+cmN1LCBwaXBhcG9fcmVjbGFpbV9tYXRjaCk7Ci0KLQlwcml2LT5jbG9uZSA9IG5l
d19jbG9uZTsKIH0KIAotc3RhdGljIHZvaWQgbmZ0X3BpcGFwb19hYm9ydChjb25zdCBzdHJ1Y3Qg
bmZ0X3NldCAqc2V0KQorc3RhdGljIHN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICpwaXBhcG9fY2xv
bmUoc3RydWN0IG5mdF9waXBhcG9fbWF0Y2ggKm9sZCk7CisKKy8qKgorICogcGlwYXBvX21heWJl
X2Nsb25lKCkgLSBCdWlsZCBjbG9uZSBmb3IgcGVuZGluZyBkYXRhIGNoYW5nZXMsIGlmIG5vdCBl
eGlzdGluZworICogQHNldDoJbmZ0YWJsZXMgQVBJIHNldCByZXByZXNlbnRhdGlvbgorICoKKyAq
IFJldHVybjogbmV3bHkgY3JlYXRlZCBvciBleGlzdGluZyBjbG9uZSwgaWYgYW55LiBOVUxMIG9u
IGFsbG9jYXRpb24gZmFpbHVyZS4KKyAqLworc3RhdGljIHN0cnVjdCBuZnRfcGlwYXBvX21hdGNo
ICpwaXBhcG9fbWF5YmVfY2xvbmUoY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNldCkKIHsKIAlzdHJ1
Y3QgbmZ0X3BpcGFwbyAqcHJpdiA9IG5mdF9zZXRfcHJpdihzZXQpOwotCXN0cnVjdCBuZnRfcGlw
YXBvX21hdGNoICpuZXdfY2xvbmUsICptOworCXN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICptOwog
Ci0JaWYgKCFwcml2LT5kaXJ0eSkKLQkJcmV0dXJuOworCWlmIChwcml2LT5jbG9uZSkKKwkJcmV0
dXJuIHByaXYtPmNsb25lOwogCi0JbSA9IHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQocHJpdi0+
bWF0Y2gsIG5mdF9waXBhcG9fdHJhbnNhY3Rpb25fbXV0ZXhfaGVsZChzZXQpKTsKKwltID0gcmN1
X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChwcml2LT5tYXRjaCwKKwkJCQkgICAgICBuZnRfcGlwYXBv
X3RyYW5zYWN0aW9uX211dGV4X2hlbGQoc2V0KSk7CisJcHJpdi0+Y2xvbmUgPSBwaXBhcG9fY2xv
bmUobSk7CiAKLQluZXdfY2xvbmUgPSBwaXBhcG9fY2xvbmUobSk7Ci0JaWYgKCFuZXdfY2xvbmUp
Ci0JCXJldHVybjsKKwlyZXR1cm4gcHJpdi0+Y2xvbmU7Cit9CiAKLQlwcml2LT5kaXJ0eSA9IGZh
bHNlOworc3RhdGljIHZvaWQgbmZ0X3BpcGFwb19hYm9ydChjb25zdCBzdHJ1Y3QgbmZ0X3NldCAq
c2V0KQoreworCXN0cnVjdCBuZnRfcGlwYXBvICpwcml2ID0gbmZ0X3NldF9wcml2KHNldCk7CisK
KwlpZiAoIXByaXYtPmNsb25lKQorCQlyZXR1cm47CiAKIAlwaXBhcG9fZnJlZV9tYXRjaChwcml2
LT5jbG9uZSk7Ci0JcHJpdi0+Y2xvbmUgPSBuZXdfY2xvbmU7CisJcHJpdi0+Y2xvbmUgPSBOVUxM
OwogfQogCiAvKioKQEAgLTE3ODcsMTAgKzE3OTMsMTMgQEAgc3RhdGljIHZvaWQgbmZ0X3BpcGFw
b19hY3RpdmF0ZShjb25zdCBzdHJ1Y3QgbmV0ICpuZXQsCiBzdGF0aWMgdm9pZCAqcGlwYXBvX2Rl
YWN0aXZhdGUoY29uc3Qgc3RydWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QgbmZ0X3NldCAqc2V0
LAogCQkJICAgICAgIGNvbnN0IHU4ICpkYXRhLCBjb25zdCBzdHJ1Y3QgbmZ0X3NldF9leHQgKmV4
dCkKIHsKLQlzdHJ1Y3QgbmZ0X3BpcGFwbyAqcHJpdiA9IG5mdF9zZXRfcHJpdihzZXQpOworCXN0
cnVjdCBuZnRfcGlwYXBvX21hdGNoICptID0gcGlwYXBvX21heWJlX2Nsb25lKHNldCk7CiAJc3Ry
dWN0IG5mdF9waXBhcG9fZWxlbSAqZTsKIAotCWUgPSBwaXBhcG9fZ2V0KHByaXYtPmNsb25lLCBk
YXRhLCBuZnRfZ2VubWFza19uZXh0KG5ldCksIG5mdF9uZXRfdHN0YW1wKG5ldCkpOworCWlmICgh
bSkKKwkJcmV0dXJuIE5VTEw7CisKKwllID0gcGlwYXBvX2dldChtLCBkYXRhLCBuZnRfZ2VubWFz
a19uZXh0KG5ldCksIG5mdF9uZXRfdHN0YW1wKG5ldCkpOwogCWlmIChJU19FUlIoZSkpCiAJCXJl
dHVybiBOVUxMOwogCkBAIC0xOTczLDggKzE5ODIsNyBAQCBzdGF0aWMgYm9vbCBwaXBhcG9fbWF0
Y2hfZmllbGQoc3RydWN0IG5mdF9waXBhcG9fZmllbGQgKmYsCiBzdGF0aWMgdm9pZCBuZnRfcGlw
YXBvX3JlbW92ZShjb25zdCBzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpz
ZXQsCiAJCQkgICAgICBjb25zdCBzdHJ1Y3QgbmZ0X3NldF9lbGVtICplbGVtKQogewotCXN0cnVj
dCBuZnRfcGlwYXBvICpwcml2ID0gbmZ0X3NldF9wcml2KHNldCk7Ci0Jc3RydWN0IG5mdF9waXBh
cG9fbWF0Y2ggKm0gPSBwcml2LT5jbG9uZTsKKwlzdHJ1Y3QgbmZ0X3BpcGFwb19tYXRjaCAqbSA9
IHBpcGFwb19tYXliZV9jbG9uZShzZXQpOwogCXN0cnVjdCBuZnRfcGlwYXBvX2VsZW0gKmUgPSBl
bGVtLT5wcml2OwogCWludCBydWxlc19mMCwgZmlyc3RfcnVsZSA9IDA7CiAJY29uc3QgdTggKmRh
dGE7CkBAIC0yMDE0LDcgKzIwMjIsNiBAQCBzdGF0aWMgdm9pZCBuZnRfcGlwYXBvX3JlbW92ZShj
b25zdCBzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpzZXQsCiAJCQltYXRj
aF9lbmQgKz0gTkZUX1BJUEFQT19HUk9VUFNfUEFEREVEX1NJWkUoZik7CiAKIAkJCWlmIChsYXN0
ICYmIGYtPm10W3J1bGVtYXBbaV0udG9dLmUgPT0gZSkgewotCQkJCXByaXYtPmRpcnR5ID0gdHJ1
ZTsKIAkJCQlwaXBhcG9fZHJvcChtLCBydWxlbWFwKTsKIAkJCQlyZXR1cm47CiAJCQl9CkBAIC0y
MDg3LDcgKzIwOTQsMTEgQEAgc3RhdGljIHZvaWQgbmZ0X3BpcGFwb193YWxrKGNvbnN0IHN0cnVj
dCBuZnRfY3R4ICpjdHgsIHN0cnVjdCBuZnRfc2V0ICpzZXQsCiAKIAlzd2l0Y2ggKGl0ZXItPnR5
cGUpIHsKIAljYXNlIE5GVF9JVEVSX1VQREFURToKLQkJbSA9IHByaXYtPmNsb25lOworCQltID0g
cGlwYXBvX21heWJlX2Nsb25lKHNldCk7CisJCWlmICghbSkgeworCQkJaXRlci0+ZXJyID0gLUVO
T01FTTsKKwkJCWJyZWFrOworCQl9CiAJCW5mdF9waXBhcG9fZG9fd2FsayhjdHgsIHNldCwgbSwg
aXRlcik7CiAJCWJyZWFrOwogCWNhc2UgTkZUX0lURVJfUkVBRDoKQEAgLTIxOTksMjAgKzIyMTAs
MTIgQEAgc3RhdGljIGludCBuZnRfcGlwYXBvX2luaXQoY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNl
dCwKIAkJZi0+bXQgPSBOVUxMOwogCX0KIAotCS8qIENyZWF0ZSBhbiBpbml0aWFsIGNsb25lIG9m
IG1hdGNoaW5nIGRhdGEgZm9yIG5leHQgaW5zZXJ0aW9uICovCi0JcHJpdi0+Y2xvbmUgPSBwaXBh
cG9fY2xvbmUobSk7Ci0JaWYgKCFwcml2LT5jbG9uZSkgewotCQllcnIgPSAtRU5PTUVNOwotCQln
b3RvIG91dF9mcmVlOwotCX0KLQotCXByaXYtPmRpcnR5ID0gZmFsc2U7CisJcHJpdi0+Y2xvbmUg
PSBOVUxMOwogCiAJcmN1X2Fzc2lnbl9wb2ludGVyKHByaXYtPm1hdGNoLCBtKTsKIAogCXJldHVy
biAwOwogCi1vdXRfZnJlZToKIAlmcmVlX3BlcmNwdShtLT5zY3JhdGNoKTsKIG91dF9zY3JhdGNo
OgogCWtmcmVlKG0pOwotLSAKMi4zNC4xCgo=

