Return-Path: <stable+bounces-72643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E7967D2A
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D06C1F2179E
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A182718641;
	Mon,  2 Sep 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ytoZzvyG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE34A0F;
	Mon,  2 Sep 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238785; cv=none; b=D7tj0Hy9V9eZ6urDp+1wJ0DIkmHhJ7AUzSW9HLL/VBqZ14/YmGktzWd1grwF83fmR62TFThyRk6CNaxlJn57UOfX3tt2IDeamjct9abfy4f+T2KSJ/gqOiDgSgXaxEw1GBO9q1KprQhOTEBL4woWEEqK/CcfkxwNVMRXFPjk9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238785; c=relaxed/simple;
	bh=eZYSraelY4chJl/boj5Eis5VJktRkyjQFuZl5WSBlPU=;
	h=Date:To:From:Subject:Message-Id; b=oO3EyPiRTTXayKSvN8pPO4cXlQi2e8cXnQUn0bsuohdJMpdmqIwbU/ULwSxpLxuu9pD6zd1ekSydDb/QChU0lTsrylNhQPk3RS9A2FxGHj/KNntOKyPG/mXYhIjLUf8J3NS+Vq2hwyFYXP9pIPk2uWQFAX0edchwL69XzzQ996A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ytoZzvyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B0FC4CEC3;
	Mon,  2 Sep 2024 00:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725238785;
	bh=eZYSraelY4chJl/boj5Eis5VJktRkyjQFuZl5WSBlPU=;
	h=Date:To:From:Subject:From;
	b=ytoZzvyG1wdfiZ3oBpjepPWuiK+/4V2RQXMSwepIRhpaAh5+7VVDdZWiHlmXtlY9h
	 INxYAPMAnyl2HFW0dnyU8QFQlCSy/M3J6/Ju4qiMDpuk3KBw9yiSXQNyLgIGHyyJkH
	 a05hGu7CnXsUmymEwFiMrBwSSXHWFbrpOfr0Zeos=
Date: Sun, 01 Sep 2024 17:59:44 -0700
To: mm-commits@vger.kernel.org,yosryahmed@google.com,stable@vger.kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,nphamcs@gmail.com,muchun.song@linux.dev,mkoutny@suse.com,mhocko@kernel.org,hannes@cmpxchg.org,me@yhndnzj.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-memcontrol-respect-zswapwriteback-setting-from-parent-cg-too.patch removed from -mm tree
Message-Id: <20240902005945.34B0FC4CEC3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm/memcontrol: respect zswap.writeback setting from parent cg too
has been removed from the -mm tree.  Its filename was
     mm-memcontrol-respect-zswapwriteback-setting-from-parent-cg-too.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Mike Yuan <me@yhndnzj.com>
Subject: mm/memcontrol: respect zswap.writeback setting from parent cg too
Date: Fri, 23 Aug 2024 16:27:06 +0000

Currently, the behavior of zswap.writeback wrt.  the cgroup hierarchy
seems a bit odd.  Unlike zswap.max, it doesn't honor the value from parent
cgroups.  This surfaced when people tried to globally disable zswap
writeback, i.e.  reserve physical swap space only for hibernation [1] -
disabling zswap.writeback only for the root cgroup results in subcgroups
with zswap.writeback=1 still performing writeback.

The inconsistency became more noticeable after I introduced the
MemoryZSwapWriteback= systemd unit setting [2] for controlling the knob.
The patch assumed that the kernel would enforce the value of parent
cgroups.  It could probably be workarounded from systemd's side, by going
up the slice unit tree and inheriting the value.  Yet I think it's more
sensible to make it behave consistently with zswap.max and friends.

[1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
[2] https://github.com/systemd/systemd/pull/31734

Link: https://lkml.kernel.org/r/20240823162506.12117-1-me@yhndnzj.com
Fixes: 501a06fe8e4c ("zswap: memcontrol: implement zswap writeback disabling")
Signed-off-by: Mike Yuan <me@yhndnzj.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/admin-guide/cgroup-v2.rst |    7 ++++---
 mm/memcontrol.c                         |   12 +++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

--- a/Documentation/admin-guide/cgroup-v2.rst~mm-memcontrol-respect-zswapwriteback-setting-from-parent-cg-too
+++ a/Documentation/admin-guide/cgroup-v2.rst
@@ -1717,9 +1717,10 @@ The following nested keys are defined.
 	entries fault back in or are written out to disk.
 
   memory.zswap.writeback
-	A read-write single value file. The default value is "1". The
-	initial value of the root cgroup is 1, and when a new cgroup is
-	created, it inherits the current value of its parent.
+	A read-write single value file. The default value is "1".
+	Note that this setting is hierarchical, i.e. the writeback would be
+	implicitly disabled for child cgroups if the upper hierarchy
+	does so.
 
 	When this is set to 0, all swapping attempts to swapping devices
 	are disabled. This included both zswap writebacks, and swapping due
--- a/mm/memcontrol.c~mm-memcontrol-respect-zswapwriteback-setting-from-parent-cg-too
+++ a/mm/memcontrol.c
@@ -3613,8 +3613,7 @@ mem_cgroup_css_alloc(struct cgroup_subsy
 	memcg1_soft_limit_reset(memcg);
 #ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
-	WRITE_ONCE(memcg->zswap_writeback,
-		!parent || READ_ONCE(parent->zswap_writeback));
+	WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -5320,7 +5319,14 @@ void obj_cgroup_uncharge_zswap(struct ob
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 	/* if zswap is disabled, do not block pages going to the swapping device */
-	return !zswap_is_enabled() || !memcg || READ_ONCE(memcg->zswap_writeback);
+	if (!zswap_is_enabled())
+		return true;
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg))
+		if (!READ_ONCE(memcg->zswap_writeback))
+			return false;
+
+	return true;
 }
 
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
_

Patches currently in -mm which might be from me@yhndnzj.com are

documentation-cgroup-v2-clarify-that-zswapwriteback-is-ignored-if-zswap-is-disabled.patch
selftests-test_zswap-add-test-for-hierarchical-zswapwriteback.patch


