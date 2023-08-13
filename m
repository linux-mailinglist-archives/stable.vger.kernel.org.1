Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F477ACE4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjHMViT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjHMViT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33F10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87A963627
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC070C433C7;
        Sun, 13 Aug 2023 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962700;
        bh=WZi/scGIq4lHh2bOoYQq3D/i7WusDzWTV2ndBFvINf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLuyD+g/JzskR3tb2H5/ySyyUhl37b60Mww/NwLFvAuTdMCiz+YbQiAUhCclvcsEc
         LPc2zmPdW4oLsun/gj/ZEaoyLhNHsmK7AUNrVnRhGVqwZeXd81sJnr57fMDM87E9f1
         NDVkPY1baHVty30crSVoUQc86wnU/QqN8mws9UQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 123/149] ibmvnic: Do partial reset on login failure
Date:   Sun, 13 Aug 2023 23:19:28 +0200
Message-ID: <20230813211722.412379272@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

commit 23cc5f667453ca7645a24c8d21bf84dbf61107b2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   46 ++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -96,6 +96,8 @@ static int pending_scrq(struct ibmvnic_a
 static union sub_crq *ibmvnic_next_scrq(struct ibmvnic_adapter *,
 					struct ibmvnic_sub_crq_queue *);
 static int ibmvnic_poll(struct napi_struct *napi, int data);
+static int reset_sub_crq_queues(struct ibmvnic_adapter *adapter);
+static inline void reinit_init_done(struct ibmvnic_adapter *adapter);
 static void send_query_map(struct ibmvnic_adapter *adapter);
 static int send_request_map(struct ibmvnic_adapter *, dma_addr_t, u32, u8);
 static int send_request_unmap(struct ibmvnic_adapter *, u8);
@@ -1336,11 +1338,9 @@ static int ibmvnic_login(struct net_devi
 
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
@@ -1385,7 +1385,41 @@ static int ibmvnic_login(struct net_devi
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
 


