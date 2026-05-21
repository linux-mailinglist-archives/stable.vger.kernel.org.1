Return-Path: <stable+bounces-253539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA8TKbMND2qSEgYAu9opvQ
	(envelope-from <stable+bounces-253539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A85A64CD
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B823152B01
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AA3806AA;
	Thu, 21 May 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icZsd+w/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1B3D8902
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368299; cv=none; b=pykmA0hA9eIE0JPUy9b3yh08dwHI34BtCBiEhX9dpDmNmsuMC6DNzFx/1LC42sCS3MM2BKk8CJn0AcpC4SeoBPSrQYVBYPDJEsQqrH0dRrT0gdWedRUigew+BTTKzsvA6elb8U/Fujw0tDYqDAp20sXNRiOMG9l1s6C6bjwRhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368299; c=relaxed/simple;
	bh=S/6ZBDu603/U5YEj8nY14SyPO/8Gis+LchfYmlLmkO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFZOCPwsCj6K46SVpmlvDChlLP05TrU6GpLZv9l4MKNd+TTWK4HZZyAyXhR4/MCTTNgH8CUDPU+uEggVIQY1IEtYIUD7OMkx3NEiKWQAFDppwZFHEPoxvliy4o4JLEgK/0HuOYebUHzUrlEzG4u/5nAAkEs1OemUhEMdA48API8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icZsd+w/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1200E1F000E9;
	Thu, 21 May 2026 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368297;
	bh=QYdNcop6jfthN0hLK+9amSwFt1aDYnFP7pVg57SOGGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=icZsd+w/SwX5v8/bFZywlh/I0rJ9gsdCl23FeIfmuYnf/8pZpJTOjbhC6J72I+uM2
	 Je5cKmUhaLow0QBEpoPrxVtCU5sIt9O36g0TRJ71XNI1ckCplRsVlpYEtrEVPpiuhH
	 cSz+FDJDpRZzDDefyYfoLce/maC+q+CLOD6/8G47b83ia8Z3Jn0LOk1IpklFJD7b5/
	 AMfXXxGTZMUt0+rDttwtuLErA9MAX+NlkTopWN40fI70PCsGwO8uPu4PNrm7Xv0jR9
	 dOuOAj7G+gnE3TNrGl5kRfV45f+WFgUw+worH9Qxqb6KaLEFs8QKfT77Upa4u4eAv0
	 BoYYegAoa4NAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
Date: Thu, 21 May 2026 08:58:12 -0400
Message-ID: <20260521125813.1165339-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521125813.1165339-1-sashal@kernel.org>
References: <2026051547-headless-mutilated-277a@gregkh>
 <20260521125813.1165339-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253539-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 056A85A64CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit aa72812b49104bb5a38272fc9541feb62ca6fd32 ]

fprobe_remove_node_in_module() is called under RCU read locked, but
this invokes kcalloc() if there are more than 8 fprobes installed
on the module. Sashiko warns it because kcalloc() can sleep [1].

 [1] https://sashiko.dev/#/patchset/177552432201.853249.5125045538812833325.stgit%40mhiramat.tok.corp.google.com

To fix this issue, expand the batch size to 128 and do not expand
the fprobe_addr_list, but just cancel walking on fprobe_ip_table,
update fgraph/ftrace_ops and retry the loop again.

Link: https://lore.kernel.org/all/177669367206.132053.1493637946869032744.stgit@mhiramat.tok.corp.google.com/

Fixes: 0de4c70d04a4 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 0ac0058a74ac ("tracing/fprobe: Check the same type fprobe on table as the unregistered one")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fprobe.c | 92 +++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 574f2886cc9e3..37a4352efb4da 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -344,11 +344,10 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 }
 
 #ifdef CONFIG_MODULES
-static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
-			   int reset)
+static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
-	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, 1, 0);
 }
 #endif
 #else
@@ -367,10 +366,9 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 }
 
 #ifdef CONFIG_MODULES
-static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
-			   int reset)
+static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
 }
 #endif
 #endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
