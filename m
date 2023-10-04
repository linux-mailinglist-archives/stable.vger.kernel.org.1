Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E17B8933
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbjJDSXd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjJDSXc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74789A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AA7C433C8;
        Wed,  4 Oct 2023 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443809;
        bh=y8aM0eZG3YNcET9e4iS/fG8RuASo7q2dJI1gUrfxU7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e64bnbQwSDTx8XNoWKUctrOLF01jegnDb45w9wU4NtZD0gpnxAi5q/H/pca+wnB+c
         sTBTyJMdMxkxh3mbSHEJg/MSfjSKupU2HXW6VsKdfvxuGovDEo+bBk9FuwGpvv+LmG
         bbTuMW+i8d29OoAiok/4L6KR4tgaoeUvGE4Eg55c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 008/321] NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
Date:   Wed,  4 Oct 2023 19:52:33 +0200
Message-ID: <20231004175229.593062883@linuxfoundation.org>
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

[ Upstream commit 51d674a5e4889f1c8e223ac131cf218e1631e423 ]

After receiving the location(s) of the DS server(s) in the
GETDEVINCEINFO, create the request for the clientid to such
server and indicate that the client is connecting to a DS.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 806a3bc421a1 ("NFSv4.1: fix pnfs MDS=DS session trunking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4client.c | 3 +++
 fs/nfs/nfs4proc.c   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d9114a754db73..27fb25567ce75 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -232,6 +232,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
 	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
 
+	if (test_bit(NFS_CS_DS, &cl_init->init_flags))
+		__set_bit(NFS_CS_DS, &clp->cl_flags);
 	/*
 	 * Set up the connection to the server before we add add to the
 	 * global list.
@@ -1007,6 +1009,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
+	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3c24c3c99e8ac..3bc6bfdf7b814 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8787,6 +8787,8 @@ nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
 #ifdef CONFIG_NFS_V4_1_MIGRATION
 	calldata->args.flags |= EXCHGID4_FLAG_SUPP_MOVED_MIGR;
 #endif
+	if (test_bit(NFS_CS_DS, &clp->cl_flags))
+		calldata->args.flags |= EXCHGID4_FLAG_USE_PNFS_DS;
 	msg.rpc_argp = &calldata->args;
 	msg.rpc_resp = &calldata->res;
 	task_setup_data.callback_data = calldata;
@@ -8864,6 +8866,8 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
 	       sizeof(clp->cl_confirm.data));
+	if (resp->flags & EXCHGID4_FLAG_USE_PNFS_DS)
+		set_bit(NFS_CS_DS, &clp->cl_flags);
 out:
 	trace_nfs4_exchange_id(clp, status);
 	rpc_put_task(task);
-- 
2.40.1



