Return-Path: <stable+bounces-14115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A7837F92
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA3429225D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D759629EC;
	Tue, 23 Jan 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A60YFfep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF186169A;
	Tue, 23 Jan 2024 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971199; cv=none; b=oLKdbkRKgiIbvigDdDPJdbtmO+ybXEMbBSSX4GGI0bZASPVuSiEJJ2lD0nMhx30Kl/3NnONkRb41HuhxoHo1UWgLwEejnKM0KsN3JiBCcTE5QlpHticVwbVTaU/vdyV+5Xpb/fxgcVRMIR5kWxu2kVw2qFOLLmjdYLlE66y7MNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971199; c=relaxed/simple;
	bh=6xbtKkDVBKuwBCC3m9HdtZ1pbe/2siYkpiZCcGCfNWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVdX51PMVD1ZHJZ626mBuKA/dHmzEUWsC30qt5OjIpIQ7vwrPxLaa//BcUNC0R11gr10Vamsf53xioylxAoPdEq2o9rlGaqDRUbgL2fMeD5zHg3+yjlX0WUMP+I0cruO6j/z7QjQ6C0gYKtFMv8x2C8Jy5NS1BEr9iHXrzJM4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A60YFfep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A237FC433F1;
	Tue, 23 Jan 2024 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971198;
	bh=6xbtKkDVBKuwBCC3m9HdtZ1pbe/2siYkpiZCcGCfNWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A60YFfephQC53GnN0Tvxr0X8/3jcbTuTmIwEEbjbcz7TreZE13S7mP4XkUAZeZw9b
	 X4pcZmNJgCdrHYhD/HeAbJaPtr3smnOG9YSrtiM3w4xqSG/+jxte71myhdYnR1DcaM
	 RgC0acXBoMo45kr4q5NVlX9NzwkHVjmCQMdAXOR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jordan Rome <jordalgo@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 110/286] bpf: Add crosstask check to __bpf_get_stack
Date: Mon, 22 Jan 2024 15:56:56 -0800
Message-ID: <20240122235736.328150930@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Jordan Rome <jordalgo@meta.com>

[ Upstream commit b8e3a87a627b575896e448021e5c2f8a3bc19931 ]

Currently get_perf_callchain only supports user stack walking for
the current task. Passing the correct *crosstask* param will return
0 frames if the task passed to __bpf_get_stack isn't the current
one instead of a single incorrect frame/address. This change
passes the correct *crosstask* param but also does a preemptive
check in __bpf_get_stack if the task is current and returns
-EOPNOTSUPP if it is not.

This issue was found using bpf_get_task_stack inside a BPF
iterator ("iter/task"), which iterates over all tasks.
bpf_get_task_stack works fine for fetching kernel stacks
but because get_perf_callchain relies on the caller to know
if the requested *task* is the current one (via *crosstask*)
it was failing in a confusing way.

It might be possible to get user stacks for all tasks utilizing
something like access_process_vm but that requires the bpf
program calling bpf_get_task_stack to be sleepable and would
therefore be a breaking change.

Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Signed-off-by: Jordan Rome <jordalgo@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20231108112334.3433136-1-jordalgo@meta.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/stackmap.c          | 11 ++++++++++-
 tools/include/uapi/linux/bpf.h |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 36ddfb98b70e..29cc0eb2e488 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3424,6 +3424,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EOPNOTSUPP.
  *		To achieve this, the helper needs *task*, which is a valid
  *		pointer to **struct task_struct**. To store the stacktrace, the
  *		bpf program provides *buf* with a nonnegative *size*.
@@ -3435,6 +3437,7 @@ union bpf_attr {
  *
  *		**BPF_F_USER_STACK**
  *			Collect a user space stack instead of a kernel stack.
+ *			The *task* must be the current task.
  *		**BPF_F_USER_BUILD_ID**
  *			Collect buildid+offset instead of ips for user stack,
  *			only valid if **BPF_F_USER_STACK** is also specified.
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0c5bf98d5576..b8afea2ceeeb 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -575,6 +575,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 {
 	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
@@ -597,6 +598,14 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (task && user && !user_mode(regs))
 		goto err_fault;
 
+	/* get_perf_callchain does not support crosstask user stack walking
+	 * but returns an empty stack instead of NULL.
+	 */
+	if (crosstask && user) {
+		err = -EOPNOTSUPP;
+		goto clear;
+	}
+
 	num_elem = size / elem_size;
 	max_depth = num_elem + skip;
 	if (sysctl_perf_event_max_stack < max_depth)
@@ -608,7 +617,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
-					   false, false);
+					   crosstask, false);
 	if (unlikely(!trace))
 		goto err_fault;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fd1a4d843e6f..63ea5bc6f1c4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3424,6 +3424,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EOPNOTSUPP.
  *		To achieve this, the helper needs *task*, which is a valid
  *		pointer to **struct task_struct**. To store the stacktrace, the
  *		bpf program provides *buf* with a nonnegative *size*.
@@ -3435,6 +3437,7 @@ union bpf_attr {
  *
  *		**BPF_F_USER_STACK**
  *			Collect a user space stack instead of a kernel stack.
+ *			The *task* must be the current task.
  *		**BPF_F_USER_BUILD_ID**
  *			Collect buildid+offset instead of ips for user stack,
  *			only valid if **BPF_F_USER_STACK** is also specified.
-- 
2.43.0