@@ -543,7 +541,7 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 #ifdef CONFIG_MODULES
 
-#define FPROBE_IPS_BATCH_INIT 8
+#define FPROBE_IPS_BATCH_INIT 128
 /* instruction pointer address list */
 struct fprobe_addr_list {
 	int index;
@@ -551,45 +549,24 @@ struct fprobe_addr_list {
 	unsigned long *addrs;
 };
 
-static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long addr)
+static int fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
+					 struct fprobe_addr_list *alist)
 {
-	unsigned long *addrs;
-
-	/* Previously we failed to expand the list. */
-	if (alist->index == alist->size)
-		return -ENOSPC;
-
-	alist->addrs[alist->index++] = addr;
-	if (alist->index < alist->size)
+	if (!within_module(node->addr, mod))
 		return 0;
 
-	/* Expand the address list */
-	addrs = kcalloc(alist->size * 2, sizeof(*addrs), GFP_KERNEL);
-	if (!addrs)
-		return -ENOMEM;
-
-	memcpy(addrs, alist->addrs, alist->size * sizeof(*addrs));
-	alist->size *= 2;
-	kfree(alist->addrs);
-	alist->addrs = addrs;
+	if (delete_fprobe_node(node))
+		return 0;
+	/* If no address list is available, we can't track this address. */
+	if (!alist->addrs)
+		return 0;
 
+	alist->addrs[alist->index++] = node->addr;
+	if (alist->index == alist->size)
+		return -ENOSPC;
 	return 0;
 }
 
-static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
-					 struct fprobe_addr_list *alist)
-{
-	if (!within_module(node->addr, mod))
-		return;
-	if (delete_fprobe_node(node))
-		return;
-	/*
-	 * If failed to update alist, just continue to update hlist.
-	 * Therefore, at list user handler will not hit anymore.
-	 */
-	fprobe_addr_list_add(alist, node->addr);
-}
-
 /* Handle module unloading to manage fprobe_ip_table. */
 static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
@@ -598,29 +575,50 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	struct fprobe_hlist_node *node;
 	struct rhashtable_iter iter;
 	struct module *mod = data;
+	bool retry;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
 
 	alist.addrs = kcalloc(alist.size, sizeof(*alist.addrs), GFP_KERNEL);
-	/* If failed to alloc memory, we can not remove ips from hash. */
-	if (!alist.addrs)
-		return NOTIFY_DONE;
+	/*
+	 * If failed to alloc memory, ftrace_ops will not be able to remove ips from
+	 * hash, but we can still remove nodes from fprobe_ip_table, so we can avoid
+	 * the potential wrong callback. So just print a warning here and try to
+	 * continue without address list.
+	 */
+	WARN_ONCE(!alist.addrs,
+		"Failed to allocate memory for fprobe_addr_list, ftrace_ops will not be updated");
 
 	mutex_lock(&fprobe_mutex);
+again:
+	retry = false;
+	alist.index = 0;
 	rhltable_walk_enter(&fprobe_ip_table, &iter);
 	do {
 		rhashtable_walk_start(&iter);
 
 		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
-			fprobe_remove_node_in_module(mod, node, &alist);
+			if (fprobe_remove_node_in_module(mod, node, &alist) < 0) {
+				retry = true;
+				break;
+			}
 
 		rhashtable_walk_stop(&iter);
-	} while (node == ERR_PTR(-EAGAIN));
+	} while (node == ERR_PTR(-EAGAIN) && !retry);
 	rhashtable_walk_exit(&iter);
+	/* Remove any ips from hash table(s) */
+	if (alist.index > 0) {
+		fprobe_remove_ips(alist.addrs, alist.index);
+		/*
+		 * If we break rhashtable walk loop except for -EAGAIN, we need
+		 * to restart looping from start for safety. Anyway, this is
+		 * not a hotpath.
+		 */
+		if (retry)
+			goto again;
+	}
 
-	if (alist.index > 0)
-		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
-- 
2.53.0


