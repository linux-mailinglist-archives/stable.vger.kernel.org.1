Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49B726DD5
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjFGUqD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjFGUpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0FB26AD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9CB064683
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A2EC433D2;
        Wed,  7 Jun 2023 20:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170729;
        bh=Eph5TImebbgjvtODVyj0Rbm4znM/CAAD2vPIht+JxTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOK6RxYxf2E0bPpN/KOzhP9bjJ/h/GPISU9zfbql3HOi9yT0JCQGAoCh7ArADrMve
         3Anwglm6ejH49lydL/SIyKk1fCli9N3oQYcpq+1P0Vk/HXtPzk2xLru+EHP1GFY5KD
         EShGPBOfK3+vlevptI+rYAG4fGT4x1TpP0wsqRF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com,
        syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com,
        syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com,
        stable@kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 196/225] ext4: add EA_INODE checking to ext4_iget()
Date:   Wed,  7 Jun 2023 22:16:29 +0200
Message-ID: <20230607200920.784114439@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit b3e6bcb94590dea45396b9481e47b809b1be4afa upstream.

Add a new flag, EXT4_IGET_EA_INODE which indicates whether the inode
is expected to have the EA_INODE flag or not.  If the flag is not
set/clear as expected, then fail the iget() operation and mark the
file system as corrupted.

This commit also makes the ext4_iget() always perform the
is_bad_inode() check even when the inode is already inode cache.  This
allows us to remove the is_bad_inode() check from the callers of
ext4_iget() in the ea_inode code.

Reported-by: syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com
Reported-by: syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com
Reported-by: syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com
Cc: stable@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20230524034951.779531-2-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h  |    3 ++-
 fs/ext4/inode.c |   31 ++++++++++++++++++++++++++-----
 fs/ext4/xattr.c |   36 +++++++-----------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2968,7 +2968,8 @@ typedef enum {
 	EXT4_IGET_NORMAL =	0,
 	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
 	EXT4_IGET_HANDLE = 	0x0002,	/* Inode # is from a handle */
-	EXT4_IGET_BAD =		0x0004  /* Allow to iget a bad inode */
+	EXT4_IGET_BAD =		0x0004, /* Allow to iget a bad inode */
+	EXT4_IGET_EA_INODE =	0x0008	/* Inode should contain an EA value */
 } ext4_iget_flags;
 
 extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4763,6 +4763,21 @@ static inline void ext4_inode_set_iversi
 		inode_set_iversion_queried(inode, val);
 }
 
+static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
+
+{
+	if (flags & EXT4_IGET_EA_INODE) {
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+			return "missing EA_INODE flag";
+	} else {
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+			return "unexpected EA_INODE flag";
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
+		return "unexpected bad inode w/o EXT4_IGET_BAD";
+	return NULL;
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -4772,6 +4787,7 @@ struct inode *__ext4_iget(struct super_b
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
+	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4799,8 +4815,14 @@ struct inode *__ext4_iget(struct super_b
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode->i_state & I_NEW)) {
+		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
+			ext4_error_inode(inode, function, line, 0, err_str);
+			iput(inode);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
 		return inode;
+	}
 
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
@@ -5066,10 +5088,9 @@ struct inode *__ext4_iget(struct super_b
 	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
-		ext4_error_inode(inode, function, line, 0,
-				 "bad inode without EXT4_IGET_BAD flag");
-		ret = -EUCLEAN;
+	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
+		ext4_error_inode(inode, function, line, 0, err_str);
+		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
 
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -397,7 +397,7 @@ static int ext4_xattr_inode_iget(struct
 		return -EFSCORRUPTED;
 	}
 
-	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_NORMAL);
+	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_EA_INODE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		ext4_error(parent->i_sb,
@@ -405,23 +405,6 @@ static int ext4_xattr_inode_iget(struct
 			   err);
 		return err;
 	}
-
-	if (is_bad_inode(inode)) {
-		ext4_error(parent->i_sb,
-			   "error while reading EA inode %lu is_bad_inode",
-			   ea_ino);
-		err = -EIO;
-		goto error;
-	}
-
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
-		ext4_error(parent->i_sb,
-			   "EA inode %lu does not have EXT4_EA_INODE_FL flag",
-			    ea_ino);
-		err = -EINVAL;
-		goto error;
-	}
-
 	ext4_xattr_inode_set_class(inode);
 
 	/*
@@ -442,9 +425,6 @@ static int ext4_xattr_inode_iget(struct
 
 	*ea_inode = inode;
 	return 0;
-error:
-	iput(inode);
-	return err;
 }
 
 /* Remove entry from mbcache when EA inode is getting evicted */
@@ -1507,11 +1487,10 @@ ext4_xattr_inode_cache_find(struct inode
 
 	while (ce) {
 		ea_inode = ext4_iget(inode->i_sb, ce->e_value,
-				     EXT4_IGET_NORMAL);
-		if (!IS_ERR(ea_inode) &&
-		    !is_bad_inode(ea_inode) &&
-		    (EXT4_I(ea_inode)->i_flags & EXT4_EA_INODE_FL) &&
-		    i_size_read(ea_inode) == value_len &&
+				     EXT4_IGET_EA_INODE);
+		if (IS_ERR(ea_inode))
+			goto next_entry;
+		if (i_size_read(ea_inode) == value_len &&
 		    !ext4_xattr_inode_read(ea_inode, ea_data, value_len) &&
 		    !ext4_xattr_inode_verify_hashes(ea_inode, NULL, ea_data,
 						    value_len) &&
@@ -1521,9 +1500,8 @@ ext4_xattr_inode_cache_find(struct inode
 			kvfree(ea_data);
 			return ea_inode;
 		}
-
-		if (!IS_ERR(ea_inode))
-			iput(ea_inode);
+		iput(ea_inode);
+	next_entry:
 		ce = mb_cache_entry_find_next(ea_inode_cache, ce);
 	}
 	kvfree(ea_data);


