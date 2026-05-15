Return-Path: <stable+bounces-247670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHxPNy4LB2pZrAIAu9opvQ
	(envelope-from <stable+bounces-247670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:01:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD754EFBA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A47DA311A79C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197B47D92E;
	Fri, 15 May 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz8g+cCO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D247CC99
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844749; cv=none; b=CmgZPzXTTeyYbQByoQW/xlzuArdlZLu3NuHuwswXLM++vapI0pvdFTVcudra6cYIxIRXykUarfX/VbdvMFcILJEc3r9QWNGgd0DFuK3fVPpuiSu5BZx5HS5LIW8fod4RSExZ866jtp1ItKHCtJKO5d6NPjYlBetq0MkUW/NHrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844749; c=relaxed/simple;
	bh=NgN3Jocr+PDSkDks8vfb8X20cv2xjRr42+byDG9Y0fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0p4oPTy8R0zDIhUgurkJcETphO8DhvySPusVGWV49epHg2IbSJSpPDoqhokQ1Qb9XRnuTO9sVxLn236Y4+cHjUMcQN/idI8KdoXncxF6tFD25GSZE8ZDjCUdxOG5TSBP0dRVcG/3m6vw+jtwuIhwFdvbJSUSbT83JOphsNrwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz8g+cCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6981C2BCB0;
	Fri, 15 May 2026 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844749;
	bh=NgN3Jocr+PDSkDks8vfb8X20cv2xjRr42+byDG9Y0fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iz8g+cCO5mxV2rOLeEVyEkoe5VJSJCb754mqmfriPw+53yn9fvNJn+wvPlzb/MGA9
	 i6YRM2sEVjWhHYSpcwq3BSh/0wPOl3SLG7TBFT4mWroBAPoefCxRL6UH7FLwUA8KTZ
	 oK8X33DMJxgxA+j4tUMVg7KVp+3VhWr57CKN60qLwRMkXemsp7QuuvqJ+LEd0hZ9kN
	 FTophxIQep6862smqKt6VZa6FUItL5Z3nQ/pQVOCHcnSEWFYtKDxhmwDVfESadCfl+
	 dD6uhIh/02iE/KmNp0Xs7bZEb2HMUysdq+ClrilU3OGK07mofS0h5bW++J8vXj2j9q
	 Z7XTEif2+4VPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Menglong Dong <dongml2@chinatelecom.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] tracing: fprobe: optimization for entry only case
Date: Fri, 15 May 2026 07:32:24 -0400
Message-ID: <20260515113226.2979191-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515113226.2979191-1-sashal@kernel.org>
References: <2026051206-mocker-bonfire-ac1c@gregkh>
 <20260515113226.2979191-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9ECD754EFBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247670-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,chinatelecom.cn,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Action: no action

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit 2c67dc457bc67367dc8fcd8f471ce2d5bb5f7b2b ]

For now, fgraph is used for the fprobe, even if we need trace the entry
only. However, the performance of ftrace is better than fgraph, and we
can use ftrace_ops for this case.

Then performance of kprobe-multi increases from 54M to 69M. Before this
commit:

  $ ./benchs/run_bench_trigger.sh kprobe-multi
  kprobe-multi   :   54.663 ± 0.493M/s

After this commit:

  $ ./benchs/run_bench_trigger.sh kprobe-multi
  kprobe-multi   :   69.447 ± 0.143M/s

Mitigation is disable during the bench testing above.

Link: https://lore.kernel.org/all/20251015083238.2374294-2-dongml2@chinatelecom.cn/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 845947aca681 ("tracing/fprobe: Remove fprobe from hash in failure path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fprobe.c | 128 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9db0a4e331132..66fa49b0cf27a 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -252,8 +252,106 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+/* ftrace_ops callback, this processes fprobes which have only entry_handler. */
+static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
+	struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
+	struct fprobe *fp;
+	int bit;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	/*
+	 * ftrace_test_recursion_trylock() disables preemption, but
+	 * rhltable_lookup() checks whether rcu_read_lcok is held.
+	 * So we take rcu_read_lock() here.
+	 */
+	rcu_read_lock();
+	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
+
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
+			continue;
+
+		if (fprobe_shared_with_kprobes(fp))
+			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
+		else
+			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
+	}
+	rcu_read_unlock();
+	ftrace_test_recursion_unlock(bit);
+}
+NOKPROBE_SYMBOL(fprobe_ftrace_entry);
+
+static struct ftrace_ops fprobe_ftrace_ops = {
+	.func	= fprobe_ftrace_entry,
+	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+};
+static int fprobe_ftrace_active;
+
+static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 0, 0);
+	if (ret)
+		return ret;
+
+	if (!fprobe_ftrace_active) {
+		ret = register_ftrace_function(&fprobe_ftrace_ops);
+		if (ret) {
+			ftrace_free_filter(&fprobe_ftrace_ops);
+			return ret;
+		}
+	}
+	fprobe_ftrace_active++;
+	return 0;
+}
+
+static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
+{
+	lockdep_assert_held(&fprobe_mutex);
+
+	fprobe_ftrace_active--;
+	if (!fprobe_ftrace_active)
+		unregister_ftrace_function(&fprobe_ftrace_ops);
+	if (num)
+		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
+}
+
+static bool fprobe_is_ftrace(struct fprobe *fp)
+{
+	return !fp->exit_handler;
+}
+#else
+static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
+{
+	return -ENOENT;
+}
+
+static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
+{
+}
+
+static bool fprobe_is_ftrace(struct fprobe *fp)
+{
+	return false;
+}
+#endif
+
+/* fgraph_ops callback, this processes fprobes which have exit_handler. */
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -289,7 +387,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 				if (node->addr != func)
 					continue;
 				fp = READ_ONCE(node->fp);
-				if (fp && !fprobe_disabled(fp))
+				if (fp && !fprobe_disabled(fp) && !fprobe_is_ftrace(fp))
 					fp->nmissed++;
 			}
 			return 0;
@@ -309,7 +407,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		if (node->addr != func)
 			continue;
 		fp = READ_ONCE(node->fp);
-		if (!fp || fprobe_disabled(fp))
+		if (unlikely(!fp || fprobe_disabled(fp) || fprobe_is_ftrace(fp)))
 			continue;
 
 		data_size = fp->entry_data_size;
@@ -337,7 +435,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -376,7 +474,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
@@ -498,9 +596,14 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0)
+	if (alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+		ftrace_set_filter_ips(&fprobe_ftrace_ops,
+				      alist.addrs, alist.index, 1, 0);
+#endif
+	}
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -735,7 +838,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 		return ret;
 
 	hlist_array = fp->hlist_array;
-	ret = fprobe_graph_add_ips(addrs, num);
+	if (fprobe_is_ftrace(fp))
+		ret = fprobe_ftrace_add_ips(addrs, num);
+	else
+		ret = fprobe_graph_add_ips(addrs, num);
+
 	if (!ret) {
 		add_fprobe_hash(fp);
 		for (i = 0; i < hlist_array->size; i++) {
@@ -830,7 +937,10 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	fprobe_graph_remove_ips(addrs, count);
+	if (fprobe_is_ftrace(fp))
+		fprobe_ftrace_remove_ips(addrs, count);
+	else
+		fprobe_graph_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.53.0


