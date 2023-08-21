Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4357831D9
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjHUTzu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHUTzu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13937191
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E5B63534
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EFBC433C9;
        Mon, 21 Aug 2023 19:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647734;
        bh=bEXIITThi8D8NdwdR9mUvs/pfPrs71ERLHsPzE2esRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvif631kPpS4c436rKEsjCKcW6li3+wj+DkzClXyBOWIfv/dn7kD/Cu/wFpFI1QqT
         LHh5vgUKvO848G/t+QnoVcXr5ioAv40fd6PLT3t+uZkf0pKjdgDXcRQe22+FNjDuLG
         lyTHYGLaCayqQR0Dj/Kt/g7D5zkmkEGtEeaGa2Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/194] octeon_ep: cancel tx_timeout_task later in remove sequence
Date:   Mon, 21 Aug 2023 21:41:38 +0200
Message-ID: <20230821194127.934063814@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 28458c80006bb4e993a09fc094094a8578cad292 ]

tx_timeout_task is canceled too early when removing the driver. Nothing
prevents .ndo_tx_timeout from triggering and queuing the work again.

Better cancel it after the netdev is unregistered.
It's harmless for octep_tx_timeout_task to run in the window between the
unregistration and cancelation, because it checks netif_running.

Fixes: 862cd659a6fb ("octeon_ep: Add driver framework and device initialization")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Link: https://lore.kernel.org/r/20230810150114.107765-3-mschmidt@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 8979dd05e873f..d4ec46d1c8cfb 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1121,12 +1121,12 @@ static void octep_remove(struct pci_dev *pdev)
 	if (!oct)
 		return;
 
-	cancel_work_sync(&oct->tx_timeout_task);
 	cancel_work_sync(&oct->ctrl_mbox_task);
 	netdev = oct->netdev;
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
+	cancel_work_sync(&oct->tx_timeout_task);
 	octep_device_cleanup(oct);
 	pci_release_mem_regions(pdev);
 	free_netdev(netdev);
-- 
2.40.1



