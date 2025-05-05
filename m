Return-Path: <stable+bounces-141100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1305AAB134
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78953A7865
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486128EA49;
	Tue,  6 May 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0ViSxPL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375C305F32
	for <stable@vger.kernel.org>; Mon,  5 May 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488150; cv=none; b=m01EFeBz3S/0ZaK6+KwkJ/7cxeSGMpCVc94uqJR6PlDjkoHQPkkBpvoYjelpfbyTHc58ZJMmEeNsO2rB2So+NWOcbo6h2e/MBETOd4Yy1Gbo+uz73BcdRjZZ5Rk2P//VUmny41TYKYbjFxKXO3KmglOd23FPcXhHNV0FsxGkOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488150; c=relaxed/simple;
	bh=qpcfmm1ZS2JJ+7o0fp2KfSwMGSTbRjKOVqg0qivpSD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nv+WP2zRDgtnH/SwBNtEV9R/xTcEeUzmpfkK13ZDwtMRVrS4j6ryqSG60en2Jn0BnfvxYKkgtbEizkqZQYAUX5nXWk1rWN+9xvZOn9+DOkXU1qQJ39mxqIA32x3sXb3N5V6gaWAE3s4nfbkoX+jv9+19axwyg/mFquLG4ZWhtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0ViSxPL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b16b35ea4aaso3073675a12.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746488147; x=1747092947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbS7NXp+fUBn82kgc8yRdgXgBYYQGbHvKqtEGolca/I=;
        b=e0ViSxPLjZzT68L2iqSQIrt1QUiTVHAXdK8ug98M8g2gK9jrDCapmhU2+pK5QvEvvc
         vKNwZE+Q5uhEBQHHkV9SRB1v8x/KK0XF/g2zp8MauMJUOJ9UM7TUx7uLrlDL082eDOHy
         DshKda8lyR0rqWIXB3HwzyDDwJbzkqRTymB5EByPZp8fIfv6RVZDIKI0soT3FP2c4lc0
         K08HgLkqrCtGMix3qbAWbRj6/3b/AgYV7ypN7YX9Z4D0PLsLyabOP3sgwKc4Uu4SUI3D
         8i8s311ic8RcdkgLDiSoZxO5BujWiGFpGLw4zNs3A8JA6beaHCXC64TojmTFVDdIYjeg
         kHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746488147; x=1747092947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbS7NXp+fUBn82kgc8yRdgXgBYYQGbHvKqtEGolca/I=;
        b=TLmsDEtpGIMnj/RP7hQ4owmvJ2KYVbQuW7dv0PyLjmp8+PySBwF9z057miGo5HRhQk
         ACBlwegzQIhdCu8BZ0SDCu+5AWF0tKbgtWfeoARGCSxWWUPTiaYLQYoxJLpqO7vz9mdB
         ENCib61Yrm3pXJgwH5yBK6tVwfFIolJ3wuSLcku4T/56fbO96PTe4yGIjUrJZRTAEnl1
         zGe9CqNCY8X4qlA+Jkm+WuUe25U2HXFh7myuoy2KX9G8UN4XghGJ2REYyIAIFjwej4dr
         9Ya7DSirQ/R6GJ3Dy82ZtFEL/eqE9lrtQafnG1oiVR1itM+65fiZljWJ9pi7sw8tvYAG
         QlwA==
X-Gm-Message-State: AOJu0YzFT+7OeXhLkc3vKG6wS18xTd0OSvhd7FEmGHuU6NBQEGq5eq1J
	iqjyN2o8VvXvrmBDNIfm618wP6BFcEHnerP8HLTN1GJftk4yq43utXMQ7nPzoeXiIQGMG2ROCqe
	6pxJ5bPKUU9jF/2LDUVTbPZyv3c5M3+/8nnOYY7faE1e0W+qk1RX8m1QF8i2ovUm9dKOkCns01+
	FB0xOWV839Rh9hm9wCabjtnAA9E9DvDA2g
X-Google-Smtp-Source: AGHT+IFDw11TSJ91LBrXkIWaKfO0pjV4UK4V8QNfu1UsoP1fbdELAtjGXqU0XyQnFFNGvPOJDldClcibYv4=
X-Received: from pjuu13.prod.google.com ([2002:a17:90b:586d:b0:2ff:6e58:89f7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f92:b0:2ff:7ad4:77af
 with SMTP id 98e67ed59e1d1-30a7dfbef83mr1004862a91.20.1746488147368; Mon, 05
 May 2025 16:35:47 -0700 (PDT)
Date: Mon,  5 May 2025 16:35:43 -0700
In-Reply-To: <2025050521-provable-extent-4108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025050521-provable-extent-4108@gregkh>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505233543.3192644-1-surenb@google.com>
Subject: [PATCH 6.14.y] mm, slab: clean up slab->obj_exts always
From: Suren Baghdasaryan <surenb@google.com>
To: stable@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, David Rientjes <rientjes@google.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

From: Zhenhua Huang <quic_zhenhuah@quicinc.com>

When memory allocation profiling is disabled at runtime or due to an
error, shutdown_mem_profiling() is called: slab->obj_exts which
previously allocated remains.
It won't be cleared by unaccount_slab() because of
mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
should always be cleaned up in unaccount_slab() to avoid following error:

[...]BUG: Bad page state in process...
..
[...]page dumped because: page still charged to cgroup

[andriy.shevchenko@linux.intel.com: fold need_slab_obj_ext() into its only user]
Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object extensions")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Tested-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://patch.msgid.link/20250421075232.2165527-1-quic_zhenhuah@quicinc.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
(cherry picked from commit be8250786ca94952a19ce87f98ad9906448bc9ef)
[surenb: fixed trivial merge conflict in alloc_tagging_slab_alloc_hook(),
skipped inlining free_slab_obj_exts() as it's already inline in 6.14]
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 96babca6b330..87f3edf9acb8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2025,18 +2025,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	if (mem_alloc_profiling_enabled())
-		return true;
-
-	/*
-	 * CONFIG_MEMCG creates vector of obj_cgroup objects conditionally
-	 * inside memcg_slab_post_alloc_hook. No other users for now.
-	 */
-	return false;
-}
-
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline void init_slab_obj_exts(struct slab *slab)
@@ -2053,11 +2041,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -2089,7 +2072,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 static inline void
 alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	if (need_slab_obj_ext()) {
+	if (mem_alloc_profiling_enabled()) {
 		struct slabobj_ext *obj_exts;
 
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
@@ -2565,8 +2548,12 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online() || need_slab_obj_ext())
-		free_slab_obj_exts(slab);
+	/*
+	 * The slab object extensions should now be freed regardless of
+	 * whether mem_alloc_profiling_enabled() or not because profiling
+	 * might have been disabled after slab->obj_exts got allocated.
+	 */
+	free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
-- 
2.49.0.967.g6a0df3ecc3-goog


