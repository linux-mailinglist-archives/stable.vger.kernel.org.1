Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0259A76ADAB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjHAJbV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjHAJa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9A269A
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BF2614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB75C433CD;
        Tue,  1 Aug 2023 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882188;
        bh=BvCkGayvJNc4V7CPnP/MoSZZz7z1jZtGRZPO87Pknos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOECd1G+kYZPxqqc9hUbY5P/aT8k6ucEEKqwVVIQwzT3yNbo2xoxL9GbQREYjj83d
         NBb/OidbLTdzC4DhDy6oy4JnjvkYHWPGAPfRFHcr2ZogbdKEi00PZ+qk+sslTxB4Ts
         G3j9bAuJ0XMNhu2KT82aucc/11paskQj/q+gNZBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/228] btrfs: fix race between quota disable and relocation
Date:   Tue,  1 Aug 2023 11:17:55 +0200
Message-ID: <20230801091923.472690489@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 8a4a0b2a3eaf75ca8854f856ef29690c12b2f531 ]

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
#      --- tests/btrfs/255.out	2023-03-02 21:47:53.876609426 +0000
#      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/255.out.bad	2023-06-16 10:20:39.267563212 +0100
#      @@ -1,2 +1,4 @@
#       QA output created by 255
#      +ERROR: error during balancing '/home/fdmanana/btrfs-tests/scratch_1': No such file or directory
#      +There may be more info in syslog - try dmesg | tail
#       Silence is golden
#      ...
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index cacdb2c5d1528..26cabffd59710 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1227,12 +1227,23 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
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
@@ -1314,6 +1325,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
+	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
 }
-- 
2.39.2



