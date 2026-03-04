Return-Path: <stable+bounces-223093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMArEftjqGmduAAAu9opvQ
	(envelope-from <stable+bounces-223093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:55:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC227204AEA
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1027E30107AF
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1A37756C;
	Wed,  4 Mar 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZBp1WQS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6F376460
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643318; cv=none; b=gkbjxhPmu2qCf97So4pkVm0Osh3lZvacO2nD7mIwZVHOEVjor28sih2anOORc49ydT1YAclh9bR3hvUL339EOd3JzuoEQYxRwAIBreukgv3v8aF4ThBbpEWElZPCIk6hmjWZSC3sO8UwFel10HFJtBWu0rTntHmfXKUc7lx4nMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643318; c=relaxed/simple;
	bh=4/IAebCFIFNUeJMlEqyL3tzRqukUet9ki6nWFKYcn1k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=esm0cQmsaY27/A3nJNXYdIgJeeR2YbnghdQ/wwtlu/G+sFD7m9K2VTnrfS3sNjaAAMTQ6cwEbA24+8rdvRJlPrS6BYuagN2QOi3rKusGd1A4Gx0DEE8Fp2ordiOC4FKPPR++pCIoOC7+RtCZzhZByN2fBYpXJP3Q10rNWhCWGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZBp1WQS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483bd7354efso94825545e9.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643313; x=1773248113; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/IAebCFIFNUeJMlEqyL3tzRqukUet9ki6nWFKYcn1k=;
        b=cZBp1WQSghj+npleA7jcWjH6ZzcBhZ2vN9MreZQpXy4pvPJfUkwo85S9AnKBUYzaEJ
         JWOLNrX1tvns+zsLHDtaVeDYrqNG5hntjhc/8xyTMdcDUNGwU74CsskFyeKBnKq8bw/f
         eH40tIn4fLyJRGV3K7xWDPnvJsUVDkLALM16EjgXniUz56RZcQERuVJgWzz9peCrH8WI
         +l4OArrHF+HnY0M1Qw1wlXyaQMnNmAI+702wwwB/tFSWJjYt8r/zVbTrMNrQsAnDu5ob
         6LccooWJfbq4r6GGF1HdzDdQxaxL2khYIeCpCCHlyG5Uv3EWxAhexRXkE6884Pj47fv0
         /O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643313; x=1773248113;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/IAebCFIFNUeJMlEqyL3tzRqukUet9ki6nWFKYcn1k=;
        b=kLpBrgkf0EEZEKUAGxfzO3eD94gv/iuJIi+i7GenTLwNUNy2ZqZwBCguk1f+P+bapO
         yF731PFPc4B3s/v4pxaBlNnU11BLgP3hzODwkpsF8gb5ISuFiyeL9TyMedkorcJpUh8x
         sufJj1wATvxPG3+cvfIgfFWGhXx5pISLxQZLPJX/vCJyWuvL6fmnGhhOLZwHA0csXm67
         6U/TQQqo+Ew5yftuqtQEkC+GHCHVD/NVDH+7x+2stP+b6w8qj8W24Xx/VuOc5Dwl+mw/
         ETgSf6xGRcvHj9BKCvujW4X+UNrKwlhfUoLkulmrGfb3T5uYb7tmV5Alf+R5RkdtLv43
         m5Fg==
X-Gm-Message-State: AOJu0YzjLP9hw4zyOMGoSKUa552H94bKh8XfFKKFd62pYjHFnmjrFbHb
	xFk2y3UvXH8YQGs3NjaxrI6MFg/ky1AGdsaoZmz8YD8cMQOZjLMjfJBgNFxoz4DAFIk=
X-Gm-Gg: ATEYQzzQEdMKXFHjqjgXzrq6IT+QohpgcYmARpbCKqsanFV8G6DQ6xpVieNsJMszrqZ
	cGUhDcPWBfFEitAs71/8BL4TrcoIJmppDZ6ekdCCA9a0/Juu1DItX58reejTuZVKlxjYja9x3dO
	yqYE1YclOEpHX+ASdApiLIpNvLpQcAC1mRHvHf7ZscDFCHUWpIN/2FokGwrzA6WWTXDJQGyrDBZ
	OHyHIaO1clL/u5inJA/vDP99WENcDX4mN0f8o7N6UzUIHS1qhsddMUzKDVVOo1KTzmNUu5Xtocv
	f+n1/e5qYWKYxcvjFdZrab2+gNbsQpiEeiMnfuJ8wx2/YLKR/w91C/o2uyVyXGY1F6EabKs8miz
	PSy0v13jkH+6JvrJhUPPEyIZJw7blNrrQ4XVbB56281ahlMcPzBcaQLtmPxNrsK+uN3FFA9XkCA
	GHddOL6WYYthBKm1BkHsIxNcefJaFZVKkKTmxlWdZzth6Mv6ztuQi0ZmfDRR52Tr/pG8Rzvuch
X-Received: by 2002:a05:600c:4e56:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-48519886e9bmr45209685e9.17.1772643313262;
        Wed, 04 Mar 2026 08:55:13 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acfe884sm22044825e9.7.2026.03.04.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:13 -0800 (PST)
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
Subject: [PATCH v3 6.6.y 4/8] netfilter: nft_set_pipapo: prepare walk function
 for on-demand clone
Message-ID: <1772643278.pipapo-v3.4@gmail.com>
Date: Wed, 04 Mar 2026 20:55:10 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: DC227204AEA
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
	TAGGED_FROM(0.00)[bounces-223093-lists,stable=lfdr.de];
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

VGhlIGV4aXN0aW5nIGNvZGUgdXNlcyBpdGVyLT50eXBlIHRvIGZpZ3VyZSBvdXQgd2hhdCBkYXRh
IGlzIG5lZWRlZCwgdGhlCmxpdmUgY29weSAoUkVBRCkgb3IgY2xvbmUgKFVQREFURSkuCgpXaXRo
b3V0IHBlbmRpbmcgdXBkYXRlcywgcHJpdi0+Y2xvbmUgYW5kIHByaXYtPm1hdGNoIHdpbGwgcG9p
bnQgdG8KZGlmZmVyZW50IG1lbW9yeSBsb2NhdGlvbnMsIGJ1dCB0aGV5IGhhdmUgaWRlbnRpY2Fs
IGNvbnRlbnQuCgpGdXR1cmUgcGF0Y2ggd2lsbCBtYWtlIHByaXYtPmNsb25lID09IE5VTEwgaWYg
dGhlcmUgYXJlIG5vIHBlbmRpbmcgY2hhbmdlcywKaW4gdGhpcyBjYXNlIHdlIG11c3QgY29weSB0
aGUgbGl2ZSBkYXRhIGZvciB0aGUgVVBEQVRFIGNhc2UuCgpDdXJyZW50bHkgdGhpcyB3b3VsZCBy
ZXF1aXJlIEdGUF9BVE9NSUMgYWxsb2NhdGlvbi4gIFNwbGl0IHRoZSB3YWxrCmZ1bmN0aW9uIGlu
IHR3byBwYXJ0czogb25lIHRoYXQgZG9lcyB0aGUgd2FsayBhbmQgb25lIHRoYXQgZGVjaWRlcyB3
aGljaApkYXRhIGlzIG5lZWRlZC4KCkluIHRoZSBVUERBVEUgY2FzZSwgY2FsbGVycyBob2xkIHRo
ZSB0cmFuc2FjdGlvbiBtdXRleCBzbyB3ZSBkbyBub3QgbmVlZAp0aGUgcmN1IHJlYWQgbG9jay4g
IFRoaXMgYWxsb3dzIHRvIHVzZSBHRlBfS0VSTkVMIGFsbG9jYXRpb24gd2hpbGUKY2xvbmluZy4K
ClNpZ25lZC1vZmYtYnk6IEZsb3JpYW4gV2VzdHBoYWwgPGZ3QHN0cmxlbi5kZT4KUmV2aWV3ZWQt
Ynk6IFN0ZWZhbm8gQnJpdmlvIDxzYnJpdmlvQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBh
YmxvIE5laXJhIEF5dXNvIDxwYWJsb0BuZXRmaWx0ZXIub3JnPgotLS0KIG5ldC9uZXRmaWx0ZXIv
bmZ0X3NldF9waXBhcG8uYyB8IDYwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMgYi9uZXQvbmV0ZmlsdGVyL25m
dF9zZXRfcGlwYXBvLmMKaW5kZXggZDNmNDExY2QyYzExLi4wMDFlNGNlMGJiNmEgMTAwNjQ0Ci0t
LSBhL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYworKysgYi9uZXQvbmV0ZmlsdGVyL25m
dF9zZXRfcGlwYXBvLmMKQEAgLTIwMjcsMzUgKzIwMjcsMjMgQEAgc3RhdGljIHZvaWQgbmZ0X3Bp
cGFwb19yZW1vdmUoY29uc3Qgc3RydWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QgbmZ0X3NldCAq
c2V0LAogfQogCiAvKioKLSAqIG5mdF9waXBhcG9fd2FsaygpIC0gV2FsayBvdmVyIGVsZW1lbnRz
CisgKiBuZnRfcGlwYXBvX2RvX3dhbGsoKSAtIFdhbGsgb3ZlciBlbGVtZW50cyBpbiBtCiAgKiBA
Y3R4OgluZnRhYmxlcyBBUEkgY29udGV4dAogICogQHNldDoJbmZ0YWJsZXMgQVBJIHNldCByZXBy
ZXNlbnRhdGlvbgorICogQG06CQltYXRjaGluZyBkYXRhIHBvaW50aW5nIHRvIGtleSBtYXBwaW5n
IGFycmF5CiAgKiBAaXRlcjoJSXRlcmF0b3IKICAqCiAgKiBBcyBlbGVtZW50cyBhcmUgcmVmZXJl
bmNlZCBpbiB0aGUgbWFwcGluZyBhcnJheSBmb3IgdGhlIGxhc3QgZmllbGQsIGRpcmVjdGx5CiAg
KiBzY2FuIHRoYXQgYXJyYXk6IHRoZXJlJ3Mgbm8gbmVlZCB0byBmb2xsb3cgcnVsZSBtYXBwaW5n
cyBmcm9tIHRoZSBmaXJzdAotICogZmllbGQuCisgKiBmaWVsZC4gQG0gaXMgcHJvdGVjdGVkIGVp
dGhlciBieSBSQ1UgcmVhZCBsb2NrIG9yIGJ5IHRyYW5zYWN0aW9uIG11dGV4LgogICovCi1zdGF0
aWMgdm9pZCBuZnRfcGlwYXBvX3dhbGsoY29uc3Qgc3RydWN0IG5mdF9jdHggKmN0eCwgc3RydWN0
IG5mdF9zZXQgKnNldCwKLQkJCSAgICBzdHJ1Y3QgbmZ0X3NldF9pdGVyICppdGVyKQorc3RhdGlj
IHZvaWQgbmZ0X3BpcGFwb19kb193YWxrKGNvbnN0IHN0cnVjdCBuZnRfY3R4ICpjdHgsIHN0cnVj
dCBuZnRfc2V0ICpzZXQsCisJCQkgICAgICAgY29uc3Qgc3RydWN0IG5mdF9waXBhcG9fbWF0Y2gg
Km0sCisJCQkgICAgICAgc3RydWN0IG5mdF9zZXRfaXRlciAqaXRlcikKIHsKLQlzdHJ1Y3QgbmZ0
X3BpcGFwbyAqcHJpdiA9IG5mdF9zZXRfcHJpdihzZXQpOwotCWNvbnN0IHN0cnVjdCBuZnRfcGlw
YXBvX21hdGNoICptOwogCWNvbnN0IHN0cnVjdCBuZnRfcGlwYXBvX2ZpZWxkICpmOwogCWludCBp
LCByOwogCi0JV0FSTl9PTl9PTkNFKGl0ZXItPnR5cGUgIT0gTkZUX0lURVJfUkVBRCAmJgotCQkg
ICAgIGl0ZXItPnR5cGUgIT0gTkZUX0lURVJfVVBEQVRFKTsKLQotCXJjdV9yZWFkX2xvY2soKTsK
LQlpZiAoaXRlci0+dHlwZSA9PSBORlRfSVRFUl9SRUFEKQotCQltID0gcmN1X2RlcmVmZXJlbmNl
KHByaXYtPm1hdGNoKTsKLQllbHNlCi0JCW0gPSBwcml2LT5jbG9uZTsKLQotCWlmICh1bmxpa2Vs
eSghbSkpCi0JCWdvdG8gb3V0OwotCiAJZm9yIChpID0gMCwgZiA9IG0tPmY7IGkgPCBtLT5maWVs
ZF9jb3VudCAtIDE7IGkrKywgZisrKQogCQk7CiAKQEAgLTIwNzUsMTQgKzIwNjMsNDQgQEAgc3Rh
dGljIHZvaWQgbmZ0X3BpcGFwb193YWxrKGNvbnN0IHN0cnVjdCBuZnRfY3R4ICpjdHgsIHN0cnVj
dCBuZnRfc2V0ICpzZXQsCiAKIAkJaXRlci0+ZXJyID0gaXRlci0+Zm4oY3R4LCBzZXQsIGl0ZXIs
ICZlbGVtKTsKIAkJaWYgKGl0ZXItPmVyciA8IDApCi0JCQlnb3RvIG91dDsKKwkJCXJldHVybjsK
IAogY29udDoKIAkJaXRlci0+Y291bnQrKzsKIAl9Cit9CiAKLW91dDoKLQlyY3VfcmVhZF91bmxv
Y2soKTsKKy8qKgorICogbmZ0X3BpcGFwb193YWxrKCkgLSBXYWxrIG92ZXIgZWxlbWVudHMKKyAq
IEBjdHg6CW5mdGFibGVzIEFQSSBjb250ZXh0CisgKiBAc2V0OgluZnRhYmxlcyBBUEkgc2V0IHJl
cHJlc2VudGF0aW9uCisgKiBAaXRlcjoJSXRlcmF0b3IKKyAqCisgKiBUZXN0IGlmIGRlc3RydWN0
aXZlIGFjdGlvbiBpcyBuZWVkZWQgb3Igbm90LCBjbG9uZSBhY3RpdmUgYmFja2VuZCBpZiBuZWVk
ZWQKKyAqIGFuZCBjYWxsIHRoZSByZWFsIGZ1bmN0aW9uIHRvIHdvcmsgb24gdGhlIGRhdGEuCisg
Ki8KK3N0YXRpYyB2b2lkIG5mdF9waXBhcG9fd2Fsayhjb25zdCBzdHJ1Y3QgbmZ0X2N0eCAqY3R4
LCBzdHJ1Y3QgbmZ0X3NldCAqc2V0LAorCQkJICAgIHN0cnVjdCBuZnRfc2V0X2l0ZXIgKml0ZXIp
Cit7CisJc3RydWN0IG5mdF9waXBhcG8gKnByaXYgPSBuZnRfc2V0X3ByaXYoc2V0KTsKKwljb25z
dCBzdHJ1Y3QgbmZ0X3BpcGFwb19tYXRjaCAqbTsKKworCXN3aXRjaCAoaXRlci0+dHlwZSkgewor
CWNhc2UgTkZUX0lURVJfVVBEQVRFOgorCQltID0gcHJpdi0+Y2xvbmU7CisJCW5mdF9waXBhcG9f
ZG9fd2FsayhjdHgsIHNldCwgbSwgaXRlcik7CisJCWJyZWFrOworCWNhc2UgTkZUX0lURVJfUkVB
RDoKKwkJcmN1X3JlYWRfbG9jaygpOworCQltID0gcmN1X2RlcmVmZXJlbmNlKHByaXYtPm1hdGNo
KTsKKwkJbmZ0X3BpcGFwb19kb193YWxrKGN0eCwgc2V0LCBtLCBpdGVyKTsKKwkJcmN1X3JlYWRf
dW5sb2NrKCk7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCWl0ZXItPmVyciA9IC1FSU5WQUw7CisJ
CVdBUk5fT05fT05DRSgxKTsKKwkJYnJlYWs7CisJfQogfQogCiAvKioKLS0gCjIuMzQuMQoK

