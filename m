Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03A703805
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbjEOR0q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbjEOR0U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD711B6D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6082762CA9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535CAC433D2;
        Mon, 15 May 2023 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171507;
        bh=gijC1yzGZA3N6eISKROgoqHRNLNf9w56/SDtBFj4ZPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brl+nqO21hwJ5E10MySTVQNw1duF1SOAVsSNRG/Wq7L02gELG9oIXnceZeNlGqdhV
         8ETUMVinpM1vnOpl3guEeT5VK9zTQc1gxNJfp8UupjIV+WUegPGePR2Y31sGhizAUV
         jstxPl3qy/wqCz6zRpXP97RL6E+6dz4N50P8IOqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+394aa8a792cb99dbc837@syzkaller.appspotmail.com,
        syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.2 230/242] ext4: improve error handling from ext4_dirhash()
Date:   Mon, 15 May 2023 18:29:16 +0200
Message-Id: <20230515161728.814682583@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Theodore Ts'o <tytso@mit.edu>

commit 4b3cb1d108bfc2aebb0d7c8a52261a53cf7f5786 upstream.

The ext4_dirhash() will *almost* never fail, especially when the hash
tree feature was first introduced.  However, with the addition of
support of encrypted, casefolded file names, that function can most
certainly fail today.

So make sure the callers of ext4_dirhash() properly check for
failures, and reflect the errors back up to their callers.

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230506142419.984260-1-tytso@mit.edu
Reported-by: syzbot+394aa8a792cb99dbc837@syzkaller.appspotmail.com
Reported-by: syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=db56459ea4ac4a676ae4b4678f633e55da005a9b
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/hash.c  |    6 +++++-
 fs/ext4/namei.c |   53 +++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 17 deletions(-)

--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -277,7 +277,11 @@ static int __ext4fs_dirhash(const struct
 	}
 	default:
 		hinfo->hash = 0;
-		return -1;
+		hinfo->minor_hash = 0;
+		ext4_warning(dir->i_sb,
+			     "invalid/unsupported hash tree version %u",
+			     hinfo->hash_version);
+		return -EINVAL;
 	}
 	hash = hash & ~1;
 	if (hash == (EXT4_HTREE_EOF_32BIT << 1))
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -674,7 +674,7 @@ static struct stats dx_show_leaf(struct
 				len = de->name_len;
 				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
-					ext4fs_dirhash(dir, de->name,
+					(void) ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
 					printk("%*.s:(U)%x.%u ", len,
 					       name, h.hash,
@@ -709,8 +709,9 @@ static struct stats dx_show_leaf(struct
 					if (IS_CASEFOLDED(dir))
 						h.hash = EXT4_DIRENT_HASH(de);
 					else
-						ext4fs_dirhash(dir, de->name,
-						       de->name_len, &h);
+						(void) ext4fs_dirhash(dir,
+							de->name,
+							de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
 								   - base));
@@ -720,7 +721,8 @@ static struct stats dx_show_leaf(struct
 #else
 				int len = de->name_len;
 				char *name = de->name;
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+				(void) ext4fs_dirhash(dir, de->name,
+						      de->name_len, &h);
 				printk("%*.s:%x.%u ", len, name, h.hash,
 				       (unsigned) ((char *) de - base));
 #endif
@@ -849,8 +851,14 @@ dx_probe(struct ext4_filename *fname, st
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 	/* hash is already computed for encrypted casefolded directory */
 	if (fname && fname_name(fname) &&
-				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
-		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
+	    !(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir))) {
+		int ret = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), hinfo);
+		if (ret < 0) {
+			ret_err = ERR_PTR(ret);
+			goto fail;
+		}
+	}
 	hash = hinfo->hash;
 
 	if (root->info.unused_flags & 1) {
@@ -1111,7 +1119,12 @@ static int htree_dirblock_to_tree(struct
 				hinfo->minor_hash = 0;
 			}
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name,
+					     de->name_len, hinfo);
+			if (err < 0) {
+				count = err;
+				goto errout;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
@@ -1313,8 +1326,12 @@ static int dx_make_map(struct inode *dir
 		if (de->name_len && de->inode) {
 			if (ext4_hash_in_dirent(dir))
 				h.hash = EXT4_DIRENT_HASH(de);
-			else
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+			else {
+				int err = ext4fs_dirhash(dir, de->name,
+						     de->name_len, &h);
+				if (err < 0)
+					return err;
+			}
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
@@ -1452,10 +1469,9 @@ int ext4_fname_setup_ci_filename(struct
 	hinfo->hash_version = DX_HASH_SIPHASH;
 	hinfo->seed = NULL;
 	if (cf_name->name)
-		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+		return ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
 	else
-		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
-	return 0;
+		return ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
 }
 #endif
 
@@ -2298,10 +2314,15 @@ static int make_indexed_dir(handle_t *ha
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 
 	/* casefolded encrypted hashes are computed on fname setup */
-	if (!ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_name(fname),
-				fname_len(fname), &fname->hinfo);
-
+	if (!ext4_hash_in_dirent(dir)) {
+		int err = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), &fname->hinfo);
+		if (err < 0) {
+			brelse(bh2);
+			brelse(bh);
+			return err;
+		}
+	}
 	memset(frames, 0, sizeof(frames));
 	frame = frames;
 	frame->entries = entries;


