Return-Path: <stable+bounces-223091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAkWEihnqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:08:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7AB204E24
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B60630D100D
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0937376BC4;
	Wed,  4 Mar 2026 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9vK/+it"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED86189F43
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643305; cv=none; b=ErPp7MVWEVhJQnN+Ngf0sFQo/gJVjox9E1GAwbLNSNJsiIA2iTWYC5jEUbEoXYWjYHaF+ULbUS7iNxHxdGGIs5MCVplU0HDgKiI1u9tE5Ty9sG71cjS4VdoS2lV0blMSrhKpq/UnVBRA9DGHNvPXJSi7b8PttRE2/4UCvm5883Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643305; c=relaxed/simple;
	bh=t4ircc/81h99+ybtT3a46mh7IGQ2m2jB2PvSSyO+nj4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=NcX/bgCk5Htho+x5UMsE0SjiDf2T8uig3luoHQyx9De9OtZUKwlrSBIHWH/xHDFBzRIVmHc+gpaz2m6TUW6W9niDJMBxw9+QGrvQSM9jRlJ4IB2PYXwh4A333HTM7mv7DlLUfqlIzphZdjgFMP5mJ7jUdL7YgkU41gsCa2frI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9vK/+it; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so58729755e9.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643302; x=1773248102; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4ircc/81h99+ybtT3a46mh7IGQ2m2jB2PvSSyO+nj4=;
        b=A9vK/+it8KXxvR8r/xf150E/guBztGGrraRW2ybV2FN5Dfx2VowULgyHWA4RcS/m90
         PpMsIdPkX1il4DR5RGJb7ClDFG5NDeIQOg8EywjOnJpO4MDCp0re7HiDzCAp4OspLRWI
         A/VYQZ23mvQv5estz5sPD2DxvZCCpjrUfA8fLVl6t1ondg66QnBGFmk84Ei4BHtLC11F
         mCXNh6N/cnNL0+GDxCy/H6LWY/7Br9TrxvGZ5ndnbDw8kko9L4pX4zG2floWZro+YVRP
         vlty6bc6Z0OAZDOBauTwUQxhmRo0LPywT/xB+EjMK/8e9O4dq5RKES3ItXvFD3Zrgjfi
         NU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643302; x=1773248102;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4ircc/81h99+ybtT3a46mh7IGQ2m2jB2PvSSyO+nj4=;
        b=BWcs1Y4N/Y2cIY3vHdZkQru23pOknEi0afgvFBb2Zomx4geieQ9GQdavf+do0ocGb3
         jeQEl/YS8Fg5i28ifehO5E8i6wqjsY/DQNAv2cuWi1BZveNTVTIr0sOEI6/r0FwP8b0R
         viUxuQxskdfMLEUJbpm0d9MDWkeOWJfaE1PSHlhEgpq/TGKZqid74zQ9RxcQF3tTxaZ+
         p5Fl89tMJKWEx18RkwIh48ONk2XnLZG5Kd9tuqg76ylx/R0+U9KL0hz1sGPNZoSVwywm
         AwKH+McVN4flsJyOQJC5Kt0wzsfIBctKhM1csQtFSrDbLAcxsA743jdVqel1AoCAL5HN
         4j+g==
X-Gm-Message-State: AOJu0YzUwzLCK0OEcIz6c0hGrJDrga+DbuVBduoRSGDF2QkfEE1n206o
	jO0I/Fpf96sHGTHFg6WL5Rm0YXDlFE48AcpCox8dXCWiCzo3kxjp3rNLhavy/a1+07M=
