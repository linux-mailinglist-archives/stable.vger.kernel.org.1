Return-Path: <stable+bounces-94607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993059D6005
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F11BB231DF
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D990745F2;
	Fri, 22 Nov 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbBAZX7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD312E7F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283514; cv=none; b=UoJo5xM+xLS7pizKXZPnwM+oh/C9K6SE1T4GgE4nY0TUX8QTtAW8arA2CESLMviTfU3ZWk2nkmvq4/q1GfFs0xWXmBtqlh5sUIgdF70TDbqYnuM1G3KIJJO5TTQ4hl4FfiNP0UAre2eqJYAZCzDqPlSj0Y1MxvyQH80uPRnIOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283514; c=relaxed/simple;
	bh=ejz9oYLebqvO5GAFgafFNWNsBcsXgW8sVMume8CjAEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRY9G7QxBgN/78bkj84ljwxB5e7loNR6hlyNP/FuQbrDkblLFaQ3LhKAbEqtfRQIAVehibwjl3J0ObddyNXRnC8HBV/lTOdVMxQlKVNbi/I/2qkRkVPgMAXVJvga3rtClWnbgJp2Ya50mojQNqFNuRo/UfNGM0ICCZ28oIx256A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbBAZX7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D2C4CECE;
	Fri, 22 Nov 2024 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283514;
	bh=ejz9oYLebqvO5GAFgafFNWNsBcsXgW8sVMume8CjAEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbBAZX7cmRe2z7RVtQ+YN8PYJUt9COi2f66fOsvZLtOI3vYxse6hvKZ53YoTTYb8E
	 8tcfS72qfemswzs4Bg4RqRz1vXzjkILIy/gCURGh/t13Kp8eAAyF148RCEyOw8LMBd
	 m4itR4//U5olyJRZUOfJCbI2is3MUd8jCa4cm51tRSpcgnWA/O45wWluALJgV9gw5B
	 C2TzINJyybL4UEWe1GwN6TrLiVdH5IsEUzfH86HPYtmgzo1oLKBKGwTb2qGEuNjSDs
	 kh8NV4aTtY176w9889Cao1D98NBRiU+Hx+z0ZkEe/xDuwNNlsGVp0PmkL7yDvLh/b5
	 dzQ70wqF97fEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krister Johansen <kjlx@templeofstupid.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/2] rcu-tasks: Idle tasks on offline CPUs are in quiescent states
Date: Fri, 22 Nov 2024 08:51:55 -0500
Message-ID: <20241122082642-c7cd4d5b3d8f0513@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <69e45347cdb5a256b6e78e77e5bf8da005582b0c.1732238585.git.kjlx@templeofstupid.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 5c9a9ca44fda41c5e82f50efced5297a9c19760d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Krister Johansen <kjlx@templeofstupid.com>
Commit author: Paul E. McKenney <paulmck@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 08:26:15.770984330 -0500
+++ /tmp/tmp.eKXYnEofof	2024-11-22 08:26:15.765204063 -0500
@@ -1,3 +1,5 @@
+commit 5c9a9ca44fda41c5e82f50efced5297a9c19760d upstream
+
 Any idle task corresponding to an offline CPU is in an RCU Tasks Trace
 quiescent state.  This commit causes rcu_tasks_trace_postscan() to ignore
 idle tasks for offline CPUs, which it can do safely due to CPU-hotplug
@@ -10,15 +12,16 @@
 Cc: Andrii Nakryiko <andrii@kernel.org>
 Cc: Martin KaFai Lau <kafai@fb.com>
 Cc: KP Singh <kpsingh@kernel.org>
+Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
 ---
  kernel/rcu/tasks.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
-index 8fe78a7fecafd..ec68bfe98c958 100644
+index bede3a4f108e..ea45a2d53a99 100644
 --- a/kernel/rcu/tasks.h
 +++ b/kernel/rcu/tasks.h
-@@ -1451,7 +1451,7 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
+@@ -1007,7 +1007,7 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
  {
  	int cpu;
  
@@ -27,3 +30,6 @@
  		rcu_tasks_trace_pertask(idle_task(cpu), hop);
  
  	// Re-enable CPU hotplug now that the tasklist scan has completed.
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |

