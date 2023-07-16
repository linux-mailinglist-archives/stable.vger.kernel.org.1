Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5A75545A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjGPU3c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjGPU3a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF329F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B007760EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA40FC433C8;
        Sun, 16 Jul 2023 20:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539369;
        bh=AvCSc32dKS8LKoAJpVstBaLvB21AaawCopakwGBabjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siiVrBcbaiY0ZqavdsRLhAnLKDtWIEALVgLLq6L8M7f7+oXKnO7lnf+cE8V9eBgZe
         UL+LnhEmG04QYBen4c+q3gIMkz8JbE07F0BPt6ZeBRAtB81mas4Ko90X99EwVLcm+k
         jgXUDkVUPWGQBwXOANKviQPrEz2+exWM3OuYCJv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.4 783/800] ovl: fix null pointer dereference in ovl_permission()
Date:   Sun, 16 Jul 2023 21:50:36 +0200
Message-ID: <20230716195007.332930252@linuxfoundation.org>
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

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit 1a73f5b8f079fd42a544c1600beface50c63af7c upstream.

Following process:
          P1                     P2
 path_lookupat
  link_path_walk
   inode_permission
    ovl_permission
      ovl_i_path_real(inode, &realpath)
        path->dentry = ovl_i_dentry_upper(inode)
                          drop_cache
			   __dentry_kill(ovl_dentry)
		            iput(ovl_inode)
		             ovl_destroy_inode(ovl_inode)
		              dput(oi->__upperdentry)
		               dentry_kill(upperdentry)
		                dentry_unlink_inode
				 upperdentry->d_inode = NULL
      realinode = d_inode(realpath.dentry) // return NULL
      inode_permission(realinode)
       inode->i_sb  // NULL pointer dereference
, will trigger an null pointer dereference at realinode:
  [  335.664979] BUG: kernel NULL pointer dereference,
                 address: 0000000000000002
  [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
  [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
  [  335.678939] Call Trace:
  [  335.679165]  <TASK>
  [  335.679371]  ovl_permission+0xde/0x320
  [  335.679723]  inode_permission+0x15e/0x2c0
  [  335.680090]  link_path_walk+0x115/0x550
  [  335.680771]  path_lookupat.isra.0+0xb2/0x200
  [  335.681170]  filename_lookup+0xda/0x240
  [  335.681922]  vfs_statx+0xa6/0x1f0
  [  335.682233]  vfs_fstatat+0x7b/0xb0

Fetch a reproducer in [Link].

Use the helper ovl_i_path_realinode() to get realinode and then do
non-nullptr checking.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217405
Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
Cc: <stable@vger.kernel.org> # v5.19
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/inode.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -288,8 +288,8 @@ int ovl_permission(struct mnt_idmap *idm
 	int err;
 
 	/* Careful in RCU walk mode */
-	ovl_i_path_real(inode, &realpath);
-	if (!realpath.dentry) {
+	realinode = ovl_i_path_real(inode, &realpath);
+	if (!realinode) {
 		WARN_ON(!(mask & MAY_NOT_BLOCK));
 		return -ECHILD;
 	}
@@ -302,7 +302,6 @@ int ovl_permission(struct mnt_idmap *idm
 	if (err)
 		return err;
 
-	realinode = d_inode(realpath.dentry);
 	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {


