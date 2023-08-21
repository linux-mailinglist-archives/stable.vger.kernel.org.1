Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6450783234
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjHUUBO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHUUBO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C34123
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD1F647A1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3ECC433C7;
        Mon, 21 Aug 2023 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648069;
        bh=z2IRWWYs/DyVYsjKdWnLHgCyC/jhbsowJiurYHgULuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/PuwH9UZQQt++Vl2OqmSpZNM1C2nQnvEzoukcMFRkx56HWsolRw8d+e9btFG8Em3
         4T71VGghdPBMZ0GpOu1Eg8/a4civVxGQc5rB7kvnLqMLTKlSecxEfu6pUum8Na9P/x
         1OTNswZkROuCC2tBXEPQ9Li4S5NBuM69SgXZmHow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 044/234] smb: client: fix warning in cifs_smb3_do_mount()
Date:   Mon, 21 Aug 2023 21:40:07 +0200
Message-ID: <20230821194130.678862214@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 12c30f33cc6769bf411088a2872843c4f9ea32f9 ]

This fixes the following warning reported by kernel test robot

  fs/smb/client/cifsfs.c:982 cifs_smb3_do_mount() warn: possible
  memory leak of 'cifs_sb'

Link: https://lore.kernel.org/all/202306170124.CtQqzf0I-lkp@intel.com/
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 43a4d8603db34..30b03938f6d1d 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -884,11 +884,11 @@ struct dentry *
 cifs_smb3_do_mount(struct file_system_type *fs_type,
 	      int flags, struct smb3_fs_context *old_ctx)
 {
-	int rc;
-	struct super_block *sb = NULL;
-	struct cifs_sb_info *cifs_sb = NULL;
 	struct cifs_mnt_data mnt_data;
+	struct cifs_sb_info *cifs_sb;
+	struct super_block *sb;
 	struct dentry *root;
+	int rc;
 
 	if (cifsFYI) {
 		cifs_dbg(FYI, "%s: devname=%s flags=0x%x\n", __func__,
@@ -897,11 +897,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 		cifs_info("Attempting to mount %s\n", old_ctx->source);
 	}
 
-	cifs_sb = kzalloc(sizeof(struct cifs_sb_info), GFP_KERNEL);
-	if (cifs_sb == NULL) {
-		root = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	cifs_sb = kzalloc(sizeof(*cifs_sb), GFP_KERNEL);
+	if (!cifs_sb)
+		return ERR_PTR(-ENOMEM);
 
 	cifs_sb->ctx = kzalloc(sizeof(struct smb3_fs_context), GFP_KERNEL);
 	if (!cifs_sb->ctx) {
@@ -938,10 +936,8 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 
 	sb = sget(fs_type, cifs_match_super, cifs_set_super, flags, &mnt_data);
 	if (IS_ERR(sb)) {
-		root = ERR_CAST(sb);
 		cifs_umount(cifs_sb);
-		cifs_sb = NULL;
-		goto out;
+		return ERR_CAST(sb);
 	}
 
 	if (sb->s_root) {
@@ -972,13 +968,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	deactivate_locked_super(sb);
 	return root;
 out:
-	if (cifs_sb) {
-		if (!sb || IS_ERR(sb)) {  /* otherwise kill_sb will handle */
-			kfree(cifs_sb->prepath);
-			smb3_cleanup_fs_context(cifs_sb->ctx);
-			kfree(cifs_sb);
-		}
-	}
+	kfree(cifs_sb->prepath);
+	smb3_cleanup_fs_context(cifs_sb->ctx);
+	kfree(cifs_sb);
 	return root;
 }
 
-- 
2.40.1



