Return-Path: <stable+bounces-95410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D439D8916
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41E1287B2E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906711ADFEA;
	Mon, 25 Nov 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3tFamwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAB171CD
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548065; cv=none; b=bPuOOqIsIv3CilqMazXOUpf63IfWwlhUnFRg0SO0UtSJb3b2ogBWTbQMmobDxWGfzVmOXfmTwCDMhvITpjBnfIEUSAH3VLLAjcovt/0Fc2gVGwmaXeU5C+K+r6YKS01ASCOTBlYXPL8HYCrD4Iy0dPEhuydHhkemI0mawINp7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548065; c=relaxed/simple;
	bh=UfpqlpzDYfEINtVE5bruFEPxx0wC3IC10RqoP8Mgx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEc4/eiNi68taPZCtS7E8gmOMieiahD1NUCHc+kTkXL/5u3MBdCHTQadYvrr7eTbgUyU8JzhZD1MoPTCkgQlelnxm/BOHlTMSpzYvF+D5jQc33x377Yn1laRexALsTJSBy9eVLk/J3dGw5PRAI5KNa8OPu6+MylED0p7ND+Y79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3tFamwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF25EC4CECE;
	Mon, 25 Nov 2024 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548065;
	bh=UfpqlpzDYfEINtVE5bruFEPxx0wC3IC10RqoP8Mgx8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3tFamwjst52QDgc5FO3HYwcrbVJxRydMB5rrknuCtCmXQXyF4pHkaO/wN6AHlyrT
	 a2avhIjvGfopWFKhChGR5MPH2/idzEkEBd2Rq2UjZguEguJVkjfNrQ3CLbh0G9di+g
	 0hE9vj9UmUKx9SCTErAKILbCMKeGrQtBOKUtUgeATPQvYTMU5CJw34Mes96ChGvTcF
	 YSXcfiPjrRQM2M6sVo+VNnWTeEw1vRzBlMsEzfADyI9LdrcEbPxUdzr1aIKHk3tIk1
	 HbqAEE6XlvU2GoF9e/HwCRBtqb3P7L8EE2Xju4YFIPnIxJ6pWpHk6bD5cFAsM86fvh
	 28QeHfEOxm5Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Mon, 25 Nov 2024 10:21:03 -0500
Message-ID: <20241125090126-a7ecce7ce5adb98d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125053307.374219-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 7601df8031fd67310af891897ef6cc0df4209305

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Oleg Nesterov <oleg@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 08:56:48.440504041 -0500
+++ /tmp/tmp.DBppGejMK4	2024-11-25 08:56:48.433034088 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7601df8031fd67310af891897ef6cc0df4209305 ]
+
 lock_task_sighand() can trigger a hard lockup.  If NR_CPUS threads call
 do_task_stat() at the same time and the process has NR_THREADS, it will
 spin with irqs disabled O(NR_CPUS * NR_THREADS) time.
@@ -12,12 +14,14 @@
 Cc: Eric W. Biederman <ebiederm@xmission.com>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- fs/proc/array.c | 58 +++++++++++++++++++++++++++----------------------
- 1 file changed, 32 insertions(+), 26 deletions(-)
+ fs/proc/array.c | 57 +++++++++++++++++++++++++++----------------------
+ 1 file changed, 32 insertions(+), 25 deletions(-)
 
 diff --git a/fs/proc/array.c b/fs/proc/array.c
-index 45ba918638084..34a47fb0c57f2 100644
+index 37b8061d84bb..34a47fb0c57f 100644
 --- a/fs/proc/array.c
 +++ b/fs/proc/array.c
 @@ -477,13 +477,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
@@ -51,7 +55,7 @@
  		if (sig->tty) {
  			struct pid *pgrp = tty_get_pgrp(sig->tty);
  			tty_pgrp = pid_nr_ns(pgrp, ns);
-@@ -527,27 +523,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
+@@ -527,26 +523,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
  		num_threads = get_nr_threads(task);
  		collect_sigign_sigcatch(task, &sigign, &sigcatch);
  
@@ -64,13 +68,12 @@
  
 -		/* add up live thread stats at the group level */
  		if (whole) {
--			struct task_struct *t;
--
--			__for_each_thread(sig, t) {
+-			struct task_struct *t = task;
+-			do {
 -				min_flt += t->min_flt;
 -				maj_flt += t->maj_flt;
 -				gtime += task_gtime(t);
--			}
+-			} while_each_thread(task, t);
 -
 -			min_flt += sig->min_flt;
 -			maj_flt += sig->maj_flt;
@@ -79,7 +82,7 @@
  			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
  				exit_code = sig->group_exit_code;
  		}
-@@ -562,6 +540,34 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
+@@ -561,6 +540,34 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
  	if (permitted && (!whole || num_threads < 2))
  		wchan = !task_is_running(task);
  
@@ -114,3 +117,6 @@
  	if (whole) {
  		thread_group_cputime_adjusted(task, &utime, &stime);
  	} else {
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

