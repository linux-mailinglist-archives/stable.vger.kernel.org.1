Return-Path: <stable+bounces-43718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCAC8C441A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C712B227AA
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D51EB5C;
	Mon, 13 May 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUWVlyog"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6831DA20
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613865; cv=none; b=bgghK//wHZ0lMWznUu2LXO8DLXrrikvUDaevzROqmrjJYZGn2T5OQ7aNP2EpIGYBS24D9Tz3YKFl+0ekUmBFc3dEC1r2tm6Jm0E2AcmMh4IgJzzja12d/Hm4irsM1x/7srVxu0rP2V2sDSAR9lyDu7am6Qu5NOhnxS/hOiesQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613865; c=relaxed/simple;
	bh=BkTQlzFNZVMy65ERyzG9/fk9sZ3P+piqhq1XaMaORBs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ppss74dmCufIS+Yu9piTTI9q2ko/qr6mjwoFpGVTTzWqWkOZbVhIJDfZ8jt9Hea2DCVDrBkqFji+MFKHwd8++fV3hKza0w2I0oFXXQ2n6EgbHEt/9reP27xlQuz/WxiIzjKbTV1TY2Fx40yyLaUDdbsPjyNv9sA9ju/Th1YfRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUWVlyog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E1CC113CC;
	Mon, 13 May 2024 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613865;
	bh=BkTQlzFNZVMy65ERyzG9/fk9sZ3P+piqhq1XaMaORBs=;
	h=Subject:To:Cc:From:Date:From;
	b=gUWVlyog0h8bp4ZocQFVLtsIa3ztbiYLjWiA9sJWe635IAH1Ohbk+dZT2JD8a9CDm
	 cOF6fZSGvcVgR6MOGDAS+B1Ib3QB9dTwQRB4GVN0es7Ieo81cEQzM1Qk3xOFFKZIeX
	 bJufuSt96VLa0GbQE79QyDdZ2tPKu3L1pfuHSVj4=
Subject: FAILED: patch "[PATCH] eventfs: Free all of the eventfs_inode after RCU" failed to apply to 6.8-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:24:14 +0200
Message-ID: <2024051314-unwilling-outmatch-c624@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x ee4e0379475e4fe723986ae96293e465014fa8d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051314-unwilling-outmatch-c624@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

ee4e0379475e ("eventfs: Free all of the eventfs_inode after RCU")
b63db58e2fa5 ("eventfs/tracing: Add callback for release of an eventfs_inode")
c3137ab6318d ("eventfs: Create eventfs_root_inode to store dentry")

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


