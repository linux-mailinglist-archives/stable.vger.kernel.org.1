Return-Path: <stable+bounces-238312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJn5GNDl4GnhnAAAu9opvQ
	(envelope-from <stable+bounces-238312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:36:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1340EEBE
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63C4830086DD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5EE3B38AF;
	Thu, 16 Apr 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFIA4L5P"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6EF3B777F
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346142; cv=none; b=eKyLwDZ2N0YVXnxMqcN6FvTzpW+MqxFE4t2VgM5wlUZZpg91hyfqrislCeOpKkqUJRQRg0b66MHajrhse9PNOwhD6dJXgv/0UsNFRAzGGJwvC07KqiwkAcCFionhbyd2LofBAU+zrIbPd9vHRwwLjDTKsGeAKecQGugo7Pu0/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346142; c=relaxed/simple;
	bh=eY9M3Hns1hCAkMA3Tyj6bH96Y0/DuuzhcW3QphbaBt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gOr9AQv20GlKMNI7xbREwD/x7CAW82MXYGbCzQhE4M3a6ReOFtCfC3yyE2SuVvrepEebdW+8QxiQr9LUwCkbmOetj4+yC5KSxp/qE8lTuGDaOjXUr1feMbT7h0sqI9fghtEqSQvPg6z/yL1tccv+UswwtQscJ0urYx6XPXSPP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFIA4L5P; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836abfc742so61893615e9.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776346139; x=1776950939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXyay+WHlh8f8CqBFyXL5GTNWYbapDVN1nCV3X7TprM=;
        b=NFIA4L5Pbpct+hzBUMRER0QgPovMbFPXjO/ZpgGHwcYzCtumv432WT00czlOp6z3ub
         JvHSHDjl4i7hbm01WVnxkn5TN6hDd4q5W5NvyJn69tgPsljgKnIrgz2qiDW35/WNsV+Y
         zAhXRH+k1/8I7rlJEOAOEjbDfpwlFpmvHBZnGiP3mRCzokhYegJfvqau/1BkFLXKiUAv
         NS+50cN05bJg5bQ62RL8ILPmGvuYP7b1DHaxUtz/W4CYCAq6hpzV0IvSFn3cWWD+ocoL
         DE4DYz5W4J9R0SdnRFWj+7GitTClG2dI8w66FvBxsR8gPazTGS0NV584aYPlTZopD6hy
         e9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776346139; x=1776950939;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXyay+WHlh8f8CqBFyXL5GTNWYbapDVN1nCV3X7TprM=;
        b=SqU1Ix6GSTjqiF7op8J+L4aag/K/ih9kNLdsJJoMZQxPe6mrq85XE1XQlfOK0OLP6l
         G8P3O80OSZJyKIIWwsZXUvOTXhp5E5v6yyUmciuFYBtNoVANAV333Sot4HXWYixsrqyr
         l41n1gZZwW/ZlwV7GUzwAYg+bcgoc70d/h+xE8funGm9/hJRLhsLd7hL7q7z/CJL74Bv
         RJ9/6ajXtHPfWahTntVsUsAXRYoy0YqslIxEFuBTarQfj+w/3Rm9JsNiTJyufpWfA4ck
         GVoQHfvTfeQCDLK7bqQQhVIxm5TTH4oLHCQTQI1V3QZocwn3qOlpnUvFOsGmQXVTumxD
         /jkA==
X-Forwarded-Encrypted: i=1; AFNElJ/7dZRQAVKiIi1BDCyXv/OP3gv3PJuAipMOiDgpbZskdCz3vqxilBLAaoT0WSmN+l/6vLv4GPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37uJtTE+CN5X2F8raKLdC1g/1fQ/RiZ4nh67S+Fx08zuO/6D9
	6FaPUGFhcDJxhTmQqEeOQqFme4M99eu2rs4wl48JCky7ffnrLl/lcAgAZPDhQAj9jjJs5Zs7YFL
	dLw==
X-Received: from wmtm7.prod.google.com ([2002:a05:600c:c4b7:b0:488:a6d9:e91a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45c6:b0:488:a797:f0ac
 with SMTP id 5b1f17b1804b1-488d6ac2226mr319528795e9.28.1776346138934; Thu, 16
 Apr 2026 06:28:58 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:25:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416132837.3787694-1-elver@google.com>
Subject: [PATCH] slub: fix data loss and overflow in krealloc()
From: Marco Elver <elver@google.com>
To: elver@google.com, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238312-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEC1340EEBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 2cd8231796b5 ("mm/slub: allow to set node and align in
k[v]realloc") introduced the ability to force a reallocation if the
original object does not satisfy new alignment or NUMA node, even when
the object is being shrunk.

This introduced two bugs in the reallocation fallback path:

1. Data loss during NUMA migration: The jump to 'alloc_new' happens
   before 'ks' and 'orig_size' are initialized. As a result, the
   memcpy() in the 'alloc_new' block would copy 0 bytes into the new
   allocation.

2. Buffer overflow during shrinking: When shrinking an object while
   forcing a new alignment, 'new_size' is smaller than the old size.
   However, the memcpy() used the old size ('orig_size ?: ks'), leading
   to an out-of-bounds write.

The same overflow bug exists in the kvrealloc() fallback path, where the
old bucket size ksize(p) is copied into the new buffer without being
bounded by the new size.

A simple reproducer:

	// e.g. add to lkdtm as KREALLOC_SHRINK_OVERFLOW
	while (1) {
		void *p = kmalloc(128, GFP_KERNEL);
		p = krealloc_node_align(p, 64, 256, GFP_KERNEL, NUMA_NO_NODE);
		kfree(p);
	}

demonstrates the issue:

  ==================================================================
  BUG: KFENCE: out-of-bounds write in memcpy_orig+0x68/0x130

  Out-of-bounds write at 0xffff8883ad757038 (120B right of kfence-#47):
   memcpy_orig+0x68/0x130
   krealloc_node_align_noprof+0x1c8/0x340
   lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
   lkdtm_do_action+0x3a/0x60 [lkdtm]
   ...

  kfence-#47: 0xffff8883ad756fc0-0xffff8883ad756fff, size=64, cache=kmalloc-64

  allocated by task 316 on cpu 7 at 97.680481s (0.021813s ago):
   krealloc_node_align_noprof+0x19c/0x340
   lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
   lkdtm_do_action+0x3a/0x60 [lkdtm]
   ...
  ==================================================================

Fix it by moving the old size calculation to the top of __do_krealloc()
and bounding all copy lengths by the new allocation size.

Fixes: 2cd8231796b5 ("mm/slub: allow to set node and align in k[v]realloc")
Cc: <stable@vger.kernel.org>
Reported-by: https://sashiko.dev/#/patchset/20260415143735.2974230-1-elver%40google.com
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/slub.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 92362eeb13e5..161079ac5ba1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6645,16 +6645,6 @@ __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags,
 	if (!kasan_check_byte(p))
 		return NULL;
 
-	/*
-	 * If reallocation is not necessary (e. g. the new size is less
-	 * than the current allocated size), the current allocation will be
-	 * preserved unless __GFP_THISNODE is set. In the latter case a new
-	 * allocation on the requested node will be attempted.
-	 */
-	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
-		     nid != page_to_nid(virt_to_page(p)))
-		goto alloc_new;
-
 	if (is_kfence_address(p)) {
 		ks = orig_size = kfence_ksize(p);
 	} else {
@@ -6673,6 +6663,16 @@ __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags,
 		}
 	}
 
+	/*
+	 * If reallocation is not necessary (e. g. the new size is less
+	 * than the current allocated size), the current allocation will be
+	 * preserved unless __GFP_THISNODE is set. In the latter case a new
+	 * allocation on the requested node will be attempted.
+	 */
+	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+		     nid != page_to_nid(virt_to_page(p)))
+		goto alloc_new;
+
 	/* If the old object doesn't fit, allocate a bigger one */
 	if (new_size > ks)
 		goto alloc_new;
@@ -6707,7 +6707,7 @@ __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags,
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
-		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
+		memcpy(ret, kasan_reset_tag(p), min(new_size, (size_t)(orig_size ?: ks)));
 		kasan_enable_current();
 	}
 
@@ -6941,7 +6941,7 @@ void *kvrealloc_node_align_noprof(const void *p, size_t size, unsigned long alig
 		if (p) {
 			/* We already know that `p` is not a vmalloc address. */
 			kasan_disable_current();
-			memcpy(n, kasan_reset_tag(p), ksize(p));
+			memcpy(n, kasan_reset_tag(p), min(size, ksize(p)));
 			kasan_enable_current();
 
 			kfree(p);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

