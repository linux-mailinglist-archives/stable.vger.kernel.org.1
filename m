Return-Path: <stable+bounces-73873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40C97071D
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC78281BEC
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C661531FB;
	Sun,  8 Sep 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GyU9ldEP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932D18C22
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796363; cv=none; b=M+KFizsteZPGQu79pWzp1Lho7bubXRLzLg76E/9b8KjVZltHjAuPNm3Zkx0BvkslkXrVo4ibl/OlxFD6PIzRpZHUATOJiEQaqefxVmyyqzENqtoW2t+7qs2bG+mqqNP6pFDD7YL0+whz+gSMiRHhXTw3vi4bH+82JqSkUqZCbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796363; c=relaxed/simple;
	bh=zb/Teyddd+8ZD29igzRVYYRx28T7vPqVY1QTtM5fd0U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gcXIZiGXdu2TK8lFOLKABQPozxgIvKhFi6xdlY9hnijdmgDKje8KHhWzeBMOQLx2ZAIxMyuG2Smw1qCborkzqEBiGe5CFP55UXXaotNjZzzS7//B2G1TYo35+Tl+jFRbMkiQAq435liZQOWTcB1yjcZDl0mUFi5v/khZt/WIWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GyU9ldEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBA4C4CEC3;
	Sun,  8 Sep 2024 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725796362;
	bh=zb/Teyddd+8ZD29igzRVYYRx28T7vPqVY1QTtM5fd0U=;
	h=Subject:To:Cc:From:Date:From;
	b=GyU9ldEPLo/hOuh2VJx8U+eAnsGT6KfaQMEHLVrqiihdiQ2RqIIEmrHQ45lnI1PWE
	 omI1AKO5zdFHmCd1+e234cAUlMyFnxqxJRllqeveqEfJWofnqPeBkelaAdP9jmsYv1
	 uc4xf4x23r30rC5vz/A3PLfmJWxrQkEzCPpSX4EE=
Subject: FAILED: patch "[PATCH] mm/memcontrol: respect zswap.writeback setting from parent cg" failed to apply to 6.10-stable tree
To: me@yhndnzj.com,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,mkoutny@suse.com,muchun.song@linux.dev,nphamcs@gmail.com,roman.gushchin@linux.dev,shakeel.butt@linux.dev,stable@vger.kernel.org,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:52:39 +0200
Message-ID: <2024090839-crimp-posted-6a31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x e399257349098bf7c84343f99efb2bc9c22eb9fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090839-crimp-posted-6a31@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

e39925734909 ("mm/memcontrol: respect zswap.writeback setting from parent cg too")
2b33a97c94bc ("mm: zswap: rename is_zswap_enabled() to zswap_is_enabled()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e399257349098bf7c84343f99efb2bc9c22eb9fd Mon Sep 17 00:00:00 2001
From: Mike Yuan <me@yhndnzj.com>
Date: Fri, 23 Aug 2024 16:27:06 +0000
Subject: [PATCH] mm/memcontrol: respect zswap.writeback setting from parent cg
 too
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 86311c2907cd..95c18bc17083 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f29157288b7d..d563fb515766 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3613,8 +3613,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	memcg1_soft_limit_reset(memcg);
 #ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
-	WRITE_ONCE(memcg->zswap_writeback,
-		!parent || READ_ONCE(parent->zswap_writeback));
+	WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -5320,7 +5319,14 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
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


