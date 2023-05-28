Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89055713F35
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjE1TnE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjE1TnE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565919E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D4461F12
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D361C433D2;
        Sun, 28 May 2023 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302982;
        bh=rhAWndNEGW0/IgAkDMGfg4Iw2J2stBFw12Q8ul+I4u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atiVcdNbFvxcOmKPG6GeSs+jf0ZFvuDQEQsrGNR9GnnBynWrEcx7K6Z84VWaNTGQm
         fqbY5/aWA+85HNl8uKHvw/Kh/VSjYkfNepEnztfJjUkxjirb8qnkfT+b86d+HDRbEh
         UEFBFNiM/EWTHJ58uWlaooDheqZRbFHPIoJGxstY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 105/211] media: netup_unidvb: fix use-after-free at del_timer()
Date:   Sun, 28 May 2023 20:10:26 +0100
Message-Id: <20230528190846.191833222@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 0f5bb36bf9b39a2a96e730bf4455095b50713f63 ]

When Universal DVB card is detaching, netup_unidvb_dma_fini()
uses del_timer() to stop dma->timeout timer. But when timer
handler netup_unidvb_dma_timeout() is running, del_timer()
could not stop it. As a result, the use-after-free bug could
happen. The process is shown below:

    (cleanup routine)          |        (timer routine)
                               | mod_timer(&dev->tx_sim_timer, ..)
netup_unidvb_finidev()         | (wait a time)
  netup_unidvb_dma_fini()      | netup_unidvb_dma_timeout()
    del_timer(&dma->timeout);  |
                               |   ndev->pci_dev->dev //USE

Fix by changing del_timer() to del_timer_sync().

Link: https://lore.kernel.org/linux-media/20230308125514.4208-1-duoming@zju.edu.cn
Fixes: 52b1eaf4c59a ("[media] netup_unidvb: NetUP Universal DVB-S/S2/T/T2/C PCI-E card driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 77bae14685513..a71814e2772d1 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -697,7 +697,7 @@ static void netup_unidvb_dma_fini(struct netup_unidvb_dev *ndev, int num)
 	netup_unidvb_dma_enable(dma, 0);
 	msleep(50);
 	cancel_work_sync(&dma->work);
-	del_timer(&dma->timeout);
+	del_timer_sync(&dma->timeout);
 }
 
 static int netup_unidvb_dma_setup(struct netup_unidvb_dev *ndev)
-- 
2.39.2



