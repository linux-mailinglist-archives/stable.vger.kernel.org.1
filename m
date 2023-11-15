Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB47ED2D8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjKOUoo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjKOUon (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:44:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06763A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:44:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D0C433C7;
        Wed, 15 Nov 2023 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081079;
        bh=bZeBol5rVjr6PNJXLG3AC31YPG0sf+0cBdwXcjgH3Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5sbxijYvJmLbWoi+GViUKv2eaMSocQha38KD9K48MMlvj3T71L2zdk2SEULjD2FR
         rd589hlthxOSUY5VMFElGAEapRbmoJiudSqsmfiMUPKYFgrkTcCNVcIOFhHvZYngP9
         e2MGZ4oUhdERrb8AGoDk+I8a7/zkcxvhp/qWAjb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/88] can: dev: can_restart(): dont crash kernel if carrier is OK
Date:   Wed, 15 Nov 2023 15:35:21 -0500
Message-ID: <20231115191426.749179928@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit fe5c9940dfd8ba0c73672dddb30acd1b7a11d4c7 ]

During testing, I triggered a can_restart() with the netif carrier
being OK [1]. The BUG_ON, which checks if the carrier is OK, results
in a fatal kernel crash. This is neither helpful for debugging nor for
a production system.

[1] The root cause is a race condition in can_restart() which will be
fixed in the next patch.

Do not crash the kernel, issue an error message instead, and continue
restarting the CAN device anyway.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Link: https://lore.kernel.org/all/20231005-can-dev-fix-can-restart-v2-1-91b5c1fd922c@pengutronix.de
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 8738d37f72737..487cb9acdd456 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -563,7 +563,8 @@ static void can_restart(struct net_device *dev)
 	struct can_frame *cf;
 	int err;
 
-	BUG_ON(netif_carrier_ok(dev));
+	if (netif_carrier_ok(dev))
+		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
 	/*
 	 * No synchronization needed because the device is bus-off and
-- 
2.42.0



