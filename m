Return-Path: <stable+bounces-223094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QfLLEvtjqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:55:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EC204AEB
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84FF83011374
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E24376BC1;
	Wed,  4 Mar 2026 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEH2oH6A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC3361647
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643321; cv=none; b=RbCi1ti5wPbTDJ/Oj5ddklzTUpsCuS7fyQ/MvkBfRUoYhydwMQalJfNnIWKZSIepS0aT5AMLee2In1IYflq8iuTQJ1jEFTiSro6pEXTjT3Jd183TP0K91fUOqg5zAkl6HaNTIaQGJNgytRFbgYZb4ovO9OKr8yhW4VoEyxXnHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643321; c=relaxed/simple;
	bh=dVoZIIQGrlG5NeQ+bfzYYbYAE1DZ7tyKSZa5HzAj2uc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=RxumNaR6nykHcE/EXHwU42P4W7x7VTgSvdjl6WRud3vhzJsu0CqE7XC1pbU5nRzrY/VzKEfpXZ6hn41ATQdgu3KoDcrNGvwtacBgG8dAulEAx6KeHI6jSKFm77oueZdxKm9vMNONZjzpLd4yGwK0UOfCmRJgtzo74MW/Cd0EYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEH2oH6A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483703e4b08so68224625e9.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643319; x=1773248119; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVoZIIQGrlG5NeQ+bfzYYbYAE1DZ7tyKSZa5HzAj2uc=;
        b=NEH2oH6AUbhe7zrzoi9VSqsMc/DTvWjkAjf798LAxfndRc6/BU9jBAiV9aCyJwhaj1
         KETwQtoaeS8dKIJ7Q+lpo0+OxHn9OTkA7wWdN1ZCGuSKNpvAjHPuJwVyl1tCnIEKw3ko
         TuA/wpgdqG6CyYuTUfVhJW2vdsHoTO1y2Kp32rtNKKwMn6+Xc2YwdO+VgCYmIJUGpGP+
         Pbrpc22f2jK0ooqdzqBexoVxJ0DulirvK974z4o6zNLjQK3r9CXAf8KfEvEOP/Yg2IpI
         ReA8m2u1rINFfyuCILKEQ3ZzOR2aWl4Can7z76A/pUwPu4uTjMoB9EidalQTdc37L3AG
         q6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643319; x=1773248119;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVoZIIQGrlG5NeQ+bfzYYbYAE1DZ7tyKSZa5HzAj2uc=;
        b=Pol6Q+wy3T7CauCODXC2Xx1/U+3Lq9aQfoI7ebhFKdyfqNbzdHKZR7o7nxUnsZO6Gb
         X4u/6/NsIG9UaK2hSt7tOR+25TsGe638rvYVyaqp6vLsPODxu5T2MyJ4s2zgAVMwVwU+
         7oTRdr4YvKwfqHIB86dkZXE/Wj95SevMAkQiYWhKGWKAPpa9kLRMTZFBfh7YNNU+GxB+
         GFvgAgr+waC4RYvHReSIoAx8wEw2I/K9PthlijRPAzTwdVIx8rrGZh1lfLgCX7EnHvX8
         6z+GzmW7yyyMuYlLRUwzx5vzJrUFPLD57hbckVkfxr7cgegEYsA0Gm/2Mxa/UYrgsG3L
         UyRg==
X-Gm-Message-State: AOJu0YydGZnHKp4B765O+73DTyCTXIxAPsOe25WaArKl05DrBVSF0qhG
	hKAhD9CmrWiCFcM2+6cPjLHhLT3NpS/dNLMVHjQrx7Bv7Hv2vTYfKG/OrZx4JzMiBRo=
X-Gm-Gg: ATEYQzwEI0ovnEMnZ/5pJL6ArVQj4bkdDaxZOsveyf1EPkj7QALnO77ZImmqzTE225z
	gToYUXZHLE+YGOikNm1K+KnAlSMjnEtAvdkSRkpuB+flrMhUXvCNLFFEQjQCg6uUKByui1p8st3
	mFrBpYV9Vixm6D8e0fboUMZ4kFWn2viz6v6LcXXLvTnXHjifLiOPLTzKfbZJDFJ8OvcNwkEULHi
	eENy0uD/+Fv62dnlGxCWw4VJa/GxnXH8Oxu1uInQSsPmtIapkc6PsKhjPQzzcjGkFJ1hGZP7OO4
	gjN86iY9UQ3d4A73AYunhBC3HuLMmjQ69e2y0gh8LipSKrVYHS9zh0XnshMLcHy3AKAbQ4VccXU
	lREt9VhSNi7NL803+9scGe9XUksUPugp66ifH5+uE/eoMT7zdLPVGpWDUHyrf7c6tkcsD5zhRxi
	w702BNBEV1paESET5yy6Sq5ufAeXEG2jdSINjZXk0MigqsnsUFVjgeoF3SDo6NoulxMszI6+kMG
	R6Mc0CZuZ0=
