Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4377A1E1
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjHLShY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHLShT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A3C10C0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E156D61EA5
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0295DC433C7;
        Sat, 12 Aug 2023 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865441;
        bh=rLxheWCgyN4pSo7Eae0MACtcEGJB5q382DybzPDnGHg=;
        h=Subject:To:Cc:From:Date:From;
        b=kEoabAqZet81HbaNEHIsW7LUnLc0ILxuZLN0u9GJkcyeZxMthoBuCXbnRFholQQvq
         zyxREPvzlRw54a8Gm1q4kEq/fr4H+zlEVa3+L1m7dBPek71osfvWZx34VDMkI/NUG6
         RZY8aWfjrCw12Uu1M3/Rjtw6lrPZVKbEec9H5itU=
Subject: FAILED: patch "[PATCH] ibmvnic: Ensure login failure recovery is safe from other" failed to apply to 4.19-stable tree
To:     nnac123@linux.ibm.com, horms@kernel.org, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:37:17 +0200
Message-ID: <2023081217-unrest-trusting-66a9@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 6db541ae279bd4e76dbd939e5fbf298396166242
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081217-unrest-trusting-66a9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

6db541ae279b ("ibmvnic: Ensure login failure recovery is safe from other resets")
23cc5f667453 ("ibmvnic: Do partial reset on login failure")
61772b0908c6 ("ibmvnic: don't release napi in __ibmvnic_open()")
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
0775ebc4cf85 ("ibmvnic: avoid calling napi_disable() twice")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6db541ae279bd4e76dbd939e5fbf298396166242 Mon Sep 17 00:00:00 2001
From: Nick Child <nnac123@linux.ibm.com>
Date: Wed, 9 Aug 2023 17:10:38 -0500
Subject: [PATCH] ibmvnic: Ensure login failure recovery is safe from other
 resets

If a login request fails, the recovery process should be protected
against parallel resets. It is a known issue that freeing and
registering CRQ's in quick succession can result in a failover CRQ from
the VIOS. Processing a failover during login recovery is dangerous for
two reasons:
 1. This will result in two parallel initialization processes, this can
 cause serious issues during login.
 2. It is possible that the failover CRQ is received but never executed.
 We get notified of a pending failover through a transport event CRQ.
 The reset is not performed until a INIT CRQ request is received.
 Previously, if CRQ init fails during login recovery, then the ibmvnic
 irq is freed and the login process returned error. If failover_pending
 is true (a transport event was received), then the ibmvnic device
 would never be able to process the reset since it cannot receive the
 CRQ_INIT request due to the irq being freed. This leaved the device
 in a inoperable state.

Therefore, the login failure recovery process must be hardened against
these possible issues. Possible failovers (due to quick CRQ free and
init) must be avoided and any issues during re-initialization should be
dealt with instead of being propagated up the stack. This logic is
similar to that of ibmvnic_probe().

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230809221038.51296-5-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e9619957d58a..df76cdaddcfb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -116,6 +116,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
+static void flush_reset_queue(struct ibmvnic_adapter *adapter);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -1507,8 +1508,8 @@ static const char *adapter_state_to_string(enum vnic_state state)
 
 static int ibmvnic_login(struct net_device *netdev)
 {
+	unsigned long flags, timeout = msecs_to_jiffies(20000);
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
-	unsigned long timeout = msecs_to_jiffies(20000);
 	int retry_count = 0;
 	int retries = 10;
 	bool retry;
@@ -1573,6 +1574,7 @@ static int ibmvnic_login(struct net_device *netdev)
 					    "SCRQ irq initialization failed\n");
 				return rc;
 			}
+		/* Default/timeout error handling, reset and start fresh */
 		} else if (adapter->init_done_rc) {
 			netdev_warn(netdev, "Adapter login failed, init_done_rc = %d\n",
 				    adapter->init_done_rc);
@@ -1588,29 +1590,53 @@ static int ibmvnic_login(struct net_device *netdev)
 				    "Freeing and re-registering CRQs before attempting to login again\n");
 			retry = true;
 			adapter->init_done_rc = 0;
-			retry_count++;
 			release_sub_crqs(adapter, true);
-			reinit_init_done(adapter);
-			release_crq_queue(adapter);
-			/* If we don't sleep here then we risk an unnecessary
-			 * failover event from the VIOS. This is a known VIOS
-			 * issue caused by a vnic device freeing and registering
-			 * a CRQ too quickly.
+			/* Much of this is similar logic as ibmvnic_probe(),
+			 * we are essentially re-initializing communication
+			 * with the server. We really should not run any
+			 * resets/failovers here because this is already a form
+			 * of reset and we do not want parallel resets occurring
 			 */
-			msleep(1500);
-			rc = init_crq_queue(adapter);
-			if (rc) {
-				netdev_err(netdev, "login recovery: init CRQ failed %d\n",
-					   rc);
-				return -EIO;
-			}
+			do {
+				reinit_init_done(adapter);
+				/* Clear any failovers we got in the previous
+				 * pass since we are re-initializing the CRQ
+				 */
+				adapter->failover_pending = false;
+				release_crq_queue(adapter);
+				/* If we don't sleep here then we risk an
+				 * unnecessary failover event from the VIOS.
+				 * This is a known VIOS issue caused by a vnic
+				 * device freeing and registering a CRQ too
+				 * quickly.
+				 */
+				msleep(1500);
+				/* Avoid any resets, since we are currently
+				 * resetting.
+				 */
+				spin_lock_irqsave(&adapter->rwi_lock, flags);
+				flush_reset_queue(adapter);
+				spin_unlock_irqrestore(&adapter->rwi_lock,
+						       flags);
 
-			rc = ibmvnic_reset_init(adapter, false);
-			if (rc) {
-				netdev_err(netdev, "login recovery: Reset init failed %d\n",
-					   rc);
-				return -EIO;
-			}
+				rc = init_crq_queue(adapter);
+				if (rc) {
+					netdev_err(netdev, "login recovery: init CRQ failed %d\n",
+						   rc);
+					return -EIO;
+				}
+
+				rc = ibmvnic_reset_init(adapter, false);
+				if (rc)
+					netdev_err(netdev, "login recovery: Reset init failed %d\n",
+						   rc);
+				/* IBMVNIC_CRQ_INIT will return EAGAIN if it
+				 * fails, since ibmvnic_reset_init will free
+				 * irq's in failure, we won't be able to receive
+				 * new CRQs so we need to keep trying. probe()
+				 * handles this similarly.
+				 */
+			} while (rc == -EAGAIN && retry_count++ < retries);
 		}
 	} while (retry);
 

