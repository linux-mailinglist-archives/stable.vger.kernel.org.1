Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453AC77A1DA
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHLSgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHLSgw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE50410C2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670DC61E90
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73593C433C7;
        Sat, 12 Aug 2023 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865413;
        bh=awehS8xFc37Ln68rvsIwxSPlIRu0pcB5yzycr7VZGl8=;
        h=Subject:To:Cc:From:Date:From;
        b=yJD2Gj0SGOIfxUQulJ8CHbGATBBBFsggU1HQ7tDL3JSExbk1Tq6AMCQ9EHR1ZrSEf
         +Qky0leaEL6Vrjz2ejnKCJjFYaJSZfk1tEujWh+HuUl/h1d2lwi2ZywQeXWa0UvjpD
         ksuqp/NLQ0xuOKF97C1tFrBTi/LK66qYNQESRydU=
Subject: FAILED: patch "[PATCH] ibmvnic: Do partial reset on login failure" failed to apply to 5.10-stable tree
To:     nnac123@linux.ibm.com, horms@kernel.org, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:36:49 +0200
Message-ID: <2023081249-throat-simply-db92@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 23cc5f667453ca7645a24c8d21bf84dbf61107b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081249-throat-simply-db92@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

23cc5f667453 ("ibmvnic: Do partial reset on login failure")
b6ee566cf394 ("ibmvnic: Update driver return codes")
bbd809305bc7 ("ibmvnic: Reuse tx pools when possible")
489de956e7a2 ("ibmvnic: Reuse rx pools when possible")
f8ac0bfa7d7a ("ibmvnic: Reuse LTB when possible")
129854f061d8 ("ibmvnic: Use bitmap for LTB map_ids")
0d1af4fa7124 ("ibmvnic: init_tx_pools move loop-invariant code")
8243c7ed6d08 ("ibmvnic: Use/rename local vars in init_tx_pools")
0df7b9ad8f84 ("ibmvnic: Use/rename local vars in init_rx_pools")
0f2bf3188c43 ("ibmvnic: Fix up some comments and messages")
38106b2c433e ("ibmvnic: Consolidate code in replenish_rx_pool()")
f6ebca8efa52 ("ibmvnic: free tx_pool if tso_pool alloc fails")
552a33729f1a ("ibmvnic: set ltb->buff to NULL after freeing")
72368f8b2b9e ("ibmvnic: account for bufs already saved in indir_buf")
65d6470d139a ("ibmvnic: clean pending indirect buffs during reset")
0ec13aff058a ("Revert "ibmvnic: simplify reset_long_term_buff function"")
d3a6abccbd27 ("ibmvnic: remove duplicate napi_schedule call in do_reset function")
8f1c0fd2c84c ("ibmvnic: fix a race between open and reset")
1c7d45e7b2c2 ("ibmvnic: simplify reset_long_term_buff function")
91dc5d2553fb ("ibmvnic: fix miscellaneous checks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23cc5f667453ca7645a24c8d21bf84dbf61107b2 Mon Sep 17 00:00:00 2001
From: Nick Child <nnac123@linux.ibm.com>
Date: Wed, 9 Aug 2023 17:10:37 -0500
Subject: [PATCH] ibmvnic: Do partial reset on login failure

Perform a partial reset before sending a login request if any of the
following are true:
 1. If a previous request times out. This can be dangerous because the
 	VIOS could still receive the old login request at any point after
 	the timeout. Therefore, it is best to re-register the CRQ's  and
 	sub-CRQ's before retrying.
 2. If the previous request returns an error that is not described in
 	PAPR. PAPR provides procedures if the login returns with partial
 	success or aborted return codes (section L.5.1) but other values
	do not have a defined procedure. Previously, these conditions
	just returned error from the login function rather than trying
	to resolve the issue.
 	This can cause further issues since most callers of the login
 	function are not prepared to handle an error when logging in. This
 	improper cleanup can lead to the device being permanently DOWN'd.
 	For example, if the VIOS believes that the device is already logged
 	in then it will return INVALID_STATE (-7). If we never re-register
 	CRQ's then it will always think that the device is already logged
 	in. This leaves the device inoperable.

The partial reset involves freeing the sub-CRQs, freeing the CRQ then
registering and initializing a new CRQ and sub-CRQs. This essentially
restarts all communication with VIOS to allow for a fresh login attempt
that will be unhindered by any previous failed attempts.

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230809221038.51296-4-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 77b0a744fa88..e9619957d58a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -97,6 +97,8 @@ static int pending_scrq(struct ibmvnic_adapter *,
 static union sub_crq *ibmvnic_next_scrq(struct ibmvnic_adapter *,
 					struct ibmvnic_sub_crq_queue *);
 static int ibmvnic_poll(struct napi_struct *napi, int data);
+static int reset_sub_crq_queues(struct ibmvnic_adapter *adapter);
+static inline void reinit_init_done(struct ibmvnic_adapter *adapter);
 static void send_query_map(struct ibmvnic_adapter *adapter);
 static int send_request_map(struct ibmvnic_adapter *, dma_addr_t, u32, u8);
 static int send_request_unmap(struct ibmvnic_adapter *, u8);
@@ -1527,11 +1529,9 @@ static int ibmvnic_login(struct net_device *netdev)
 
 		if (!wait_for_completion_timeout(&adapter->init_done,
 						 timeout)) {
-			netdev_warn(netdev, "Login timed out, retrying...\n");
-			retry = true;
-			adapter->init_done_rc = 0;
-			retry_count++;
-			continue;
+			netdev_warn(netdev, "Login timed out\n");
+			adapter->login_pending = false;
+			goto partial_reset;
 		}
 
 		if (adapter->init_done_rc == ABORTED) {
@@ -1576,7 +1576,41 @@ static int ibmvnic_login(struct net_device *netdev)
 		} else if (adapter->init_done_rc) {
 			netdev_warn(netdev, "Adapter login failed, init_done_rc = %d\n",
 				    adapter->init_done_rc);
-			return -EIO;
+
+partial_reset:
+			/* adapter login failed, so free any CRQs or sub-CRQs
+			 * and register again before attempting to login again.
+			 * If we don't do this then the VIOS may think that
+			 * we are already logged in and reject any subsequent
+			 * attempts
+			 */
+			netdev_warn(netdev,
+				    "Freeing and re-registering CRQs before attempting to login again\n");
+			retry = true;
+			adapter->init_done_rc = 0;
+			retry_count++;
+			release_sub_crqs(adapter, true);
+			reinit_init_done(adapter);
+			release_crq_queue(adapter);
+			/* If we don't sleep here then we risk an unnecessary
+			 * failover event from the VIOS. This is a known VIOS
+			 * issue caused by a vnic device freeing and registering
+			 * a CRQ too quickly.
+			 */
+			msleep(1500);
+			rc = init_crq_queue(adapter);
+			if (rc) {
+				netdev_err(netdev, "login recovery: init CRQ failed %d\n",
+					   rc);
+				return -EIO;
+			}
+
+			rc = ibmvnic_reset_init(adapter, false);
+			if (rc) {
+				netdev_err(netdev, "login recovery: Reset init failed %d\n",
+					   rc);
+				return -EIO;
+			}
 		}
 	} while (retry);
 

