Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4459C7A8192
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjITMqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjITMqn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E292
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6401C433C8;
        Wed, 20 Sep 2023 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213992;
        bh=rFT0fXBSdYGd3XzhGeNA81O5dEcTwYZTZ1zdLVIHhm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjTDC5EKZFnxLVdVwR2I7NtFqbWuQnZt/mgtEAqk+9OhMUbEqBR/9d85wxPAEHaGs
         HSM48yT5zB0KuGcwrcfeebbMPvZy5zXPiJV8+RvPV3eD9k1WOrbe2hue1PD8zt9ra9
         cf5KYWN2EzWGt9Gt9sJqNiSjR/19M8XAs3Q0Vi04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 073/110] btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
Date:   Wed, 20 Sep 2023 13:32:11 +0200
Message-ID: <20230920112833.164803789@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit c2e79e865b87c2920a3cd39de69c35f2bc758a51 ]

This is defined in volumes.c, move the prototype into volumes.h.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6bfe3959b0e7 ("btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h   | 2 --
 fs/btrfs/volumes.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 02d3ee6c7d9b0..1467bf439cb48 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -536,8 +536,6 @@ struct btrfs_swapfile_pin {
 	int bg_extent_count;
 };
 
-bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-
 enum {
 	BTRFS_FS_BARRIER,
 	BTRFS_FS_CLOSING_START,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b49fa784e5ba3..1f6461b568659 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -622,4 +622,6 @@ const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
+bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+
 #endif
-- 
2.40.1



