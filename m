Return-Path: <stable+bounces-223090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDk7Gk1lqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:01:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B33204C17
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 659AE300BE08
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE20374E54;
	Wed,  4 Mar 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boXc3kwV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0976374E73
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643298; cv=none; b=JOQkND3HDW2c2GxdgIwOi0uy0hkI4aZQVUQgmr3J8XNccL4xDk0e2D+lKzIkDznyU1WLOKg0xvpHJC2w/uijyICoFQuqWyEHTSeq9T5RhAceM7DHjpfr2Jfcdi7wnX8txZZQYK1i2g5zsMLLZAS9zGOtxfDoka424kWmrdrIGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643298; c=relaxed/simple;
	bh=iROaPJToKB3QQdQ4etsCxL09peaa5U72K78gyMZbpDQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=ceGSlNQlbEmbRXgiZbcyeN8L+IKJkObcJ9FDhjsn42Fmipi2yD5Yun7ecvL9gantzqvn99gDp6ZxduI4kv1iZNktKMAJmuQ2jJWAqChR+NAwoBqGXvPFkYiak7ZzUt6CnL5mprTP3SD1EzzvRtLMmhTxkvmY+6vnr8Vna0sKVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boXc3kwV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so85696955e9.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643295; x=1773248095; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iROaPJToKB3QQdQ4etsCxL09peaa5U72K78gyMZbpDQ=;
        b=boXc3kwVKKmXItZzTq9B+Eq7UhKb8ZZhOfP6cwFj+lCGoI+8lHEM4XLt622M7lBnJM
         lJvtTeVOmoJOfiNiWffWyENKfjXZEMugRGrDvYcB0iHa8GVg/PJFdWXDVmloU6IOHbq2
         AeauaRhxjdqCNz91W0YRNWcUn2t3nTbBvRNCPV49MTN42PoqITpO3XqA+TjuGKtGfOLz
         lx0a7vmuEzEjo1KtTH0Gs3H9gT4cmG+W2XLTtcXWC7MtgH2dkzrvz7R8+JXH5MFDKlpO
         s5EY3TNKmfrrNKqQmyTc6c817jd1NKFgDjouia9SkdpJI3jxZw2D1+2ienac+rOn3q0w
         UqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643295; x=1773248095;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iROaPJToKB3QQdQ4etsCxL09peaa5U72K78gyMZbpDQ=;
        b=lI+/gT4VrRxwAvjiPBFuNC6aJqLUVZrn7ZgBYsKRgWY6dlF59yJMGq2rBmHURQa2DH
         sjh/osCJsN6MYsSV5bjNk2P1Ot5iqKPgTqdqOLDr6BqX7uFtfL3GBpvu8iwTSNWAas/b
         L2HJzO7lyBwvFGyXhWvTqt2rOMBqEXT7P77AK0//BX+5bXXwoDXkGbthisbVki0a6VdM
         ++iqTpU+Vz/MEoDYmsqJgITTyNCrurLeJnEw0v3JZlIzkE6wAmcXK3T8f9iKQ1Nga6Eb
         Lg6GGXnApWh6DMAbXkd9tjaoF4Rtsg68QeDg2GVB17+QVKgweA3BqXkJAM885dlTkAG+
         /0mw==
X-Gm-Message-State: AOJu0Yy4u5PNPJJkQw7JyWarVlqlXLDjRE84BWim52A7k/Kvv80b6K4J
	5hPh82ppH5AjI2pFEUu5/qcaEDcTKHryt6yCSZpHDW6x0zoyKAKkYFGwqyejVid9SLA=
X-Gm-Gg: ATEYQzxarRXjow9E/fwUer7YSlqKR/CI4LVj6hNWf3CPlVkqwTPs9al9DH8qow9ZHQL
	//D9//zFrNOqPvKBr6Z97AWa/k+tpHN6RDZmiJ0iQlQvIHiN+lwdqliK61RMXhEszCiIqngu7Y6
	HOEvL/dbl/p8mKmB+O3igJRiibzMdYytxWRLJAUfSLXAtue6Qdz1XTWtcaFzV5hZntYrgmI3q+V
	KxQZmGrznif9rkV1LK1uLl20sbKdTdEgNsgkLioSm9f8FfW1ZAdOGRnIbjkN8xZEzbRn/I7Dkzm
	w+4V5Y8lFy7yFBdrMyiPECHJ3B5p/zbyW5pyFhpx8oNgd/wntJmM7ZQJujoeHko8Nj2NYJE4p97
	eXawPv+v3R3NREHCJ94DhknrIfjIR3zlWghTeDTnk04w8fx+d8w/80DmbRFQqXStfOBgZE51bd5
	ESO56K7GxZK2mK8QFDPPSWB8pUDDsAy2IO7x0gHFnehrTMam5sp/PFbsYptKvM8wEEfy6KuhF/
