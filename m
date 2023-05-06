Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BF36F8ECA
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjEFFwq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEFFwp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA54C10
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D791615E7
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC9DC4339B;
        Sat,  6 May 2023 05:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352363;
        bh=FNmp66BK8LaYwRIsJ4phj7a457TFiu5g3htyAty80eY=;
        h=Subject:To:Cc:From:Date:From;
        b=q1DkPTyxeGeeNNcgh2xRmEsxBtYDn6W0g/hUnehEPYelnLLhcFl82s44qwdDxOgfR
         uX7lbhv0+TSjCsGn6ZwUxcxmsDO9JOAoQw3rR0otHHtjCV4PXadmErCj0K/UnN4HBu
         5XGkusWB3qVEH5Zuq6ZCyxgdmtYJrhBazRAZBMLE=
Subject: FAILED: patch "[PATCH] phy: qcom-qmp-pcie: sc8180x PCIe PHY has 2 lanes" failed to apply to 5.15-stable tree
To:     dmitry.baryshkov@linaro.org, vkoul@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 10:46:45 +0900
Message-ID: <2023050644-oversold-skimpily-d741@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1db6b0a4246ce708b89f5136571130b9987741d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050644-oversold-skimpily-d741@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1db6b0a4246ce708b89f5136571130b9987741d1 Mon Sep 17 00:00:00 2001
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 31 Mar 2023 18:12:49 +0300
Subject: [PATCH] phy: qcom-qmp-pcie: sc8180x PCIe PHY has 2 lanes

All PCIe PHYs on sc8180x platform have 2 lanes, so change the number of
lanes to 2.

Fixes: f839f14e24f2 ("phy: qcom-qmp: Add sc8180x PCIe support")
Cc: stable@vger.kernel.org # 5.15
Sgned-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230331151250.4049-1-dmitry.baryshkov@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index b1e81530d551..f378c1ebefd7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2331,7 +2331,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
-	.lanes			= 1,
+	.lanes			= 2,
 
 	.tbls = {
 		.serdes		= sc8180x_qmp_pcie_serdes_tbl,

