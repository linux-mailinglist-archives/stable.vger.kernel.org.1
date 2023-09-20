Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A677A7F23
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjITMYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjITMYX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:24:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3D97
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:24:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D5DC433C9;
        Wed, 20 Sep 2023 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212657;
        bh=3qziMd/wnNZVrKZ7Yknaln1DMTbEs6vMkg2rTf/AcLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptzTLUhKqASsm4OvOdo16/hs5jy+JkYafWE0Gx3UhtI0RhxidPmPOnyq1go3SUBeA
         ibkCneIktRRarJQ3x3ashMU7hCrzGGp7FMgaNywt637oPoJzjam5swX7TjRfsbs8BI
         EkFxLSWWZ5ecV6L49eIIVmyQs9LU9LmvURwzy02Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 56/83] btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
Date:   Wed, 20 Sep 2023 13:31:46 +0200
Message-ID: <20230920112828.875484587@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index bcc6848bb6d6a..67831868ef0de 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -529,8 +529,6 @@ struct btrfs_swapfile_pin {
 	int bg_extent_count;
 };
 
-bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-
 enum {
 	BTRFS_FS_BARRIER,
 	BTRFS_FS_CLOSING_START,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f2177263748e8..2463aeb34ab55 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -580,4 +580,6 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 
+bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+
 #endif
-- 
2.40.1



