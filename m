Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F70766C34
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 13:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjG1L4U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjG1L4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 07:56:17 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4734680
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 04:55:50 -0700 (PDT)
X-QQ-mid: bizesmtp66t1690545181t5r2sl40
Received: from localhost.localdomain.localdoma ( [117.133.52.232])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 19:52:59 +0800 (CST)
X-QQ-SSF: 0140000000000010D000000A0000000
X-QQ-FEAT: zT6n3Y95oi0vRnR+X/G1x2+1b5rkx09dtVb/Jm3A8trCSt0sUK825sKAWj4In
        asv5A0Ttnybfa58z4PuT6PMjNLqnvNAc+faZcvsyJvVE2DyR1209B61j8a7nKAwoHt8q7AV
        q2mTzCkO5n35V+DLmy8W1+eux3IXer4mI8A5uZX0iUaNj+7fAiz/KbkkDuPRvcjuwkmaU4H
        0rP3szVdwh5809F/RvhaQIfOqKlb2T+DZnezmd5I7w2IJ76u+4g/6eP+II6wYSN8BnfMgAE
        IY4Iq5RZdTPsvR1cTIO/h4TBPQ4gC035jdWymYOEzm/UegnLOZRReSQr85Tisn6kaqEwT3T
        wrj+VVGQX5XUjJ3FfVFJs1KyZbW6Tq/6X7QcIeXxCa1wrkeilSWP0Wor6Do2swnIvZ2RaDF
        Uwbv28X/zHM=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13736869315236303362
From:   jiangziqi@haohandata.com.cn
To:     jiangziqi@haohandata.com.cn
Cc:     Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 001/321] fuse: add feature flag for expire-only
Date:   Fri, 28 Jul 2023 19:47:31 +0800
Message-ID: <4BF6BE0A84D2583B+20230728115254.3253-1-jiangziqi@haohandata.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:haohandata.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Add an init flag idicating whether the FUSE_EXPIRE_ONLY flag of
FUSE_NOTIFY_INVAL_ENTRY is effective.

This is needed for backports of this feature, otherwise the server could
just check the protocol version.

Fixes: 4f8d37020e1f ("fuse: add "expire only" mode to FUSE_NOTIFY_INVAL_ENTRY")
Cc: <stable@vger.kernel.org> # v6.2
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c           | 3 ++-
 include/uapi/linux/fuse.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d66070af145d..660be31aaabc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1254,7 +1254,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
+		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
+		FUSE_HAS_EXPIRE_ONLY;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..b3fcab13fcd3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -206,6 +206,7 @@
  *  - add extension header
  *  - add FUSE_EXT_GROUPS
  *  - add FUSE_CREATE_SUPP_GROUP
+ *  - add FUSE_HAS_EXPIRE_ONLY
  */
 
 #ifndef _LINUX_FUSE_H
@@ -369,6 +370,7 @@ struct fuse_file_lock {
  * FUSE_HAS_INODE_DAX:  use per inode DAX
  * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
  *			symlink and mknod (single group that matches parent)
+ * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -406,6 +408,7 @@ struct fuse_file_lock {
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
+#define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.41.0

