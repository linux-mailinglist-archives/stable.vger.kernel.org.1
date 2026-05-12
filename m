Return-Path: <stable+bounces-245630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMgHCek2A2ow1wEAu9opvQ
	(envelope-from <stable+bounces-245630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:19:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A9522378
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53E863035671
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF40397B1B;
	Tue, 12 May 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qW8RL5PZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4804395AF5
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593810; cv=none; b=eO5N3Mtl0kteqvvDgZA8lj5SHRFy94Igc4D3qZ0oLWkUes617LuHWx1Z2jr6UTOMHzwicUREvqYpOCIjKos3RUSvsi6hm3KERNFfvz9i+IHAAnrxrEQ91XUZbtfmmkiOOOuKJt/QmhTUnDvaSwjBRumQg6eT9utcQpbrpJpJcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593810; c=relaxed/simple;
	bh=vyCJ/CnnDD3UN7dYXpwZmjJLXyPi/FylfbarDMaS3wI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mmKFNIxw7wM2/mk1VVGNejY2a6l+sFD40GwMHvg4Uc5t/8E9O+GVxDHvLdU3MGh/ldYc9bc0dJzEnwXqP7yXYVrXyRFXbQ/K2wtJfTrsRyKmVQ+KoBkEQ3IAQ0p1PUqmXXrXYFILxyW4j9BvqWchZU5t1bqgBbk2cEoqsFIgC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qW8RL5PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED0EC2BCB0;
	Tue, 12 May 2026 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593809;
	bh=vyCJ/CnnDD3UN7dYXpwZmjJLXyPi/FylfbarDMaS3wI=;
	h=Subject:To:Cc:From:Date:From;
	b=qW8RL5PZH2CAuLJM2RQ1c0uixsR03e9ZLjNrR7vTTBmtojXdv91e4iFVkv+5duU6t
	 ismrCEYASjckW1xJA4bh91GsMqyzzh+bOsiDeW8IbzEaXx1Yi0ZUzEFsnnpQFEucnZ
	 +WaP6SW6vdCyWez4jtne6Thm7M5gNcABTaBPetZw=
Subject: FAILED: patch "[PATCH] tracing/fprobe: Unregister fprobe even if memory allocation" failed to apply to 6.18-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:50:14 +0200
Message-ID: <2026051214-retool-routing-618c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 476A9522378
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245630-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1aec9e5c3e31ce1e28f914427fb7f90b91d310df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051214-retool-routing-618c@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aec9e5c3e31ce1e28f914427fb7f90b91d310df Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 20 Apr 2026 23:00:56 +0900
Subject: [PATCH] tracing/fprobe: Unregister fprobe even if memory allocation
 fails

unregister_fprobe() can fail under memory pressure because of memory
allocation failure, but this maybe called from module unloading, and
usually there is no way to retry it. Moreover. trace_fprobe does not
check the return value.

To fix this problem, unregister fprobe and fprobe_hash_node even if
working memory allocation fails.
Anyway, if the last fprobe is removed, the filter will be freed.

Link: https://lore.kernel.org/all/177669365629.132053.8433032896213721288.stgit@mhiramat.tok.corp.google.com/

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index af9ba7250874..a2b659006e0e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -324,9 +324,10 @@ static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
 	lockdep_assert_held(&fprobe_mutex);
 
 	fprobe_ftrace_active--;
-	if (!fprobe_ftrace_active)
+	if (!fprobe_ftrace_active) {
 		unregister_ftrace_function(&fprobe_ftrace_ops);
-	if (num)
+		ftrace_free_filter(&fprobe_ftrace_ops);
+	} else if (num)
 		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
 }
 
@@ -525,10 +526,10 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 	fprobe_graph_active--;
 	/* Q: should we unregister it ? */
-	if (!fprobe_graph_active)
+	if (!fprobe_graph_active) {
 		unregister_ftrace_graph(&fprobe_graph_ops);
-
-	if (num)
+		ftrace_free_filter(&fprobe_graph_ops.ops);
+	} else if (num)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
@@ -932,15 +933,19 @@ int unregister_fprobe(struct fprobe *fp)
 
 	hlist_array = fp->hlist_array;
 	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
-	if (!addrs) {
-		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
-		goto out;
-	}
+	/*
+	 * This will remove fprobe_hash_node from the hash table even if
+	 * memory allocation fails. However, ftrace_ops will not be updated.
+	 * Anyway, when the last fprobe is unregistered, ftrace_ops is also
+	 * unregistered.
+	 */
+	if (!addrs)
+		pr_warn("Failed to allocate working array. ftrace_ops may not sync.\n");
 
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		if (!delete_fprobe_node(&hlist_array->array[i]) && addrs)
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);


