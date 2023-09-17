Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766F7A3B45
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbjIQUPb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbjIQUPL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:15:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E29F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:15:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525F1C433C8;
        Sun, 17 Sep 2023 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981705;
        bh=fxYVeOYJzPyT3HEhgsntd6Vzf6DXqWdsQaaUTBdlpBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4NjnJH1m4Y3/RgItbaY+2XT+yvXnDrnu+eVULATbgrgm+bO1+iCgtXxMag1gVGWE
         yZ4Yej2f5O42v1RLlbjqQ1tO4aRp86s/DmkFbQ5adU/ZU1tVu6cxEowvluBI3L5RH4
         H7NDO5QUOzLFTAwyDXyej/VNhp4j/BH1OoWyDPbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 161/219] btrfs: use the correct superblock to compare fsid in btrfs_validate_super
Date:   Sun, 17 Sep 2023 21:14:48 +0200
Message-ID: <20230917191046.864193038@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit d167aa76dc0683828588c25767da07fb549e4f48 upstream.

The function btrfs_validate_super() should verify the fsid in the provided
superblock argument. Because, all its callers expect it to do that.

Such as in the following stack:

   write_all_supers()
       sb = fs_info->super_for_commit;
       btrfs_validate_write_super(.., sb)
         btrfs_validate_super(.., sb, ..)

   scrub_one_super()
	btrfs_validate_super(.., sb, ..)

And
   check_dev_super()
	btrfs_validate_super(.., sb, ..)

However, it currently verifies the fs_info::super_copy::fsid instead,
which is not correct.  Fix this using the correct fsid in the superblock
argument.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2721,11 +2721,10 @@ int btrfs_validate_super(struct btrfs_fs
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
-		   BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
-			fs_info->super_copy->fsid, fs_info->fs_devices->fsid);
+			  sb->fsid, fs_info->fs_devices->fsid);
 		ret = -EINVAL;
 	}
 


