Return-Path: <stable+bounces-246530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JY4IvdwA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:27:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DD52794F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D00732A55AA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522A36C9E4;
	Tue, 12 May 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kr9rM5Ur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6133B6CC;
	Tue, 12 May 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609463; cv=none; b=kqychCdL4mBw59j/6UL0GF0y3UprcS4BYBgxoGIX2aHk00ELR4hr8fdtYT5mAnyf50+QTOUDgYusE2Aw8NqRSN0gqhE4UvTQ/K2zFokmz1Laqo4aNvNZMj35xLRUeDHQPP4JbBMFUEOqbzr4dDmkXR19TcyWEFqUe/NQeISO5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609463; c=relaxed/simple;
	bh=N7Uan/uPXqpqL8WjfS9t75iS7ajjY+0wTGZZV465/js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl4c0BIeuOqHY3gxbItyWmRpIkm1eP4EdkZ0cY2rAO6esM3Ov0ty6slyMLRIOLG4kZUOPAVA3RDYtj8yeuj7iz4sIq8+ROGg2N5uX83xV0uB38XWv59y1DNHFqes9Yq6FZPCsCECsEahxebvfHejXL/Tczu0nODdC+cKAjgcpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kr9rM5Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C459C2BCB0;
	Tue, 12 May 2026 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609463;
	bh=N7Uan/uPXqpqL8WjfS9t75iS7ajjY+0wTGZZV465/js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kr9rM5UrkIRJNAHSeHiKakvwywlG75iBQkMheAlIxqd/xen310Z9QReqvE02lMAmP
	 oS9JB8hsHl8wjw3+uNz8qzMIP2Z2GHKP/jthydgraoZaFh3BxHaqjROCEEi63UNWyk
	 bSA7C7/AfKVoeUgZRY3grEmFXy7KPuyL14t6+JWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 7.0 164/307] tracing/fprobe: Check the same type fprobe on table as the unregistered one
Date: Tue, 12 May 2026 19:39:19 +0200
Message-ID: <20260512173943.585472491@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 296DD52794F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246530-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

commit 0ac0058a74ac5765c7ce09ea630f4fdeaf4d80fa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/fprobe.c |   82 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 17 deletions(-)

--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -92,11 +92,8 @@ static int insert_fprobe_node(struct fpr
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
@@ -105,13 +102,6 @@ static bool delete_fprobe_node(struct fp
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
@@ -343,6 +333,32 @@ static bool fprobe_is_ftrace(struct fpro
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
@@ -365,6 +381,29 @@ static bool fprobe_is_ftrace(struct fpro
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
@@ -553,18 +592,25 @@ struct fprobe_addr_list {
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
 
@@ -935,7 +981,9 @@ static int unregister_fprobe_nolock(stru
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



