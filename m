Return-Path: <stable+bounces-139628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA5AA8DA9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213AD3A820D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E91EEA4E;
	Mon,  5 May 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U85W5fH/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B71E1A3F
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431734; cv=none; b=amfUco3npSmDTahi5W0iQSe5z9EeKBnJiUUR+rtF10g7KLwrTqu1O1THJSlNl417kNRIaLcY4zTJVKvQzB0uvrdhzJkUW9j4OhASq4hrLqpIn2pcnb9eVzCd8egSFpt6rZmn3OMjyFevH98W8sOYzVrflybe1MEeB/7jzEKHTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431734; c=relaxed/simple;
	bh=y7PJxyixzFUgzbZI3SVfBMNEy7Vcx1cA6ShPGAj5Wx0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sDc37eQfnaBufN7mvWFdrrXuWaiAovjvqPN/TKoTMPDqGuZwlMfVSP/qNlLM69DN+XD+LvJyQL+CzuL9DdaGup6UwWE2ZrvPGE3Dzv6vCorJ2OtkIl+6EUjvpRVcctlDyqAEtGOmm0F/AXQYYbZZxYoBhTf40Ui8qdn7EA+bWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U85W5fH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C0BC4CEE9;
	Mon,  5 May 2025 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431734;
	bh=y7PJxyixzFUgzbZI3SVfBMNEy7Vcx1cA6ShPGAj5Wx0=;
	h=Subject:To:Cc:From:Date:From;
	b=U85W5fH/1tsRRG6tq9LAoyXo/j4BWR0nKKTV0PGuyV6HvnZ6pTFWJgfwggXMXHOJP
	 XINvZPTt25H2oYn8sW/RH5DMKgx1m8D4MnCdXBz9XNVYL4BsbM7kxxb9Os7o9f/Kef
	 yC9YvUr0QQaMGtOuqk7Nw/DoTs9wTVj3hyb7WbIQ=
Subject: FAILED: patch "[PATCH] mm, slab: clean up slab->obj_exts always" failed to apply to 6.14-stable tree
To: quic_zhenhuah@quicinc.com,harry.yoo@oracle.com,rientjes@google.com,surenb@google.com,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:55:21 +0200
Message-ID: <2025050521-provable-extent-4108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x be8250786ca94952a19ce87f98ad9906448bc9ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050521-provable-extent-4108@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be8250786ca94952a19ce87f98ad9906448bc9ef Mon Sep 17 00:00:00 2001
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Date: Mon, 21 Apr 2025 15:52:32 +0800
Subject: [PATCH] mm, slab: clean up slab->obj_exts always

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

diff --git a/mm/slub.c b/mm/slub.c
index dc9e729e1d26..be8b09e09d30 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2028,8 +2028,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	return 0;
 }
 
-/* Should be called only if mem_alloc_profiling_enabled() */
-static noinline void free_slab_obj_exts(struct slab *slab)
+static inline void free_slab_obj_exts(struct slab *slab)
 {
 	struct slabobj_ext *obj_exts;
 
@@ -2049,18 +2048,6 @@ static noinline void free_slab_obj_exts(struct slab *slab)
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
@@ -2077,11 +2064,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -2129,7 +2111,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 static inline void
 alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	if (need_slab_obj_ext())
+	if (mem_alloc_profiling_enabled())
 		__alloc_tagging_slab_alloc_hook(s, object, flags);
 }
 
@@ -2601,8 +2583,12 @@ static __always_inline void account_slab(struct slab *slab, int order,
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


