Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86177A7C12
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjITL5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjITL5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:57:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3DB4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:57:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302FC433C9;
        Wed, 20 Sep 2023 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211057;
        bh=mZMihZ6UIDZE9mNoIC6fS9yLGbbZMYXYF/wFnlIqKWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVatUTxlRmdFfXI10/OSV3twoAjwqf88bqTLPpcBi4qYQt3Yu0uFHYo1OK4cOieuy
         4wMgF/O9bIoaUlZWm8Q+g3UGoX/iWV2TuwMD8bbmQzRpzNJ19ikTvVfU+PDspxTBMc
         5y0Sb9g1xheabccMBYbDVej+pJJ4CcpB2ROF0wLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 093/139] btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super
Date:   Wed, 20 Sep 2023 13:30:27 +0200
Message-ID: <20230920112839.073200237@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 6bfe3959b0e7a526f5c64747801a8613f002f05a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 64daae693afd1..c44f1fcc19097 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2728,13 +2728,11 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
 
-- 
2.40.1



