Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0E7BDFD4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbjJINee (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377146AbjJINed (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:34:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C191
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:34:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3931C433C8;
        Mon,  9 Oct 2023 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858471;
        bh=GlXlLYQife2gSuC3BSI14Zd5ALKgP7oZEZbIWEXq78k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/8OXr8w5KbaS/Q6NycqiJjyr910gQNILL0byaik1tN+LtJ42kBKXGsaE2nYNUkhl
         tXJ+wmwZMNg156T1+/qzYcVkn00tZv5q29rwHQUH25A09RRDUlfCaWiKJzOHCx34ap
         RGX1hI9w7E0GZK6Rlkm/sA81EcYr+wJfN9YR4d2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 106/131] NFS: Add a helper nfs_client_for_each_server()
Date:   Mon,  9 Oct 2023 15:02:26 +0200
Message-ID: <20231009130119.663114676@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 3c9e502b59fbd243cfac7cc6c875e432d285102a ]

Add a helper nfs_client_for_each_server() to iterate through all the
filesystems that are attached to a struct nfs_client, and apply
a function to all the active ones.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: ed1cc05aa1f7 ("NFSv4: Fix a nfs4_state_manager() race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/internal.h |  4 +++-
 fs/nfs/super.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a4dc182e8989b..fcd35c98a9377 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -411,7 +411,9 @@ extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
 extern bool nfs_sb_active(struct super_block *sb);
 extern void nfs_sb_deactive(struct super_block *sb);
-
+extern int nfs_client_for_each_server(struct nfs_client *clp,
+				      int (*fn)(struct nfs_server *, void *),
+				      void *data);
 /* io.c */
 extern void nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ecc7277b3eda4..1d3b681a6b279 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -436,6 +436,41 @@ void nfs_sb_deactive(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(nfs_sb_deactive);
 
+static int __nfs_list_for_each_server(struct list_head *head,
+		int (*fn)(struct nfs_server *, void *),
+		void *data)
+{
+	struct nfs_server *server, *last = NULL;
+	int ret = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, head, client_link) {
+		if (!nfs_sb_active(server->super))
+			continue;
+		rcu_read_unlock();
+		if (last)
+			nfs_sb_deactive(last->super);
+		last = server;
+		ret = fn(server, data);
+		if (ret)
+			goto out;
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+out:
+	if (last)
+		nfs_sb_deactive(last->super);
+	return ret;
+}
+
+int nfs_client_for_each_server(struct nfs_client *clp,
+		int (*fn)(struct nfs_server *, void *),
+		void *data)
+{
+	return __nfs_list_for_each_server(&clp->cl_superblocks, fn, data);
+}
+EXPORT_SYMBOL_GPL(nfs_client_for_each_server);
+
 /*
  * Deliver file system statistics to userspace
  */
-- 
2.40.1