X-Received: by 2002:a05:600c:3542:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-485198ee3admr44895065e9.14.1772643318667;
        Wed, 04 Mar 2026 08:55:18 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187c2ef2sm63839585e9.5.2026.03.04.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:18 -0800 (PST)
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
Subject: [PATCH v3 6.6.y 5/8] netfilter: nft_set_pipapo: merge deactivate
 helper into caller
Message-ID: <1772643278.pipapo-v3.5@gmail.com>
Date: Wed, 04 Mar 2026 20:55:15 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: 1F1EC204AEB
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
	TAGGED_FROM(0.00)[bounces-223094-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

QWRhcHRhdGlvbiBvZiBjb21taXQgYzU0NDQ3ODZkMGVhICgibmV0ZmlsdGVyOiBuZnRfc2V0X3Bp
cGFwbzogbWVyZ2UKZGVhY3RpdmF0ZSBoZWxwZXIgaW50byBjYWxsZXIiKSB0byA2LjYuMTIyLgoK
SW4gNi42LjEyMiwgbmZ0X3BpcGFwb19mbHVzaCgpIHN0aWxsIHVzZXMgcGlwYXBvX2RlYWN0aXZh
dGUoKSBkdWUgdG8KdGhlIG9sZGVyIEFQSSAobm8gZWxlbV9wcml2KSwgc28gdGhlIGhlbHBlciBp
cyBrZXB0LiBPbmx5IGRvYyBjb21tZW50cwphcmUgdXBkYXRlZC4KClNpZ25lZC1vZmYtYnk6IEZs
b3JpYW4gV2VzdHBoYWwgPGZ3QHN0cmxlbi5kZT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gQnJpdmlv
IDxzYnJpdmlvQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBhYmxvIE5laXJhIEF5dXNvIDxw
YWJsb0BuZXRmaWx0ZXIub3JnPgpTaWduZWQtb2ZmLWJ5OiBOYXRhcmFqYW4gS1YgPG5hdGFyYWph
bmt2OTFAZ21haWwuY29tPgotLS0KIG5ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYyB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMgYi9uZXQvbmV0ZmlsdGVy
L25mdF9zZXRfcGlwYXBvLmMKaW5kZXggMDAxZTRjZTBiYjZhLi5jYjYwNTNmOTZlODcgMTAwNjQ0
Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYworKysgYi9uZXQvbmV0ZmlsdGVy
L25mdF9zZXRfcGlwYXBvLmMKQEAgLTE4MDAsNyArMTgwMCw3IEBAIHN0YXRpYyB2b2lkICpwaXBh
cG9fZGVhY3RpdmF0ZShjb25zdCBzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBuZnRfc2V0
ICpzZXQsCiB9CiAKIC8qKgotICogbmZ0X3BpcGFwb19kZWFjdGl2YXRlKCkgLSBDYWxsIHBpcGFw
b19kZWFjdGl2YXRlKCkgdG8gbWFrZSBlbGVtZW50IGluYWN0aXZlCisgKiBuZnRfcGlwYXBvX2Rl
YWN0aXZhdGUoKSAtIFNlYXJjaCBmb3IgZWxlbWVudCBhbmQgbWFrZSBpdCBpbmFjdGl2ZQogICog
QG5ldDoJTmV0d29yayBuYW1lc3BhY2UKICAqIEBzZXQ6CW5mdGFibGVzIEFQSSBzZXQgcmVwcmVz
ZW50YXRpb24KICAqIEBlbGVtOgluZnRhYmxlcyBBUEkgZWxlbWVudCByZXByZXNlbnRhdGlvbiBj
b250YWluaW5nIGtleSBkYXRhCkBAIC0xODE3LDcgKzE4MTcsNyBAQCBzdGF0aWMgdm9pZCAqbmZ0
X3BpcGFwb19kZWFjdGl2YXRlKGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwKIH0KIAogLyoqCi0gKiBu
ZnRfcGlwYXBvX2ZsdXNoKCkgLSBDYWxsIHBpcGFwb19kZWFjdGl2YXRlKCkgdG8gbWFrZSBlbGVt
ZW50IGluYWN0aXZlCisgKiBuZnRfcGlwYXBvX2ZsdXNoKCkgLSBtYWtlIGVsZW1lbnQgaW5hY3Rp
dmUKICAqIEBuZXQ6CU5ldHdvcmsgbmFtZXNwYWNlCiAgKiBAc2V0OgluZnRhYmxlcyBBUEkgc2V0
IHJlcHJlc2VudGF0aW9uCiAgKiBAZWxlbToJbmZ0YWJsZXMgQVBJIGVsZW1lbnQgcmVwcmVzZW50
YXRpb24gY29udGFpbmluZyBrZXkgZGF0YQotLSAKMi4zNC4xCgo=

