Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418856FAA80
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjEHLDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjEHLCr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449FB2B411
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCFF862A52
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A0CC433D2;
        Mon,  8 May 2023 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543720;
        bh=TzV7u64l8JUQh+nK3ehWDatwdY/CWmOIyHTQmdu5MOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCoblmv37kQX4Nvs6EJdyTMoE35y1BuKPM9vTYnfKiMyHZYUmjasCynDK5e2agD/C
         RB5q4l4IryToZKL9NZt2tDMUxLXYppOrS4ejB4B4cFKOqzh1S3HyW1KsCxYcdgmb88
         nWXmVF0o4jyUYVF3SPps+3k/Mj0IWEjkrKUnsrJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jingbo Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 148/694] erofs: initialize packed inode after root inode is assigned
Date:   Mon,  8 May 2023 11:39:43 +0200
Message-Id: <20230508094437.249287581@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit cb9bce79514392a9a216ff67148e05e2d72c28bd ]

As commit 8f7acdae2cd4 ("staging: erofs: kill all failure handling in
fill_super()"), move the initialization of packed inode after root
inode is assigned, so that the iput() in .put_super() is adequate as
the failure handling.

Otherwise, iput() is also needed in .kill_sb(), in case of the mounting
fails halfway.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230407141710.113882-3-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1db018f8c2e89..42444b593cf16 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -156,6 +156,7 @@ struct erofs_sb_info {
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
+	erofs_nid_t packed_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec41..dbe466295d0e0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -380,17 +380,7 @@ static int erofs_read_superblock(struct super_block *sb)
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
-#ifdef CONFIG_EROFS_FS_ZIP
-	sbi->packed_inode = NULL;
-	if (erofs_sb_has_fragments(sbi) && dsb->packed_nid) {
-		sbi->packed_inode =
-			erofs_iget(sb, le64_to_cpu(dsb->packed_nid));
-		if (IS_ERR(sbi->packed_inode)) {
-			ret = PTR_ERR(sbi->packed_inode);
-			goto out;
-		}
-	}
-#endif
+	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
@@ -799,6 +789,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	erofs_shrinker_register(sb);
 	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
+#ifdef CONFIG_EROFS_FS_ZIP
+	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
+		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
+		if (IS_ERR(sbi->packed_inode)) {
+			err = PTR_ERR(sbi->packed_inode);
+			sbi->packed_inode = NULL;
+			return err;
+		}
+	}
+#endif
 	err = erofs_init_managed_cache(sb);
 	if (err)
 		return err;
-- 
2.39.2



