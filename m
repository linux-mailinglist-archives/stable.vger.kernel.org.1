Return-Path: <stable+bounces-101371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742079EEBC4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092828391A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466F20969B;
	Thu, 12 Dec 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U5fbu8xZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1E748A;
	Thu, 12 Dec 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017321; cv=none; b=MyxQ8cXSS2Aw1foKh4xKIiKN3Ml351UVSbip5IFpmxMnmIZxJ0P2S7H4cPggoxwQFbQt2V6bSZWNImRWGDHuu4+NmQKInBysaub+VWp0ozOPhcA6VyXvKmQlatKQvcE+3YIcEYbzZB0Zq1wuTnv7rIkOpdfd97dlW+obaPTFwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017321; c=relaxed/simple;
	bh=a4fapku+Cc7GK11s2C4RhiHIWJynnw53OvLqNb5YXMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ28MZvREwMn/w8LOt1E353DCHrmDH8+yfcLvPeHLat7VHdTdN3f8IxlbZTm1mfkFP9FIK+BCwYB6DpGY+d37Y5vAw49DofDMO/FgyCAl8WwwzP6q3xi1WGzKw0qMm58yBEpQuVpsZYHptYuxJCuAokAy/SpKRcdc8+QD/mKq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U5fbu8xZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B76DC4CECE;
	Thu, 12 Dec 2024 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017321;
	bh=a4fapku+Cc7GK11s2C4RhiHIWJynnw53OvLqNb5YXMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5fbu8xZzfmi57ftvbGJgaXaPrcvXzK4cZvq+yQNyL2myJvx2089tcvsbR7WYXLys
	 9rDEaFthh4X8hACTZIgU3/IXSPY4/n3OBb6Vt3M1Ox7B/DVs2RGphmMjN5NJnWeyfe
	 5ArLAwkl+E1VgTfHVPIabMPjXZU/MybNGeKubh7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Enno Gotthold <egotthold@suse.com>,
	Fabian Vogt <fvogt@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 446/466] btrfs: fix mount failure due to remount races
Date: Thu, 12 Dec 2024 16:00:15 +0100
Message-ID: <20241212144324.475629985@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 951a3f59d268fe1397aaeb9a96fcb1944890c4cb ]

[BUG]
The following reproducer can cause btrfs mount to fail:

  dev="/dev/test/scratch1"
  mnt1="/mnt/test"
  mnt2="/mnt/scratch"

  mkfs.btrfs -f $dev
  mount $dev $mnt1
  btrfs subvolume create $mnt1/subvol1
  btrfs subvolume create $mnt1/subvol2
  umount $mnt1

  mount $dev $mnt1 -o subvol=subvol1
  while mount -o remount,ro $mnt1; do mount -o remount,rw $mnt1; done &
  bg=$!

  while mount $dev $mnt2 -o subvol=subvol2; do umount $mnt2; done

  kill $bg
  wait
  umount -R $mnt1
  umount -R $mnt2

The script will fail with the following error:

  mount: /mnt/scratch: /dev/mapper/test-scratch1 already mounted on /mnt/test.
        dmesg(1) may have more information after failed mount system call.
  umount: /mnt/test: target is busy.
  umount: /mnt/scratch/: not mounted

And there is no kernel error message.

[CAUSE]
During the btrfs mount, to support mounting different subvolumes with
different RO/RW flags, we need to detect that and retry if needed:

  Retry with matching RO flags if the initial mount fail with -EBUSY.

The problem is, during that retry we do not hold any super block lock
(s_umount), this means there can be a remount process changing the RO
flags of the original fs super block.

If so, we can have an EBUSY error during retry.  And this time we treat
any failure as an error, without any retry and cause the above EBUSY
mount failure.

[FIX]
The current retry behavior is racy because we do not have a super block
thus no way to hold s_umount to prevent the race with remount.

Solve the root problem by allowing fc->sb_flags to mismatch from the
sb->s_flags at btrfs_get_tree_super().

Then at the re-entry point btrfs_get_tree_subvol(), manually check the
fc->s_flags against sb->s_flags, if it's a RO->RW mismatch, then
reconfigure with s_umount lock hold.

Reported-by: Enno Gotthold <egotthold@suse.com>
Reported-by: Fabian Vogt <fvogt@suse.com>
[ Special thanks for the reproducer and early analysis pointing to btrfs. ]
Fixes: f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1231836
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/super.c | 66 ++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0c477443fbc5f..8292e488d3d77 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1886,18 +1886,21 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	if (sb->s_root) {
 		btrfs_close_devices(fs_devices);
-		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
-			ret = -EBUSY;
+		/*
+		 * At this stage we may have RO flag mismatch between
+		 * fc->sb_flags and sb->s_flags.  Caller should detect such
+		 * mismatch and reconfigure with sb->s_umount rwsem held if
+		 * needed.
+		 */
 	} else {
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices);
-	}
-
-	if (ret) {
-		deactivate_locked_super(sb);
-		return ret;
+		if (ret) {
+			deactivate_locked_super(sb);
+			return ret;
+		}
 	}
 
 	btrfs_clear_oneshot_options(fs_info);
@@ -1983,39 +1986,18 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
  * work with different options work we need to keep backward compatibility.
  */
-static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
+static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
 {
-	struct vfsmount *mnt;
-	int ret;
-	const bool ro2rw = !(fc->sb_flags & SB_RDONLY);
-
-	/*
-	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
-	 * super block, so invert our setting here and retry the mount so we
-	 * can get our vfsmount.
-	 */
-	if (ro2rw)
-		fc->sb_flags |= SB_RDONLY;
-	else
-		fc->sb_flags &= ~SB_RDONLY;
-
-	mnt = fc_mount(fc);
-	if (IS_ERR(mnt))
-		return mnt;
+	int ret = 0;
 
-	if (!ro2rw)
-		return mnt;
+	if (fc->sb_flags & SB_RDONLY)
+		return ret;
 
-	/* We need to convert to rw, call reconfigure. */
-	fc->sb_flags &= ~SB_RDONLY;
 	down_write(&mnt->mnt_sb->s_umount);
-	ret = btrfs_reconfigure(fc);
+	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
+		ret = btrfs_reconfigure(fc);
 	up_write(&mnt->mnt_sb->s_umount);
-	if (ret) {
-		mntput(mnt);
-		return ERR_PTR(ret);
-	}
-	return mnt;
+	return ret;
 }
 
 static int btrfs_get_tree_subvol(struct fs_context *fc)
@@ -2025,6 +2007,7 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	struct fs_context *dup_fc;
 	struct dentry *dentry;
 	struct vfsmount *mnt;
+	int ret = 0;
 
 	/*
 	 * Setup a dummy root and fs_info for test/set super.  This is because
@@ -2067,11 +2050,16 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fc->security = NULL;
 
 	mnt = fc_mount(dup_fc);
-	if (PTR_ERR_OR_ZERO(mnt) == -EBUSY)
-		mnt = btrfs_reconfigure_for_mount(dup_fc);
-	put_fs_context(dup_fc);
-	if (IS_ERR(mnt))
+	if (IS_ERR(mnt)) {
+		put_fs_context(dup_fc);
 		return PTR_ERR(mnt);
+	}
+	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
+	put_fs_context(dup_fc);
+	if (ret) {
+		mntput(mnt);
+		return ret;
+	}
 
 	/*
 	 * This free's ->subvol_name, because if it isn't set we have to
-- 
2.43.0




