Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984775CEF0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjGUQ0F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGUQZp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F35FC1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2480D61D41
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38680C433C9;
        Fri, 21 Jul 2023 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956552;
        bh=YPBLTson+rYGv2YUpGQRUUbx4VYOWGuIgOlB0875Vv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eR70lNbUrPzU8e5i3oeqIsa+InrVsNw6Wws4cyzfLhkEsEBnDL0WncNV940ZxBPBa
         D9YSjFDq8t5/2m/bK3vkDkd8rBTI9cSnlTNrBraboB21YVVXVzi9tdAEF6xMo0XIUq
         AB7WOuOIdyHPlt03ggazg9aywXfm7npJV81AouXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: [PATCH 6.4 221/292] ceph: add a dedicated private data for netfs rreq
Date:   Fri, 21 Jul 2023 18:05:30 +0200
Message-ID: <20230721160538.364398979@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 23ee27dce30e7d3091d6c3143b79f48dab6f9a3e upstream.

We need to save the 'f_ra.ra_pages' to expand the readahead window
later.

Cc: stable@vger.kernel.org
Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
Link: https://lore.kernel.org/ceph-devel/20230504082510.247-1-sehuww@mail.scut.edu.cn
Link: https://www.spinics.net/lists/ceph-users/msg76183.html
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-and-tested-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/addr.c  |   45 ++++++++++++++++++++++++++++++++++-----------
 fs/ceph/super.h |   13 +++++++++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -362,18 +362,28 @@ static int ceph_init_request(struct netf
 {
 	struct inode *inode = rreq->inode;
 	int got = 0, want = CEPH_CAP_FILE_CACHE;
+	struct ceph_netfs_request_data *priv;
 	int ret = 0;
 
 	if (rreq->origin != NETFS_READAHEAD)
 		return 0;
 
+	priv = kzalloc(sizeof(*priv), GFP_NOFS);
+	if (!priv)
+		return -ENOMEM;
+
 	if (file) {
 		struct ceph_rw_context *rw_ctx;
 		struct ceph_file_info *fi = file->private_data;
 
+		priv->file_ra_pages = file->f_ra.ra_pages;
+		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
+
 		rw_ctx = ceph_find_rw_context(fi);
-		if (rw_ctx)
+		if (rw_ctx) {
+			rreq->netfs_priv = priv;
 			return 0;
+		}
 	}
 
 	/*
@@ -383,27 +393,40 @@ static int ceph_init_request(struct netf
 	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
 	if (ret < 0) {
 		dout("start_read %p, error getting cap\n", inode);
-		return ret;
+		goto out;
 	}
 
 	if (!(got & want)) {
 		dout("start_read %p, no cache cap\n", inode);
-		return -EACCES;
+		ret = -EACCES;
+		goto out;
+	}
+	if (ret == 0) {
+		ret = -EACCES;
+		goto out;
 	}
-	if (ret == 0)
-		return -EACCES;
 
-	rreq->netfs_priv = (void *)(uintptr_t)got;
-	return 0;
+	priv->caps = got;
+	rreq->netfs_priv = priv;
+
+out:
+	if (ret < 0)
+		kfree(priv);
+
+	return ret;
 }
 
 static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 {
-	struct ceph_inode_info *ci = ceph_inode(rreq->inode);
-	int got = (uintptr_t)rreq->netfs_priv;
+	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
+
+	if (!priv)
+		return;
 
-	if (got)
-		ceph_put_cap_refs(ci, got);
+	if (priv->caps)
+		ceph_put_cap_refs(ceph_inode(rreq->inode), priv->caps);
+	kfree(priv);
+	rreq->netfs_priv = NULL;
 }
 
 const struct netfs_request_ops ceph_netfs_ops = {
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -451,6 +451,19 @@ struct ceph_inode_info {
 	unsigned long  i_work_mask;
 };
 
+struct ceph_netfs_request_data {
+	int caps;
+
+	/*
+	 * Maximum size of a file readahead request.
+	 * The fadvise could update the bdi's default ra_pages.
+	 */
+	unsigned int file_ra_pages;
+
+	/* Set it if fadvise disables file readahead entirely */
+	bool file_ra_disabled;
+};
+
 static inline struct ceph_inode_info *
 ceph_inode(const struct inode *inode)
 {


