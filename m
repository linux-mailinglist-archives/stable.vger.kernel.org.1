Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB47B8A88
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbjJDSgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244473AbjJDSg1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318CFC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D39C433CB;
        Wed,  4 Oct 2023 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444582;
        bh=P2eQ2b1o09piXbs1qTCp2g7ON5jLo0MggT8i+qBuReo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcctaXg/diO0I1akV+oLGMqfhvtnNCEmPt5kLep1wrELycarJKMCHxurkCzBFPapY
         +4tw0S38P8KSf+cGW2UvrMupPnZpmA4oPhomTHLgZCh0I2P4blbz/WCe1IxDzgLYEN
         QpzxgbEx4fkN/+xlLE7AOU0lw+LYO8cljFJ5Jqww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.5 274/321] NFSv4: Fix a state manager thread deadlock regression
Date:   Wed,  4 Oct 2023 19:56:59 +0200
Message-ID: <20231004175241.981739694@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 956fd46f97d238032cb5fa4771cdaccc6e760f9a upstream.

Commit 4dc73c679114 reintroduces the deadlock that was fixed by commit
aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because it
prevents the setup of new threads to handle reboot recovery, while the
older recovery thread is stuck returning delegations.

Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c  |    4 +++-
 fs/nfs/nfs4state.c |   38 ++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10622,7 +10622,9 @@ static void nfs4_disable_swap(struct ino
 	 */
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 
-	nfs4_schedule_state_manager(clp);
+	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+	wake_up_var(&clp->cl_state);
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1209,16 +1209,26 @@ void nfs4_schedule_state_manager(struct
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
+	struct rpc_clnt *clnt = clp->cl_rpcclient;
+	bool swapon = false;
 
-	if (clp->cl_rpcclient->cl_shutdown)
+	if (clnt->cl_shutdown)
 		return;
 
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
 
@@ -1235,8 +1245,9 @@ void nfs4_schedule_state_manager(struct
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
@@ -2741,22 +2752,25 @@ static int nfs4_run_state_manager(void *
 
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


