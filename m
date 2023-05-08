Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37A6FA9B4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjEHKyu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjEHKyT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BC2B409
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D60761821
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F0C433EF;
        Mon,  8 May 2023 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543212;
        bh=jeuc4JoFCPqwXiJad/GWe37t5buoUxk7bGN9lF/fzn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQBgYl08X96Ji5r+2De7tXimP33styTLNPV40jTcspcnPcfbDL6qqP0b+iOE6BGJt
         D0CHbxdqk3t3l704Su0IrY+p8seht8d+xN6BU6rPlCVtqIYKb5miK61EawfFKYu5DZ
         aU3oEvmp4RBbPrjNQZkQD3CduuJl7x01MQARPFzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.3 008/694] phy: qcom-qmp-pcie: sc8180x PCIe PHY has 2 lanes
Date:   Mon,  8 May 2023 11:37:23 +0200
Message-Id: <20230508094432.906917602@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

commit 1db6b0a4246ce708b89f5136571130b9987741d1 upstream.

All PCIe PHYs on sc8180x platform have 2 lanes, so change the number of
lanes to 2.

Fixes: f839f14e24f2 ("phy: qcom-qmp: Add sc8180x PCIe support")
Cc: stable@vger.kernel.org # 5.15
Sgned-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230331151250.4049-1-dmitry.baryshkov@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2152,7 +2152,7 @@ static const struct qmp_phy_cfg msm8998_
 };
 
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
-	.lanes			= 1,
+	.lanes			= 2,
 
 	.tbls = {
 		.serdes		= sc8180x_qmp_pcie_serdes_tbl,