X-Received: by 2002:a05:600c:8105:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-48519840222mr46073795e9.10.1772643294753;
        Wed, 04 Mar 2026 08:54:54 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188122a6sm61766435e9.12.2026.03.04.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:54:54 -0800 (PST)
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
Subject: [PATCH v3 6.6.y 1/8] netfilter: nft_set_pipapo: move prove_locking
 helper around
Message-ID: <1772643278.pipapo-v3.1@gmail.com>
Date: Wed, 04 Mar 2026 20:54:46 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: B8B33204C17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223090-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natarajankv91@gmail.com,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[pablo.netfilter.org:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Action: no action

UHJlcGFyYXRpb24gcGF0Y2gsIHRoZSBoZWxwZXIgd2lsbCBzb29uIGdldCBjYWxsZWQgZnJvbSBp
bnNlcnQKZnVuY3Rpb24gdG9vLgoKU2lnbmVkLW9mZi1ieTogRmxvcmlhbiBXZXN0cGhhbCA8ZndA
c3RybGVuLmRlPgpSZXZpZXdlZC1ieTogU3RlZmFubyBCcml2aW8gPHNicml2aW9AcmVkaGF0LmNv
bT4KU2lnbmVkLW9mZi1ieTogUGFibG8gTmVpcmEgQXl1c28gPHBhYmxvQG5ldGZpbHRlci5vcmc+
Ci0tLQogbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jIHwgMjIgKysrKysrKysrKystLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYyBiL25ldC9uZXRm
aWx0ZXIvbmZ0X3NldF9waXBhcG8uYwppbmRleCA0Mjc0ODMxYjZlNjcuLmQ5ZWRjMDc2YThkMSAx
MDA2NDQKLS0tIGEvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jCisrKyBiL25ldC9uZXRm
aWx0ZXIvbmZ0X3NldF9waXBhcG8uYwpAQCAtMTE4MSw2ICsxMTgxLDE3IEBAIHN0YXRpYyBpbnQg
cGlwYXBvX3JlYWxsb2Nfc2NyYXRjaChzdHJ1Y3QgbmZ0X3BpcGFwb19tYXRjaCAqY2xvbmUsCiAJ
cmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBib29sIG5mdF9waXBhcG9fdHJhbnNhY3Rpb25fbXV0ZXhf
aGVsZChjb25zdCBzdHJ1Y3QgbmZ0X3NldCAqc2V0KQoreworI2lmZGVmIENPTkZJR19QUk9WRV9M
T0NLSU5HCisJY29uc3Qgc3RydWN0IG5ldCAqbmV0ID0gcmVhZF9wbmV0KCZzZXQtPm5ldCk7CisK
KwlyZXR1cm4gbG9ja2RlcF9pc19oZWxkKCZuZnRfcGVybmV0KG5ldCktPmNvbW1pdF9tdXRleCk7
CisjZWxzZQorCXJldHVybiB0cnVlOworI2VuZGlmCit9CisKIC8qKgogICogbmZ0X3BpcGFwb19p
bnNlcnQoKSAtIFZhbGlkYXRlIGFuZCBpbnNlcnQgcmFuZ2VkIGVsZW1lbnRzCiAgKiBAbmV0OglO
ZXR3b3JrIG5hbWVzcGFjZQpAQCAtMTcyMSwxNyArMTczMiw2IEBAIHN0YXRpYyB2b2lkIG5mdF9w
aXBhcG9fY29tbWl0KHN0cnVjdCBuZnRfc2V0ICpzZXQpCiAJcHJpdi0+Y2xvbmUgPSBuZXdfY2xv
bmU7CiB9CiAKLXN0YXRpYyBib29sIG5mdF9waXBhcG9fdHJhbnNhY3Rpb25fbXV0ZXhfaGVsZChj
b25zdCBzdHJ1Y3QgbmZ0X3NldCAqc2V0KQotewotI2lmZGVmIENPTkZJR19QUk9WRV9MT0NLSU5H
Ci0JY29uc3Qgc3RydWN0IG5ldCAqbmV0ID0gcmVhZF9wbmV0KCZzZXQtPm5ldCk7Ci0KLQlyZXR1
cm4gbG9ja2RlcF9pc19oZWxkKCZuZnRfcGVybmV0KG5ldCktPmNvbW1pdF9tdXRleCk7Ci0jZWxz
ZQotCXJldHVybiB0cnVlOwotI2VuZGlmCi19Ci0KIHN0YXRpYyB2b2lkIG5mdF9waXBhcG9fYWJv
cnQoY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNldCkKIHsKIAlzdHJ1Y3QgbmZ0X3BpcGFwbyAqcHJp
diA9IG5mdF9zZXRfcHJpdihzZXQpOwotLSAKMi4zNC4xCgo=

