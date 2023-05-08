Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D66FAA60
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEHLCj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjEHLCQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B830AF0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE9662A29
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91748C433EF;
        Mon,  8 May 2023 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543655;
        bh=MAB3dtPYftmQz3ahY//MiHajMhjIR/dm2BqKGdUiJ/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3nbm4qzizRq4Jmp5PX6MJT/FMgdNLAIz6tjXpUS8gpiomkD4IA/+SXk8k+9c0gSs
         pbslExffBWa6TUVKGeqxzZsfjfYKKoMLHtsItCtKB4A5i8z0nI29yM4wrcrulvY4xS
         NhNBIp8uN2T0KYHYrjcOE+FLa3anTalBx2Aslvvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaoqian Lin <linmq006@gmail.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 159/694] soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe
Date:   Mon,  8 May 2023 11:39:54 +0200
Message-Id: <20230508094437.585987736@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 8f3c307b580a4a6425896007325bddefc36e8d91 ]

wkup_m3_ipc_get() takes refcount, which should be freed by
wkup_m3_ipc_put(). Add missing refcount release in the error paths.

Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20230106054022.947529-1-linmq006@gmail.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/pm33xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index ce09c42eaed25..f04c21157904b 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -527,7 +527,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 
 	ret = am33xx_pm_alloc_sram();
 	if (ret)
-		return ret;
+		goto err_wkup_m3_ipc_put;
 
 	ret = am33xx_pm_rtc_setup();
 	if (ret)
@@ -572,13 +572,14 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 err_pm_runtime_disable:
 	pm_runtime_disable(dev);
-	wkup_m3_ipc_put(m3_ipc);
 err_unsetup_rtc:
 	iounmap(rtc_base_virt);
 	clk_put(rtc_fck);
 err_free_sram:
 	am33xx_pm_free_sram();
 	pm33xx_dev = NULL;
+err_wkup_m3_ipc_put:
+	wkup_m3_ipc_put(m3_ipc);
 	return ret;
 }
 
-- 
2.39.2



