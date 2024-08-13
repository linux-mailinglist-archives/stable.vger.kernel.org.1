Return-Path: <stable+bounces-67505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFA950885
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426411F21873
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130219EEA4;
	Tue, 13 Aug 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ce9dziyi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B919EED6
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561683; cv=none; b=qaEhMRfmXT+PREeCrOUh1Z5mW9wkuZ1/4iDwkdfyJU/N4YTn/x8gpeMnjVP9WzP31WKtbiN90JqtCvlKgMUm6QMFj1N9U2oHjdcOIbvto7t+W8WU2pIZnTmuEParT3MDwMHhbjw2ybENFKilgCkHyO0/dlv5ijsaG+9VlbWEc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561683; c=relaxed/simple;
	bh=qC3XQWCCu1rctIzw6y3siLeysb9QkV1chjdq8hOhrEs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W5nH5QAVJU0vS35EzRw8dkmcdlfQpE6NMqRHNFc0p+iS8lI+bwpFVdgGHSSINOD9trq1w/t2nwjCXJ6VhKDXbOU1dMuEZAfKd4bXcxao3EbrMykGFOhAEfwP52VUcvtkqs6ys777r5IcWW+qR1LOr0vxbJDan47dcwdQQ4MZkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ce9dziyi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e8826e03bso9230430276.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723561681; x=1724166481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1x8HY6pqVTVF5kQzcpH4Ucp1zz0s1gAq4xU9MqMd/wE=;
        b=ce9dziyi9vKY8MxR0ZIhBgdof4vxT4DQRAqkbDkKn/qLQQsmlfboZL6d9z8sv4+w5V
         8QfoSAKz2picIJ0Xd7UwMSuYkhH6vzstRMZkj3EoN0DoODQPjaJ57SbU4vVSaQt2jI8v
         p3wt+C+lnfaw40p3SUtbn05OdX0gXPaNIll8I1r53hrsBCMxbfjTFy/eU53mPsAaxcZW
         SZuTnKCPRgJoslFXVLW/JuxJKuBruVSkQq7iQxyIewYmlpr2Bi1rgMPIJ0ouFKB1mZxW
         Qhez39/8JscTd5ZVKGMOR96KUClD14cF76euboR/keHxAdq0i82MpQN7AfUjdWNT4pVo
         Tmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561681; x=1724166481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1x8HY6pqVTVF5kQzcpH4Ucp1zz0s1gAq4xU9MqMd/wE=;
        b=X4YSuJtal3V4NE4aYchpQ133dBZ/NIdE93VvZ03jnoy2RkpL6UKs4YI+SFvI+///sQ
         sF2eeqs//ZZFsZwaJAPxhhiJjB9JonVr/nvrm90YmIdzD3j5ce0mMEyIVWGOWrs/VPoi
         Cds0htYh+AUwvkQ89flZ1tdHGTT3a6HthaGNJhwEKqKu9jnKF9v8MqqGMW/n7pVfwxNd
         js0Kp5JysDLADDotQu74p42Fay+Q+gVkZPmNGmW6tXUn6MJLAhWmsmYJeUwj3fsRUGh8
         A3JkI8vsqcVjR8ubd8D9F3wuv5JDJg5trqW4qEWIdaTMQl9taCb7uQ9VW0IQYABqy9q6
         shdw==
X-Forwarded-Encrypted: i=1; AJvYcCXZi8XSB/M9dhvOp8Z0/ifcOMSGFNNFwLzJjAEK1LxxSBPL6Uu3M1XPDH6QXOh804gK7Wd9HdwbfBfoT+8LKQyb2dO2Mhil
X-Gm-Message-State: AOJu0YwEJzzH/CJ4eMo4Dnqdqt/NeSe6HGM+CyrAFTC+p03l2a88i69z
	r3tzHfkP1xaOTydN1rCdTcsOBtMXscNEWuvv1EaYZYHdFcOc8GAPfouuuYJj1ysuOVGaRR+R0cW
	9AA==
X-Google-Smtp-Source: AGHT+IEz36OwLmoBcnEL1WUUu6fUVYlI+FT85j7U+cB0aTgWoq2vINT4jdflqp8Za9uby33WBDXFm+7GRew=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b416:2d8c:d850:78])
 (user=surenb job=sendgmr) by 2002:a25:4844:0:b0:e05:eb99:5f84 with SMTP id
 3f1490d57ef6-e113e9066d6mr4889276.4.1723561681199; Tue, 13 Aug 2024 08:08:01
 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:07:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813150758.855881-1-surenb@google.com>
Subject: [PATCH v3 1/2] alloc_tag: introduce clear_page_tag_ref() helper function
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In several cases we are freeing pages which were not allocated using
common page allocators. For such cases, in order to keep allocation
accounting correct, we should clear the page tag to indicate that the
page being freed is expected to not have a valid allocation tag.
Introduce clear_page_tag_ref() helper function to be used for this.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
 include/linux/pgalloc_tag.h | 13 +++++++++++++
 mm/mm_init.c                | 10 +---------
 mm/page_alloc.c             |  9 +--------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 18cd0c0c73d9..207f0c83c8e9 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -43,6 +43,18 @@ static inline void put_page_tag_ref(union codetag_ref *ref)
 	page_ext_put(page_ext_from_codetag_ref(ref));
 }
 
+static inline void clear_page_tag_ref(struct page *page)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr)
 {
@@ -126,6 +138,7 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
 static inline void put_page_tag_ref(union codetag_ref *ref) {}
+static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..907c46b0773f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2460,15 +2460,7 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	}
 
 	/* pages were reserved and not allocated */
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
-
+	clear_page_tag_ref(page);
 	__free_pages_core(page, order, MEMINIT_EARLY);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28f80daf5c04..3f80e94a0b66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5821,14 +5821,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 
 void free_reserved_page(struct page *page)
 {
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
+	clear_page_tag_ref(page);
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);

base-commit: d74da846046aeec9333e802f5918bd3261fb5509
-- 
2.46.0.76.ge559c4bf1a-goog


