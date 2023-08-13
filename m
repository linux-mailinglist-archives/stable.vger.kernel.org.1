Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC877AC4C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHMVcI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjHMVcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECF10F2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4985762B62
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3E7C433C8;
        Sun, 13 Aug 2023 21:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962283;
        bh=C2Mf8hRPe93haF1t/rJTtceQg4ddXQXvb7uxOYaAKqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdQjn4+AphOfRAw86gBOvxcvwJIjoLKIJQfoct/zwo1xVyji0T88sjmeGZCFY9jNL
         0k/41b4rvkuEIeZKoiSAfJFibIafb+M2fgIcpXPaijpAC+A5jMpqouKWBJepCmTFBR
         3NiRj03UW00zHNLECM9a1ulBDc/98kB9bUUV/5u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 179/206] ibmvnic: Ensure login failure recovery is safe from other resets
Date:   Sun, 13 Aug 2023 23:19:09 +0200
Message-ID: <20230813211730.146923038@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nick Child <nnac123@linux.ibm.com>

commit 6db541ae279bd4e76dbd939e5fbf298396166242 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   70 +++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 22 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -116,6 +116,7 @@ static void ibmvnic_tx_scrq_clean_buffer
 static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
+static void flush_reset_queue(struct ibmvnic_adapter *adapter);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -1507,8 +1508,8 @@ static const char *adapter_state_to_stri
 
 static int ibmvnic_login(struct net_device *netdev)
 {
+	unsigned long flags, timeout = msecs_to_jiffies(20000);
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
-	unsigned long timeout = msecs_to_jiffies(20000);
 	int retry_count = 0;
 	int retries = 10;
 	bool retry;
@@ -1573,6 +1574,7 @@ static int ibmvnic_login(struct net_devi
 					    "SCRQ irq initialization failed\n");
 				return rc;
 			}
+		/* Default/timeout error handling, reset and start fresh */
 		} else if (adapter->init_done_rc) {
 			netdev_warn(netdev, "Adapter login failed, init_done_rc = %d\n",
 				    adapter->init_done_rc);
@@ -1588,29 +1590,53 @@ partial_reset:
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
-
-			rc = ibmvnic_reset_init(adapter, false);
-			if (rc) {
-				netdev_err(netdev, "login recovery: Reset init failed %d\n",
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
+
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
 


