Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F17AC64C
	for <lists+stable@lfdr.de>; Sun, 24 Sep 2023 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjIXCUO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 22:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIXCUO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 22:20:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947010B
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 19:20:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3231df054c4so552951f8f.0
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 19:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695522005; x=1696126805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipDK22wS5etgWiSV07SPcEV8HzMBF9D7TF65lxUNyyc=;
        b=JdmcUnjawlFgzrqSb2UUqJvCn3OTdUVkNHPxjH/z+3XhszLNs7qWaJJcXXvYWrOvBV
         7QoyR2n5vAwkBwvWP9ofn9ryU1OH4+PIswUISEgptvztslpdphCBuOIy+5ylqc42AJ8w
         jj0ZAzfsLORclY4u8oYPy1g7oQcIklrrw08qUWhA4C5bZ6nyF7juLHN+EwQKtsMYD4Xn
         FzMujJhYYn0Fd/xJZ7kII2Ul+oe6ucYzVkeUHiMkiEZBPg1x++7dSH+clgC2xb/SB1dU
         pVEvMVVN82NplP7/k3WMh8PtE9yRvlYYFk5cW6kzI7HPmWEjr6ZsARvO3ZwhP4JkQbmN
         +PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695522005; x=1696126805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipDK22wS5etgWiSV07SPcEV8HzMBF9D7TF65lxUNyyc=;
        b=iCL1M2ITpQEnIydA4wUqLoHH+gMt5ND9bIDMpllLy8suvuU8P5i2e2wxDj1/qYEN8N
         KZg1Lj0XF+Guo05iptIzu3nnt48i2XLnSRD3Fq8aOjHdSnwgIf3b3X+QV7n3ZF4h8e1f
         8LtSASsTZszr9uceRV1jjJzV2oKKNlQO5NxqsikmLIbdz1nix9BvUgy/Lhz5NBN3UMQP
         ylHHfr3rz0k9MdbvIaGchjLX2BSXc7LDPVe8RZnYIs3Fvo+wELd2XsWlEvLNE7JOy9mG
         cmxtOj1WodtU2R2ZGfzdC0Yncy0FT2TWYWq9pb/jIM204/tKfM+V7iZkgx2EyBH4uAOa
         GbKQ==
X-Gm-Message-State: AOJu0YyneVB/HewErhKeoUVVvF++7nxfo/ZmWJ2cLr88GXuopqHYzyds
        ZFLqTIjnx1BBcGWukJoZhwdXRdgCMxIwsIMI
X-Google-Smtp-Source: AGHT+IHx15wMt5oM8pYEWfa4DWtMlKFptKkNDvLU+siii1DTxlFSFEfqqGoyebYau5UtVgdthr3IKQ==
X-Received: by 2002:a5d:634c:0:b0:320:a4e:6b83 with SMTP id b12-20020a5d634c000000b003200a4e6b83mr2849707wrw.31.1695522004620;
        Sat, 23 Sep 2023 19:20:04 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b0031ffa453affsm8168744wru.17.2023.09.23.19.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:20:04 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     stable@vger.kernel.org
Cc:     starzhangzsd@gmail.com, Shida Zhang <zhangshida@kylinos.cn>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 4.14.y] ext4: fix rec_len verify error
Date:   Sun, 24 Sep 2023 10:19:55 +0800
Message-Id: <20230924021955.2256033-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023092057-company-unworried-210b@gregkh>
References: <2023092057-company-unworried-210b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

