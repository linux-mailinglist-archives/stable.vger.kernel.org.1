Return-Path: <stable+bounces-247826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PTwEfE7B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:29:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A648B552233
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9963026F3A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DC495535;
	Fri, 15 May 2026 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0/aw1yN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E13FE670
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858926; cv=none; b=rdDBxsPx4zhUi3ciw6a11TRFeKxqMay2qzpo+g3YqRVjs4QGQbbMJCMBZHt5MixIyq6NbG+hiQAjl7hEJ4VNio/FTi07rTkIf00Dr8OaLrpKA7RepkIadBisQD5JWJbcEvaGjo7SxxMg0D+WU9lDdWPSi/nzWttvEgfwl4HKp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858926; c=relaxed/simple;
	bh=uZUKF6GH+Do/tepP8BiUoRKPfwvENe2A6+h1AFgz26o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cora4S0DbAcNhA5ZEai+vDaWTlJdwgX/OXSv2AXx11xTVUsDD3CXUYe3TUYhX9kv+ac0nN58l9ghAW+PrL52Ka1lrmM4Bdu3gV/Yltq1pIvfHbnW80C0UHDj7q+Y3ieZkocboU7QZD8aqVYCMpY7BKusdeLLUUWkn8CES5ozoRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0/aw1yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFADC2BCC7;
	Fri, 15 May 2026 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778858923;
	bh=uZUKF6GH+Do/tepP8BiUoRKPfwvENe2A6+h1AFgz26o=;
	h=Subject:To:Cc:From:Date:From;
	b=c0/aw1yNBjYb9YaF4nNSA2ndqpLMZKcauJLsweptOTYDWSCuyL4gaShaNUKCTUtvE
	 TXFuwylswXHQHLW7oGBywmp1FDbROA3REdrfFkxOmdMKhGr6oG0vfPu+PNFVbXKuO3
	 VRvbF0EiTjFLCnAH3YaFTWWLZY2KhpqAnLzyskcg=
Subject: FAILED: patch "[PATCH] tracing/fprobe: Check the same type fprobe on table as the" failed to apply to 6.18-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 17:28:47 +0200
Message-ID: <2026051547-headless-mutilated-277a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A648B552233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247826-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0ac0058a74ac5765c7ce09ea630f4fdeaf4d80fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051547-headless-mutilated-277a@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ac0058a74ac5765c7ce09ea630f4fdeaf4d80fa Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 20 Apr 2026 23:01:20 +0900
Subject: [PATCH] tracing/fprobe: Check the same type fprobe on table as the
 unregistered one

Commit 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
introduced a different ftrace_ops for entry-only fprobes.

However, when unregistering an fprobe, the kernel only checks if another
fprobe exists at the same address, without checking which type of fprobe
it is.
If different fprobes are registered at the same address, the same address
will be registered in both fgraph_ops and ftrace_ops, but only one of
them will be deleted when unregistering. (the one removed first will not
be deleted from the ops).

This results in junk entries remaining in either fgraph_ops or ftrace_ops.
For example:
 =======
 cd /sys/kernel/tracing

 # 'Add entry and exit events on the same place'
 echo 'f:event1 vfs_read' >> dynamic_events
 echo 'f:event2 vfs_read%return' >> dynamic_events

 # 'Enable both of them'
 echo 1 > events/fprobes/enable
 cat enabled_functions
vfs_read (2)            ->arch_ftrace_ops_list_func+0x0/0x210

 # 'Disable and remove exit event'
 echo 0 > events/fprobes/event2/enable
 echo -:event2 >> dynamic_events

 # 'Disable and remove all events'
 echo 0 > events/fprobes/enable
 echo > dynamic_events

 # 'Add another event'
 echo 'f:event3 vfs_open%return' > dynamic_events
 cat dynamic_events
f:fprobes/event3 vfs_open%return

 echo 1 > events/fprobes/enable
 cat enabled_functions
vfs_open (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
vfs_read (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
 =======

As you can see, an entry for the vfs_read remains.

To fix this issue, when unregistering, the kernel should also check if
there is the same type of fprobes still exist at the same address, and
if not, delete its entry from either fgraph_ops or ftrace_ops.

Link: https://lore.kernel.org/all/177669367993.132053.10553046138528674802.stgit@mhiramat.tok.corp.google.com/

Fixes: 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9b913facfd36..d0a68a2c5eaf 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -92,11 +92,8 @@ static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
 	return ret;
 }
 
-/* Return true if there are synonims */
-static bool delete_fprobe_node(struct fprobe_hlist_node *node)
+static void delete_fprobe_node(struct fprobe_hlist_node *node)
 {
-	bool ret;
-
 	lockdep_assert_held(&fprobe_mutex);
 
 	/* Avoid double deleting and non-inserted nodes */
@@ -105,13 +102,6 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 		rhltable_remove(&fprobe_ip_table, &node->hlist,
 				fprobe_rht_params);
 	}
-
-	rcu_read_lock();
-	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
-				fprobe_rht_params);
-	rcu_read_unlock();
-
-	return ret;
 }
 
 /* Check existence of the fprobe */
@@ -343,6 +333,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return !fp->exit_handler;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We have to check the same type on the list. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp)) {
+			if ((!ftrace && fp->exit_handler) ||
+			    (ftrace && !fp->exit_handler))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
@@ -365,6 +381,29 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return false;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We only need to check fp is there. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp))
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
@@ -551,18 +590,25 @@ struct fprobe_addr_list {
 static int fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
 					 struct fprobe_addr_list *alist)
 {
+	lockdep_assert_in_rcu_read_lock();
+
 	if (!within_module(node->addr, mod))
 		return 0;
 
-	if (delete_fprobe_node(node))
-		return 0;
+	delete_fprobe_node(node);
 	/* If no address list is available, we can't track this address. */
 	if (!alist->addrs)
 		return 0;
+	/*
+	 * Don't care the type here, because all fprobes on the same
+	 * address must be removed eventually.
+	 */
+	if (!rhltable_lookup(&fprobe_ip_table, &node->addr, fprobe_rht_params)) {
+		alist->addrs[alist->index++] = node->addr;
+		if (alist->index == alist->size)
+			return -ENOSPC;
+	}
 
-	alist->addrs[alist->index++] = node->addr;
-	if (alist->index == alist->size)
-		return -ENOSPC;
 	return 0;
 }
 
@@ -933,7 +979,9 @@ static int unregister_fprobe_nolock(struct fprobe *fp)
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]) && addrs)
+		delete_fprobe_node(&hlist_array->array[i]);
+		if (addrs && !fprobe_exists_on_hash(hlist_array->array[i].addr,
+						    fprobe_is_ftrace(fp)))
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);


