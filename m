Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F727A8195
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjITMqu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjITMqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A1218D
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024FEC433C7;
        Wed, 20 Sep 2023 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213997;
        bh=rp4y9kBwQVkK1IoXUpuT2UkPKAITlq9TAYHiUYOswrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zii1vVX0PMxj5y7G8BU1zJI6JLpZmEgOoAqp6Qa2B/KZpm/BtztjDvoezn8bcGUk9
         rv59jyTNB3nq3dFysPtSU6AO7JuBJrn8vRf0/DFu3SdB8C+iSyoxa1IYrSy0BuC/p5
         KEDLY3F9M9KRuggcljFcDpHUjSdVRi4nAsv8w6gA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/110] btrfs: add a helper to read the superblock metadata_uuid
Date:   Wed, 20 Sep 2023 13:32:12 +0200
Message-ID: <20230920112833.196750626@linuxfoundation.org>
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

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 4844c3664a72d36cc79752cb651c78860b14c240 ]

In some cases, we need to read the FSID from the superblock when the
metadata_uuid is not set, and otherwise, read the metadata_uuid. So,
add a helper.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6bfe3959b0e7 ("btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 8 ++++++++
 fs/btrfs/volumes.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0e9236a745b81..56ea2ec26436f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -709,6 +709,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	return -EINVAL;
 }
 
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
 /*
  * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
  * being created with a disk that has already completed its fsid change. Such
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1f6461b568659..eb91d6eb78ceb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -623,5 +623,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb);
 
 #endif
-- 
2.40.1



