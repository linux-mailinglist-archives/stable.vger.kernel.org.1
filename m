Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF545775DF1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjHILm1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHILm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F41FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1C4636D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A43CC433CB;
        Wed,  9 Aug 2023 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581345;
        bh=yM3h/ytfl8HFqQOGWnjQj2o2cTF1i5EP/kxziaCNv5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYdD7e03xllzBEBFC6dRlWp6Ftnlo6ipad5IW2aQGwTK5G0amW7868tphsjnXrvSx
         l3y/lCOzQj+Y8r0SWTfF750eUzu8awFs+80pdJPWnwT86Tsj93xKiGz3oGqqplMryx
         fjl6lqG43kGZIwVnjcSITvN6U6FJ6pygi395+gZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hyeongseok Kim <hyeongseok@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 193/201] exfat: speed up iterate/lookup by fixing start point of traversing cluster chain
Date:   Wed,  9 Aug 2023 12:43:15 +0200
Message-ID: <20230809103650.303814918@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hyeongseok Kim <hyeongseok@gmail.com>

[ Upstream commit c6e2f52e3051e8d898d38840104638ca8bbcdec2 ]

When directory iterate and lookup is called, there's a buggy rewinding
of start point for traversing cluster chain to the parent directory
entry's first cluster. This caused repeated cluster chain traversing
from the first entry of the parent directory that would show worse
performance if huge amounts of files exist under the parent directory.
Fix not to rewind, make continue from currently referenced cluster and
dir entry.

Tested with 50,000 files under single directory / 256GB sdcard,
with command "time ls -l > /dev/null",
Before :     0m08.69s real     0m00.27s user     0m05.91s system
After  :     0m07.01s real     0m00.25s user     0m04.34s system

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Stable-dep-of: d42334578eba ("exfat: check if filename entries exceeds max filename length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/dir.c      | 19 +++++++++++++------
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/namei.c    |  9 ++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 093f79ae3c671..0e1886f9a6241 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -148,7 +148,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 					0);
 
 			*uni_name.name = 0x0;
-			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
+			exfat_get_uniname_from_ext_entry(sb, &clu, i,
 				uni_name.name);
 			exfat_utf16_to_nls(sb, &uni_name,
 				dir_entry->namebuf.lfn,
@@ -902,14 +902,19 @@ enum {
 };
 
 /*
- * return values:
- *   >= 0	: return dir entiry position with the name in dir
- *   -ENOENT	: entry with the name does not exist
- *   -EIO	: I/O error
+ * @ei:         inode info of parent directory
+ * @p_dir:      directory structure of parent directory
+ * @num_entries:entry size of p_uniname
+ * @hint_opt:   If p_uniname is found, filled with optimized dir/entry
+ *              for traversing cluster chain.
+ * @return:
+ *   >= 0:      file directory entry position where the name exists
+ *   -ENOENT:   entry with the name does not exist
+ *   -EIO:      I/O error
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type)
+		int num_entries, unsigned int type, struct exfat_hint *hint_opt)
 {
 	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
 	int order, step, name_len = 0;
@@ -986,6 +991,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 
 			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR) {
 				step = DIRENT_STEP_FILE;
+				hint_opt->clu = clu.dir;
+				hint_opt->eidx = i;
 				if (type == TYPE_ALL || type == entry_type) {
 					num_ext = ep->dentry.file.num_ext;
 					step = DIRENT_STEP_STRM;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 07b09af57436f..436683da2515c 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -458,7 +458,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries, unsigned int type, struct exfat_hint *hint_opt);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1382d816912c8..bd00afc5e4c16 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -596,6 +596,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	struct exfat_inode_info *ei = EXFAT_I(dir);
 	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es;
+	/* for optimized dir & entry to prevent long traverse of cluster chain */
+	struct exfat_hint hint_opt;
 
 	if (qname->len == 0)
 		return -ENOENT;
@@ -619,7 +621,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 	/* search the file name for directories */
 	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
-			num_entries, TYPE_ALL);
+			num_entries, TYPE_ALL, &hint_opt);
 
 	if (dentry < 0)
 		return dentry; /* -error value */
@@ -628,6 +630,11 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->entry = dentry;
 	info->num_subdirs = 0;
 
+	/* adjust cdir to the optimized value */
+	cdir.dir = hint_opt.clu;
+	if (cdir.flags & ALLOC_NO_FAT_CHAIN)
+		cdir.size -= dentry / sbi->dentries_per_clu;
+	dentry = hint_opt.eidx;
 	es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 	if (!es)
 		return -EIO;
-- 
2.40.1



