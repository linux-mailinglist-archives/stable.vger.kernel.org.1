Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B40754E55
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGPKTy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGPKTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3772186
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298C360BDC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382D3C433C8;
        Sun, 16 Jul 2023 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502791;
        bh=lLYOBv/lOjGqVUO/2BsU9n4iW9+mr3okdPQiaLU1Snw=;
        h=Subject:To:Cc:From:Date:From;
        b=vUaIoC8sMdtsE+919XLIRrsloBS/T+YCzd3Lr9lxTyXabmJGFyDEJ+JWXYokmNS/P
         +bXPdD8uyJFRn9bv9xrQvS33naLbtpiqHcu5wVHZ0d3I1xgqEO6CM9mc5MhPxOAl49
         6CEUrKEli5jVdBDbx/Ms07mot9+1Rdj51YDS3Ujk=
Subject: FAILED: patch "[PATCH] btrfs: fix race between quota disable and relocation" failed to apply to 5.4-stable tree
To:     fdmanana@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:19:36 +0200
Message-ID: <2023071636-neatness-trapping-fe89@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8a4a0b2a3eaf75ca8854f856ef29690c12b2f531
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071636-neatness-trapping-fe89@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8a4a0b2a3eaf ("btrfs: fix race between quota disable and relocation")
e804861bd4e6 ("btrfs: fix deadlock between quota disable and qgroup rescan worker")
a855fbe69229 ("btrfs: fix lockdep splat when enabling and disabling qgroups")
49e5fb46211d ("btrfs: qgroup: export qgroups in sysfs")
5958253cf65d ("btrfs: qgroup: catch reserved space leaks at unmount time")
81f7eb00ff5b ("btrfs: destroy qgroup extent records on transaction abort")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a4a0b2a3eaf75ca8854f856ef29690c12b2f531 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 19 Jun 2023 17:21:50 +0100
Subject: [PATCH] btrfs: fix race between quota disable and relocation

If we disable quotas while we have a relocation of a metadata block group
that has extents belonging to the quota root, we can cause the relocation
to fail with -ENOENT. This is because relocation builds backref nodes for
extents of the quota root and later needs to walk the backrefs and access
the quota root - however if in between a task disables quotas, it results
in deleting the quota root from the root tree (with btrfs_del_root(),
called from btrfs_quota_disable().

This can be sporadically triggered by test case btrfs/255 from fstests:

  $ ./check btrfs/255
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc6-btrfs-next-134+ #1 SMP PREEMPT_DYNAMIC Thu Jun 15 11:59:28 WEST 2023
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/255 6s ... _check_dmesg: something found in dmesg (see /home/fdmanana/git/hub/xfstests/results//btrfs/255.dmesg)
  - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/255.out.bad)
      --- tests/btrfs/255.out	2023-03-02 21:47:53.876609426 +0000
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/255.out.bad	2023-06-16 10:20:39.267563212 +0100
      @@ -1,2 +1,4 @@
       QA output created by 255
      +ERROR: error during balancing '/home/fdmanana/btrfs-tests/scratch_1': No such file or directory
      +There may be more info in syslog - try dmesg | tail
       Silence is golden
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/255.out /home/fdmanana/git/hub/xfstests/results//btrfs/255.out.bad'  to see the entire diff)
  Ran: btrfs/255
  Failures: btrfs/255
  Failed 1 of 1 tests

To fix this make the quota disable operation take the cleaner mutex, as
relocation of a block group also takes this mutex. This is also what we
do when deleting a subvolume/snapshot, we take the cleaner mutex in the
cleaner kthread (at cleaner_kthread()) and then we call btrfs_del_root()
at btrfs_drop_snapshot() while under the protection of the cleaner mutex.

Fixes: bed92eae26cc ("Btrfs: qgroup implementation and prototypes")
CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f8735b31da16..da1f84a0eb29 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1232,12 +1232,23 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 
 	/*
-	 * We need to have subvol_sem write locked, to prevent races between
-	 * concurrent tasks trying to disable quotas, because we will unlock
-	 * and relock qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
+	 * We need to have subvol_sem write locked to prevent races with
+	 * snapshot creation.
 	 */
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
+	/*
+	 * Lock the cleaner mutex to prevent races with concurrent relocation,
+	 * because relocation may be building backrefs for blocks of the quota
+	 * root while we are deleting the root. This is like dropping fs roots
+	 * of deleted snapshots/subvolumes, we need the same protection.
+	 *
+	 * This also prevents races between concurrent tasks trying to disable
+	 * quotas, because we will unlock and relock qgroup_ioctl_lock across
+	 * BTRFS_FS_QUOTA_ENABLED changes.
+	 */
+	mutex_lock(&fs_info->cleaner_mutex);
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
 		goto out;
@@ -1319,6 +1330,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
+	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
 }

