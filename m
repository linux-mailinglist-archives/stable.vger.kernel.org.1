Return-Path: <stable+bounces-46004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94CE8CDBE3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FE3282AF8
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D312837C;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E1128365;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499401; cv=none; b=mUjoUCtOZarZHbpKbwfLR9cNLK8/gL600VtBexyZxhFzn9f8aOtIGaEhbiD4YaVIY/sialBMk4fNpDwd2ipEzM9nTzzWFX1bTTQHJ7SASQnSss6tFEHHWb1ziQw8vYRMUVjCivshXzl7HNGiFPipT7G9VT/7wGJFbzDPiK/f7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499401; c=relaxed/simple;
	bh=1Wy8rfVh+tcDx6TeVrWroMHMwycF9RAXCxOu1SCaAl4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eE3HlPPlD3S0DoFqHij/xvwEQoZc6fTJQfo7Es2hRlWC3B79KaCn73rWiwW38yBkPqFuj+hCv6V/nzaWYk9iRUpxJMiGbiMjvngRIjyBURQLyuOe7nrv12oSwQCL+zrz0OpdRXaHbmqzez23NF8FfrOawrq0C9JdqmmrrPnybe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8211C2BD10;
	Thu, 23 May 2024 21:23:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFuw-00000006l9h-308p;
	Thu, 23 May 2024 17:24:06 -0400
Message-ID: <20240523212406.575903016@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:23:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 4/8] tracefs: Clear EVENT_INODE flag in tracefs_drop_inode()
References: <20240523212258.883756004@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When the inode is being dropped from the dentry, the TRACEFS_EVENT_INODE
flag needs to be cleared to prevent a remount from calling
eventfs_remount() on the tracefs_inode private data. There's a race
between the inode is dropped (and the dentry freed) to where the inode is
actually freed. If a remount happens between the two, the eventfs_inode
could be accessed after it is freed (only the dentry keeps a ref count on
it).

Currently the TRACEFS_EVENT_INODE flag is cleared from the dentry iput()
function. But this is incorrect, as it is possible that the inode has
another reference to it. The flag should only be cleared when the inode is
really being dropped and has no more references. That happens in the
drop_inode callback of the inode, as that gets called when the last
reference of the inode is released.

Remove the tracefs_d_iput() function and move its logic to the more
appropriate tracefs_drop_inode() callback function.

Link: https://lore.kernel.org/linux-trace-kernel/20240523051539.908205106@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Fixes: baa23a8d4360d ("tracefs: Reset permissions on remount if permissions are options")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 9252e0d78ea2..7c29f4afc23d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -426,10 +426,26 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static int tracefs_drop_inode(struct inode *inode)
+{
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	/*
+	 * This inode is being freed and cannot be used for
+	 * eventfs. Clear the flag so that it doesn't call into
+	 * eventfs during the remount flag updates. The eventfs_inode
+	 * gets freed after an RCU cycle, so the content will still
+	 * be safe if the iteration is going on now.
+	 */
+	ti->flags &= ~TRACEFS_EVENT_INODE;
+
+	return 1;
+}
+
 static const struct super_operations tracefs_super_operations = {
 	.alloc_inode    = tracefs_alloc_inode,
 	.free_inode     = tracefs_free_inode,
-	.drop_inode     = generic_delete_inode,
+	.drop_inode     = tracefs_drop_inode,
 	.statfs		= simple_statfs,
 	.show_options	= tracefs_show_options,
 };
@@ -455,22 +471,7 @@ static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return !(ei && ei->is_freed);
 }
 
-static void tracefs_d_iput(struct dentry *dentry, struct inode *inode)
-{
-	struct tracefs_inode *ti = get_tracefs(inode);
-
-	/*
-	 * This inode is being freed and cannot be used for
-	 * eventfs. Clear the flag so that it doesn't call into
-	 * eventfs during the remount flag updates. The eventfs_inode
-	 * gets freed after an RCU cycle, so the content will still
-	 * be safe if the iteration is going on now.
-	 */
-	ti->flags &= ~TRACEFS_EVENT_INODE;
-}
-
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_d_iput,
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
 };
-- 
2.43.0



