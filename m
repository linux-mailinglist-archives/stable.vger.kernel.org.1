Return-Path: <stable+bounces-223092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMvsGVFlqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:01:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A67204C1F
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6CA1301AFDE
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756F376BC4;
	Wed,  4 Mar 2026 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jomcRQXU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FC189F43
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643311; cv=none; b=kNoYcVJxdX+vNtiRJG0JIu2RQMNfc2p7brCCMKqscQy/d/7AWJhpbc2BKz3Z9k7KvN8garpyzvMDBawwD5eJmoqPnWL+AFUKZyj6GXnFgeL8TZfDzTKox1KwQr3NrcR/VbRs83lD5AmZMyZMKi+BvBQLHI1sbpk8oqOiTmYlnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643311; c=relaxed/simple;
	bh=7jqxAjOGyod7/O7Rt5aalLvtkAOhYLGvZLQM1WrCCkg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=MDPYvNiMB4aol9zz/2v7WkRi1cW0pcw6y7Ado4NbJ0c92P+kq96scAwf2L7NQig2gp2tAjD1leqKgzDIUkZuagqMVsEuH9iz7EHGY94orWg6/NAlPDPmeUO5yK+nrwv64Baes1jooS1prlRHm564LXNGfJE19JcmOEP09g3sN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jomcRQXU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so85699275e9.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643308; x=1773248108; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jqxAjOGyod7/O7Rt5aalLvtkAOhYLGvZLQM1WrCCkg=;
        b=jomcRQXUt/M1y1ZR9IJYeTlUF1DXkv2SHLsfaVJBRT3APIu2MDNlOUw7X2c9/0rmm0
         x7p0yTd8tPSSucgljK/IepgycOkBJ1YfgmZuHm3xQoT6aryXF8MzDkcsdGG69zAXYscx
         9mi++BipxDsudvj7t4q3kSo8Skb0r4H2A0IvxdIBPlE4T/OThfx1UTFOtggb/1mq/jEg
         5oFGM8RV/3NlYi54lYXoRS+JHTbRiwKCZUXNJLt7ZL4+76u/sG8oY69VQ6dkqkp+8xNS
         g1x/CUjGJnp+B6NqZFSQCkZ1p9Ah1syIL5osa4dTZY83RttPFZK1XSfwTHzqiF5GqdYy
         sWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643308; x=1773248108;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jqxAjOGyod7/O7Rt5aalLvtkAOhYLGvZLQM1WrCCkg=;
        b=QwEb5lRhDg+W3WlA+erL/WhzfugmmyBtQ+xQa36dOM30MGqn85ffsqvux//P7GSPq0
         Yuk6maA4Rck/az3QD6AdTv6BXaMZn5cq+4e6WdioicLdh3efinq75n2V4bVoAqW9hUd9
         ArA3Dr5n4E8kkEAMdRfuT9DVXYGb9yLWItX8xGlBgOw941I4a2Ig/UkmYJwHTSgdWUR/
         nLhFY7Ub/MpOB/0Uh+2MXQBKkK8Sme76ivdm8w00P9v5Tjqyp3VAKyhMvFpDkqvotzD6
         oh7dDmB3QROPgZ/e/bYVkwju1UPggDWIjvG1Wtinke+r7Wkd0o22bGQnxOXAbg/btoGy
         KfKw==
X-Gm-Message-State: AOJu0Yz+yTmkeckPqv6UpYS/S8NLGF/guvYqNF3HusGTrcoZWbnDnil4
	QGP5MGBnBUwbL/5MxPnQhefoLjwGqVRHwEd6bb7BxrMM0uY1gnk+qrIvwcLDFE4Gbyw=
X-Gm-Gg: ATEYQzxHbhj5CJFnMz/EaUxOt6foWHF1ADttQiVss1aB6T4WOWvREDlfmo+h3erJhU6
	3Ru4RAyV9HySuhE1BOKAiLzDV5sAvzLYbo7OS9q0Nv9NKnkLIg/Zr/kE8X8Pg1Mdj9MN2xZQvCY
	94Zp4dey/GWbtdUCykPQ92RIxRTKpgLYspmQlfFj83lwTX6/07XPusUmtbtQgfk0Q7XR0hCBh3x
	9UeOk1n/5Y0S2TrDul79c7VCNvUauh+fORMUtfJOKpHwgdK+KkS7nkg/6Yyot4GaTTz+fVGygMs
	sHJf+4zpOucCtTvYP1a4NsG4eGjBBNdROsmgUgUpX3VBTGrX+wYrLSNVvYsIHYG9x2FXIwCtCXr
	RrcSKWu+aCYVWvoMd5bII3aoj0PKPeJygXgJJumQ+bowGmqwpdDcB5tlN+KVbHjUpzdydLj1dOJ
	WaGSf5CUzdbPS5YtKtnt7gpBpAIGE8MSy5M9iBO8ag4NB2FdG+8Kou/NBtIqytlXBiCQ0YN4VWP
	8SzSBL73ts=
X-Received: by 2002:a05:600c:3483:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-48519880930mr49659225e9.17.1772643307802;
        Wed, 04 Mar 2026 08:55:07 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851889322bsm59693525e9.13.2026.03.04.08.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:07 -0800 (PST)
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
Subject: [PATCH v3 6.6.y 3/8] netfilter: nft_set_pipapo: prepare destroy
 function for on-demand clone
