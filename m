Return-Path: <stable+bounces-124487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63BA6214F
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1178519C5A31
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512741A23B7;
	Fri, 14 Mar 2025 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+mUFO91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CE1F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993827; cv=none; b=CG/Fp88y3yTAguQfGC4C7nAXEptRHrYPfYMiIeqbkqf1B4+BSyOyZHyzIj+T7V2lu+gRKAdVLco9tgXDhkxEoqGMVPqNayYn/vFcmk+Eoxt29MOiPtdeSw0HIPLf7R3dfmwnIRquOfM776hUDAXQe7cK8Kx2ZaF+oUD66ljvAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993827; c=relaxed/simple;
	bh=QVKevXcCq7E9+/FEvWG7qSrCS4N0E1cyxlF5yB8reow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jyrj588vkemkiE5DK8+VCmnu7iAIo5AiqLCpzW/SfbQosc4/QgqU6UYy5MTNYejy2dTEtPLybw8fjAf+dWiEAMxzlK23FC66p94uSc34Y+v5r4d7rYBI1Khfj3MdEmrPfXPiECnIUOn44fagHczU9lhb31doY2/cFVcpJ6Od3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+mUFO91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74517C4CEE3;
	Fri, 14 Mar 2025 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993826;
	bh=QVKevXcCq7E9+/FEvWG7qSrCS4N0E1cyxlF5yB8reow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+mUFO91VSAdpFrzk6RAmlJl1KOZHDnDJ1+o9lWQlgVCgXfAmTXwUK+F6RoFbao/Y
	 SccbaJm5ohd42sIgKz2WmX4v29hkrCU92budrQmBfi4lIHvmswuo7wGz1BMGKnFU26
	 H7vlqYs/fc9QsTmS2oLkiEB0JqeQN1t8MAfkma1aE2aZOSyjBZZCxrpBK+rNLl18El
	 SvvDE5swFq8MOjkIGzKVTY8/jEMKDJJjTbtueadYcaz2WW8IZRc5EmQcYIjiyp0BR4
	 Ja6m46w3iGCA2dZFMsZxXPr8ZM4hh8OKn2phaa5LWpsFbfMp/wgFFBYk0BCu0dRsGt
	 w9F6dJzyB39Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kareemem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] memcg: fix soft lockup in the OOM process
Date: Fri, 14 Mar 2025 19:10:25 -0400
Message-Id: <20250314081509-114460a8b7f811a9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313180309.41770-1-kareemem@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: ade81479c7dda1ce3eedb215c78bc615bbd04f06

WARNING: Author mismatch between patch and upstream commit:
Backport author: Abdelkareem Abdelsaamad<kareemem@amazon.com>
Commit author: Chen Ridong<chenridong@huawei.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 465768342918)
6.12.y | Present (different SHA1: c3a3741db8c1)
6.6.y | Present (different SHA1: 972486d37169)
6.1.y | Present (different SHA1: 0a09d56e1682)
5.15.y | Present (different SHA1: a9042dbc1ed4)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/mm/memcontrol.c b/mm/memcontrol.c	(rejected hunks)
@@ -1312,6 +1312,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
+	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1320,8 +1321,12 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct task_struct *task;
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
-		while (!ret && (task = css_task_iter_next(&it)))
+		while (!ret && (task = css_task_iter_next(&it))) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				cond_resched();
 			ret = fn(task, arg);
+		}
 		css_task_iter_end(&it);
 		if (ret) {
 			mem_cgroup_iter_break(memcg, iter);
diff a/mm/oom_kill.c b/mm/oom_kill.c	(rejected hunks)
@@ -43,6 +43,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
+		int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p)
+		for_each_process(p) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				touch_softlockup_watchdog();
 			dump_task(p, oc);
+		}
 		rcu_read_unlock();
 	}
 }

