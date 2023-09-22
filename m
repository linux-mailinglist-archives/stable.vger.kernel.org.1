Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D66C7AA873
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjIVFjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 01:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVFjb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 01:39:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6A8F
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 22:39:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1695510f8f.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695361164; x=1695965964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipDK22wS5etgWiSV07SPcEV8HzMBF9D7TF65lxUNyyc=;
        b=h/KwFOzqDZcYbR4AdN5f4f8VRAys0DWDQ1n5PsFNnRssOeoiJlcX3GyzNV2OoNdswr
         ABzZ38Sg90bYtH92mYsjU/IHFX7so8NKYRfu2xUNE4KGYG4zaZJWOh9/hcrcNt7ILL8+
         TXJacv1Wl1LeBweeuRZQGOguiulrsMZIrx1o3+9j3CEB/9q6/snjqPPLFZ75cYn4/MOx
         lFkS6cZ2dA0nxxGw41e5VHpU8oauRPmX5Ei981MQPZktPfuIyLDDDWyGbuDn4Thwx6vV
         RFao9S7PMdbbLG6F5fCbgtMVd53GRHvTlD3GEATiXoj1R+zQA0uU4xQHlB5sgZ3XbvIW
         7boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695361164; x=1695965964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipDK22wS5etgWiSV07SPcEV8HzMBF9D7TF65lxUNyyc=;
        b=XLLej9r3mttIQBiJqueaQtk2RnQcSn89iQaCJ3sjRcruiKrepjylrFSjLZ08xw+Oof
         qVYzkFSgHUY5dxq5XxnsgK4wD15+lnbjp0NBnEgzrK9PQCq7cl5pXeGEaNZ19cE2X4lS
         Cv2THxYOOXLv0HN4KK72tZyG24eWlZDKYKLFWUvsXcBvdhfW7w4D7Rp2Oz/MVXfg/igi
         49DuE/8Hkkqbsuf4+pYFgLypTNhXuZzt7M0sgOMyN4oYneG1ohdnmtuZiaLvvEs4qWBT
         qRPes6m2eAsCQLaCSHICJgRjtbFoFZ2i7kBDhivhtB4/thYLXSdIzUdW5R4njFjxLzJh
         YmOA==
X-Gm-Message-State: AOJu0YyDyMEUKsVGLopO56XzLfFKoCLuLFtKe9hmaud1BKHf1iMUwpOw
        pOQYiZDiFyM3n+u0jsbeHt1+UBy6xZtKpiHE
X-Google-Smtp-Source: AGHT+IHlrgYBDjD0MOh3X7fzj3PvnTCAscAAftXePQzZEaon+8jjjzJSyYG0VKALreAxq09baImrAA==
X-Received: by 2002:a05:6000:41:b0:31f:b402:5aaa with SMTP id k1-20020a056000004100b0031fb4025aaamr6312297wrx.8.1695361163378;
        Thu, 21 Sep 2023 22:39:23 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdcc5000000b0031c6581d55esm3505880wrm.91.2023.09.21.22.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 22:39:23 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     stable@vger.kernel.org
Cc:     starzhangzsd@gmail.com, Shida Zhang <zhangshida@kylinos.cn>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] ext4: fix rec_len verify error
Date:   Fri, 22 Sep 2023 13:39:15 +0800
Message-Id: <20230922053915.2176290-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023092057-company-unworried-210b@gregkh>
References: <2023092057-company-unworried-210b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

[ Upstream commit 7fda67e8c3ab6069f75888f67958a6d30454a9f6 ]

With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
a problem occurred when more than 13 million files were directly created
under a directory:

EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum

When enough files are created, the fake_dirent->reclen will be 0xffff.
it doesn't equal to the blocksize 65536, i.e. 0x10000.

But it is not the same condition when blocksize equals to 4k.
when enough files are created, the fake_dirent->reclen will be 0x1000.
it equals to the blocksize 4k, i.e. 0x1000.

The problem seems to be related to the limitation of the 16-bit field
when the blocksize is set to 64k.
To address this, helpers like ext4_rec_len_{from,to}_disk has already
been introduced to complete the conversion between the encoded and the
plain form of rec_len.

So fix this one by using the helper, and all the other in this file too.

Cc: stable@kernel.org
Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree nodes")
Suggested-by: Andreas Dilger <adilger@dilger.ca>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Link: https://lore.kernel.org/r/20230803060938.1929759-1-zhangshida@kylinos.cn
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/namei.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 57c78a7a7425..a763216e1c15 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -321,17 +321,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 						   struct ext4_dir_entry *de)
 {
 	struct ext4_dir_entry_tail *t;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
 #ifdef PARANOID
 	struct ext4_dir_entry *d, *top;
 
 	d = de;
 	top = (struct ext4_dir_entry *)(((void *)de) +
-		(EXT4_BLOCK_SIZE(inode->i_sb) -
-		sizeof(struct ext4_dir_entry_tail)));
-	while (d < top && d->rec_len)
+		(blocksize - sizeof(struct ext4_dir_entry_tail)));
+	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
 		d = (struct ext4_dir_entry *)(((void *)d) +
-		    le16_to_cpu(d->rec_len));
+		    ext4_rec_len_from_disk(d->rec_len, blocksize));
 
 	if (d != top)
 		return NULL;
@@ -342,7 +342,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -424,13 +425,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
+	unsigned int rlen = ext4_rec_len_from_disk(dirent->rec_len, blocksize);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (rlen == blocksize)
 		count_offset = 8;
-	else if (le16_to_cpu(dirent->rec_len) == 12) {
+	else if (rlen == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-		if (le16_to_cpu(dp->rec_len) !=
-		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
+		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
 			return NULL;
 		root = (struct dx_root_info *)(((void *)dp + 12));
 		if (root->reserved_zero ||
@@ -1243,6 +1245,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1256,11 +1259,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
-			map_tail->size = le16_to_cpu(de->rec_len);
+			map_tail->size = ext4_rec_len_from_disk(de->rec_len,
+								blocksize);
 			count++;
 			cond_resched();
 		}
-		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
+		de = ext4_next_entry(de, blocksize);
 	}
 	return count;
 }
-- 
2.27.0

