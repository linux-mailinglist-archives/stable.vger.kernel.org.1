Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821FF7BDED9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376460AbjJINXq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376458AbjJINXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFB8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:23:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B655C433C8;
        Mon,  9 Oct 2023 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857824;
        bh=AOBR5gMaGwwyLWPOTUrWjlVAGbDV7xosvXDE2FnBSnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSpQsFjYPMi9Fdh6G0ZDVVLc6BaWF+TXp3tvnhpDCrSjCoyLgCIZnP/yJJm1gqqCr
         36+eR9er1+SkPtfGTJJXVbJry9rjOeSyQ7/92A5QnM+iCp56W11roZcbPw+Qi2cBo9
         Xj8CuvxgasZv/O1tO00gHCXsARN4+MB4+xiAMivU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 160/162] btrfs: fix an error handling path in btrfs_rename()
Date:   Mon,  9 Oct 2023 15:02:21 +0200
Message-ID: <20231009130127.342659173@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit abe3bf7425fb695a9b37394af18b9ea58a800802 upstream.

If new_whiteout_inode() fails, some resources need to be freed.
Add the missing goto to the error handling path.

Fixes: ab3c5c18e8fa ("btrfs: setup qstr from dentrys using fscrypt helper")
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9400,8 +9400,10 @@ static int btrfs_rename(struct user_name
 
 	if (flags & RENAME_WHITEOUT) {
 		whiteout_args.inode = new_whiteout_inode(mnt_userns, old_dir);
-		if (!whiteout_args.inode)
-			return -ENOMEM;
+		if (!whiteout_args.inode) {
+			ret = -ENOMEM;
+			goto out_fscrypt_names;
+		}
 		ret = btrfs_new_inode_prepare(&whiteout_args, &trans_num_items);
 		if (ret)
 			goto out_whiteout_inode;


