Return-Path: <stable+bounces-139285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B2AA5B94
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214769C3F50
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539501C6FE0;
	Thu,  1 May 2025 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqlfnj0v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F341E515
	for <stable@vger.kernel.org>; Thu,  1 May 2025 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746085747; cv=none; b=clyjLCKg472jCf0fKbayiLxLNOwsIUOfhVoE44Vrn1Sxzj8QpOPOdrtSD81KvlGvzHeuyvKsa0AppfAXT3YwN155JU5xEx3DRS6l1srzzsoFT9qz4yBh+pKiulXIuC5jK16U9UwfAOEqk8MqxLlia5rlrr5TieCRjejIS05tWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746085747; c=relaxed/simple;
	bh=DnkKHEryAmqjyc2wnmPEzC0mdCI59iK/guE1msBaumI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WG5wwLNY70WoAgHO1YrNNLD40HNkXZuHvyyQE+igh8hOtnlUMPX2yco2t5fIXSUCJhK1rucP5e6n/a88mW33Y4zHjbuSrSsgVQ/g9pvgx/ppSSkRozLHOFv9JhOX2z6Fi5V1UtQz3VJIvzjsH67dfHlxaylO7qJBeSum/+7T5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqlfnj0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF4C4CEE3;
	Thu,  1 May 2025 07:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746085746;
	bh=DnkKHEryAmqjyc2wnmPEzC0mdCI59iK/guE1msBaumI=;
	h=Subject:To:Cc:From:Date:From;
	b=aqlfnj0vlY9jtGqJnxOpFSns2t+t3dzyQpWZp5yXfOkdGqylp7xuJ0zVMrx/e4+Op
	 PO/XUR45zqxqyGZnYT7W6o2AIsaInZcjeHM5SptvY7SJfDPdWHeC12GIxhuvKlTcCk
	 049sR9wm0MPW5DA9VWJTp8xA3OjzbbdHBFFnC+LY=
Subject: FAILED: patch "[PATCH] memcg: drain obj stock on cpu hotplug teardown" failed to apply to 6.1-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 09:48:55 +0200
Message-ID: <2025050155-approve-flatly-068d@gregkh>
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
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050155-approve-flatly-068d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


