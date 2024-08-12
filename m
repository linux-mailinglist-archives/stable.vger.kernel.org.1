Return-Path: <stable+bounces-66496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E294EC86
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBDB1F22058
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762417A5AA;
	Mon, 12 Aug 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qc4v8HhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC717997A
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464762; cv=none; b=j2zpxB9P8UrjpM3V72ilop67BJv/cGSDJMlUl0Ke28aPwBVvHKT/ny/Zs4U9OOYLaYzq0fCEv2qmX4BK6IRRfneiXm2dxXK/w5/vjX1HO9Mjo6tsZgtlo1Hcn2HH7jc3/SxyJCCQ22HrtGGe8JjaVspFydXFSZN11i5kLBDZd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464762; c=relaxed/simple;
	bh=btxOidFksNJJr408c9fpo9YwIy4dFkiwO0fgFCEC61Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y4qEBj5r6dl1DzVMec1VHm+0iyYox4hlp6+9otmV31o4FHi7eFoGDuU25MSeJRJqNeLT0zGuPp0kP3mbQAw7KdnYM0+NohQN5SfK4J6k0r8JdG1P9lFyiYUxrSjpiEnefvussa/LZQTuc391WoCFqcGhbqnhNdl5IMnhDxVW9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qc4v8HhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BE8C32782;
	Mon, 12 Aug 2024 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464762;
	bh=btxOidFksNJJr408c9fpo9YwIy4dFkiwO0fgFCEC61Y=;
	h=Subject:To:Cc:From:Date:From;
	b=qc4v8HhBvEuMSmkAarkUplZG9dD+FHbnQrwrkAbTBgnRFYUBUoajj4OH74VEMdwJg
	 QVBlQC7vpVmo8Oq+F9IiGJ5tZz9nY2WzMs+Xfb6lucCbfaznoqmcFqb+P+ui5o9wqT
	 34b4UXNOW8AQPegzhbiPRcWcFV1HkTxUrRn7Dh1o=
Subject: FAILED: patch "[PATCH] sched/smt: Fix unbalance sched_smt_present dec/inc" failed to apply to 5.10-stable tree
To: yangyingliang@huawei.com,peterz@infradead.org,tim.c.chen@linux.intel.com,yu.c.chen@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:12:39 +0200
Message-ID: <2024081238-catalyst-resident-aec1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e22f910a26cc2a3ac9c66b8e935ef2a7dd881117
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081238-catalyst-resident-aec1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e22f910a26cc ("sched/smt: Fix unbalance sched_smt_present dec/inc")
2558aacff858 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")
565790d28b1e ("sched: Fix balance_callback()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e22f910a26cc2a3ac9c66b8e935ef2a7dd881117 Mon Sep 17 00:00:00 2001
From: Yang Yingliang <yangyingliang@huawei.com>
Date: Wed, 3 Jul 2024 11:16:08 +0800
Subject: [PATCH] sched/smt: Fix unbalance sched_smt_present dec/inc

I got the following warn report while doing stress test:

jump label: negative count!
WARNING: CPU: 3 PID: 38 at kernel/jump_label.c:263 static_key_slow_try_dec+0x9d/0xb0
Call Trace:
 <TASK>
 __static_key_slow_dec_cpuslocked+0x16/0x70
 sched_cpu_deactivate+0x26e/0x2a0
 cpuhp_invoke_callback+0x3ad/0x10d0
 cpuhp_thread_fun+0x3f5/0x680
 smpboot_thread_fn+0x56d/0x8d0
 kthread+0x309/0x400
 ret_from_fork+0x41/0x70
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Because when cpuset_cpu_inactive() fails in sched_cpu_deactivate(),
the cpu offline failed, but sched_smt_present is decremented before
calling sched_cpu_deactivate(), it leads to unbalanced dec/inc, so
fix it by incrementing sched_smt_present in the error path.

Fixes: c5511d03ec09 ("sched/smt: Make sched_smt_present track topology")
Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20240703031610.587047-3-yangyingliang@huaweicloud.com

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index acc04ed9dbc2..949473e414f9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8009,6 +8009,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	sched_update_numa(cpu, false);
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		sched_smt_present_inc(cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);


