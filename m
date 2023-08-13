Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52D77AC31
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjHMVaU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjHMVaU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4310DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A355614BD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C9C433C8;
        Sun, 13 Aug 2023 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962221;
        bh=Oqah/ag2XjGtbbrX54Zg7qK/mrCarrAQSj8qAbka6WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvqKxKPzjfg4d76XCUm5XmtFsZwL1+UrGpTVhrRHkMsW6c6g1gYr/M1zAqzjP2/p2
         ST4LgiheMZKs/vNu7a6sHhTpu0KFSimC0dtTZGb2C5F5fz3NyZePRCPqv1o/46VrqX
         6zRX01xCuejRf5JAZf3fCEE6sK+UbjmgTfTeqUsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nitya Sunkad <nitya.sunkad@amd.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 129/206] ionic: Add missing err handling for queue reconfig
Date:   Sun, 13 Aug 2023 23:18:19 +0200
Message-ID: <20230813211728.717355097@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nitya Sunkad <nitya.sunkad@amd.com>

commit 52417a95ff2d810dc31a68ae71102e741efea772 upstream.

ionic_start_queues_reconfig returns an error code if txrx_init fails.
Handle this error code in the relevant places.

This fixes a corner case where the device could get left in a detached
state if the CMB reconfig fails and the attempt to clean up the mess
also fails. Note that calling netif_device_attach when the netdev is
already attached does not lead to unexpected behavior.

Change goto name "errout" to "err_out" to maintain consistency across
goto statements.

Fixes: 40bc471dc714 ("ionic: add tx/rx-push support with device Component Memory Buffers")
Fixes: 6f7d6f0fd7a3 ("ionic: pull reset_queues into tx_timeout handler")
Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1816,6 +1816,7 @@ static int ionic_change_mtu(struct net_d
 static void ionic_tx_timeout_work(struct work_struct *ws)
 {
 	struct ionic_lif *lif = container_of(ws, struct ionic_lif, tx_timeout_work);
+	int err;
 
 	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		return;
@@ -1828,8 +1829,11 @@ static void ionic_tx_timeout_work(struct
 
 	mutex_lock(&lif->queue_lock);
 	ionic_stop_queues_reconfig(lif);
-	ionic_start_queues_reconfig(lif);
+	err = ionic_start_queues_reconfig(lif);
 	mutex_unlock(&lif->queue_lock);
+
+	if (err)
+		dev_err(lif->ionic->dev, "%s: Restarting queues failed\n", __func__);
 }
 
 static void ionic_tx_timeout(struct net_device *netdev, unsigned int txqueue)
@@ -2799,17 +2803,22 @@ static int ionic_cmb_reconfig(struct ion
 			if (err) {
 				dev_err(lif->ionic->dev,
 					"CMB restore failed: %d\n", err);
-				goto errout;
+				goto err_out;
 			}
 		}
 
-		ionic_start_queues_reconfig(lif);
-	} else {
-		/* This was detached in ionic_stop_queues_reconfig() */
-		netif_device_attach(lif->netdev);
+		err = ionic_start_queues_reconfig(lif);
+		if (err) {
+			dev_err(lif->ionic->dev,
+				"CMB reconfig failed: %d\n", err);
+			goto err_out;
+		}
 	}
 
-errout:
+err_out:
+	/* This was detached in ionic_stop_queues_reconfig() */
+	netif_device_attach(lif->netdev);
+
 	return err;
 }
 


