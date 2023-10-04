Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969707B8934
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjJDSXh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjJDSXh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE2C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89866C433C8;
        Wed,  4 Oct 2023 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443811;
        bh=FHgkP8Yk78+84U9IOSHsQBBFhqPwp1CZUat/jJ/P14E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yquJ+kHEGEep+9UXNxMvvuuiqfZR9byLCYJNcchFtZzoDyxnKetWAd3OZpcAvXhdm
         f7Va5WDvcvDekWasrXN2ubQJbEpBzUraWTblzq/NYFd88yig59H0xYHnVIqM6Z2Qsx
         G7M9ZJi1t1+7q+QBqfNZyyZBKvK8S45CEAFtNALk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 009/321] NFSv4.1: fix pnfs MDS=DS session trunking
Date:   Wed,  4 Oct 2023 19:52:34 +0200
Message-ID: <20231004175229.639310578@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit 806a3bc421a115fbb287c1efce63a48c54ee804b ]

Currently, when GETDEVICEINFO returns multiple locations where each
is a different IP but the server's identity is same as MDS, then
nfs4_set_ds_client() finds the existing nfs_client structure which
has the MDS's max_connect value (and if it's 1), then the 1st IP
on the DS's list will get dropped due to MDS trunking rules. Other
IPs would be added as they fall under the pnfs trunking rules.

For the list of IPs the 1st goes thru calling nfs4_set_ds_client()
which will eventually call nfs4_add_trunk() and call into
rpc_clnt_test_and_add_xprt() which has the check for MDS trunking.
The other IPs (after the 1st one), would call rpc_clnt_add_xprt()
which doesn't go thru that check.

nfs4_add_trunk() is called when MDS trunking is happening and it
needs to enforce the usage of max_connect mount option of the
1st mount. However, this shouldn't be applied to pnfs flow.

Instead, this patch proposed to treat MDS=DS as DS trunking and
make sure that MDS's max_connect limit does not apply to the
1st IP returned in the GETDEVICEINFO list. It does so by
marking the newly created client with a new flag NFS_CS_PNFS
which then used to pass max_connect value to use into the
rpc_clnt_test_and_add_xprt() instead of the existing rpc
client's max_connect value set by the MDS connection.

For example, mount was done without max_connect value set
so MDS's rpc client has cl_max_connect=1. Upon calling into
rpc_clnt_test_and_add_xprt() and using rpc client's value,
the caller passes in max_connect value which is previously
been set in the pnfs path (as a part of handling
GETDEVICEINFO list of IPs) in nfs4_set_ds_client().

However, when NFS_CS_PNFS flag is not set and we know we
are doing MDS trunking, comparing a new IP of the same
server, we then set the max_connect value to the
existing MDS's value and pass that into
rpc_clnt_test_and_add_xprt().

Fixes: dc48e0abee24 ("SUNRPC enforce creation of no more than max_connect xprts")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4client.c       |  6 +++++-
 include/linux/nfs_fs_sb.h |  1 +
 net/sunrpc/clnt.c         | 11 +++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 27fb25567ce75..11e3a285594c2 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -417,6 +417,8 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 		.net = old->cl_net,
 		.servername = old->cl_hostname,
 	};
+	int max_connect = test_bit(NFS_CS_PNFS, &clp->cl_flags) ?
+		clp->cl_max_connect : old->cl_max_connect;
 
 	if (clp->cl_proto != old->cl_proto)
 		return;
@@ -430,7 +432,7 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 	xprt_args.addrlen = clp_salen;
 
 	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
-			  rpc_clnt_test_and_add_xprt, NULL);
+			  rpc_clnt_test_and_add_xprt, &max_connect);
 }
 
 /**
@@ -1010,6 +1012,8 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_DS, &cl_init.init_flags);
+	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
+	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009df..cd628c4b011e5 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -48,6 +48,7 @@ struct nfs_client {
 #define NFS_CS_NOPING		6		/* - don't ping on connect */
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
+#define NFS_CS_PNFS		9		/* - Server used for pnfs */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c8ee7be4c631c..62a09e51e4316 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2905,19 +2905,22 @@ static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
  * @clnt: pointer to struct rpc_clnt
  * @xps: pointer to struct rpc_xprt_switch,
  * @xprt: pointer struct rpc_xprt
- * @dummy: unused
+ * @in_max_connect: pointer to the max_connect value for the passed in xprt transport
  */
 int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
-		void *dummy)
+		void *in_max_connect)
 {
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
+	int max_connect = clnt->cl_max_connect;
 
-	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+	if (in_max_connect)
+		max_connect = *(int *)in_max_connect;
+	if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
 		rcu_read_lock();
 		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
-			"transport to server: %s\n", clnt->cl_max_connect,
+			"transport to server: %s\n", max_connect,
 			rpc_peeraddr2str(clnt, RPC_DISPLAY_ADDR));
 		rcu_read_unlock();
 		return -EINVAL;
-- 
2.40.1



