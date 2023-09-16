Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48557A305F
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIPM7d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbjIPM7N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:59:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CEECF0
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:59:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AC1C433C8;
        Sat, 16 Sep 2023 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694869147;
        bh=HqK7zc30OM8iKRPK1XX+aqHJFSpvIJ8gR5ZqQ44m/xQ=;
        h=Subject:To:Cc:From:Date:From;
        b=MhjtCe1SD+UBdmcX1tpgWw4orw3Wl5Jk/Kft1GCClMq0LCiF/V2a8ijGnFtSWpPnd
         OtLvTJXpxDv8CEf+tH4Mmqk1QQyzzasFiDpz3VW4mwGKSPVgPScr2+zk+7g3L34kZH
         d/Z3Ig0RbdkbW89bZEHTxmJH2KBbwgRd0v/7FcfA=
Subject: FAILED: patch "[PATCH] btrfs: compare the correct fsid/metadata_uuid in" failed to apply to 5.4-stable tree
To:     anand.jain@oracle.com, dsterba@suse.com, gpiccoli@igalia.com,
        johannes.thumshirn@wdc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:59:05 +0200
Message-ID: <2023091605-gargle-tweet-b0a7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 6bfe3959b0e7a526f5c64747801a8613f002f05a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091605-gargle-tweet-b0a7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

6bfe3959b0e7 ("btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super")
aefd7f706556 ("btrfs: promote debugging asserts to full-fledged checks in validate_super")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6bfe3959b0e7a526f5c64747801a8613f002f05a Mon Sep 17 00:00:00 2001
From: Anand Jain <anand.jain@oracle.com>
Date: Mon, 31 Jul 2023 19:16:35 +0800
Subject: [PATCH] btrfs: compare the correct fsid/metadata_uuid in
 btrfs_validate_super

The function btrfs_validate_super() should verify the metadata_uuid in
the provided superblock argument. Because, all its callers expect it to
do that.

Such as in the following stacks:

  write_all_supers()
   sb = fs_info->super_for_commit;
   btrfs_validate_write_super(.., sb)
     btrfs_validate_super(.., sb, ..)

  scrub_one_super()
	btrfs_validate_super(.., sb, ..)

And
   check_dev_super()
	btrfs_validate_super(.., sb, ..)

However, it currently verifies the fs_info::super_copy::metadata_uuid
instead.  Fix this using the correct metadata_uuid in the superblock
argument.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 49f405495e34..32ec651c570f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2391,13 +2391,11 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID) &&
-	    memcmp(fs_info->fs_devices->metadata_uuid,
-		   fs_info->super_copy->metadata_uuid, BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(sb),
+		   BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
 "superblock metadata_uuid doesn't match metadata uuid of fs_devices: %pU != %pU",
-			fs_info->super_copy->metadata_uuid,
-			fs_info->fs_devices->metadata_uuid);
+			  btrfs_sb_fsid_ptr(sb), fs_info->fs_devices->metadata_uuid);
 		ret = -EINVAL;
 	}
 

