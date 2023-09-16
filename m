Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5447A3021
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjIPMfA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbjIPMef (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:34:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F619A
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:34:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADFFC433C8;
        Sat, 16 Sep 2023 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867669;
        bh=kwiCd0gUL5Cp+FBfTdYkOtE0RNf7Hkj4OGGmA24ofS4=;
        h=Subject:To:Cc:From:Date:From;
        b=akPj7ywx9gKevr1lqDOkTAsDCC4pAkdZnlAXNddPFTyE29DNxgPbNqhRlvDkTGhnd
         l3fEnuAJdshFg2z1Ng/Kkhik9wX08ttAI9wWfTcF1oR+gq3RAhpLdCgbYMe0c0w5/d
         ac81AMNJDJ+rOawFd2/GJMnnuRhUOO1omP/Rp1zM=
Subject: FAILED: patch "[PATCH] btrfs: free qgroup rsv on io failure" failed to apply to 5.10-stable tree
To:     boris@bur.io, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:31:32 +0200
Message-ID: <2023091632-graceful-actress-f418@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
git cherry-pick -x e28b02118b94e42be3355458a2406c6861e2dd32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091632-graceful-actress-f418@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e28b02118b94 ("btrfs: free qgroup rsv on io failure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e28b02118b94e42be3355458a2406c6861e2dd32 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 21 Jul 2023 09:02:06 -0700
Subject: [PATCH] btrfs: free qgroup rsv on io failure

If we do a write whose bio suffers an error, we will never reclaim the
qgroup reserved space for it. We allocate the space in the write_iter
codepath, then release the reservation as we allocate the ordered
extent, but we only create a delayed ref if the ordered extent finishes.
If it has an error, we simply leak the rsv. This is apparent in running
any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
tests fail due to dmesg on umount complaining about the leaked qgroup
data space.

When we clean up other aspects of space on failed ordered_extents, also
free the qgroup rsv.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
CC: stable@vger.kernel.org # 5.10+
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5508597be614..8e53df3516c2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3358,6 +3358,13 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, 1);
+			/*
+			 * Actually free the qgroup rsv which was released when
+			 * the ordered extent was created.
+			 */
+			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+						  ordered_extent->qgroup_rsv,
+						  BTRFS_QGROUP_RSV_DATA);
 		}
 	}
 

