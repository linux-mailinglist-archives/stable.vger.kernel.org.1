Return-Path: <stable+bounces-126914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A355A74488
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 08:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB823BF2D2
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440F212B02;
	Fri, 28 Mar 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oix7uIDl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287119F40A
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743147872; cv=none; b=T4JhRz8/AT/+45tDLvYSjbeIM298SjGbmnNQnhqz2SpjHJE1mLbP78boBJUSDeBJoPEIfHmQTlabGalxkS8ZBxR53mGnLfSebCuoSyzDmWIa52rSeRVvl+33xyfvA9012vANjoEcJcPeqdAm3jBLqua5oqZ2mV/amEy8sxuUIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743147872; c=relaxed/simple;
	bh=VcTgQ0Spxw+Z0Kq1EucWx+nVcQWqWtr7aozm5NCS4MQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X8NWafJXccEcIQEvOc0CbHKi7K0/2JfieQL7keYBXjejYHOEJ2cjDI2gSouhpmU/CY/TtrtI/g/IEOz6j/T80tM5HtlxJquxH872/Krv0wkedvYYqlBj4O/+HXIab/LrGYqiuv3xW3ueTKc+aHi0sGOVUfrPSIaEMETrZJpHkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oix7uIDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBC3C4CEE8;
	Fri, 28 Mar 2025 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743147871;
	bh=VcTgQ0Spxw+Z0Kq1EucWx+nVcQWqWtr7aozm5NCS4MQ=;
	h=Subject:To:Cc:From:Date:From;
	b=oix7uIDlo5c1tOrpeBGIfx+Cof263sraCYkg2+S+Pc9YnExqp/9RCV1Nz4tVfy/jn
	 mHO0jiFUN2DOKZ6mbGcB0zzcN5GN0YbPARvkpYGgzGdC5mf/CXBdtCiSiQ1m5EdQS9
	 Zatfe5mPb1gto2omidBRky3yAV/13NUtr9+koQ/o=
Subject: FAILED: patch "[PATCH] memcg: drain obj stock on cpu hotplug teardown" failed to apply to 6.1-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 28 Mar 2025 08:43:07 +0100
Message-ID: <2025032807-famished-reprocess-abd3@gregkh>
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
git cherry-pick -x 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032807-famished-reprocess-abd3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 10 Mar 2025 16:09:34 -0700
Subject: [PATCH] memcg: drain obj stock on cpu hotplug teardown

Currently on cpu hotplug teardown, only memcg stock is drained but we
need to drain the obj stock as well otherwise we will miss the stats
accumulated on the target cpu as well as the nr_bytes cached. The stats
include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
addition we are leaking reference to struct obj_cgroup object.

Link: https://lkml.kernel.org/r/20250310230934.2913113-1-shakeel.butt@linux.dev
Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f9b35f80e24..a037ec92881d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old;
+	unsigned long flags;
 
 	stock = &per_cpu(memcg_stock, cpu);
+
+	/* drain_obj_stock requires stock_lock */
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	old = drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+
 	drain_stock(stock);
+	obj_cgroup_put(old);
 
 	return 0;
 }


