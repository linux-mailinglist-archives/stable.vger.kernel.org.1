Return-Path: <stable+bounces-196504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90320C7A882
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330F73A2198
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AB29BDAB;
	Fri, 21 Nov 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idHHdSW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08638178372
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738404; cv=none; b=Buf90bV6oaRQLtfcnBFAdC0zUDiWwfw7x0RY89NV6Tav4vMEVaR8nTFHcZEzGfwfSa3Em8ztvRQdFE0KRYhWI4Yx3E4hkdU3P5RxMdZbhv3LarabaDRS/xXYVF51KTjgGFYtN3vX/zWJWMjZ2teulhojtObW62RNygKZAmhhV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738404; c=relaxed/simple;
	bh=S91R0JrQrKJKxdEYRIXhRczEsMtoKEtP1XH3tqkO6NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVDoG+cslIbd9A7fwb92oKJNa2ulQDtpfS6mcjyppcVEfNc8UYNYgPn5VbKWiOZF0K3KXTRH+C8XRRBBSAqHTmbTDxsaEN9TqrlMQ8NPZsBVcd8v6Cwh2/LzA+HjDiwNSzTcLS6bFMQq3NQcobA8da7z8r/+kzCCo0PsoaEFoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idHHdSW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9632BC4CEF1;
	Fri, 21 Nov 2025 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763738403;
	bh=S91R0JrQrKJKxdEYRIXhRczEsMtoKEtP1XH3tqkO6NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idHHdSW+y/gTsOGUlykky0m6rMzwS5RWJpnd/xjRFJ3NSWgswRIFhMg6de1DKk6P2
	 q06LoWEJobYBtr4WkU0js7fcd8B8RowDUxZ7RuNCKQ/QimbOi7+TZAx6oZ/gYPIuOe
	 8dAdUJVLhx0RQIBFw6ly2Wr+UX40u0QkxbzJ+fySVijSD4fPbPOXQz9DEnnbI+qLgK
	 rkm4u/mQvck/+8H7bcsFGvVvf/oIHOcbEQTl+RVaxoCbddD5gyTb7y13+qE7fyOYaP
	 NNxj3zo+Ackiyd3Dp8rBUb9p36iSHE59Gv67JTUYQ7gDp6PFQK5AZs/4odDtwRPb1v
	 GX+CV3Qzi/BqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ftrace: Fix BPF fexit with livepatch
Date: Fri, 21 Nov 2025 10:20:00 -0500
Message-ID: <20251121152000.2567643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112016-arrogance-recast-439f@gregkh>
References: <2025112016-arrogance-recast-439f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

[ Upstream commit 56b3c85e153b84f27e6cff39623ba40a1ad299d3 ]

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
[ moved cleanup to reset_direct() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/trampoline.c |  4 ----
 kernel/trace/ftrace.c   | 20 ++++++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e97aeda3a86b5..b6024fc903490 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -460,10 +460,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		 * BPF_TRAMP_F_SHARE_IPMODIFY is set, we can generate the
 		 * trampoline again, and retry register.
 		 */
-		/* reset fops->func and fops->trampoline for re-register */
-		tr->fops->func = NULL;
-		tr->fops->trampoline = 0;
-
 		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
 		set_memory_nx((long)im->image, 1);
 		set_memory_rw((long)im->image, 1);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 15785a729a0cd..ecda59d6acb4c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5370,6 +5370,17 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 	}
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
@@ -5465,6 +5476,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
+	if (err)
+		reset_direct(ops, addr);
 
  out_unlock:
 	mutex_unlock(&direct_mutex);
@@ -5497,7 +5510,6 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
 int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 			     bool free_filters)
 {
-	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
 
 	if (check_direct_multi(ops))
@@ -5507,13 +5519,9 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 
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
-- 
2.51.0


