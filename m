Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A597A813A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjITMnl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjITMnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:43:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C778C83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:43:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D295C433CA;
        Wed, 20 Sep 2023 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213814;
        bh=2M2sbHInPHyM5OpFJgWaBdR0uaNVSHJ+7w+kau3m2yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itHDrpSYYUasOXdIWTJa56t0Zkry/7wb2YkS1SzGVfsupc1C5Pb4XEbpWoX/EKawD
         g8SNH2IllsJp/JnOnV01NeNv34fd8GQ2SSHAa2t+YkHipZAJGrhFY09jxMLpMr9cEX
         Am9tP9p4nxUJvZjZr2RcbV/rCEo1iUCTIZ8UmFm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 351/367] btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
Date:   Wed, 20 Sep 2023 13:32:08 +0200
Message-ID: <20230920112907.576619759@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index c2e5fe972f566..b141a7ba4507b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -482,8 +482,6 @@ struct btrfs_swapfile_pin {
 	bool is_block_group;
 };
 
-bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-
 enum {
 	BTRFS_FS_BARRIER,
 	BTRFS_FS_CLOSING_START,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index aa6a6d7b2978e..fd8fdaa4b0cdf 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -581,4 +581,6 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 
+bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+
 #endif
-- 
2.40.1



