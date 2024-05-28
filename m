Return-Path: <stable+bounces-47581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE58D237A
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 20:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAAB285AC2
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1528179970;
	Tue, 28 May 2024 18:47:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A390179954;
	Tue, 28 May 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922066; cv=none; b=hXjT8cuvHc+m4rB1yod6GaZFBpNlCWERDaG3IZCCJyXeVcIDgA/LY4Q14Ddo2JL2BpFLeWJ/E204qSmJd59cUQp88cQg2AuOIyIjd0oy4B/SxvCwsaknG6E7aSiZIEpyt7eE9w34jUxihQgG1kTVjdXYg+y5fbZ4JjZComXmPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922066; c=relaxed/simple;
	bh=hwmeUbItsm+bV91/Ve29xLJ4dPvWDPNLCD48sqQOZYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZMb1b37WGl3Iyi677JGjgRunJL0iTxwtz+pR0d4Ktr+y46q5jKdd6obinyJpxBXFnuJx98VAEuFcvNZw/e69hW/qAlr/oVhQbxnzoQWTdUwdUXDCENwLH6XrChXm3HfLgMGyiIdSCXYW53gTmqmcFzAPETNmetaF5qtXsPxDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D691C32781;
	Tue, 28 May 2024 18:47:45 +0000 (UTC)
Date: Tue, 28 May 2024 14:47:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Linux regressions mailing list
 <regressions@lists.linux.dev>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240528144743.149e351b@rorschach.local.home>
In-Reply-To: <CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
 <20240527183139.42b6123c@rorschach.local.home>
 <CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 07:51:30 +0300
Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:

> yeah, the cache_from_obj tracing bug (without panic) has been
> displayed quite some time now - maybe even since 6.7.x or so. I could
> try checking a few versions back for this and try bisecting it if I
> can find when this started.
>=20

OK, so I don't think the commit your last bisect hit is the cause of
the bug. It added a delay (via RCU) and is causing the real bug to blow
up more.

Can you add this patch to v6.9.2 and hopefully it crashes in a better
location that we can find where the mixup happened.

You may need to add the other commit (too if this doesn't trigger.

Thanks,

-- Steve

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 417c840e6403..7af3f696696d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -50,6 +50,7 @@ static struct inode *tracefs_alloc_inode(struct super_blo=
ck *sb)
 	list_add_rcu(&ti->list, &tracefs_inodes);
 	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
=20
+	ti->magic =3D 20240823;
 	return &ti->vfs_inode;
 }
=20
@@ -66,6 +67,7 @@ static void tracefs_free_inode(struct inode *inode)
 	struct tracefs_inode *ti =3D get_tracefs(inode);
 	unsigned long flags;
=20
+	BUG_ON(ti->magic !=3D 20240823);
 	spin_lock_irqsave(&tracefs_inode_lock, flags);
 	list_del_rcu(&ti->list);
 	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
@@ -271,16 +273,6 @@ static const struct inode_operations tracefs_file_inod=
e_operations =3D {
 	.setattr	=3D tracefs_setattr,
 };
=20
-struct inode *tracefs_get_inode(struct super_block *sb)
-{
-	struct inode *inode =3D new_inode(sb);
-	if (inode) {
-		inode->i_ino =3D get_next_ino();
-		simple_inode_init_ts(inode);
-	}
-	return inode;
-}
-
 struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
@@ -448,6 +440,17 @@ static const struct super_operations tracefs_super_ope=
rations =3D {
 	.show_options	=3D tracefs_show_options,
 };
=20
+struct inode *tracefs_get_inode(struct super_block *sb)
+{
+	struct inode *inode =3D new_inode(sb);
+	BUG_ON(sb->s_op !=3D &tracefs_super_operations);
+	if (inode) {
+		inode->i_ino =3D get_next_ino();
+		simple_inode_init_ts(inode);
+	}
+	return inode;
+}
+
 /*
  * It would be cleaner if eventfs had its own dentry ops.
  *
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f704d8348357..dda7d2708e30 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -16,6 +16,7 @@ struct tracefs_inode {
 	};
 	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	struct list_head	list;
+	unsigned long		magic;
 	unsigned long           flags;
 	void                    *private;
 };

