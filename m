Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65947BDE40
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376966AbjJINRd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376994AbjJINRd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD891
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:17:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EC2C433C9;
        Mon,  9 Oct 2023 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857449;
        bh=rystTE9DupvfIPn/prsMxhEkGOs57OMQiWTe8fhlBqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgiz6zPRP2fg71lBgEs/jMc3GWH5ySnZ22YpMcPryJC/upTmz0uM2aOx7YHIRU1Ks
         JPDTbtazjp3cwhrowD/bkoP99jYe+qUDVUgQWbBQuv0RsDhEyrUhktYTFV+TOgFX1M
         c+bfLUWJAiyHtZBSdswDa9BWDjP/j/3glY72DKyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/162] NFSv4: Fix a state manager thread deadlock regression
Date:   Mon,  9 Oct 2023 15:00:04 +0200
Message-ID: <20231009130123.588112921@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 956fd46f97d238032cb5fa4771cdaccc6e760f9a ]

Commit 4dc73c679114 reintroduces the deadlock that was fixed by commit
aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because it
prevents the setup of new threads to handle reboot recovery, while the
older recovery thread is stuck returning delegations.

Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c  |  4 +++-
 fs/nfs/nfs4state.c | 36 +++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index be570c65ae154..b927a7d1b46d4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10629,7 +10629,9 @@ static void nfs4_disable_swap(struct inode *inode)
 	 */
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 
-	nfs4_schedule_state_manager(clp);
+	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+	wake_up_var(&clp->cl_state);
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 1b707573fbf8d..ed789e0cb9431 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1209,13 +1209,23 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
+	struct rpc_clnt *clnt = clp->cl_rpcclient;
+	bool swapon = false;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
-	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
-		wake_up_var(&clp->cl_state);
-		return;
+
+	if (atomic_read(&clnt->cl_swapper)) {
+		swapon = !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
+					   &clp->cl_state);
+		if (!swapon) {
+			wake_up_var(&clp->cl_state);
+			return;
+		}
 	}
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
+
+	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
+		return;
+
 	__module_get(THIS_MODULE);
 	refcount_inc(&clp->cl_count);
 
@@ -1232,8 +1242,9 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 			__func__, PTR_ERR(task));
 		if (!nfs_client_init_is_complete(clp))
 			nfs_mark_client_ready(clp, PTR_ERR(task));
+		if (swapon)
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs4_clear_state_manager_bit(clp);
-		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
 		module_put(THIS_MODULE);
 	}
@@ -2737,22 +2748,25 @@ static int nfs4_run_state_manager(void *ptr)
 
 	allow_signal(SIGKILL);
 again:
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	nfs4_state_manager(clp);
-	if (atomic_read(&cl->cl_swapper)) {
+
+	if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
+	    !test_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state)) {
 		wait_var_event_interruptible(&clp->cl_state,
 					     test_bit(NFS4CLNT_RUN_MANAGER,
 						      &clp->cl_state));
-		if (atomic_read(&cl->cl_swapper) &&
-		    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
+		if (!atomic_read(&cl->cl_swapper))
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+		if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 			goto again;
 		/* Either no longer a swapper, or were signalled */
+		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 	}
-	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 
 	if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
 	    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
-	    !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state))
+	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 		goto again;
 
 	nfs_put_client(clp);
-- 
2.40.1



