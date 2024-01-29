Return-Path: <stable+bounces-16689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A6840E02
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B832C1C23750
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5E15DBB7;
	Mon, 29 Jan 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+s++hIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED7159572;
	Mon, 29 Jan 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548205; cv=none; b=joo9RIRXK4518pTxhhjw/a+YMpFy9M4wvKMy2Tm87EkRPsAYJscYnqKuGD5tO1fKb0Ez2Ac+eMLb445bF5D7BKzxUqbbXK7syDxaN6zOUseGkgp8B2Y+5cYPsrUG8Qn0yHOLejtJSk8w9ToRJKm4n2tSANDfrIcjM8NbxxfC6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548205; c=relaxed/simple;
	bh=u0QRLBwnGRc3TbduJOiJM7iQNEmnq+3QXgYHNGR/vKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4QTmtUq9GEf8yLHpU6tcLWmDOKajq9RpAmGdCUnSsTpKysB7ObZvaUjnvMfg9oi4CZQWoy3Laq3PFk+fRwvIjWsVNN2ycUlKXtiPWjzyX+EBYpsHS1mT2QwrwpYJK/70MDJ6YQTLaUyJNuiYfSKbrhmU4vyWZS2axYECQvdKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+s++hIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D38C43394;
	Mon, 29 Jan 2024 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548205;
	bh=u0QRLBwnGRc3TbduJOiJM7iQNEmnq+3QXgYHNGR/vKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+s++hIc8jDLXXbwen9pkN8ieQmZjzwWoq+cPG7382sx4dfktRojnsQfmm7OAZr7t
	 UsMAlUWYe29hTZf7ZipwANbQYchYHHKwkw8JMDWC9ivPAgVlGRHQQrydKUeyOo0XAW
	 vFBJKfCJb9CjLLNVxtCX+bTklLp9rD8tWgSqJI64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH 6.7 243/346] xfs: read only mounts with fsopen mount API are busted
Date: Mon, 29 Jan 2024 09:04:34 -0800
Message-ID: <20240129170023.554401187@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit d8d222e09dab84a17bb65dda4b94d01c565f5327 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_super.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1510,6 +1510,18 @@ xfs_fs_fill_super(
 
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
@@ -1979,6 +1991,11 @@ static const struct fs_context_operation
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
@@ -2010,16 +2027,6 @@ static int xfs_init_fs_context(
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
 



