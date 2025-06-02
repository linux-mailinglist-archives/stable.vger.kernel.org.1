Return-Path: <stable+bounces-150026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C608AACB59E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8022B4A6E4C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44012309B5;
	Mon,  2 Jun 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PFrDwllC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0275229B1E;
	Mon,  2 Jun 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875799; cv=none; b=ZU4TgdKbkRseXzmzjpVakT5MQO0zTD3pEZkXmuoSs6XCG5bmnhXPlRWt+UKHnANuEoHth2/1rg7aHk5cTqi8gLRJJclDMkiB1cnm72fvp0JYjkifodkh4Y/PX8NbtvMiWDrGDNR8a4gjHTJ6yGXd83/c76D7QpZc+YCX6vxy+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875799; c=relaxed/simple;
	bh=05/0NNzlwMrqOFZcaq3Dfsa+iHjqw6B+VNzN9dJNtG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSog4YNkJDJKv8tezFaH/bWcbam6nO8YyWwIch4FoYVrVqJiqNddo0fDa0G0MSKN3EFQVOe2Q2J2frJTjnRFkLH6LYj/J/JbHE3gdyY9unhXCXDKrNPdrv1YELInXoBJPkE2bMYlkN68JOoNbvctJWDEOAGzafh5MXAhOnGMSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PFrDwllC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA918C4CEEB;
	Mon,  2 Jun 2025 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875799;
	bh=05/0NNzlwMrqOFZcaq3Dfsa+iHjqw6B+VNzN9dJNtG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFrDwllCBCJetRUs59youdfIA6Zu0Av9atTU1J9vu4nkMVK8U+DeSQ26Fx3xRBl6r
	 myq5VsyK1gRkmoQ5YdJ+hooTik6295l66ZkpAJvWa0Eg1HIm5jwEeETyM23dLHA4Cv
	 +4SOQ7kk8vJvHVYXJzHGZ6mH9V8+KZ0STC/94O50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Chen Ridong <chenridong@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 247/270] memcg: always call cond_resched() after fn()
Date: Mon,  2 Jun 2025 15:48:52 +0200
Message-ID: <20250602134317.428317627@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 06717a7b6c86514dbd6ab322e8083ffaa4db5712 upstream.

I am seeing soft lockup on certain machine types when a cgroup OOMs.  This
is happening because killing the process in certain machine might be very
slow, which causes the soft lockup and RCU stalls.  This happens usually
when the cgroup has MANY processes and memory.oom.group is set.

Example I am seeing in real production:

       [462012.244552] Memory cgroup out of memory: Killed process 3370438 (crosvm) ....
       ....
       [462037.318059] Memory cgroup out of memory: Killed process 4171372 (adb) ....
       [462037.348314] watchdog: BUG: soft lockup - CPU#64 stuck for 26s! [stat_manager-ag:1618982]
       ....

Quick look at why this is so slow, it seems to be related to serial flush
for certain machine types.  For all the crashes I saw, the target CPU was
at console_flush_all().

In the case above, there are thousands of processes in the cgroup, and it
is soft locking up before it reaches the 1024 limit in the code (which
would call the cond_resched()).  So, cond_resched() in 1024 blocks is not
sufficient.

Remove the counter-based conditional rescheduling logic and call
cond_resched() unconditionally after each task iteration, after fn() is
called.  This avoids the lockup independently of how slow fn() is.

Link: https://lkml.kernel.org/r/20250523-memcg_fix-v1-1-ad3eafb60477@debian.org
Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Rik van Riel <riel@surriel.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michael van der Westhuizen <rmikey@meta.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Chen Ridong <chenridong@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1312,7 +1312,6 @@ int mem_cgroup_scan_tasks(struct mem_cgr
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
-	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1322,10 +1321,9 @@ int mem_cgroup_scan_tasks(struct mem_cgr
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			/* Avoid potential softlockup warning */
-			if ((++i & 1023) == 0)
-				cond_resched();
 			ret = fn(task, arg);
+			/* Avoid potential softlockup warning */
+			cond_resched();
 		}
 		css_task_iter_end(&it);
 		if (ret) {



