Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC106F9895
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEGNMW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEGNMV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 09:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A85265
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA1D60C64
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3D0C433EF;
        Sun,  7 May 2023 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683465139;
        bh=+sMr242MLEBBEhnS2Gcka6fwT3qyZH9zGtuQtG3sgaE=;
        h=Subject:To:Cc:From:Date:From;
        b=0A/tCSWlfLRFO7gl1TYGNuZQkn0vSn9LLf6/HQz1AriOKsg/0SmK14sWVIV0jbRwb
         15onOmY85DwCIXZe2ad2BWPmDl7dkJkm3T/ugmr4Lw0hlwIbAi10JTNKDyAqxvPKbb
         VrtvCJ9PPDudbXnfLGUAEDBdAEqTOTNV0iYZtLdg=
Subject: FAILED: patch "[PATCH] dm: don't lock fs when the map is NULL in process of resume" failed to apply to 5.10-stable tree
To:     lilingfeng3@huawei.com, snitzer@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 15:12:16 +0200
Message-ID: <2023050716-eggnog-acutely-8d74@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 38d11da522aacaa05898c734a1cec86f1e611129
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050716-eggnog-acutely-8d74@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

38d11da522aa ("dm: don't lock fs when the map is NULL in process of resume")
7533afa1d27b ("dm: send just one event on resize, not two")
84010e519f95 ("dm ima: measure data on device remove")
8eb6fab402e2 ("dm ima: measure data on device resume")
91ccbbac1747 ("dm ima: measure data on table load")
89f871af1b26 ("dm: delay registering the gendisk")
ba30585936b0 ("dm: move setting md->type into dm_setup_md_queue")
74a2b6ec9380 ("dm: cleanup cleanup_mapped_device")
2cfa582be800 ("Merge tag 'for-5.14/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38d11da522aacaa05898c734a1cec86f1e611129 Mon Sep 17 00:00:00 2001
From: Li Lingfeng <lilingfeng3@huawei.com>
Date: Tue, 18 Apr 2023 16:38:04 +0800
Subject: [PATCH] dm: don't lock fs when the map is NULL in process of resume

Commit fa247089de99 ("dm: requeue IO if mapping table not yet available")
added a detection of whether the mapping table is available in the IO
submission process. If the mapping table is unavailable, it returns
BLK_STS_RESOURCE and requeues the IO.
This can lead to the following deadlock problem:

dm create                                      mount
ioctl(DM_DEV_CREATE_CMD)
ioctl(DM_TABLE_LOAD_CMD)
                               do_mount
                                vfs_get_tree
                                 ext4_get_tree
                                  get_tree_bdev
                                   sget_fc
                                    alloc_super
                                     // got &s->s_umount
                                     down_write_nested(&s->s_umount, ...);
                                   ext4_fill_super
                                    ext4_load_super
                                     ext4_read_bh
                                      submit_bio
                                      // submit and wait io end
ioctl(DM_DEV_SUSPEND_CMD)
dev_suspend
 do_resume
  dm_suspend
   __dm_suspend
    lock_fs
     freeze_bdev
      get_active_super
       grab_super
        // wait for &s->s_umount
        down_write(&s->s_umount);
  dm_swap_table
   __bind
    // set md->map(can't get here)

IO will be continuously requeued while holding the lock since mapping
table is NULL. At the same time, mapping table won't be set since the
lock is not available.
Like request-based DM, bio-based DM also has the same problem.

It's not proper to just abort IO if the mapping table not available.
So clear DM_SKIP_LOCKFS_FLAG when the mapping table is NULL, this
allows the DM table to be loaded and the IO submitted upon resume.

Fixes: fa247089de99 ("dm: requeue IO if mapping table not yet available")
Cc: stable@vger.kernel.org
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 7d5c9c582ed2..cc77cf3d4109 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1168,10 +1168,13 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		int srcu_idx;
 
 		/* Suspend if it isn't already suspended */
-		if (param->flags & DM_SKIP_LOCKFS_FLAG)
+		old_map = dm_get_live_table(md, &srcu_idx);
+		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+		dm_put_live_table(md, srcu_idx);
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))

