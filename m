Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E453C7614FD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjGYLYb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjGYLYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E797
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 493B76167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3C5C433C9;
        Tue, 25 Jul 2023 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284268;
        bh=8m6eav4SntL9E9lvTwD8myAVuBHyodsZr0FeIXrhjMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ti5PZBpRXa86sgsIZpqCMaW5nf4bfjfucTBnLDXZd7WeEDaTl+6hPKz4uPVC5tg2a
         dIV8ECuvqXVS5oWNa+/vt0zrKkXZ/3923FJeGVQ/xRFC/fwPauXuaFoa8KQ9JtWHE9
         AIG4M1aLBHKsMz2szL/yA17tGfjXBmJYbDQkOdqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.10 296/509] ext4: Remove ext4 locking of moved directory
Date:   Tue, 25 Jul 2023 12:43:55 +0200
Message-ID: <20230725104607.288640820@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 3658840cd363f2be094f5dfd2f0b174a9055dd0f upstream.

Remove locking of moved directory in ext4_rename2(). We will take care
of it in VFS instead. This effectively reverts commit 0813299c586b
("ext4: Fix possible corruption when moving a directory") and followup
fixes.

CC: Ted Tso <tytso@mit.edu>
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230601105830.13168-1-jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/namei.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3863,19 +3863,10 @@ static int ext4_rename(struct inode *old
 			return retval;
 	}
 
-	/*
-	 * We need to protect against old.inode directory getting converted
-	 * from inline directory format into a normal one.
-	 */
-	if (S_ISDIR(old.inode->i_mode))
-		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
-
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
 				 &old.inlined);
-	if (IS_ERR(old.bh)) {
-		retval = PTR_ERR(old.bh);
-		goto unlock_moved_dir;
-	}
+	if (IS_ERR(old.bh))
+		return PTR_ERR(old.bh);
 
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
@@ -4065,10 +4056,6 @@ release_bh:
 	brelse(old.bh);
 	brelse(new.bh);
 
-unlock_moved_dir:
-	if (S_ISDIR(old.inode->i_mode))
-		inode_unlock(old.inode);
-
 	return retval;
 }
 


