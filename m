Return-Path: <stable+bounces-76685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B497BDA0
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7240528D45A
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC9B18A6CD;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz5Kc3Ph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16318B47B
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668247; cv=none; b=b9OOMdq2Bf5Lor2MF6DcwVtDm0WZk5jWENBJgV+DBioNrzu+dVLrZNjdbDm4ACPQMmSzjLkJBKzSfvN+d3bw+9/PKV1AH93ZpmEPShZ7mIOsXAkyjvUEbJlcHgyzdOaw2Dx63+1RTgSykhXcfQX4E0Dv+CIhGbGpMG8VScJdwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668247; c=relaxed/simple;
	bh=UgrEC0fMdTY6bGtmKjzCHWfv4tiW6VPnT1O+kyaXAmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYKHjF3dlA43RB1LOHlKuOFQMapJo9GTz8OapPkdqJckCiXtOvOcFrDKQG05BK4XOsTVNhibnGm4mljz2aCzim5Do2Z+k8Csx7E77b+UUQ9rwsb5QBARHqCQprUbu+gkLfzL24ltSsGvVYxxpHmFadTm04NZxYhSaxyMnlkb4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz5Kc3Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 441BAC4CED6;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668247;
	bh=UgrEC0fMdTY6bGtmKjzCHWfv4tiW6VPnT1O+kyaXAmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jz5Kc3Phh0oOy9lUGyL9G4ah6c4dqs4QQG8l0lzPLX4Z0KFJR1qS4wEJ6NEkFjaqE
	 5JX4OoW7BlGe08zB/BiaVJg0riEhiGV4VYyc4w/XPNAmytQ+tV/RbSxoAuBR+UU0Qm
	 yoH5mgVGonftkVBuIFnx23Kr2PpHpf9ahS+GdbX9SpwJu8+tNJpkukfrPTqmUm5x+Y
	 dSiTSdTFWX8MWhFBhrIQEEQl/Ps4Pdw0Fkbk9Nqh/D9F2tgsYosGAj21IGFLlD+MiP
	 w0C4c1HXeiZvNqBdugGsXT2F0WIGM0GdFiS29AnRAyVa4DUbfMd78asjoJt2gz0VoF
	 8ZHDUGjVtMLnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC9CCD1AE;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:04:01 +0800
Subject: [PATCH v6.1 5/5] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-1-y-v1-5-364a92b1a34f@gmail.com>
References: <20240918-statx-stable-linux-6-1-y-v1-0-364a92b1a34f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-6-1-y-v1-0-364a92b1a34f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6114;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=77zJsb0u6kCk3K0hUzAxVrYqZjci5JDs/Px8b4GNrDA=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t3UFu2pG1eIJP5tbcng+fJxpxa1uEHewXBLG
 8VXulWPfqmJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurd1AAKCRCwMePKe/7Z
 bn9AEADK++5yEtH3u6pKQnDC5GTKYgbQm5JeLhZayoAdi/dd9BoXYVkLNXS8hVOdzhGJBeLm1Hf
 6bShbpvBMTAzIwN92fwIjqHepw1ytCJCzNq/gMmXlOSWUPz/QVf8SPeE1UjvxavmT9M2RGMKNoF
 RXHBt9KOV3Uypgw2Mmcp8l576gQGO8o0nc1QhIK/V2gWoh6Nga68ARooySoO2AfrZW2r8J/PZxL
 9CcwgVfoGisquW7f0zv+R8lPDL3gwO2IouYEzOQZatuuZ6rn4Q04xrRyy0sL0rJ3UNcgwJqaQM8
 TsNKlAdT9eLTMDAZTG+bqn1uFTY6bAL8grdtrQNSlnX7EX2ylD8Zac4YGi1Gja3QgbaeFyFS6vZ
 mYwnsZFxSTVKmqxOH/hwg/iTSMfPlFcsL7v5Ru4X8XsklI46+erBNXozw7KhQGf8Pf0oru0pYUB
 K5K2SIBSqmrmRYYsPHJcUHfpDLprvCkuhvTQpGjSAJvQ1IfgdqW6JCT+GWqP6tdQyKmqdXQGSIM
 tmwM40XhJdotpCBFDgjrseEVk8yE6SuDu56ywM8z4ketcbcJvm+RKAtBmsPVRq5JXS/JdF6r1Ix
 DmcIYWRIHd+6TiuN5s7d0lnMYe+dGvDhUuRaCrLUy8q60ZR3kAaWAmvU5AdqVPfOBrtmi1c9UfE
 OYQ+3NpTf9wYTmw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Mateusz Guzik <mjguzik@gmail.com>

commit 0ef625b upstream.

The newly used helper also checks for empty ("") paths.

NULL paths with any flag value other than AT_EMPTY_PATH go the usual
route and end up with -EFAULT to retain compatibility (Rust is abusing
calls of the sort to detect availability of statx).