X-Gm-Gg: ATEYQzx4BTpnTgqY825ovy1Xv4qEK1fY0efqJWVaeckypn/WDTzxC0CGavgMdwEQlam
	h9yz0pmpDJhBrEUJZ8kbOp5mo8kwFru1ccHLANTmi12TyQ9mogs8XLg9BUzgqcxLiVuZ/8jfDxr
	GxMo3VhlkP8GHHm7VT6IIoGmIZv58iJbe1gyJCQsR+VJl4mTsIWvYuUtfDEaOUZ3iP4aUcHWqoi
	e8to1pD63usTTBoYiv/IUbEXfZUlyeGWXrZLCRbibkJcXzHsqw7vAbHRmd0wyqQKLy8RUNb5Fbm
	FRUeDRaEWmIlc4/cNe4JJAN15ewPHtCyP/mxsryGcBmhCFZZTiIEu8kfU7D6mTtDWQimhU07htJ
	AcERjf5u+F5Wk76IB7rfGFBzfUUSncxKp3RhQOq8DKYuf6fcq8Ztjp7pfmyYIJSsbpKGpNmbL43
	5cxhE/82CqWRaHvEEoNOhG/Xl8UfAr9pK99iMyEj0gKPl/WBi6CYQawq4oTxQfoEUPVhaARr9v
X-Received: by 2002:a05:600c:6099:b0:480:4ae2:def1 with SMTP id 5b1f17b1804b1-48519847dedmr53161865e9.13.1772643302356;
        Wed, 04 Mar 2026 08:55:02 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8e2413sm18706995e9.10.2026.03.04.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:02 -0800 (PST)
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
Subject: [PATCH v3 6.6.y 2/8] netfilter: nft_set_pipapo: make pipapo_clone
 helper return NULL
Message-ID: <1772643278.pipapo-v3.2@gmail.com>
Date: Wed, 04 Mar 2026 20:54:57 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: AF7AB204E24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223091-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,strlen.de:email]
X-Rspamd-Action: no action

