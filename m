Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4949575D445
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGUTTj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjGUTTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75330ED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7AD61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B07EC433C8;
        Fri, 21 Jul 2023 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967167;
        bh=xHofbX3Qluu8lkL3KQFTTm5ooNYgfikNe91gcg/2WTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+NAkSChPMSYCg4/eP9COU71l31Xhc1R5BLFePiJ72fyrACYVPF2B8cV1/oEVqhaV
         3QXLCVq5RkRAVwQf+/xrycSS22/5lMm1DFfzvKl5TWTFU70ZpRJZObpzwZcq8tw7m7
         zIlwTU6OUfjVqlJpoQBcrz0Q09TVxquJHCfBmCPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.1 067/223] ovl: fix null pointer dereference in ovl_get_acl_rcu()
Date:   Fri, 21 Jul 2023 18:05:20 +0200
Message-ID: <20230721160523.716877753@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit f4e19e595cc2e76a8a58413eb19d3d9c51328b53 ]

Following process:
         P1                     P2
 path_openat
  link_path_walk
   may_lookup
    inode_permission(rcu)
     ovl_permission
      acl_permission_check
       check_acl
        get_cached_acl_rcu
	 ovl_get_inode_acl
	  realinode = ovl_inode_real(ovl_inode)
	                      drop_cache
		               __dentry_kill(ovl_dentry)
				iput(ovl_inode)
		                 ovl_destroy_inode(ovl_inode)
		                  dput(oi->__upperdentry)
		                   dentry_kill(upperdentry)
		                    dentry_unlink_inode
				     upperdentry->d_inode = NULL
	    ovl_inode_upper
	     upperdentry = ovl_i_dentry_upper(ovl_inode)
	     d_inode(upperdentry) // returns NULL
	  IS_POSIXACL(realinode) // NULL pointer dereference
, will trigger an null pointer dereference at realinode:
  [  205.472797] BUG: kernel NULL pointer dereference, address:
                 0000000000000028
  [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
                 6.3.0-12064-g2edfa098e750-dirty #1216
  [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
  [  205.489584] Call Trace:
  [  205.489812]  <TASK>
  [  205.490014]  ovl_get_inode_acl+0x26/0x30
  [  205.490466]  get_cached_acl_rcu+0x61/0xa0
  [  205.490908]  generic_permission+0x1bf/0x4e0
  [  205.491447]  ovl_permission+0x79/0x1b0
  [  205.491917]  inode_permission+0x15e/0x2c0
  [  205.492425]  link_path_walk+0x115/0x550
  [  205.493311]  path_lookupat.isra.0+0xb2/0x200
  [  205.493803]  filename_lookup+0xda/0x240
  [  205.495747]  vfs_fstatat+0x7b/0xb0

Fetch a reproducer in [Link].

Use the helper ovl_i_path_realinode() to get realinode and then do
non-nullptr checking.

There are some changes from upstream commit:
1. Corrusponds to do_ovl_get_acl() in 6.1 is ovl_get_acl()
2. Context conflicts caused by 6c0a8bfb84af8f3 ("ovl: implement get acl
   method") is handled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217404
Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
Cc: <stable@vger.kernel.org> # v5.15
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/inode.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -497,20 +497,20 @@ static void ovl_idmap_posix_acl(struct i
  */
 struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 {
-	struct inode *realinode = ovl_inode_real(inode);
+	struct inode *realinode;
 	struct posix_acl *acl, *clone;
 	struct path realpath;
 
-	if (!IS_POSIXACL(realinode))
-		return NULL;
-
 	/* Careful in RCU walk mode */
-	ovl_i_path_real(inode, &realpath);
-	if (!realpath.dentry) {
+	realinode = ovl_i_path_real(inode, &realpath);
+	if (!realinode) {
 		WARN_ON(!rcu);
 		return ERR_PTR(-ECHILD);
 	}
 
+	if (!IS_POSIXACL(realinode))
+		return NULL;
+
 	if (rcu) {
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {


