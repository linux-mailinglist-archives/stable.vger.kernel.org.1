Return-Path: <stable+bounces-273177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x0gaABfBUGpQ4gIAu9opvQ
	(envelope-from <stable+bounces-273177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 11:53:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DEA739486
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 11:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=starlabs-sg.20251104.gappssmtp.com header.s=20251104 header.b=r0BRXBuG;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=starlabs.sg (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273177-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273177-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CFCC30A2C34
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7C3F8245;
	Fri, 10 Jul 2026 09:34:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7EC3F4DE0
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:34:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676077; cv=none; b=cUViDKgTZhc3s8Diy1ErVvdkUyH5V8Q8bS02zQpF18ohyF95QpwXeP9A83kJWsPJ/OLXEZQ4Hv5UUFzu7QCtd5byHrUHX+DRbia9diyfcMtmfzzbBwFc0QKkY32mb/TJQEUTJgUu0FYr2so8c/jm1h4zr5t813IxksYc3rG61DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676077; c=relaxed/simple;
	bh=gk/Ly+VOdTlozILkyIXx25UNv6a0Ie7o/tS0LPDPWYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiW9ED9vrM6xtodoSIvqShgnMUvFAgKuDNmQezvyRExY067J17nphEuWuWyyKTwXj0Qk21+Y0eaCZ5VsX0+kxKINK5hJjfvrb2a0Gos5yKT3yDb8pHfPvjE2/b1milJrW3WtnUs4A+re7o2Sk+gaI/wgkTU/gyjjzWeHJEpX4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b=r0BRXBuG; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso739167b3a.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20251104.gappssmtp.com; s=20251104; t=1783676073; x=1784280873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrSY6cgMwW3xQnZDAd/GUTYiSszR+F3mzsF9ozQGQpA=;
        b=r0BRXBuGtIYnqP4QnskYJv82g49+PywpV7xsqL8WQ1V/8A/SgFUK7K012Wfr/w7J3D
         zADB9pT3Y9i+IPb6tLhApnKxZM2HOXFfWl6YPf8Zm/4RV3F/kiXSZv+SFjsqww/J6mah
         xUGwrUNIkkiNx6j2zzSR8ixswy8m4wfQBZx1CFhf4BUiWRlnVIiP9wIHSVKZpb1xmVBs
         BIzYUabR0A7V2Uuovy/gyvoCbfYJhKfaFkObDvBzIb0uscQA1zvtzK7NPVGQnoIQlQQB
         h5RGkXyB2XidVOo+SIVRpI41fjpdjFz9N+vmsHNN7ZLlDXESjwneqgR4P4s48W+zODg6
         HlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676073; x=1784280873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrSY6cgMwW3xQnZDAd/GUTYiSszR+F3mzsF9ozQGQpA=;
        b=W3LYXWjL642hJW3dQ9RIP2KHSlGlztQul+ZdWzJynRBSlsSGdRsmxH07lHzV9yEwvK
         hPUNw+rTHC6FfoTcqIlJkJWn7qTKaIKCNl3TsOTMAUO+yTXes8H/VbvekXNk4gNxgU5U
         vShiT+3JgGK/7P5iSrIBOjfBJfEzA5i5keFWju/xc54/ebhOS6MU1Jb9JK7hj3iRq/WJ
         mrLGEPV8bI6d1d4VygnTtkd02EaQ4RC/M14fRLpytRvbSN5949zsiirkz5Y/eRhDqAOJ
         Znwht4n0g4eAo2CuHk3zQg1gmL4F33rbecVKcQ4Bwo01yQR80YREuA4MevSjif/SDo/y
         L8Ew==
X-Forwarded-Encrypted: i=1; AHgh+RpVCKNs/6FSAghgYPjvBsrtCXFNk4/3NQDVjnZMPpm4fz1ir/pE0W3vRgneU+hyKdo3DIEUaq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrELGo8YMZTNAot6/WEvw8ZAnpekvXHkHwI/CN5Mcc0RtZj79Z
	ASGATYBgYb4F1zKr8tk204liZ1S0jCAJPUKCRIBTgooi20q7HmNJa2QACl2BNj7ioew=
X-Gm-Gg: AfdE7cl4GQfpJHhiXMoDQVYVpk5ndOzdooGitPIeFKGux1Ff0KN5hurkRETpBP1IWUC
	zofA2DyxXzqgSr3AxbohG2eMroYGAE9amxrBswCT6l+f1XbdDMH+SGRWPwWof8DMP5SQXeosUHO
	A+vS5yWuIDacM+wrIXYLq3ERDZHmJoq1DMw4UDeLQcevzJVF9MvXlvDw5z9dndcGieBemYVO/zP
	nI+QpYMyXXwWpiF15tZm64kQe2GHpkpGSTpR0h9GU1HpOtor1PclfwQfKdHUfR0SgX6iT18tLah
	KxGGSiASNTNQ0FfoCgCVzsrH9mNr4LLrz02WuAF3Qy3nlrUyEM0v1er/dVfuL7OKOrW5O/vQmeI
	9Vjp8uQTKLvj+8J0XU/i8B4anQedTukMz01HbrVj06xQ3LTWbKf90ePWM/7RBbpUNse0y1iP176
	f/EMaaNmp34Tll
X-Received: by 2002:a05:6a00:3988:b0:848:2f84:732 with SMTP id d2e1a72fcca58-8484303d498mr9875898b3a.69.1783676073080;
        Fri, 10 Jul 2026 02:34:33 -0700 (PDT)
Received: from localhost ([49.245.21.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm134544b3a.20.2026.07.10.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:34:32 -0700 (PDT)
From: Lee Jia Jie <jiajie.lee@starlabs.sg>
To: w@1wt.eu
Cc: info@starlabs.sg,
	security@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	Lee Jia Jie <jiajie.lee@starlabs.sg>,
	stable@vger.kernel.org
Subject: [PATCH] perf/aux: Fix page UAF in map_range()
Date: Fri, 10 Jul 2026 17:33:21 +0800
Message-ID: <20260710093321.14764-1-jiajie.lee@starlabs.sg>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <alBkCyY6VCbtWW0z@1wt.eu>
References: <alBkCyY6VCbtWW0z@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[starlabs-sg.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[starlabs.sg : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:info@starlabs.sg,m:security@kernel.org,m:acme@kernel.org,m:mingo@redhat.com,m:namhyung@kernel.org,m:peterz@infradead.org,m:jiajie.lee@starlabs.sg,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiajie.lee@starlabs.sg,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273177-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiajie.lee@starlabs.sg,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[starlabs-sg.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,starlabs-sg.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6DEA739486

map_range() reads rb->aux_pages[], rb->aux_nr_pages and rb->aux_pgoff via
perf_mmap_to_page() while holding only event->mmap_mutex. Those fields are
serialized by rb->aux_mutex, and mmap_mutex is per event.

Thus, two events sharing one rb via PERF_EVENT_IOC_SET_OUTPUT can race
rb_alloc_aux() with map_range(), leading to a page-UAF scenario as follows:

CPU 0                           CPU 1
===============================================================
rb_alloc_aux()                  map_range()
[1]: allocate rb->aux_pages[0]
[2]: rb->aux_nr_pages++
                                [3]: perf_mmap_to_page()
                                       returns rb->aux_pages[0]
                                [4]: map it as VM_PFNMAP
[5]: rb->aux_pgoff = 1

munmap the page
[6]: free rb->aux_pages[0]
===============================================================

Pages mapped as VM_PFNMAP have no refcount protection, so CPU 1 holds a
mapping to a freed physical frame.

Fix this by taking rb->aux_mutex across the page walk in map_range().

Fixes: b709eb872e19 ("perf: map pages in advance")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jia Jie <jiajie.lee@starlabs.sg>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7f3e2c2ecb1..ba5bd6a78fe7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7150,6 +7150,8 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 	int err = 0;
 	unsigned long pagenum;

+	guard(mutex)(&rb->aux_mutex);
+
 	/*
 	 * We map this as a VM_PFNMAP VMA.
 	 *