Q3VycmVudGx5IGl0IHJldHVybnMgYW4gZXJyb3IgcG9pbnRlciwgYnV0IHRoZSBvbmx5IHBvc3Np
YmxlIGZhaWx1cmUKaXMgRU5PTUVNLgoKQWZ0ZXIgYSBmb2xsb3d1cCBwYXRjaCwgd2UnZCBuZWVk
IHRvIGRpc2NhcmQgdGhlIGVycm5vIGNvZGUsIGkuZS4KCnggPSBwaXBhcG9fY2xvbmUoKQppZiAo
SVNfRVJSKHgpKQoJcmV0dXJuIE5VTEwKCm9yIG1ha2UgbW9yZSBjaGFuZ2VzIHRvIGZpeCB1cCBj
YWxsZXJzIHRvIGV4cGVjdCBJU19FUlIoKSBjb2RlCmZyb20gc2V0LT5vcHMtPmRlYWN0aXZhdGUo
KS4KClNvIHNpbXBsaWZ5IHRoaXMgYW5kIG1ha2UgaXQgcmV0dXJuIHB0ci1vci1udWxsLgoKU2ln
bmVkLW9mZi1ieTogRmxvcmlhbiBXZXN0cGhhbCA8ZndAc3RybGVuLmRlPgpSZXZpZXdlZC1ieTog
U3RlZmFubyBCcml2aW8gPHNicml2aW9AcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGFibG8g
TmVpcmEgQXl1c28gPHBhYmxvQG5ldGZpbHRlci5vcmc+Ci0tLQogbmV0L25ldGZpbHRlci9uZnRf
c2V0X3BpcGFwby5jIHwgMTQgKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L25ldGZpbHRlci9uZnRf
c2V0X3BpcGFwby5jIGIvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jCmluZGV4IGQ5ZWRj
MDc2YThkMS4uMTUwY2EzNTc5YmZiIDEwMDY0NAotLS0gYS9uZXQvbmV0ZmlsdGVyL25mdF9zZXRf
cGlwYXBvLmMKKysrIGIvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jCkBAIC0xMzIxLDcg
KzEzMjEsNyBAQCBzdGF0aWMgaW50IG5mdF9waXBhcG9faW5zZXJ0KGNvbnN0IHN0cnVjdCBuZXQg
Km5ldCwgY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNldCwKICAqIHBpcGFwb19jbG9uZSgpIC0gQ2xv
bmUgbWF0Y2hpbmcgZGF0YSB0byBjcmVhdGUgbmV3IHdvcmtpbmcgY29weQogICogQG9sZDoJRXhp
c3RpbmcgbWF0Y2hpbmcgZGF0YQogICoKLSAqIFJldHVybjogY29weSBvZiBtYXRjaGluZyBkYXRh
IHBhc3NlZCBhcyAnb2xkJywgZXJyb3IgcG9pbnRlciBvbiBmYWlsdXJlCisgKiBSZXR1cm46IGNv
cHkgb2YgbWF0Y2hpbmcgZGF0YSBwYXNzZWQgYXMgJ29sZCcgb3IgTlVMTC4KICAqLwogc3RhdGlj
IHN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICpwaXBhcG9fY2xvbmUoc3RydWN0IG5mdF9waXBhcG9f
bWF0Y2ggKm9sZCkKIHsKQEAgLTEzMzEsNyArMTMzMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgbmZ0X3Bp
cGFwb19tYXRjaCAqcGlwYXBvX2Nsb25lKHN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICpvbGQpCiAK
IAluZXcgPSBrbWFsbG9jKHN0cnVjdF9zaXplKG5ldywgZiwgb2xkLT5maWVsZF9jb3VudCksIEdG
UF9LRVJORUwpOwogCWlmICghbmV3KQotCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKKwkJcmV0
dXJuIE5VTEw7CiAKIAluZXctPmZpZWxkX2NvdW50ID0gb2xkLT5maWVsZF9jb3VudDsKIAluZXct
PmJzaXplX21heCA9IG9sZC0+YnNpemVfbWF4OwpAQCAtMTM5Niw3ICsxMzk2LDcgQEAgc3RhdGlj
IHN0cnVjdCBuZnRfcGlwYXBvX21hdGNoICpwaXBhcG9fY2xvbmUoc3RydWN0IG5mdF9waXBhcG9f
bWF0Y2ggKm9sZCkKIAlmcmVlX3BlcmNwdShuZXctPnNjcmF0Y2gpOwogCWtmcmVlKG5ldyk7CiAK
LQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKKwlyZXR1cm4gTlVMTDsKIH0KIAogLyoqCkBAIC0x
NzE5LDcgKzE3MTksNyBAQCBzdGF0aWMgdm9pZCBuZnRfcGlwYXBvX2NvbW1pdChzdHJ1Y3QgbmZ0
X3NldCAqc2V0KQogCQlyZXR1cm47CiAKIAluZXdfY2xvbmUgPSBwaXBhcG9fY2xvbmUocHJpdi0+
Y2xvbmUpOwotCWlmIChJU19FUlIobmV3X2Nsb25lKSkKKwlpZiAoIW5ld19jbG9uZSkKIAkJcmV0
dXJuOwogCiAJcHJpdi0+ZGlydHkgPSBmYWxzZTsKQEAgLTE3NDMsNyArMTc0Myw3IEBAIHN0YXRp
YyB2b2lkIG5mdF9waXBhcG9fYWJvcnQoY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNldCkKIAltID0g
cmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChwcml2LT5tYXRjaCwgbmZ0X3BpcGFwb190cmFuc2Fj
dGlvbl9tdXRleF9oZWxkKHNldCkpOwogCiAJbmV3X2Nsb25lID0gcGlwYXBvX2Nsb25lKG0pOwot
CWlmIChJU19FUlIobmV3X2Nsb25lKSkKKwlpZiAoIW5ld19jbG9uZSkKIAkJcmV0dXJuOwogCiAJ
cHJpdi0+ZGlydHkgPSBmYWxzZTsKQEAgLTIxODMsOCArMjE4Myw4IEBAIHN0YXRpYyBpbnQgbmZ0
X3BpcGFwb19pbml0KGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpzZXQsCiAKIAkvKiBDcmVhdGUgYW4g
aW5pdGlhbCBjbG9uZSBvZiBtYXRjaGluZyBkYXRhIGZvciBuZXh0IGluc2VydGlvbiAqLwogCXBy
aXYtPmNsb25lID0gcGlwYXBvX2Nsb25lKG0pOwotCWlmIChJU19FUlIocHJpdi0+Y2xvbmUpKSB7
Ci0JCWVyciA9IFBUUl9FUlIocHJpdi0+Y2xvbmUpOworCWlmICghcHJpdi0+Y2xvbmUpIHsKKwkJ
ZXJyID0gLUVOT01FTTsKIAkJZ290byBvdXRfZnJlZTsKIAl9CiAKLS0gCjIuMzQuMQoK

