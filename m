Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66079BDD7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbjIKU4C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbjIKPEL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:04:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D1125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:04:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F55EC433C7;
        Mon, 11 Sep 2023 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444646;
        bh=RkPyhsgsbZVriQzdlb0b7BHmNPO0ZY2/zxB4KhvRaxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1QDYRIksJxob7p26Bu2i+OWmjn1wZxlVd7GAJDeIuSSzS0OYXqcrzvOJtQrS/RZVm
         4Kc9G0IDjlsReCl8Hw6y8VCsZ3BMiWdUztOf0fEt+Dfu06uw+Sy7KcA+GCkhkGWCLb
         ReSaT9f5zPywGDSzFIKo8XPdNH66a7nTfKMTJ91k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shyam Prasad N <sprasad@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/600] cifs: fix sockaddr comparison in iface_cmp
Date:   Mon, 11 Sep 2023 15:41:39 +0200
Message-ID: <20230911134635.571072239@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 2991b77409891e14a10b96899755c004b0c07edb ]

iface_cmp used to simply do a memcmp of the two
provided struct sockaddrs. The comparison needs to do more
based on the address family. Similar logic was already
present in cifs_match_ipaddr. Doing something similar now.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  | 37 -----------------------------
 fs/smb/client/cifsproto.h |  1 +
 fs/smb/client/connect.c   | 50 +++++++++++++++++++++++++++++++++++++++
 fs/smb/client/smb2ops.c   | 37 +++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a37afbb7e399f..4a092cc5a3936 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -970,43 +970,6 @@ release_iface(struct kref *ref)
 	kfree(iface);
 }
 
-/*
- * compare two interfaces a and b
- * return 0 if everything matches.
- * return 1 if a has higher link speed, or rdma capable, or rss capable
- * return -1 otherwise.
- */
-static inline int
-iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
-{
-	int cmp_ret = 0;
-
-	WARN_ON(!a || !b);
-	if (a->speed == b->speed) {
-		if (a->rdma_capable == b->rdma_capable) {
-			if (a->rss_capable == b->rss_capable) {
-				cmp_ret = memcmp(&a->sockaddr, &b->sockaddr,
-						 sizeof(a->sockaddr));
-				if (!cmp_ret)
-					return 0;
-				else if (cmp_ret > 0)
-					return 1;
-				else
-					return -1;
-			} else if (a->rss_capable > b->rss_capable)
-				return 1;
-			else
-				return -1;
-		} else if (a->rdma_capable > b->rdma_capable)
-			return 1;
-		else
-			return -1;
-	} else if (a->speed > b->speed)
-		return 1;
-	else
-		return -1;
-}
-
 struct cifs_chan {
 	unsigned int in_reconnect : 1; /* if session setup in progress for this channel */
 	struct TCP_Server_Info *server;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 98513f5af3f96..a914b88ca51a1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -85,6 +85,7 @@ extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
 extern int smb3_parse_opt(const char *options, const char *key, char **val);
+extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
 extern int cifs_call_async(struct TCP_Server_Info *server,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index cbe08948baf4a..9cd282960c0bb 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1343,6 +1343,56 @@ cifs_demultiplex_thread(void *p)
 	module_put_and_kthread_exit(0);
 }
 
+int
+cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs)
+{
+	struct sockaddr_in *saddr4 = (struct sockaddr_in *)srcaddr;
+	struct sockaddr_in *vaddr4 = (struct sockaddr_in *)rhs;
+	struct sockaddr_in6 *saddr6 = (struct sockaddr_in6 *)srcaddr;
+	struct sockaddr_in6 *vaddr6 = (struct sockaddr_in6 *)rhs;
+
+	switch (srcaddr->sa_family) {
+	case AF_UNSPEC:
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+			return 0;
+		case AF_INET:
+		case AF_INET6:
+			return 1;
+		default:
+			return -1;
+		}
+	case AF_INET: {
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+			return -1;
+		case AF_INET:
+			return memcmp(saddr4, vaddr4,
+				      sizeof(struct sockaddr_in));
+		case AF_INET6:
+			return 1;
+		default:
+			return -1;
+		}
+	}
+	case AF_INET6: {
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+		case AF_INET:
+			return -1;
+		case AF_INET6:
+			return memcmp(saddr6,
+				      vaddr6,
+				      sizeof(struct sockaddr_in6));
+		default:
+			return -1;
+		}
+	}
+	default:
+		return -1; /* don't expect to be here */
+	}
+}
+
 /*
  * Returns true if srcaddr isn't specified and rhs isn't specified, or
  * if srcaddr is specified and matches the IP address of the rhs argument
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index e6a191a7499e8..bcd4c3a507601 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -511,6 +511,43 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	return rsize;
 }
 
+/*
+ * compare two interfaces a and b
+ * return 0 if everything matches.
+ * return 1 if a is rdma capable, or rss capable, or has higher link speed
+ * return -1 otherwise.
+ */
+static int
+iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
+{
+	int cmp_ret = 0;
+
+	WARN_ON(!a || !b);
+	if (a->rdma_capable == b->rdma_capable) {
+		if (a->rss_capable == b->rss_capable) {
+			if (a->speed == b->speed) {
+				cmp_ret = cifs_ipaddr_cmp((struct sockaddr *) &a->sockaddr,
+							  (struct sockaddr *) &b->sockaddr);
+				if (!cmp_ret)
+					return 0;
+				else if (cmp_ret > 0)
+					return 1;
+				else
+					return -1;
+			} else if (a->speed > b->speed)
+				return 1;
+			else
+				return -1;
+		} else if (a->rss_capable > b->rss_capable)
+			return 1;
+		else
+			return -1;
+	} else if (a->rdma_capable > b->rdma_capable)
+		return 1;
+	else
+		return -1;
+}
+
 static int
 parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			size_t buf_len, struct cifs_ses *ses, bool in_mount)
-- 
2.40.1



