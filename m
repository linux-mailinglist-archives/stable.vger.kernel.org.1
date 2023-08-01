Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9D76AFD6
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjHAJuc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjHAJuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB02707
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6766A614FA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C299C433C8;
        Tue,  1 Aug 2023 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883385;
        bh=3EYp6Jomimwdv1cE+y/2nAA0xK2igOXFwSJPQfM9lxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Air6EvB3NMolT/aXVWxApJGvJEzNp2+gILvMhW0njZZXlRw4ZbMxtn+Szl2FQIIvt
         UbgFivMCDQS0Q9kI1Jsa3Z8hreXGeGF4d8wjyjBDkGVT49GLqCoE0m2oX3cOgyj2LF
         vLpeDraJNYaXAwz66nAzYKajyxdawwST2OsHMhH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Horman <simon.horman@corigine.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH 6.4 216/239] 9p: fix ignored return value in v9fs_dir_release
Date:   Tue,  1 Aug 2023 11:21:20 +0200
Message-ID: <20230801091933.689802556@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dominique Martinet <asmadeus@codewreck.org>

commit eee4a119e96c2f58cfd1b6d4de42095abc5f8877 upstream.

retval from filemap_fdatawrite was immediately overwritten by the
following p9_fid_put: preserve any error in fdatawrite if there
was any first.

This fixes the following scan-build warning:
fs/9p/vfs_dir.c:220:4: warning: Value stored to 'retval' is never read [deadcode.DeadStores]
                        retval = filemap_fdatawrite(inode->i_mapping);
                        ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 89c58cb395ec ("fs/9p: fix error reporting in v9fs_dir_release")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/vfs_dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 45b684b7d8d7..4102759a5cb5 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -208,7 +208,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	struct p9_fid *fid;
 	__le32 version;
 	loff_t i_size;
-	int retval = 0;
+	int retval = 0, put_err;
 
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
@@ -221,7 +221,8 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
-		retval = p9_fid_put(fid);
+		put_err = p9_fid_put(fid);
+		retval = retval < 0 ? retval : put_err;
 	}
 
 	if ((filp->f_mode & FMODE_WRITE)) {
-- 
2.41.0



