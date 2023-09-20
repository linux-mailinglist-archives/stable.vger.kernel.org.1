Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B17A80B7
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjITMk1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjITMjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E5DE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:39:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F7BC433CA;
        Wed, 20 Sep 2023 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213561;
        bh=ZGbWVUH03n8UQM3lutusxiP3RaIGBHv9R5AHygBUrTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPYzbCLcO/a1Vehc904Tt6Sy9iIRGZQrBeZC6uq8qCBwaaAFy7FSkZyWw1pI/DIET
         gtZS1IPfjjeZOUAHCNYMDKblai+ScpU7eqEipU8QLpUJY4LaQTECtP0vIVOcQUwyol
         hXbjG1rnsO1z/5iAUwlQSiI8wOhO+ezFL09O9qtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 283/367] btrfs: use the correct superblock to compare fsid in btrfs_validate_super
Date:   Wed, 20 Sep 2023 13:31:00 +0200
Message-ID: <20230920112905.890925724@linuxfoundation.org>
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
@@ -2480,11 +2480,10 @@ static int validate_super(struct btrfs_f
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
 


