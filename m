Return-Path: <stable+bounces-47660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71368D3F0B
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 21:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE901F23D6A
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B71C688F;
	Wed, 29 May 2024 19:48:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C981C6880;
	Wed, 29 May 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012110; cv=none; b=ZqSxaVfLwnrq//5y8NnCnAqmU19SdWWJsZyjRjifEErivTSagX2ixZVxeexxnxhnaDsvCCJmaFSIPv1XzhpRIaBsaCWjJC4hE1ze6ozhBPNnhpfHM8tpukR5FLiR1TuVnT1gViq+I1mZ5OLYtFi3atyM0EPAp/xckDdIOBFn6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012110; c=relaxed/simple;
	bh=mBYHB0w2lJlfGEgtklPsCNe/hCVdcPJEF9Af5j6pvzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMPXY6zbgZ0TPHnRBL0iPz0Uv8Bdzzr0qBDd8E23dUCCp5mNCeIemQwwvUj70GnG9HuqC3OCcLv10yR8pyeB1sPdM8q8TyCKNnla21ayL/wxra46Sb2k1piIs71h5UCpXv2+WO9Ps55nccWG2film5cq39nMirBlE/8roPMPAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D7FC113CC;
	Wed, 29 May 2024 19:48:28 +0000 (UTC)
Date: Wed, 29 May 2024 15:48:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Linux regressions mailing list
 <regressions@lists.linux.dev>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240529154824.2db8133a@rorschach.local.home>
In-Reply-To: <20240529144757.79d09eeb@rorschach.local.home>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
	<20240527183139.42b6123c@rorschach.local.home>
	<CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
	<20240528144743.149e351b@rorschach.local.home>
	<CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
	<20240529144757.79d09eeb@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 14:47:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Let me make a debug patch (that crashes on this issue) for that kernel,
> and perhaps you could bisect it?

Can you try this on 6.6-rc1 and see if it gives you any other splats?

Hmm, you can switch it to WARN_ON and that way it may not crash the
machine, and you can use dmesg to get the output.

Thanks,

-- Steve


diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de5b72216b1a..a090495e78c9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -39,13 +39,17 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	ti->flags = 0;
+	ti->magic = 20240823;
 
 	return &ti->vfs_inode;
 }
 
 static void tracefs_free_inode(struct inode *inode)
 {
-	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	BUG_ON(ti->magic != 20240823);
+	kmem_cache_free(tracefs_inode_cachep, ti);
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -147,16 +151,6 @@ static const struct inode_operations tracefs_dir_inode_operations = {
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
-struct inode *tracefs_get_inode(struct super_block *sb)
-{
-	struct inode *inode = new_inode(sb);
-	if (inode) {
-		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
-	}
-	return inode;
-}
-
 struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
@@ -384,6 +378,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
 		return;
 
 	ti = get_tracefs(inode);
+	BUG_ON(ti->magic != 20240823);
 	if (ti && ti->flags & TRACEFS_EVENT_INODE)
 		eventfs_set_ef_status_free(dentry);
 	iput(inode);
@@ -568,6 +563,18 @@ struct dentry *eventfs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+struct inode *tracefs_get_inode(struct super_block *sb)
+{
+	struct inode *inode = new_inode(sb);
+
+	BUG_ON(sb->s_op != &tracefs_super_operations);
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	}
+	return inode;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 69c2b1d87c46..9f6f303a9e58 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -9,6 +9,7 @@ enum {
 struct tracefs_inode {
 	unsigned long           flags;
 	void                    *private;
+	unsigned long		magic;
 	struct inode            vfs_inode;
 };
 

