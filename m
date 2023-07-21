Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE475D418
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjGUTRz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjGUTRy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045530F1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F0261D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE1CC433C8;
        Fri, 21 Jul 2023 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967064;
        bh=jEEiw9tp2dEgWuB+uUbQEz3b3QSTWfB5sIFAnUlSxcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kdil01M4dGAAS6u/GKInVqn7O3YGs80ei2m9uBdOf5qPJxmsgyWzeg1LvZjmWlWlg
         qpM6wIPl91K8P5Y5tzB2M27Fpg9qnsoLYHSLer8mu2IKmmgTXuR14+XpNRBYaCmPnY
         kWyzXSGBMQ59igNSr1L57PYhPivkTwdpQlRM63kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michal Kubiak <michal.kubiak@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/223] net: bgmac: postpone turning IRQs off to avoid SoC hangs
Date:   Fri, 21 Jul 2023 18:04:45 +0200
Message-ID: <20230721160522.237937933@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit e7731194fdf085f46d58b1adccfddbd0dfee4873 ]

Turning IRQs off is done by accessing Ethernet controller registers.
That can't be done until device's clock is enabled. It results in a SoC
hang otherwise.

This bug remained unnoticed for years as most bootloaders keep all
Ethernet interfaces turned on. It seems to only affect a niche SoC
family BCM47189. It has two Ethernet controllers but CFE bootloader uses
only the first one.

Fixes: 34322615cbaa ("net: bgmac: Mask interrupts during probe")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bgmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 1761df8fb7f96..10c7c232cc4ec 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1492,8 +1492,6 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 
 	bgmac->in_init = true;
 
-	bgmac_chip_intrs_off(bgmac);
-
 	net_dev->irq = bgmac->irq;
 	SET_NETDEV_DEV(net_dev, bgmac->dev);
 	dev_set_drvdata(bgmac->dev, bgmac);
@@ -1511,6 +1509,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	 */
 	bgmac_clk_enable(bgmac, 0);
 
+	bgmac_chip_intrs_off(bgmac);
+
 	/* This seems to be fixing IRQ by assigning OOB #6 to the core */
 	if (!(bgmac->feature_flags & BGMAC_FEAT_IDM_MASK)) {
 		if (bgmac->feature_flags & BGMAC_FEAT_IRQ_ID_OOB_6)
-- 
2.39.2



