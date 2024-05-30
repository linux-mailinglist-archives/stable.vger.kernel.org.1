Return-Path: <stable+bounces-47712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658B8D4D64
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FBE1C23418
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51495186E49;
	Thu, 30 May 2024 14:00:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FED186E32;
	Thu, 30 May 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077628; cv=none; b=Y4arpDiQU0cVrmzoetzNkiD6tIG/W6jgWDbR1xKm6Ww5qtR8YNW1yfgLM4DFYfzNwzrZlO+qI/A6RcaS+BqteMldky8J5rSfrJHUInC9s/+e3UAf/Inw3t8/mhSnD+BbI+MledYIYCbVr/dMmZfmMf4PJc5ZX7KTylp3qtQL9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077628; c=relaxed/simple;
	bh=wCx8iiEp261jvrvjM1hzx6frOs/knK+xtBsnK/gZCnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJ/8hzh4ZpQ+8TMDwx3V5jeqP6wa0vdSfPu/h3gS6oadKhTBctABQbHIzhy0uuFDfIfzkgcqmXg0eBQ0y5k0SFB1XWQpiBnjE43GRVx/k/SjvDXnz9Tf/eyw1hX9gFmnyq38tYHe8ibE099jJAGjYIJuYZc7ClYHj0Blxp3mUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F32C3277B;
	Thu, 30 May 2024 14:00:25 +0000 (UTC)
Date: Thu, 30 May 2024 09:59:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Linux regressions mailing list
 <regressions@lists.linux.dev>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240530095953.0020dff9@rorschach.local.home>
In-Reply-To: <CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
	<20240527183139.42b6123c@rorschach.local.home>
	<CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
	<20240528144743.149e351b@rorschach.local.home>
	<CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
	<20240529144757.79d09eeb@rorschach.local.home>
	<20240529154824.2db8133a@rorschach.local.home>
	<CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 May 2024 16:02:37 +0300
Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:

> applied your patch and here's the output.
>=20

Unfortunately, it doesn't give me any new information. I added one more
BUG on, want to try this? Otherwise, I'm pretty much at a lost. :-/

-- Steve

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de5b72216b1a..a090495e78c9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -39,13 +39,17 @@ static struct inode *tracefs_alloc_inode(struct super_b=
lock *sb)
 		return NULL;
=20
 	ti->flags =3D 0;
+	ti->magic =3D 20240823;
=20
 	return &ti->vfs_inode;
 }
=20
 static void tracefs_free_inode(struct inode *inode)
 {
-	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+	struct tracefs_inode *ti =3D get_tracefs(inode);
+
+	BUG_ON(ti->magic !=3D 20240823);
+	kmem_cache_free(tracefs_inode_cachep, ti);
 }
=20
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -147,16 +151,6 @@ static const struct inode_operations tracefs_dir_inode=
_operations =3D {
 	.rmdir		=3D tracefs_syscall_rmdir,
 };
=20
-struct inode *tracefs_get_inode(struct super_block *sb)
-{
-	struct inode *inode =3D new_inode(sb);
-	if (inode) {
-		inode->i_ino =3D get_next_ino();
-		inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
-	}
-	return inode;
-}
-
 struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
@@ -384,6 +378,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, =
struct inode *inode)
 		return;
=20
 	ti =3D get_tracefs(inode);
+	BUG_ON(ti->magic !=3D 20240823);
 	if (ti && ti->flags & TRACEFS_EVENT_INODE)
 		eventfs_set_ef_status_free(dentry);
 	iput(inode);
@@ -568,6 +563,18 @@ struct dentry *eventfs_end_creating(struct dentry *den=
try)
 	return dentry;
 }
=20
+struct inode *tracefs_get_inode(struct super_block *sb)
+{
+	struct inode *inode =3D new_inode(sb);
+
+	BUG_ON(sb->s_op !=3D &tracefs_super_operations);
+	if (inode) {
+		inode->i_ino =3D get_next_ino();
+		inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
+	}
+	return inode;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 69c2b1d87c46..9059b8b11bb6 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -9,12 +9,15 @@ enum {
 struct tracefs_inode {
 	unsigned long           flags;
 	void                    *private;
+	unsigned long		magic;
 	struct inode            vfs_inode;
 };
=20
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
 {
-	return container_of(inode, struct tracefs_inode, vfs_inode);
+	struct tracefs_inode *ti =3D container_of(inode, struct tracefs_inode, vf=
s_inode);
+	BUG_ON(ti->magic !=3D 20240823);
+	return ti;
 }
=20
 struct dentry *tracefs_start_creating(const char *name, struct dentry *par=
ent);

