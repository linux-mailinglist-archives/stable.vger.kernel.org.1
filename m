Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3D754F4E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGPPOW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGPPOV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F897E50
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB28A60D2E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 15:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D813EC433C7;
        Sun, 16 Jul 2023 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520459;
        bh=Xe8qLjVqMixsTwGESm22x6fTs6dGsJH7mhpU/6RTzcg=;
        h=Subject:To:Cc:From:Date:From;
        b=DukNeYwnO3+MvBaXfGS53ZlRr42ZTAgZ7kVFFmxN5ChjVSrk9ClmDt3kHM5BDY523
         k1JHDO6ifNZ3qL42BEeavw/Sr1yDSVKPg07ehH2j6POCW9wmaVzztPGkqpxaHAHUTZ
         dTgmtWFn0V6oWynFTXoHb4+tvVmS/S5QwRXNoZtI=
Subject: FAILED: patch "[PATCH] ovl: let helper ovl_i_path_real() return the realinode" failed to apply to 5.15-stable tree
To:     chengzhihao1@huawei.com, amir73il@gmail.com, mszeredi@redhat.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 17:14:08 +0200
Message-ID: <2023071608-regain-untapped-0931@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b2dd05f107b11966e26fe52a313b418364cf497b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071608-regain-untapped-0931@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b2dd05f107b1 ("ovl: let helper ovl_i_path_real() return the realinode")
e67fe63341b8 ("fs: port i_{g,u}id_into_vfs{g,u}id() to mnt_idmap")
9452e93e6dae ("fs: port privilege checking helpers to mnt_idmap")
f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
13e83a4923be ("fs: port ->set_acl() to pass mnt_idmap")
77435322777d ("fs: port ->get_acl() to pass mnt_idmap")
011e2b717b1b ("fs: port ->tmpfile() to pass mnt_idmap")
5ebb29bee8d5 ("fs: port ->mknod() to pass mnt_idmap")
c54bd91e9eab ("fs: port ->mkdir() to pass mnt_idmap")
7a77db95511c ("fs: port ->symlink() to pass mnt_idmap")
6c960e68aaed ("fs: port ->create() to pass mnt_idmap")
b74d24f7a74f ("fs: port ->getattr() to pass mnt_idmap")
c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
abf08576afe3 ("fs: port vfs_*() helpers to struct mnt_idmap")
6022ec6ee2c3 ("Merge tag 'ntfs3_for_6.2' of https://github.com/Paragon-Software-Group/linux-ntfs3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2dd05f107b11966e26fe52a313b418364cf497b Mon Sep 17 00:00:00 2001
From: Zhihao Cheng <chengzhihao1@huawei.com>
Date: Tue, 16 May 2023 22:16:17 +0800
Subject: [PATCH] ovl: let helper ovl_i_path_real() return the realinode

Let helper ovl_i_path_real() return the realinode to prepare for
checking non-null realinode in RCU walking path.

[msz] Use d_inode_rcu() since we are depending on the consitency
between dentry and inode being non-NULL in an RCU setting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Fixes: ffa5723c6d25 ("ovl: store lower path in ovl_inode")
Cc: <stable@vger.kernel.org> # v5.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4d0b278f5630..7398de332527 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -382,7 +382,7 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
 void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
-void ovl_i_path_real(struct inode *inode, struct path *path);
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..5a6f34c7ed03 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -250,7 +250,7 @@ struct dentry *ovl_i_dentry_upper(struct inode *inode)
 	return ovl_upperdentry_dereference(OVL_I(inode));
 }
 
-void ovl_i_path_real(struct inode *inode, struct path *path)
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
 {
 	path->dentry = ovl_i_dentry_upper(inode);
 	if (!path->dentry) {
@@ -259,6 +259,8 @@ void ovl_i_path_real(struct inode *inode, struct path *path)
 	} else {
 		path->mnt = ovl_upper_mnt(OVL_FS(inode->i_sb));
 	}
+
+	return path->dentry ? d_inode_rcu(path->dentry) : NULL;
 }
 
 struct inode *ovl_inode_upper(struct inode *inode)
@@ -1105,8 +1107,7 @@ void ovl_copyattr(struct inode *inode)
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
 
-	ovl_i_path_real(inode, &realpath);
-	realinode = d_inode(realpath.dentry);
+	realinode = ovl_i_path_real(inode, &realpath);
 	real_idmap = mnt_idmap(realpath.mnt);
 
 	vfsuid = i_uid_into_vfsuid(real_idmap, realinode);

