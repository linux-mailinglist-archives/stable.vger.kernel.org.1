Return-Path: <stable+bounces-16116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C383F077
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853311F22FC3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69EC1B807;
	Sat, 27 Jan 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRX4Wtao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCC1B7E1
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393197; cv=none; b=ENEZV8dtS7D0htOCempY4LiJIFOBZnHh+434zwOoBdDtuTx4RkAOHlJW06DEfYSPVGdsJTYG1/Dosh17bBhzXfLOtk1MJdI5qAztc6W3g0TG1EBVQFHqCfyJ2WUKaMI9fBpyctsGPGIlvbRb15Ddy+K5bYIBboMWX4nygUJKp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393197; c=relaxed/simple;
	bh=1TZBow6R4TrSY3EfSyZZUXHbGXmyvineE6dVXuT5AnQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VU+HdoALoZE6AQxSuB6PvBp/Cpcjc1rI55k84lhlLZgSdfazAtn128lNGYzej6N98DkzzMFdhE/zjTeGWKg44Kx2Oy0athZJMR5QhpaI8Ojf+ZS4JwrqFL+00OOAxvlpB3apvcZ3eXLyM4WV1PPEN+iQR94m3Y0IczQXsHRoHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRX4Wtao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4428EC433F1;
	Sat, 27 Jan 2024 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706393197;
	bh=1TZBow6R4TrSY3EfSyZZUXHbGXmyvineE6dVXuT5AnQ=;
	h=Subject:To:Cc:From:Date:From;
	b=hRX4WtaoVpvzzeVpTNH/UjVucOaoIOeV61tYNM1dMV02CWGvgFMaZw8DziujvYnT4
	 GbJvoXfGLaZtp/5Leffx6VC5SvbjNzO7xb1FrLfdLs/lefacbAZ0INmyf6sOBxN97o
	 oQ+mn7bAz+dessqpTttLaXJn5rxeyvBFhlxzv8EU=
Subject: FAILED: patch "[PATCH] xfs: read only mounts with fsopen mount API are busted" failed to apply to 5.10-stable tree
To: dchinner@redhat.com,chandanbabu@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:06:36 -0800
Message-ID: <2024012736-provable-risotto-2228@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d8d222e09dab84a17bb65dda4b94d01c565f5327
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012736-provable-risotto-2228@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8d222e09dab84a17bb65dda4b94d01c565f5327 Mon Sep 17 00:00:00 2001
From: Dave Chinner <dchinner@redhat.com>
Date: Tue, 16 Jan 2024 15:33:07 +1100
Subject: [PATCH] xfs: read only mounts with fsopen mount API are busted

Recently xfs/513 started failing on my test machines testing "-o
ro,norecovery" mount options. This was being emitted in dmesg:

[ 9906.932724] XFS (pmem0): no-recovery mounts must be read-only.

Turns out, readonly mounts with the fsopen()/fsconfig() mount API
have been busted since day zero. It's only taken 5 years for debian
unstable to start using this "new" mount API, and shortly after this
I noticed xfs/513 had started to fail as per above.

The syscall trace is:

fsopen("xfs", FSOPEN_CLOEXEC)           = 3
mount_setattr(-1, NULL, 0, NULL, 0)     = -1 EINVAL (Invalid argument)
.....
fsconfig(3, FSCONFIG_SET_STRING, "source", "/dev/pmem0", 0) = 0
fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
fsconfig(3, FSCONFIG_SET_FLAG, "norecovery", NULL, 0) = 0
fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = -1 EINVAL (Invalid argument)
close(3)                                = 0

Showing that the actual mount instantiation (FSCONFIG_CMD_CREATE) is
what threw out the error.

During mount instantiation, we call xfs_fs_validate_params() which
does:

        /* No recovery flag requires a read-only mount */
        if (xfs_has_norecovery(mp) && !xfs_is_readonly(mp)) {
                xfs_warn(mp, "no-recovery mounts must be read-only.");
                return -EINVAL;
        }

and xfs_is_readonly() checks internal mount flags for read only
state. This state is set in xfs_init_fs_context() from the
context superblock flag state:

        /*
         * Copy binary VFS mount flags we are interested in.
         */
        if (fc->sb_flags & SB_RDONLY)
                set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);

With the old mount API, all of the VFS specific superblock flags
had already been parsed and set before xfs_init_fs_context() is
called, so this all works fine.

However, in the brave new fsopen/fsconfig world,
xfs_init_fs_context() is called from fsopen() context, before any
VFS superblock have been set or parsed. Hence if we use fsopen(),
the internal XFS readonly state is *never set*. Hence anything that
depends on xfs_is_readonly() actually returning true for read only
mounts is broken if fsopen() has been used to mount the filesystem.

Fix this by moving this internal state initialisation to
xfs_fs_fill_super() before we attempt to validate the parameters
that have been set prior to the FSCONFIG_CMD_CREATE call being made.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Fixes: 73e5fff98b64 ("xfs: switch to use the new mount-api")
cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index aff20ddd4a9f..5a2512d20bd0 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1496,6 +1496,18 @@ xfs_fs_fill_super(
 
 	mp->m_super = sb;
 
+	/*
+	 * Copy VFS mount flags from the context now that all parameter parsing
+	 * is guaranteed to have been completed by either the old mount API or
+	 * the newer fsopen/fsconfig API.
+	 */
+	if (fc->sb_flags & SB_RDONLY)
+		set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);
+	if (fc->sb_flags & SB_DIRSYNC)
+		mp->m_features |= XFS_FEAT_DIRSYNC;
+	if (fc->sb_flags & SB_SYNCHRONOUS)
+		mp->m_features |= XFS_FEAT_WSYNC;
+
 	error = xfs_fs_validate_params(mp);
 	if (error)
 		return error;
@@ -1965,6 +1977,11 @@ static const struct fs_context_operations xfs_context_ops = {
 	.free        = xfs_fs_free,
 };
 
+/*
+ * WARNING: do not initialise any parameters in this function that depend on
+ * mount option parsing having already been performed as this can be called from
+ * fsopen() before any parameters have been set.
+ */
 static int xfs_init_fs_context(
 	struct fs_context	*fc)
 {
@@ -1996,16 +2013,6 @@ static int xfs_init_fs_context(
 	mp->m_logbsize = -1;
 	mp->m_allocsize_log = 16; /* 64k */
 
-	/*
-	 * Copy binary VFS mount flags we are interested in.
-	 */
-	if (fc->sb_flags & SB_RDONLY)
-		set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);
-	if (fc->sb_flags & SB_DIRSYNC)
-		mp->m_features |= XFS_FEAT_DIRSYNC;
-	if (fc->sb_flags & SB_SYNCHRONOUS)
-		mp->m_features |= XFS_FEAT_WSYNC;
-
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;
 


