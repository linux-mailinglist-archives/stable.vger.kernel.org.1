Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284A783331
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHUUGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjHUUGT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137FA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 934356494F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CB4C433CA;
        Mon, 21 Aug 2023 20:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648377;
        bh=ssKlJnTABAjpqIuwDCywPavouhxTUo+/w8ya1mq2tLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYAlpFX8N4j+lbH8Un7DE+D8dHLU/rxg7bG7kvQof1mJHXbEmlFDKOvsHSzhAXQbu
         KShNIxoEM3/CvpOxrTGhqm+0pJe1Wp1keuuxzqSY1gdGm0xqPSJvl2fvIBENi2Bj6n
         w8jJZJCYSfJNH/CfrxZsqkWMCJ0MSOMjH4XXqyW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 152/234] octeon_ep: cancel ctrl_mbox_task after intr_poll_task
Date:   Mon, 21 Aug 2023 21:41:55 +0200
Message-ID: <20230821194135.548090239@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 607a7a45cdf38c1901e0d81e4e00a2a88786330a ]

intr_poll_task may queue ctrl_mbox_task. The function
octep_poll_non_ioq_interrupts_cn93_pf does this.

When removing the driver and canceling these two works, cancel
ctrl_mbox_task last to guarantee it does not run anymore.

Fixes: 24d4333233b3 ("octeon_ep: poll for control messages")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Link: https://lore.kernel.org/r/20230810150114.107765-4-mschmidt@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index d8066bff5f7b1..ab69b6d625094 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1200,7 +1200,6 @@ static void octep_remove(struct pci_dev *pdev)
 	if (!oct)
 		return;
 
-	cancel_work_sync(&oct->ctrl_mbox_task);
 	netdev = oct->netdev;
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
@@ -1208,6 +1207,7 @@ static void octep_remove(struct pci_dev *pdev)
 	cancel_work_sync(&oct->tx_timeout_task);
 	oct->poll_non_ioq_intr = false;
 	cancel_delayed_work_sync(&oct->intr_poll_task);
+	cancel_work_sync(&oct->ctrl_mbox_task);
 	octep_device_cleanup(oct);
 	pci_release_mem_regions(pdev);
 	free_netdev(netdev);
-- 
2.40.1



