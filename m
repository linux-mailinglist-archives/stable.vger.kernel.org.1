Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91975D444
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjGUTTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGUTT2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660F3A9F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3393261D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47445C433C7;
        Fri, 21 Jul 2023 19:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967164;
        bh=+gmrOA2FPH9Fy1Xnx4YiVp0bhf12VARKE7jFJQATkjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1tcBHirGazum4yaRW/3ouuivTLsrfHLhYQGXVYb40jXUeZ4sXVQmKBm/wFCtFP/l
         9A0EK3368b5pA4oVjV9AxeH/cEvvX86d4Ea4fGMjhoKfeGtUIXgJDG8vSsv9eDcgkV
         XQR5jtsHDN2JYBRwAG9ko2dQTeHeCALTF42DsECc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.1 066/223] ovl: let helper ovl_i_path_real() return the realinode
Date:   Fri, 21 Jul 2023 18:05:19 +0200
Message-ID: <20230721160523.674784708@linuxfoundation.org>
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

[ Upstream commit b2dd05f107b11966e26fe52a313b418364cf497b ]

Let helper ovl_i_path_real() return the realinode to prepare for
checking non-null realinode in RCU walking path.

[msz] Use d_inode_rcu() since we are depending on the consitency
between dentry and inode being non-NULL in an RCU setting.

There are some changes from upstream commit:
1. Context conflicts caused by 73db6a063c785bc ("ovl: port to
   vfs{g,u}id_t and associated helpers") is handled.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Fixes: ffa5723c6d25 ("ovl: store lower path in ovl_inode")
Cc: <stable@vger.kernel.org> # v5.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/overlayfs.h |    2 +-
 fs/overlayfs/util.c      |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -369,7 +369,7 @@ enum ovl_path_type ovl_path_type(struct
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
 void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
-void ovl_i_path_real(struct inode *inode, struct path *path);
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -266,7 +266,7 @@ struct dentry *ovl_i_dentry_upper(struct
 	return ovl_upperdentry_dereference(OVL_I(inode));
 }
 
-void ovl_i_path_real(struct inode *inode, struct path *path)
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
 {
 	path->dentry = ovl_i_dentry_upper(inode);
 	if (!path->dentry) {
@@ -275,6 +275,8 @@ void ovl_i_path_real(struct inode *inode
 	} else {
 		path->mnt = ovl_upper_mnt(OVL_FS(inode->i_sb));
 	}
+
+	return path->dentry ? d_inode_rcu(path->dentry) : NULL;
 }
 
 struct inode *ovl_inode_upper(struct inode *inode)
@@ -1121,8 +1123,7 @@ void ovl_copyattr(struct inode *inode)
 	struct inode *realinode;
 	struct user_namespace *real_mnt_userns;
 
-	ovl_i_path_real(inode, &realpath);
-	realinode = d_inode(realpath.dentry);
+	realinode = ovl_i_path_real(inode, &realpath);
 	real_mnt_userns = mnt_user_ns(realpath.mnt);
 
 	inode->i_uid = i_uid_into_mnt(real_mnt_userns, realinode);