This avoids path lookup code, lockref management, memory allocation and
in case of NULL path userspace memory access (which can be quite
expensive with SMAP on x86_64).

Benchmarked with statx(..., AT_EMPTY_PATH, ...) running on Sapphire
Rapids, with the "" path for the first two cases and NULL for the last
one.

Results in ops/s:
stock:     4231237
pre-check: 5944063 (+40%)
NULL path: 6601619 (+11%/+56%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20240625151807.620812-1-mjguzik@gmail.com
Tested-by: Xi Ruoyao <xry111@xry111.site>
[brauner: use path_mounted() and other tweaks]
Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/internal.h |  2 ++
 fs/stat.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 42df013f7fe7..004af47be35b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -199,6 +199,8 @@ int sb_init_dio_done_wq(struct super_block *sb);
 int getname_statx_lookup_flags(int flags);
 int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer);
+int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
+		struct statx __user *buffer);
 
 /*
  * fs/splice.c:
diff --git a/fs/stat.c b/fs/stat.c
index 84e07356dfa4..61b9eefb19fe 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -199,6 +199,38 @@ int getname_statx_lookup_flags(int flags)
 	return lookup_flags;
 }
 
+static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
+			  u32 request_mask)
+{
+	int error = vfs_getattr(path, stat, request_mask, flags);
+
+	stat->mnt_id = real_mount(path->mnt)->mnt_id;
+	stat->result_mask |= STATX_MNT_ID;
+
+	if (path->mnt->mnt_root == path->dentry)
+		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
+	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+
+	/* Handle STATX_DIOALIGN for block devices. */
+	if (request_mask & STATX_DIOALIGN) {
+		struct inode *inode = d_backing_inode(path->dentry);
+
+		if (S_ISBLK(inode->i_mode))
+			bdev_statx_dioalign(inode, stat);
+	}
+
+	return error;
+}
+
+static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
+			  u32 request_mask)
+{
+	CLASS(fd_raw, f)(fd);
+	if (!f.file)
+		return -EBADF;
+	return vfs_statx_path(&f.file->f_path, flags, stat, request_mask);
+}
+
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename
@@ -228,31 +260,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 retry:
 	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
 	if (error)
-		goto out;
-
-	error = vfs_getattr(&path, stat, request_mask, flags);
-
-	stat->mnt_id = real_mount(path.mnt)->mnt_id;
-	stat->result_mask |= STATX_MNT_ID;
-
-	if (path.mnt->mnt_root == path.dentry)
-		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
-	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
-
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
-
+		return error;
+	error = vfs_statx_path(&path, flags, stat, request_mask);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
 	return error;
 }
 
@@ -656,16 +670,35 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	return cp_statx(&stat, buffer);
 }
 
+int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
+	     struct statx __user *buffer)
+{
+	struct kstat stat;
+	int error;
+
+	if (mask & STATX__RESERVED)
+		return -EINVAL;
+	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
+		return -EINVAL;
+
+	error = vfs_statx_fd(fd, flags, &stat, mask);
+	if (error)
+		return error;
+
+	return cp_statx(&stat, buffer);
+}
+
 /**
  * sys_statx - System call to get enhanced stats
  * @dfd: Base directory to pathwalk from *or* fd to stat.
- * @filename: File to stat or "" with AT_EMPTY_PATH
+ * @filename: File to stat or either NULL or "" with AT_EMPTY_PATH
  * @flags: AT_* flags to control pathwalk.
  * @mask: Parts of statx struct actually required.
  * @buffer: Result buffer.
  *
  * Note that fstat() can be emulated by setting dfd to the fd of interest,
- * supplying "" as the filename and setting AT_EMPTY_PATH in the flags.
+ * supplying "" (or preferably NULL) as the filename and setting AT_EMPTY_PATH
+ * in the flags.
  */
 SYSCALL_DEFINE5(statx,
 		int, dfd, const char __user *, filename, unsigned, flags,
@@ -673,8 +706,23 @@ SYSCALL_DEFINE5(statx,
 		struct statx __user *, buffer)
 {
 	int ret;
+	unsigned lflags;
 	struct filename *name;
 
+	/*
+	 * Short-circuit handling of NULL and "" paths.
+	 *
+	 * For a NULL path we require and accept only the AT_EMPTY_PATH flag
+	 * (possibly |'d with AT_STATX flags).
+	 *
+	 * However, glibc on 32-bit architectures implements fstatat as statx
+	 * with the "" pathname and AT_NO_AUTOMOUNT | AT_EMPTY_PATH flags.
+	 * Supporting this results in the uglification below.
+	 */
+	lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
+	if (lflags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
+
 	name = getname_flags(filename, getname_statx_lookup_flags(flags), NULL);
 	ret = do_statx(dfd, name, flags, mask, buffer);
 	putname(name);

-- 
2.43.0



