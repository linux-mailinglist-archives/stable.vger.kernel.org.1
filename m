Return-Path: <stable+bounces-216040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKk4ETL1jmnDGAEAu9opvQ
	(envelope-from <stable+bounces-216040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3627134BD8
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE18E309EA57
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBBB34F241;
	Fri, 13 Feb 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esS4MH7D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9534F24A
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976459; cv=none; b=qewMvHALomG525QB9yneBY1d7b1MlUsgitj0F+f+elXBkPaXlPUHZy+khHllCg9LoYiBOu/TTl4xIDGzkRIRiP+KOKnwLuR8tueceBjk+VeILo98+NKnQivW4KhVt+sHI9iJGh+d+KwF7vjAJSqBu10dlsNw2rIPBhjx7YwxNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976459; c=relaxed/simple;
	bh=r+HpcvjKmu0TxXhYFDAE5Rr5F09FZxMG4CrUw1YgdRE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jsq21txJfXKk1KMWrFHa0IclnylAtaEwqn9hzBLU/7M1yMaEepDL1gF/SucD0N0URKEsMITfO+owOK0C64CYXrALvfrHuQXOzu9knzc/LXWgIl9fzWwTBKQ9aL0suUGCJBU5j8Paew5syz+cXHM3lYLfy8q4VM45gZGgvCoAyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=esS4MH7D; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so5681695e9.2
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770976456; x=1771581256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFs1D2cDtd6f/aAyQgYmfXZj2j/U+wImXIancDSX5wo=;
        b=esS4MH7D4GAsfjM4iZ2h9Z9hE+bv71qMJtB5/iYNSOvqNzDZap4glQMKkE8HJZ9L68
         blaabODtmEhl8pf0PPMY4cNauzd8wloTnGq7ORuOXAPWimNwHA6jh9gZJwiPYtedP+lR
         jC2ce2aug83z0Dft3dBb4AWe/Yk0dV1E9n22NSWLiEumGyoTTf+P9yTtUVzNufQIF1sH
         s1BEW4QK5JIsaZ3j/7KDg+6KO3NsQIu7QzJYZ3T3jWSYYNp9CflBw1vNSq9/mrlSRKUB
         vgG/ho838tfHQBvAby5UlTbSM+7l38pHifRFcTVdbwIKm9/3juoICJINar6UVh5F9xan
         OF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976456; x=1771581256;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFs1D2cDtd6f/aAyQgYmfXZj2j/U+wImXIancDSX5wo=;
        b=SFqYK7gnEphoaWYC3FTfo20JlEed9y1bZyCeGFQ14Is2JLdFMjeuvXVgVbSZ1C/wB2
         NkInTsAH0zFWcY6AG5GMwXRSMZaQAmJ18rQFC8WHxL6thk3zMZzGnCH2HyF08+b6ALYx
         NYQKY1363GnRhMAaFSRUT5v3ArS4w0pg5UxoPPPfNpKa5YIdVd61PiTwSMQ9zDJE76et
         yyHlWubejImHbjsi79L0N8DV9oLwa24/YSEamKuoTybktiswrC4Isaon8yjAn77OePhg
         TrCTTpwu4K7woKP0pJJ3P8yPTTsr/YobHCDXX/b++wRS3FkNMDSIzo7QvDsrHYCC3GwS
         p6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUyRhirT4GxG5w83y+6xbJSrkkC1e6yda1nf5kd9rhEUkCoKcBI/E1tQ7UtydNZaSotH3xBWEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cvAG69YP0GHYBW4Ie5yc6BSzFpoHNu75o82Ks7XSN5F7PyjU
	Jkmc7SRSwNx/JZMgVBKtYbsXhSXRewcjEFKo4mt/+I/NSKtXAC77p5gUPmEDChkeOGS5L+XPcgH
	aqi/2vw==
X-Received: from wmoo19.prod.google.com ([2002:a05:600d:113:b0:483:6a60:3501])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fc8:b0:47a:814c:ee95
 with SMTP id 5b1f17b1804b1-48373a234fdmr19866675e9.12.1770976455591; Fri, 13
 Feb 2026 01:54:15 -0800 (PST)
Date: Fri, 13 Feb 2026 10:54:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213095410.1862978-1-glider@google.com>
Subject: [PATCH v1] mm/kfence: disable KFENCE upon KASAN HW tags enablement
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: akpm@linux-foundation.org, mark.rutland@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, pimyn@google.com, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, stable@vger.kernel.org, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216040-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glider@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kvack.org,vger.kernel.org,googlegroups.com,google.com,gmail.com,tugraz.at,linuxfoundation.org,kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A3627134BD8
X-Rspamd-Action: no action

KFENCE does not currently support KASAN hardware tags. As a result, the
two features are incompatible when enabled simultaneously.

Given that MTE provides deterministic protection and KFENCE is a
sampling-based debugging tool, prioritize the stronger hardware
protections. Disable KFENCE initialization and free the pre-allocated
pool if KASAN hardware tags are detected to ensure the system maintains
the security guarantees provided by MTE.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kfence/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4f79ec7207525..71f87072baf9b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -13,6 +13,7 @@
 #include <linux/hash.h>
 #include <linux/irq_work.h>
 #include <linux/jhash.h>
+#include <linux/kasan-enabled.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
 #include <linux/kmemleak.h>
@@ -911,6 +912,20 @@ void __init kfence_alloc_pool_and_metadata(void)
 	if (!kfence_sample_interval)
 		return;
 
+	/*
+	 * If KASAN hardware tags are enabled, disable KFENCE, because it
+	 * does not support MTE yet.
+	 */
+	if (kasan_hw_tags_enabled()) {
+		pr_info("disabled as KASAN HW tags are enabled\n");
+		if (__kfence_pool) {
+			memblock_free(__kfence_pool, KFENCE_POOL_SIZE);
+			__kfence_pool = NULL;
+		}
+		kfence_sample_interval = 0;
+		return;
+	}
+
 	/*
 	 * If the pool has already been initialized by arch, there is no need to
 	 * re-allocate the memory pool.
-- 
2.53.0.273.g2a3d683680-goog


