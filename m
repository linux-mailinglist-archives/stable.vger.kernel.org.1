Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFB6FA5FE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjEHKPE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjEHKPC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC193AA2F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822066245F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9097FC433EF;
        Mon,  8 May 2023 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540899;
        bh=unCZGmqAzJlAK8MB4tHDkgOcSq5PkLiBQGLN331w5pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZ/ennnwdl2gwmPd9YYVTLwKcWa5phwz43AF8e1QQP2hUQ/B0Jl2gtHn2u0DrbMZH
         oNZxSeOuOWr2sHQaBdRp6Cp8w7GyyIpMUlMlD24+FeFnqyq54Y4TmQqlsbg08RravD
         d15Gr86EwlW1jU1FefGXJ/brivSzOxSe1R8a+FPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 540/611] dma: gpi: remove spurious unlock in gpi_ch_init
Date:   Mon,  8 May 2023 11:46:22 +0200
Message-Id: <20230508094439.554483161@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 91d6a468e335571f1e67e046050dea9af5fa4ebe ]

gpi_ch_init() doesn't lock the ctrl_lock mutex, so there is no need to
unlock it too. Instead the mutex is handled by the function
gpi_alloc_chan_resources(), which properly locks and unlocks the mutex.

=====================================
WARNING: bad unlock balance detected!
6.3.0-rc5-00253-g99792582ded1-dirty #15 Not tainted
-------------------------------------
kworker/u16:0/9 is trying to release lock (&gpii->ctrl_lock) at:
[<ffffb99d04e1284c>] gpi_alloc_chan_resources+0x108/0x5bc
but there are no more locks to release!

other info that might help us debug this:
6 locks held by kworker/u16:0/9:
 #0: ffff575740010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x220/0x594
 #1: ffff80000809bdd0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x220/0x594
 #2: ffff575740f2a0f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x188
 #3: ffff57574b5570f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x188
 #4: ffffb99d06a2f180 (of_dma_lock){+.+.}-{3:3}, at: of_dma_request_slave_channel+0x138/0x280
 #5: ffffb99d06a2ee20 (dma_list_mutex){+.+.}-{3:3}, at: dma_get_slave_channel+0x28/0x10c

stack backtrace:
CPU: 7 PID: 9 Comm: kworker/u16:0 Not tainted 6.3.0-rc5-00253-g99792582ded1-dirty #15
Hardware name: Google Pixel 3 (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0xa0/0xfc
 show_stack+0x18/0x24
 dump_stack_lvl+0x60/0xac
 dump_stack+0x18/0x24
 print_unlock_imbalance_bug+0x130/0x148
 lock_release+0x270/0x300
 __mutex_unlock_slowpath+0x48/0x2cc
 mutex_unlock+0x20/0x2c
 gpi_alloc_chan_resources+0x108/0x5bc
 dma_chan_get+0x84/0x188
 dma_get_slave_channel+0x5c/0x10c
 gpi_of_dma_xlate+0x110/0x1a0
 of_dma_request_slave_channel+0x174/0x280
 dma_request_chan+0x3c/0x2d4
 geni_i2c_probe+0x544/0x63c
 platform_probe+0x68/0xc4
 really_probe+0x148/0x2ac
 __driver_probe_device+0x78/0xe0
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 device_add+0x60c/0x7d8
 of_device_add+0x44/0x60
 of_platform_device_create_pdata+0x90/0x124
 of_platform_bus_create+0x15c/0x3c8
 of_platform_populate+0x58/0xf8
 devm_of_platform_populate+0x58/0xbc
 geni_se_probe+0xf0/0x164
 platform_probe+0x68/0xc4
 really_probe+0x148/0x2ac
 __driver_probe_device+0x78/0xe0
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x2bc/0x594
 worker_thread+0x228/0x438
 kthread+0x108/0x10c
 ret_from_fork+0x10/0x20

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230409233355.453741-1-dmitry.baryshkov@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/qcom/gpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 98d45ee4b4e34..db6d0dc308d29 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1966,7 +1966,6 @@ static int gpi_ch_init(struct gchan *gchan)
 error_config_int:
 	gpi_free_ring(&gpii->ev_ring, gpii);
 exit_gpi_init:
-	mutex_unlock(&gpii->ctrl_lock);
 	return ret;
 }
 
-- 
2.39.2



