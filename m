Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20D755434
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGPU1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjGPU1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B81B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9370560E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B65C433C9;
        Sun, 16 Jul 2023 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539266;
        bh=9Kzx93ONTewq3YHkLEe+8eOQGn5cKefBKEsEJfh+VDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ek7API/9NpTGHI50uM/WN8h+sYRdQmsAKaALAZoARfM/C0K3iIPmg40lMAbNnMHTA
         m7sWdCTjyr7jIidoDG2jvXQqt994cfbYqx1dh4WjiWSk7svaS8/EV0U/9xJmmePe34
         Lbz3FxU4z0gCz2aYrLUq8LeOpyRPpTjfmUtIcj2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.4 746/800] ext4: Remove ext4 locking of moved directory
Date:   Sun, 16 Jul 2023 21:49:59 +0200
Message-ID: <20230716195006.448596679@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
@@ -3834,19 +3834,10 @@ static int ext4_rename(struct mnt_idmap
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
@@ -4043,10 +4034,6 @@ release_bh:
 	brelse(old.bh);
 	brelse(new.bh);
 
-unlock_moved_dir:
-	if (S_ISDIR(old.inode->i_mode))
-		inode_unlock(old.inode);
-
 	return retval;
 }
 