Message-ID: <1772643278.pipapo-v3.3@gmail.com>
Date: Wed, 04 Mar 2026 20:55:04 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: B5A67204C1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Action: no action

T25jZSBwcml2LT5jbG9uZSBjYW4gYmUgTlVMTCBpbiBjYXNlIG5vIGluc2VydGlvbnMvcmVtb3Zh
bHMgb2NjdXJyZWQKaW4gdGhlIGxhc3QgdHJhbnNhY3Rpb24gd2UgbmVlZCB0byBkcm9wIHNldCBl
bGVtZW50cyBmcm9tIHByaXYtPm1hdGNoCmlmIHByaXYtPmNsb25lIGlzIE5VTEwuCgpXaGlsZSBh
dCBpdCwgY29uZGVuc2UgdGhpcyBmdW5jdGlvbiBieSByZXVzaW5nIHRoZSBwaXBhcG9fZnJlZV9t
YXRjaApoZWxwZXIgaW5zdGVhZCBvZiBvcGVuLWNvZGVkIHZlcnNpb24uCgpUaGUgcmN1X2JhcnJp
ZXIoKSBpcyByZW1vdmVkLCBpdHMgbm90IG5lZWRlZDogb2xkIGNhbGxfcmN1IGluc3RhbmNlcwpm
b3IgcGlwYXBvX3JlY2xhaW1fbWF0Y2ggZG8gbm90IGFjY2VzcyBzdHJ1Y3QgbmZ0X3NldC4KClNp
Z25lZC1vZmYtYnk6IEZsb3JpYW4gV2VzdHBoYWwgPGZ3QHN0cmxlbi5kZT4KUmV2aWV3ZWQtYnk6
IFN0ZWZhbm8gQnJpdmlvIDxzYnJpdmlvQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBhYmxv
IE5laXJhIEF5dXNvIDxwYWJsb0BuZXRmaWx0ZXIub3JnPgotLS0KIG5ldC9uZXRmaWx0ZXIvbmZ0
X3NldF9waXBhcG8uYyB8IDI3ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0
L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jIGIvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFw
by5jCmluZGV4IDE1MGNhMzU3OWJmYi4uZDNmNDExY2QyYzExIDEwMDY0NAotLS0gYS9uZXQvbmV0
ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMKKysrIGIvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFw
by5jCkBAIC0yMjQwLDMzICsyMjQwLDE4IEBAIHN0YXRpYyB2b2lkIG5mdF9waXBhcG9fZGVzdHJv
eShjb25zdCBzdHJ1Y3QgbmZ0X2N0eCAqY3R4LAogewogCXN0cnVjdCBuZnRfcGlwYXBvICpwcml2
ID0gbmZ0X3NldF9wcml2KHNldCk7CiAJc3RydWN0IG5mdF9waXBhcG9fbWF0Y2ggKm07Ci0JaW50
IGNwdTsKIAogCW0gPSByY3VfZGVyZWZlcmVuY2VfcHJvdGVjdGVkKHByaXYtPm1hdGNoLCB0cnVl
KTsKLQlpZiAobSkgewotCQlyY3VfYmFycmllcigpOwotCi0JCWZvcl9lYWNoX3Bvc3NpYmxlX2Nw
dShjcHUpCi0JCQlwaXBhcG9fZnJlZV9zY3JhdGNoKG0sIGNwdSk7Ci0JCWZyZWVfcGVyY3B1KG0t
PnNjcmF0Y2gpOwotCQlwaXBhcG9fZnJlZV9maWVsZHMobSk7Ci0JCWtmcmVlKG0pOwotCQlwcml2
LT5tYXRjaCA9IE5VTEw7Ci0JfQogCiAJaWYgKHByaXYtPmNsb25lKSB7Ci0JCW0gPSBwcml2LT5j
bG9uZTsKLQotCQluZnRfc2V0X3BpcGFwb19tYXRjaF9kZXN0cm95KGN0eCwgc2V0LCBtKTsKLQot
CQlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KQotCQkJcGlwYXBvX2ZyZWVfc2NyYXRjaChwcml2
LT5jbG9uZSwgY3B1KTsKLQkJZnJlZV9wZXJjcHUocHJpdi0+Y2xvbmUtPnNjcmF0Y2gpOwotCi0J
CXBpcGFwb19mcmVlX2ZpZWxkcyhwcml2LT5jbG9uZSk7Ci0JCWtmcmVlKHByaXYtPmNsb25lKTsK
KwkJbmZ0X3NldF9waXBhcG9fbWF0Y2hfZGVzdHJveShjdHgsIHNldCwgcHJpdi0+Y2xvbmUpOwor
CQlwaXBhcG9fZnJlZV9tYXRjaChwcml2LT5jbG9uZSk7CiAJCXByaXYtPmNsb25lID0gTlVMTDsK
Kwl9IGVsc2UgeworCQluZnRfc2V0X3BpcGFwb19tYXRjaF9kZXN0cm95KGN0eCwgc2V0LCBtKTsK
IAl9CisKKwlwaXBhcG9fZnJlZV9tYXRjaChtKTsKIH0KIAogLyoqCi0tIAoyLjM0LjEKCg==

