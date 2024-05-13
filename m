Return-Path: <stable+bounces-43717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C98C4419
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEB61F22799
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55B56443;
	Mon, 13 May 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="umozCd7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B5539C
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613856; cv=none; b=e45AzbNS/iQOAIoYsIkK0tUi9Jbf2lghxr3RZN2fOXKuxpv9COLI/mNECJEpf77MwyUJ3rDCFo2Hmgtry7z1eedBH7PLVXyCaf4ihQVCC2N1xSW6FlM2hm+Ai3Ao95GHqyn0pSyEaEnAKFKtLCAWn5v8jNpJDAyoSDSAaefmBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613856; c=relaxed/simple;
	bh=Cjd+urLOc3ubsrMLzF565MoM3IAWsEAwTxzrnMGAPtM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pZcsdy5zew4/8JsdAFqq0bFkrLS6EXxdjnRaxfaFS8Caby4ujwxAJBBj3KIrqhOEj63drz1kfz+fFe+OOwv3XWvi3laVJUxvoK3dFrpq/rbVDFf4eIgV7r9AuSlig6NCdXrT5wIdz7WmATrzWyZ7EZoW1/Ja3slX5g9RnxMRavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=umozCd7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B1BC32782;
	Mon, 13 May 2024 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613856;
	bh=Cjd+urLOc3ubsrMLzF565MoM3IAWsEAwTxzrnMGAPtM=;
	h=Subject:To:Cc:From:Date:From;
	b=umozCd7WTr3CuJMbiUw3lvU+OuQV/LYAvBLao19wW3mD/1ZeQSSxCaw+e3L9rhuCP
	 /UQ8CK1XRHpH35C45bNTDohJVYrxE5Kyx+EtZ9UTbzMLNEDlzQ6kH78m6tirVZMxY1
	 8WZwXwl6a4js/hXqKAQDg+TbHwI9OYMprOX/bkaE=
Subject: FAILED: patch "[PATCH] eventfs: Free all of the eventfs_inode after RCU" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:24:13 +0200
Message-ID: <2024051313-twilight-disposal-0184@gregkh>
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
git cherry-pick -x ee4e0379475e4fe723986ae96293e465014fa8d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051313-twilight-disposal-0184@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

ee4e0379475e ("eventfs: Free all of the eventfs_inode after RCU")
b63db58e2fa5 ("eventfs/tracing: Add callback for release of an eventfs_inode")
c3137ab6318d ("eventfs: Create eventfs_root_inode to store dentry")
264424dfdd5c ("eventfs: Restructure eventfs_inode structure to be more condensed")
5a49f996046b ("eventfs: Warn if an eventfs_inode is freed without is_freed being set")
43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
408600be78cd ("eventfs: Remove unused d_parent pointer field")
49304c2b93e4 ("tracefs: dentry lookup crapectomy")
4fa4b010b83f ("eventfs: Initialize the tracefs inode properly")
29142dc92c37 ("tracefs: remove stale 'update_gid' code")
834bf76add3e ("eventfs: Save directory inodes in the eventfs_inode structure")
1057066009c4 ("eventfs: Use kcalloc() instead of kzalloc()")
852e46e239ee ("eventfs: Do not create dentries nor inodes in iterate_shared")
53c41052ba31 ("eventfs: Have the inodes all for files and directories all be the same")
1de94b52d5e8 ("eventfs: Shortcut eventfs_iterate() by skipping entries already read")
704f960dbee2 ("eventfs: Read ei->entries before ei->children in eventfs_iterate()")
1e4624eb5a0e ("eventfs: Do ctx->pos update for all iterations in eventfs_iterate()")
e109deadb733 ("eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set")
8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
493ec81a8fb8 ("eventfs: Stop using dcache_readdir() for getdents()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee4e0379475e4fe723986ae96293e465014fa8d9 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 2 May 2024 16:08:22 -0400
Subject: [PATCH] eventfs: Free all of the eventfs_inode after RCU

The freeing of eventfs_inode via a kfree_rcu() callback. But the content
of the eventfs_inode was being freed after the last kref. This is
dangerous, as changes are being made that can access the content of an
eventfs_inode from an RCU loop.

Instead of using kfree_rcu() use call_rcu() that calls a function to do
all the freeing of the eventfs_inode after a RCU grace period has expired.

Link: https://lore.kernel.org/linux-trace-kernel/20240502200905.370261163@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 43aa6f97c2d03 ("eventfs: Get rid of dentry pointers without refcounts")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f5510e26f0f6..cc8b838bbe62 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -73,6 +73,21 @@ enum {
 
 #define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
 
+static void free_ei_rcu(struct rcu_head *rcu)
+{
+	struct eventfs_inode *ei = container_of(rcu, struct eventfs_inode, rcu);
+	struct eventfs_root_inode *rei;
+
+	kfree(ei->entry_attrs);
+	kfree_const(ei->name);
+	if (ei->is_events) {
+		rei = get_root_inode(ei);
+		kfree(rei);
+	} else {
+		kfree(ei);
+	}
+}
+
 /*
  * eventfs_inode reference count management.
  *
@@ -85,7 +100,6 @@ static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
 	const struct eventfs_entry *entry;
-	struct eventfs_root_inode *rei;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
@@ -95,14 +109,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	kfree(ei->entry_attrs);
-	kfree_const(ei->name);
-	if (ei->is_events) {
-		rei = get_root_inode(ei);
-		kfree_rcu(rei, ei.rcu);
-	} else {
-		kfree_rcu(ei, rcu);
-	}
+	call_rcu(&ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)


