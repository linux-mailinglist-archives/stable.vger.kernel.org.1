Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2027AC64D
	for <lists+stable@lfdr.de>; Sun, 24 Sep 2023 04:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIXC1w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 22:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXC1w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 22:27:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B417D109
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 19:27:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-404fbfac998so49034405e9.3
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695522464; x=1696127264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMfDZDuksR5eQc4Yl0JfhVvRtgXZ5DRnxfxpGHzX4c4=;
        b=lj08jMYsy5UELG63+WicvSYCJ+8EimzgDjkWb6OtBks4p4ywJ50ani6zPmkB/KepUK
         /vj83i0XYmCHktWUvjVHqkD/hRAlEfE2hpYdylKGh8EharmUSkgjfNj+Es0Ea/BjGeVX
         fOXVYxTBp7sYeaxbe4HTDlzT0es4jCeDTRvy7kr7otlRG6oAUqVN2++lZUc6aKvW3s1+
         3InAYdvE0xmRJtQNDqcSBA3Rdna23jbAV6JJ41JWqDEQKVjKnBtJO5dGaaQHNUp+qzNe
         sq8cymEzhCa0jZa1RP+eSNfjUa4H/50zJ2WIcOeVaLZNKZfbnehvfAG8dPuUxynkzOA8
         nd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695522464; x=1696127264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMfDZDuksR5eQc4Yl0JfhVvRtgXZ5DRnxfxpGHzX4c4=;
        b=jvWdp04VFXe6iU0nce6+BgDZ9B4/bu8N+L5ORcLICLxZP52/QCfVPSO/dBRJlRmfSU
         QlLXpz9bSZ0VFOjHs0DaDUPimqQ2Z/TlrQj2IcNUWYC1b9JA1mIy86uWfj+QdHxcyEyZ
         srBOahNXB6+pmYDoMiuHZf3TOV4uHiwoSag09R2XChSzVB8eaKyA3Eb8dVlQCN6OHMsr
         wl7mlmjTIa0C9QNTX7zsENTB86h/xaxgEkPgzjhMfLfBc6MSpGwPOQRBaAmV4FaAtUdt
         +0xFCqnr5BhZRvDIYkW4oVHTHuutvnJ6ZWB//yXIHGp/QFa7WkRPtKu/fjbfMKKgBcML
         Cd0Q==
X-Gm-Message-State: AOJu0YwHQMzkEitW5w/d74VrdbAUZ0QjJLxI7raN3BiQvB/k6BwdyEuN
        AUUJuCk1cZu0JUon5W9oNX9/T+2hUYDwkjYE
X-Google-Smtp-Source: AGHT+IFR9bWkrjxdc0c3nfvmaiT52a2qLTOuinBjLmy9PRa+dR9KfCiULXTDhUx3KhBjBJix4qL9dQ==
X-Received: by 2002:a05:600c:291:b0:404:fc5c:15ed with SMTP id 17-20020a05600c029100b00404fc5c15edmr2812991wmk.35.1695522463659;
        Sat, 23 Sep 2023 19:27:43 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b00321673de0d7sm8156299wrw.25.2023.09.23.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:27:43 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     stable@vger.kernel.org
Cc:     starzhangzsd@gmail.com, Shida Zhang <zhangshida@kylinos.cn>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 4.19.y] ext4: fix rec_len verify error
Date:   Sun, 24 Sep 2023 10:27:35 +0800
Message-Id: <20230924022735.2256466-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023092055-disband-unveiling-f6cc@gregkh>
References: <2023092055-disband-unveiling-f6cc@gregkh>
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
(cherry picked from commit 7fda67e8c3ab6069f75888f67958a6d30454a9f6)
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/namei.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index db9bba3473b5..93d392576c12 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -322,17 +322,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
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
@@ -343,7 +343,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -425,13 +426,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
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
@@ -1244,6 +1246,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1257,11 +1260,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
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

