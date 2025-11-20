Return-Path: <stable+bounces-195341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23AC7553D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE1FE3561DC
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A325362144;
	Thu, 20 Nov 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vttxdUEl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7F19ADBA
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655440; cv=none; b=BjsWEhSk6IBT1MzCIgBqfVPsVl6EBqCK1uv8JeXYLKZi2VhW6uU8mQszXKJkimeNVCmQf6ja8kd15yo6kr7vZG61LHjw24+OSa3kYbwq0I2+QvzFd1r0PrtEAi3wdJ2PQKIzrih3lYAijME2dLRZLzd/wuHxiIw725kj1ujRD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655440; c=relaxed/simple;
	bh=FQbRW6cR7ioZUW+FBv7GKR2j3G8AtPhqRj7xvshWjPY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oiFqA5uD8xmTo3CB7Rx0TS2vLlAjWwSjPbq+DAlKgdCrmFV1kXrUunGD82yezEGtwFucWIUTzNh1sYNK6Ha9HhloPfqn/f43YKQtVNX53wciR00FZf+BdBDn/Cw7Fzu5ZqHXp7Gi5aM74snreodH4Se9bm31eW4U7Zo3+/lgq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vttxdUEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DECC4CEF1;
	Thu, 20 Nov 2025 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655439;
	bh=FQbRW6cR7ioZUW+FBv7GKR2j3G8AtPhqRj7xvshWjPY=;
	h=Subject:To:Cc:From:Date:From;
	b=vttxdUEl8k2pW/T8kIyYTiTU5C6EwCV7dk6b9K2BCjKhYyxXBlR1Q8ZKiUeyjePga
	 nqQPJVIFWyxagtV/rnRsNR2VtxQQL/pA96pndkmbhunMtebR65BeGWs4u74r/xPZi3
	 vKa4RG2fJBivfFv6tiaar5Jgue0BH+Q6bQ/pieoo=
Subject: FAILED: patch "[PATCH] ftrace: Fix BPF fexit with livepatch" failed to apply to 6.6-stable tree
To: song@kernel.org,andrey.grodzovsky@crowdstrike.com,ast@kernel.org,jolsa@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:17:16 +0100
Message-ID: <2025112016-arrogance-recast-439f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 56b3c85e153b84f27e6cff39623ba40a1ad299d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112016-arrogance-recast-439f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56b3c85e153b84f27e6cff39623ba40a1ad299d3 Mon Sep 17 00:00:00 2001
From: Song Liu <song@kernel.org>
Date: Mon, 27 Oct 2025 10:50:21 -0700
Subject: [PATCH] ftrace: Fix BPF fexit with livepatch

When livepatch is attached to the same function as bpf trampoline with
a fexit program, bpf trampoline code calls register_ftrace_direct()
twice. The first time will fail with -EAGAIN, and the second time it
will succeed. This requires register_ftrace_direct() to unregister
the address on the first attempt. Otherwise, the bpf trampoline cannot
attach. Here is an easy way to reproduce this issue:

  insmod samples/livepatch/livepatch-sample.ko
  bpftrace -e 'fexit:cmdline_proc_show {}'
  ERROR: Unable to attach probe: fexit:vmlinux:cmdline_proc_show...

Fix this by cleaning up the hash when register_ftrace_function_nolock hits
errors.

Also, move the code that resets ops->func and ops->trampoline to the error
path of register_ftrace_direct(); and add a helper function reset_direct()
in register_ftrace_direct() and unregister_ftrace_direct().

Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
Cc: stable@vger.kernel.org # v6.6+
Reported-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Closes: https://lore.kernel.org/live-patching/c5058315a39d4615b333e485893345be@crowdstrike.com/
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Signed-off-by: Song Liu <song@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20251027175023.1521602-2-song@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..f2cb0b097093 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -479,11 +479,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		 * BPF_TRAMP_F_SHARE_IPMODIFY is set, we can generate the
 		 * trampoline again, and retry register.
 		 */
-		/* reset fops->func and fops->trampoline for re-register */
-		tr->fops->func = NULL;
-		tr->fops->trampoline = 0;
-
-		/* free im memory and reallocate later */
 		bpf_tramp_image_free(im);
 		goto again;
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..cbeb7e833131 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5953,6 +5953,17 @@ static void register_ftrace_direct_cb(struct rcu_head *rhp)
 	free_ftrace_hash(fhp);
 }
 
+static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+
+	remove_direct_functions_hash(hash, addr);
+
+	/* cleanup for possible another register call */
+	ops->func = NULL;
+	ops->trampoline = 0;
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -6048,6 +6059,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
+	if (err)
+		reset_direct(ops, addr);
 
  out_unlock:
 	mutex_unlock(&direct_mutex);
@@ -6080,7 +6093,6 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
 int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 			     bool free_filters)
 {
-	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
 
 	if (check_direct_multi(ops))
@@ -6090,13 +6102,9 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 
 	mutex_lock(&direct_mutex);
 	err = unregister_ftrace_function(ops);
-	remove_direct_functions_hash(hash, addr);
+	reset_direct(ops, addr);
 	mutex_unlock(&direct_mutex);
 
-	/* cleanup for possible another register call */
-	ops->func = NULL;
-	ops->trampoline = 0;
-
 	if (free_filters)
 		ftrace_free_filter(ops);
 	return err;


