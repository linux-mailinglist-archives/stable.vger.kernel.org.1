Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1A75C948
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGUOMn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGUOMk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECAE30EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C55C61C3C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6158FC433C8;
        Fri, 21 Jul 2023 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689948754;
        bh=k4hc/A5CoZ9csW0AUrXccwrOu6R78ujOlKbJeqakDyo=;
        h=Subject:To:Cc:From:Date:From;
        b=HuhdW1NqpHkEys4Tq6e1E/hV4QPxCUw7vLS5cxYvSPX/B7KTI4bTu+nZP8lRO4lVx
         eR3+rWBMz6tgMQZYl367bpiwLm5YnYN1Oli+CZ0QbRBBIk8uj1BRTXtviokrngUWFE
         Gbr81287+OScHl3BZsnvuf6+TrGQfgOgeX0OeFDI=
Subject: FAILED: patch "[PATCH] ceph: add a dedicated private data for netfs rreq" failed to apply to 5.15-stable tree
To:     xiubli@redhat.com, idryomov@gmail.com, mchangir@redhat.com,
        sehuww@mail.scut.edu.cn
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:12:31 +0200
Message-ID: <2023072131-reflux-material-ce4e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 23ee27dce30e7d3091d6c3143b79f48dab6f9a3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072131-reflux-material-ce4e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

23ee27dce30e ("ceph: add a dedicated private data for netfs rreq")
40a811012023 ("netfs: Rename the netfs_io_request cleanup op and give it an op pointer")
bc899ee1c898 ("netfs: Add a netfs inode context")
a5c9dc445139 ("ceph: Make ceph_init_request() check caps on readahead")
2de160417315 ("netfs: Change ->init_request() to return an error code")
663dfb65c3b3 ("netfs: Refactor arguments for netfs_alloc_read_request")
de74023befa1 ("netfs: Trace refcounting on the netfs_io_request struct")
18b3ff9fe8b8 ("netfs: Adjust the netfs_rreq tracepoint slightly")
3a4a38e66d24 ("netfs: Split netfs_io_* object handling out")
f18a378580a7 ("netfs: Finish off rename of netfs_read_request to netfs_io_request")
6a19114b8e7f ("netfs: Rename netfs_read_*request to netfs_io_*request")
5ac417d24c6c ("netfs: Generate enums from trace symbol mapping lists")
083db6fd3e73 ("ceph: uninline the data on a file opened for writing")
5b19f1eba459 ("ceph: make ceph_netfs_issue_op() handle inlined data")
a25cedb4313d ("ceph: switch netfs read ops to use rreq->inode instead of rreq->mapping->host")
8205ae327e39 ("Merge tag '5.17-rc-part2-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23ee27dce30e7d3091d6c3143b79f48dab6f9a3e Mon Sep 17 00:00:00 2001
From: Xiubo Li <xiubli@redhat.com>
Date: Wed, 10 May 2023 19:55:46 +0800
Subject: [PATCH] ceph: add a dedicated private data for netfs rreq

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

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6bb251a4d613..19c4f08454d2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -362,18 +362,28 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
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
@@ -383,27 +393,40 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
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
 
-	if (got)
-		ceph_put_cap_refs(ci, got);
+	if (!priv)
+		return;
+
+	if (priv->caps)
+		ceph_put_cap_refs(ceph_inode(rreq->inode), priv->caps);
+	kfree(priv);
+	rreq->netfs_priv = NULL;
 }
 
 const struct netfs_request_ops ceph_netfs_ops = {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d24bf0db5234..3bfddf34d488 100644
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

