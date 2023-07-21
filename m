Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5039875D370
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGUTKk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGUTKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2E30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C5F661D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3B2C433C7;
        Fri, 21 Jul 2023 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966637;
        bh=YWNF1zzNFQ7y1wDpyc44tr/EblJIlqfHJqYDmnCsMs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNucWpk3yv/Qhsi1ohHmuQrfwD+0vIGfOjw7Dm/92BXE1z8neOk2BI5ewFNfQYj7w
         LwPq+w+tg7VL7vPjiJpoIex+wyik9ziVe2fHa20Sw/gonezRKSfkNFfHNJM/eI0JM7
         uikydAV1tdjtc2azQq7AOpFQWo2QnTZbbBdrZkSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.15 377/532] ovl: fix null pointer dereference in ovl_get_acl_rcu()
Date:   Fri, 21 Jul 2023 18:04:41 +0200
Message-ID: <20230721160634.942148619@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit f4e19e595cc2e76a8a58413eb19d3d9c51328b53 upstream.

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
 fs/overlayfs/inode.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -453,7 +453,15 @@ struct posix_acl *ovl_get_acl(struct ino
 	const struct cred *old_cred;
 	struct posix_acl *acl;
 
-	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
+	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
+		return NULL;
+
+	if (!realinode) {
+		WARN_ON(!rcu);
+		return ERR_PTR(-ECHILD);
+	}
+
+	if (!IS_POSIXACL(realinode))
 		return NULL;
 
 	if (rcu)


