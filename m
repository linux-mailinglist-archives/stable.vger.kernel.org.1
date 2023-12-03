Return-Path: <stable+bounces-3779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDAE80244B
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D371C208FE
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E31AFC02;
	Sun,  3 Dec 2023 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H09c0dn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D5C2EE
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECD3C433C7;
	Sun,  3 Dec 2023 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701610713;
	bh=BkV/kAFPGPbj/VkJxYuzyJ6tFKmr8nrzybt/jfxp+cQ=;
	h=Subject:To:Cc:From:Date:From;
	b=H09c0dn14rWto9ggY4WmxeZVPhpxVhLhlzBBOAa5zAcgesPq39RnA3Hu/0FCO+/b7
	 KU6fluVkbsUyWkFbnlDSLyoDAIn39/atoTba3zEvOO4AtK22jqLkjirVfm26yx2+Wr
	 OXKtqXLrN8s4HU8hC2OK//boi2MxcJtMvIwGjXd0=
Subject: FAILED: patch "[PATCH] kprobes: consistent rcu api usage for kretprobe holder" failed to apply to 5.15-stable tree
To: inwardvessel@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:38:19 +0100
Message-ID: <2023120319-failing-aviator-303a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d839a656d0f3caca9f96e9bf912fd394ac6a11bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120319-failing-aviator-303a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d839a656d0f3 ("kprobes: consistent rcu api usage for kretprobe holder")
4bbd93455659 ("kprobes: kretprobe scalability improvement")
8865aea0471c ("kernel: kprobes: Use struct_size()")
195b9cb5b288 ("fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()")
5f81018753df ("fprobe: Release rethook after the ftrace_ops is unregistered")
76d0de5729c0 ("fprobe: Pass entry_data to handlers")
0a1ebe35cb3b ("rethook: fix a potential memleak in rethook_alloc()")
d05ea35e7eea ("fprobe: Check rethook_alloc() return in rethook initialization")
c09eb2e578eb ("bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT")
c0f3bb4054ef ("rethook: Reject getting a rethook if RCU is not watching")
439940491807 ("kprobes: Fix build errors with CONFIG_KRETPROBES=n")
73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
9052e4e83762 ("fprobe: Fix smatch type mismatch warning")
f70986902c86 ("bpf: Fix kprobe_multi return probe backtrace")
f705ec764b34 ("Revert "bpf: Add support to inline bpf_get_func_ip helper on x86"")
2c6401c966ae ("selftests/bpf: Add kprobe_multi bpf_cookie test")
f7a11eeccb11 ("selftests/bpf: Add kprobe_multi attach test")
ca74823c6e16 ("bpf: Add cookie support to programs attached with kprobe multi link")
97ee4d20ee67 ("bpf: Add support to inline bpf_get_func_ip helper on x86")
42a5712094e8 ("bpf: Add bpf_get_func_ip kprobe helper for multi kprobe link")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d839a656d0f3caca9f96e9bf912fd394ac6a11bc Mon Sep 17 00:00:00 2001
From: JP Kobryn <inwardvessel@gmail.com>
Date: Fri, 1 Dec 2023 14:53:55 +0900
Subject: [PATCH] kprobes: consistent rcu api usage for kretprobe holder

It seems that the pointer-to-kretprobe "rp" within the kretprobe_holder is
RCU-managed, based on the (non-rethook) implementation of get_kretprobe().
The thought behind this patch is to make use of the RCU API where possible
when accessing this pointer so that the needed barriers are always in place
and to self-document the code.

The __rcu annotation to "rp" allows for sparse RCU checking. Plain writes
done to the "rp" pointer are changed to make use of the RCU macro for
assignment. For the single read, the implementation of get_kretprobe()
is simplified by making use of an RCU macro which accomplishes the same,
but note that the log warning text will be more generic.

I did find that there is a difference in assembly generated between the
usage of the RCU macros vs without. For example, on arm64, when using
rcu_assign_pointer(), the corresponding store instruction is a
store-release (STLR) which has an implicit barrier. When normal assignment
is done, a regular store (STR) is found. In the macro case, this seems to
be a result of rcu_assign_pointer() using smp_store_release() when the
value to write is not NULL.

Link: https://lore.kernel.org/all/20231122132058.3359-1-inwardvessel@gmail.com/

Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
Cc: stable@vger.kernel.org
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index ab1da3142b06..64672bace560 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -139,7 +139,7 @@ static inline bool kprobe_ftrace(struct kprobe *p)
  *
  */
 struct kretprobe_holder {
-	struct kretprobe	*rp;
+	struct kretprobe __rcu *rp;
 	struct objpool_head	pool;
 };
 
@@ -245,10 +245,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return READ_ONCE(ri->rph->rp);
+	return rcu_dereference_check(ri->rph->rp, rcu_read_lock_any_held());
 }
 
 static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 075a632e6c7c..d5a0ee40bf66 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2252,7 +2252,7 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->rph = NULL;
 		return -ENOMEM;
 	}
-	rp->rph->rp = rp;
+	rcu_assign_pointer(rp->rph->rp, rp);
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
@@ -2300,7 +2300,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 		rethook_free(rps[i]->rh);
 #else
-		rps[i]->rph->rp = NULL;
+		rcu_assign_pointer(rps[i]->rph->rp, NULL);
 #endif
 	}
 	mutex_unlock(&kprobe_mutex);


