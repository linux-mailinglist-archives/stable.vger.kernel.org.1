Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783967E23EC
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjKFNQU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjKFNQS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62A3D47
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64928C433C7;
        Mon,  6 Nov 2023 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276568;
        bh=8vmI0vCoI7cr86jiryB4BJkNabliJuSlpVlft2f3VG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FP42yc+oAmAU/kFC7WTbTUH7Nw0ouYgm6NPLzsyua9Ysgl/FpVxjYji7KiqeXb52G
         h7+LVW3zTu1XOwdpoOOAWTRdK6QZa9zJy5c/BP49OSThBfnj9qNAYl8v62Z/qjXzy3
         JK+xJh4KXEJGug4zdjWhzxlipzPdj1X99L3pU9ME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 24/88] fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
Date:   Mon,  6 Nov 2023 14:03:18 +0100
Message-ID: <20231106130306.672560246@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d27e202b9ac416e52093edf8789614d93dbd6231 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9124d74ea676b..d699819c70a14 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -453,15 +453,23 @@ static struct proc_dir_entry *proc_info_root;
  * ntfs3.1
  * cluster size
  * number of clusters
+ * total number of mft records
+ * number of used mft records ~= number of files + folders
+ * real state of ntfs "dirty"/"clean"
+ * current state of ntfs "dirty"/"clean"
 */
 static int ntfs3_volinfo(struct seq_file *m, void *o)
 {
 	struct super_block *sb = m->private;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 
-	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n", sbi->volume.major_ver,
-		   sbi->volume.minor_ver, sbi->cluster_size,
-		   sbi->used.bitmap.nbits);
+	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n\%zu\n%zu\n%s\n%s\n",
+		   sbi->volume.major_ver, sbi->volume.minor_ver,
+		   sbi->cluster_size, sbi->used.bitmap.nbits,
+		   sbi->mft.bitmap.nbits,
+		   sbi->mft.bitmap.nbits - wnd_zeroes(&sbi->mft.bitmap),
+		   sbi->volume.real_dirty ? "dirty" : "clean",
+		   (sbi->volume.flags & VOLUME_FLAG_DIRTY) ? "dirty" : "clean");
 
 	return 0;
 }
-- 
2.42.0



