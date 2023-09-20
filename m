Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4162E7A818B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjITMq2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjITMjj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D687CC5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:39:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B36C43391;
        Wed, 20 Sep 2023 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213556;
        bh=MWn8rNWEXCBI3dmlx4PY9Qp5TCptfbIg5BHviAx/sP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVz7RlOvmReIGOvwmQpEEVW7AWlx4bToFAyYUNZN36ZjbdzSE8VQdhA+9jMA5Inia
         Ve9H9RatUxqt9lIgR3vp7iV1OUPBjBzHWynOBPNdrkd5KQSmdkdjElqe3O7ad7m9O4
         vsVQBe/aNCbBSCj7XyCmLotYzT2URX+eWwV8KPXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, ruanmeisi <ruan.meisi@zte.com.cn>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.4 281/367] fuse: nlookup missing decrement in fuse_direntplus_link
Date:   Wed, 20 Sep 2023 13:30:58 +0200
Message-ID: <20230920112905.837442296@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ruanmeisi <ruan.meisi@zte.com.cn>

commit b8bd342d50cbf606666488488f9fea374aceb2d5 upstream.

During our debugging of glusterfs, we found an Assertion failed error:
inode_lookup >= nlookup, which was caused by the nlookup value in the
kernel being greater than that in the FUSE file system.

The issue was introduced by fuse_direntplus_link, where in the function,
fuse_iget increments nlookup, and if d_splice_alias returns failure,
fuse_direntplus_link returns failure without decrementing nlookup
https://github.com/gluster/glusterfs/pull/4081

Signed-off-by: ruanmeisi <ruan.meisi@zte.com.cn>
Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
Cc: <stable@vger.kernel.org> # v3.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/readdir.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -238,8 +238,16 @@ retry:
 			dput(dentry);
 			dentry = alias;
 		}
-		if (IS_ERR(dentry))
+		if (IS_ERR(dentry)) {
+			if (!IS_ERR(inode)) {
+				struct fuse_inode *fi = get_fuse_inode(inode);
+
+				spin_lock(&fi->lock);
+				fi->nlookup--;
+				spin_unlock(&fi->lock);
+			}
 			return PTR_ERR(dentry);
+		}
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);


