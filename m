Return-Path: <stable+bounces-4796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A298064E1
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 03:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2EC1F21744
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3EE566C;
	Wed,  6 Dec 2023 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoYWQXcs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC041856
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 02:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DAEC433C7;
	Wed,  6 Dec 2023 02:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701828908;
	bh=S33V7R2udorBvtquhqz/QBRaf4aGyfRlNwWWMXTv/Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IoYWQXcsejxSvaQ7oKGwiZskf14prHqlX3ntnRD2vUCUhe31S15OBX8flJMNbGIBR
	 S1nssGguU9hpYaehqxsTNHk9sWj997AMzxVovBTwJEfylhBZFtD5XMfhwo2EpLDySE
	 dLrebiToEF1KBgUB6AXLGhubxWTSxpvTQ/mmM294NnLYue62O9Sv69Zf3FhyEJlJvM
	 0u5H+t9/0TyXaxKleT9S+IqZJGnhtyy85cAlu+aLfE7l6W6I94jC9/tJVJwsX4FwY7
	 EzLVZJuMsZHDPXbu5HV8iUhcqxWOu1MuyPOVRG1bVdOeCUfbnGm5oGvC8F71Qu3fEp
	 E3d47YC2K06Hw==
From: mhiramat@kernel.org
To: stable@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5.15.y] kprobes: consistent rcu api usage for kretprobe holder
Date: Wed,  6 Dec 2023 11:14:58 +0900
Message-ID: <20231206021458.90689-1-mhiramat@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <2023120319-failing-aviator-303a@gregkh>
References: <2023120319-failing-aviator-303a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

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
(cherry picked from commit d839a656d0f3caca9f96e9bf912fd394ac6a11bc)
---
 include/linux/kprobes.h | 7 ++-----
 kernel/kprobes.c        | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 2cbb6a51c291..24b0eaa5de30 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -139,7 +139,7 @@ static inline int kprobe_ftrace(struct kprobe *p)
  *
  */
 struct kretprobe_holder {
-	struct kretprobe	*rp;
+	struct kretprobe __rcu *rp;
 	refcount_t		ref;
 };
 
@@ -224,10 +224,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return READ_ONCE(ri->rph->rp);
+	return rcu_dereference_check(ri->rph->rp, rcu_read_lock_any_held());
 }
 
 #else /* CONFIG_KRETPROBES */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6cf561322bbe..07d36cee2a80 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2044,7 +2044,7 @@ int register_kretprobe(struct kretprobe *rp)
 	if (!rp->rph)
 		return -ENOMEM;
 
-	rp->rph->rp = rp;
+	rcu_assign_pointer(rp->rph->rp, rp);
 	for (i = 0; i < rp->maxactive; i++) {
 		inst = kzalloc(sizeof(struct kretprobe_instance) +
 			       rp->data_size, GFP_KERNEL);
@@ -2101,7 +2101,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	for (i = 0; i < num; i++) {
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
-		rps[i]->rph->rp = NULL;
+		rcu_assign_pointer(rps[i]->rph->rp, NULL);
 	}
 	mutex_unlock(&kprobe_mutex);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog


