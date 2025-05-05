Return-Path: <stable+bounces-141099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A16AAB0C4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D27B46EF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906D3146B7;
	Mon,  5 May 2025 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMmmnJb6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220E2FDEF1
	for <stable@vger.kernel.org>; Mon,  5 May 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487570; cv=none; b=n6yxIY3WgI6BazBQC8AOCaTmkdFoeKGXHiz5Pq/EqaseL4aXsWlSd3L7jwSd6hKsQuXhB3MddFyP+svew53Arzr3QUkw/KIQLEzfKEqj7I+dXOH0mlyGL0aFcaDXNaBxlrs2uySy9urJ4oVq1QRL0y7EGcsKXogLwZFHZO0AVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487570; c=relaxed/simple;
	bh=F0WEmGwiQi9jA7VIMNQBwpez05DZB5Axh3NxJ9nzth4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jNuBuqW7XMtYWaUkiBO7PFmkVwXryzwUKiJDhFaDJULNaDBHBPtVRlNXS+oVb0EYxwQwyvmV/zgdylx7NTI/fdT/BV18Y2mwKWFFkW8PcyriL8wemOWI4BppKffM9bBYiQp+CyAseJ+ftAXUYn52D6iF1liWszt7lVDku6Sp0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMmmnJb6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22de54b0b97so42110345ad.2
        for <stable@vger.kernel.org>; Mon, 05 May 2025 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746487567; x=1747092367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgQJcy7xureeTRIeWfNVkzRO5AGoHawvodbUo90ljGw=;
        b=UMmmnJb6xkQSFXiBwpLB0q5AZgV9zDToebISik1NC03lTRWm3ti/5M+J8rfSKrKf63
         vkfNz0bdCVpRoIp936gQGCME5YZbBw9MCyWoE0zEbpHQ7uyfgR9+mpQ3Y83Itj3z//Ss
         prbhR94Up8NVRoeE8lO21r1XIIb7uxi6LBp/Ee4iMcrTynezMqQfHwokLhzCdUW38PNr
         +eoy4uybAD4Pkjfpqsbqk0zDX2PyqN4sYxsT0tzvRCapRpPoMrn5qoouaoG9MfoER1p6
         07i/CWNai1ErSyXEu7QxukIFpbBaBYzP+gzY6bZ1tU4LtQbVZY/qUr26+IgK754BYZWn
         nJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746487567; x=1747092367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgQJcy7xureeTRIeWfNVkzRO5AGoHawvodbUo90ljGw=;
        b=hnlrGsx1AMgyC/hkg/4pCpXtU6ww16xgirjitvIEw02QspGVNAYbXA55HRZnlndKPM
         ADDRT1DpayWNNpZMS7QIyVljSfG8lqRcyfNZ+ppBn3ZvY3vLrsOCjDVtEfcVxz6MNFAm
         AkdTRz57HamoxcXMzSA+pdWFLHqsbIWNqbzJ+wb07mSVe9R5cFBnV1Z0DR7QJBJuLAv9
         IKU2Asmwoudq+H9TS4TBkuOoHwADXcyG9LTvtUyi1gXmaV7yMLnGe5MGs3tnBQ0ODSYW
         wL3wcDarYXCZzKzV0dQtWWKJDJneD3rpb6dN+lnwUZnUZ/Dmvyaupz2nW8TejQVb0ii/
         rB3A==
X-Gm-Message-State: AOJu0Yyda61mqExy3NUhKohPzO582Sy5Vdz6mYYH4kPdj4uAnHSwrLya
	S+DdvsycyIdJof299CHkd7Mk2y/kYzgWkw5q8AZjMoUN10gH8/Kz7mBFzkwaG2r+MHVK1uU9wIX
	3swZ6EEVjEMvEkxbSuPteWK/Ad/mnF1w29wlktAWfWH7TG93egcRZCCfQaaJBbFW75Qzf/VfDQS
	T5hK6JdyZSDGLdyxtv+AJHkKXo2saMO0GR
X-Google-Smtp-Source: AGHT+IFLJP7VPTFDIPT3F1+7DtuzLdIOZ1hlHROldjPDTx6M1hsUWWJMxk168+nHcF3eJ2BsZScUGVHyOWY=
X-Received: from plrt7.prod.google.com ([2002:a17:902:b207:b0:223:fab5:e761])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa4:b0:21c:fb6:7c3c
 with SMTP id d9443c01a7336-22e32a5e471mr16283475ad.17.1746487566784; Mon, 05
 May 2025 16:26:06 -0700 (PDT)
Date: Mon,  5 May 2025 16:26:01 -0700
In-Reply-To: <2025050521-crispy-study-e836@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025050521-crispy-study-e836@gregkh>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505232601.3160940-1-surenb@google.com>
Subject: [PATCH 6.12.y] mm, slab: clean up slab->obj_exts always
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
skipped inlining free_slab_obj_exts() as it's already inline in 6.12]
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c26d9cd107cc..66f86e532818 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2035,18 +2035,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
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
@@ -2063,11 +2051,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -2099,7 +2082,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 static inline void
 alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	if (need_slab_obj_ext()) {
+	if (mem_alloc_profiling_enabled()) {
 		struct slabobj_ext *obj_exts;
 
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
@@ -2577,8 +2560,12 @@ static __always_inline void account_slab(struct slab *slab, int order,
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


