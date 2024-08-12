Return-Path: <stable+bounces-66478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CD94EBFE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F1A282AB4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A9176AD1;
	Mon, 12 Aug 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CheaRgzZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8316A948
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462989; cv=none; b=lcDHbkB7pn+w9qFZLoiRk1Fg+nYzEqVxP0iicimj8SunrVBEwg/zGC3wh1vsvdrmmOVhLIj9S9I5+dgSgdwR1kxpUdjqNLhQqhdqSKtThdlnpAi5K0vp7meXuXM9L8qL8PR5snJvtdTu2+mHr/i3Nb6FudNIMOKsdczlDENwhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462989; c=relaxed/simple;
	bh=2pfank+5t4OfJr5y/Pz3+X4Ksba2TxwrLJ4XVNWJHFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pNZaGbwxZY3Ke0+SZYzLYsYZR2016f1OAuWR2wlOWUHyt243Z0taikfykMah5esIDN1FSPR3AqtoD+ku44Gl2WR5gZ4Oaxd+Vgu9qRuY+c0at44sdliO5FRKuuWU/0BNeTqxw3ehtsQtLwge1SEsum1dYTaUiJ22wPX5UKQzcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CheaRgzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B8DC32782;
	Mon, 12 Aug 2024 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723462989;
	bh=2pfank+5t4OfJr5y/Pz3+X4Ksba2TxwrLJ4XVNWJHFk=;
	h=Subject:To:Cc:From:Date:From;
	b=CheaRgzZvF7vKVFr9mWFxkjKFc8WGAS+5pjhK98FYjtcxHTgubEw753425g4sNCKv
	 R+NWWLKI1aYodIzcU7mi/qYu3iz3FG2BvU9ENu8YBG5W3/k9SwFdzMRl5NJPEwuUrP
	 vlyIFVrSdYDzWHcl0KNHgjIBT5zLKmJ8ju0Cmyj8=
Subject: FAILED: patch "[PATCH] memcg: protect concurrent access to mem_cgroup_idr" failed to apply to 6.1-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@suse.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 13:43:00 +0200
Message-ID: <2024081259-plow-freezing-a93e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9972605a238339b85bd16b084eed5f18414d22db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081259-plow-freezing-a93e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9972605a2383 ("memcg: protect concurrent access to mem_cgroup_idr")
6f0df8e16eb5 ("memcontrol: ensure memcg acquired by id is properly set up")
e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
7348cc91821b ("mm: multi-gen LRU: remove aging fairness safeguard")
a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safeguard")
adb8213014b2 ("mm: memcg: fix stale protection of reclaim target memcg")
57e9cc50f4dd ("mm: vmscan: split khugepaged stats from direct reclaim stats")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9972605a238339b85bd16b084eed5f18414d22db Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Fri, 2 Aug 2024 16:58:22 -0700
Subject: [PATCH] memcg: protect concurrent access to mem_cgroup_idr

Commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after
many small jobs") decoupled the memcg IDs from the CSS ID space to fix the
cgroup creation failures.  It introduced IDR to maintain the memcg ID
space.  The IDR depends on external synchronization mechanisms for
modifications.  For the mem_cgroup_idr, the idr_alloc() and idr_replace()
happen within css callback and thus are protected through cgroup_mutex
from concurrent modifications.  However idr_remove() for mem_cgroup_idr
was not protected against concurrency and can be run concurrently for
different memcgs when they hit their refcnt to zero.  Fix that.

We have been seeing list_lru based kernel crashes at a low frequency in
our fleet for a long time.  These crashes were in different part of
list_lru code including list_lru_add(), list_lru_del() and reparenting
code.  Upon further inspection, it looked like for a given object (dentry
and inode), the super_block's list_lru didn't have list_lru_one for the
memcg of that object.  The initial suspicions were either the object is
not allocated through kmem_cache_alloc_lru() or somehow
memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
returned success.  No evidence were found for these cases.

Looking more deeply, we started seeing situations where valid memcg's id
is not present in mem_cgroup_idr and in some cases multiple valid memcgs
have same id and mem_cgroup_idr is pointing to one of them.  So, the most
reasonable explanation is that these situations can happen due to race
between multiple idr_remove() calls or race between
idr_alloc()/idr_replace() and idr_remove().  These races are causing
multiple memcgs to acquire the same ID and then offlining of one of them
would cleanup list_lrus on the system for all of them.  Later access from
other memcgs to the list_lru cause crashes due to missing list_lru_one.

Link: https://lkml.kernel.org/r/20240802235822.1830976-1-shakeel.butt@linux.dev
Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 960371788687..f29157288b7d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3386,11 +3386,28 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
 
 #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
 static DEFINE_IDR(mem_cgroup_idr);
+static DEFINE_SPINLOCK(memcg_idr_lock);
+
+static int mem_cgroup_alloc_id(void)
+{
+	int ret;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&memcg_idr_lock);
+	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
+			GFP_NOWAIT);
+	spin_unlock(&memcg_idr_lock);
+	idr_preload_end();
+	return ret;
+}
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		spin_lock(&memcg_idr_lock);
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		spin_unlock(&memcg_idr_lock);
+
 		memcg->id.id = 0;
 	}
 }
@@ -3524,8 +3541,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -3667,7 +3683,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 * publish it here at the end of onlining. This matches the
 	 * regular ID destruction during offlining.
 	 */
+	spin_lock(&memcg_idr_lock);
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	spin_unlock(&memcg_idr_lock);
 
 	return 0;
 offline_kmem:


