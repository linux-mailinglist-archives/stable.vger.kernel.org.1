Return-Path: <stable+bounces-36142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41789A2A9
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACCE1F248BF
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E016FF31;
	Fri,  5 Apr 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPuXUtCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524116C858;
	Fri,  5 Apr 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335095; cv=none; b=nkDi5Qh8mzY0agm1i4AjBibd8P+QWJxJXag0TqFFs2Pc1ZTCCmfxxb0UBYYoTnESCu1B8tRufLxFg7/3zycg2/ys7ltfh0aFsLBN+UlDdD4sHqTN7qArdrVOThavJbOZ1c7ZrB/N6SUtRkkwErufH+LsJZgz9RAgPO1kJPx/xmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335095; c=relaxed/simple;
	bh=kXq93UKEEFxWN1e6sPwHdWtAfUO1m9+Kw69vUo17i50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2u9GMs62titfb7sNS6YkKZ6XeEh3mqDdT1OBEyDkXInXGAiIKUUAehR0bwRPLSbbgrPmtZ8vZqZTpuw6kp3TPPt7oYjR/+9X9ZLS+elHzv4SNK5Lm1J5+SjirCvStLD9AmokQSRF18fqwU47X0eZS1jHSDwjdLk4p9pPFL7+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPuXUtCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C6C433F1;
	Fri,  5 Apr 2024 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712335095;
	bh=kXq93UKEEFxWN1e6sPwHdWtAfUO1m9+Kw69vUo17i50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPuXUtCC7qWy92Z5r7iBKZk2zCNHVcijzPnPZRlaEVrdwPlzCXFq7wpGqAxFeCva+
	 fsN8TM1+0g3JRcXOm6cTc5GbPHZ+87CvFO3eDJbWKOQv2E4jrap/btDdWs8K/rzap+
	 /UzwDXRsQJZ3Z/RIXA2gmvVGPhwMpV4YHNv+Rnt8Y5Is5UMoSZpOFkTyd7S/BI3EK/
	 cQBhbdhIqklwxvpdgrTbjkHcWU0rXWmxKUNBqJ7vo4fS9DXii7z6pZZFe+Ns2IBVRe
	 /GOkudQAQ6G6xdin3b8xgq1pcpWSu2A+NhUXQiZ4Uu7fMY49V4R30S5tLJvhvwUUUT
	 a1TNZZkxXnehA==
From: Andrii Nakryiko <andrii@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com,
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com,
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.6.y 2/2] bpf: support deferring bpf_link dealloc to after RCU grace period
Date: Fri,  5 Apr 2024 09:38:06 -0700
Message-ID: <20240405163806.45495-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405163806.45495-1-andrii@kernel.org>
References: <2024040548-lid-mahogany-fd86@gregkh>
 <20240405163806.45495-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF link for some program types is passed as a "context" which can be
used by those BPF programs to look up additional information. E.g., for
multi-kprobes and multi-uprobes, link is used to fetch BPF cookie values.

Because of this runtime dependency, when bpf_link refcnt drops to zero
there could still be active BPF programs running accessing link data.

This patch adds generic support to defer bpf_link dealloc callback to
after RCU GP, if requested. This is done by exposing two different
deallocation callbacks, one synchronous and one deferred. If deferred
one is provided, bpf_link_free() will schedule dealloc_deferred()
callback to happen after RCU GP.

BPF is using two flavors of RCU: "classic" non-sleepable one and RCU
tasks trace one. The latter is used when sleepable BPF programs are
used. bpf_link_free() accommodates that by checking underlying BPF
program's sleepable flag, and goes either through normal RCU GP only for
non-sleepable, or through RCU tasks trace GP *and* then normal RCU GP
(taking into account rcu_trace_implies_rcu_gp() optimization), if BPF
program is sleepable.

We use this for multi-kprobe and multi-uprobe links, which dereference
link during program run. We also preventively switch raw_tp link to use
deferred dealloc callback, as upcoming changes in bpf-next tree expose
raw_tp link data (specifically, cookie value) to BPF program at runtime
as well.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20240328052426.3042617-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce)
---
 include/linux/bpf.h      | 16 +++++++++++++++-
 kernel/bpf/syscall.c     | 35 ++++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c |  4 ++--
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9b08d792fa95..2ebb5d4d43dc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1524,12 +1524,26 @@ struct bpf_link {
 	enum bpf_link_type type;
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
-	struct work_struct work;
+	/* rcu is used before freeing, work can be used to schedule that
+	 * RCU-based freeing before that, so they never overlap
+	 */
+	union {
+		struct rcu_head rcu;
+		struct work_struct work;
+	};
 };
 
 struct bpf_link_ops {
 	void (*release)(struct bpf_link *link);
+	/* deallocate link resources callback, called without RCU grace period
+	 * waiting
+	 */
 	void (*dealloc)(struct bpf_link *link);
+	/* deallocate link resources callback, called after RCU grace period;
+	 * if underlying BPF program is sleepable we go through tasks trace
+	 * RCU GP and then "classic" RCU GP
+	 */
+	void (*dealloc_deferred)(struct bpf_link *link);
 	int (*detach)(struct bpf_link *link);
 	int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_prog,
 			   struct bpf_prog *old_prog);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4b7d186c7622..4902a7487f07 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2866,17 +2866,46 @@ void bpf_link_inc(struct bpf_link *link)
 	atomic64_inc(&link->refcnt);
 }
 
+static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
+{
+	struct bpf_link *link = container_of(rcu, struct bpf_link, rcu);
+
+	/* free bpf_link and its containing memory */
+	link->ops->dealloc_deferred(link);
+}
+
+static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_link_defer_dealloc_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
+}
+
 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
+	bool sleepable = false;
+
 	bpf_link_free_id(link->id);
 	if (link->prog) {
+		sleepable = link->prog->aux->sleepable;
 		/* detach BPF program, clean up used resources */
 		link->ops->release(link);
 		bpf_prog_put(link->prog);
 	}
-	/* free bpf_link and its containing memory */
-	link->ops->dealloc(link);
+	if (link->ops->dealloc_deferred) {
+		/* schedule BPF link deallocation; if underlying BPF program
+		 * is sleepable, we need to first wait for RCU tasks trace
+		 * sync, then go through "classic" RCU grace period
+		 */
+		if (sleepable)
+			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
+		else
+			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
+	}
+	if (link->ops->dealloc)
+		link->ops->dealloc(link);
 }
 
 static void bpf_link_put_deferred(struct work_struct *work)
@@ -3381,7 +3410,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
 	.release = bpf_raw_tp_link_release,
-	.dealloc = bpf_raw_tp_link_dealloc,
+	.dealloc_deferred = bpf_raw_tp_link_dealloc,
 	.show_fdinfo = bpf_raw_tp_link_show_fdinfo,
 	.fill_link_info = bpf_raw_tp_link_fill_link_info,
 };
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4d49a9f47e68..1e79084a9d9d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2639,7 +2639,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
-	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
@@ -3081,7 +3081,7 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
 
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
-	.dealloc = bpf_uprobe_multi_link_dealloc,
+	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 };
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
-- 
2.43.0


