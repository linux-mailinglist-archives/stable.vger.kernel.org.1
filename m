Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D977D31CB
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjJWLNS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjJWLNS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05297C1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A30C433C8;
        Mon, 23 Oct 2023 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059595;
        bh=hO7/u4QvEpDSyIujDNLy4B/cM9A3gEd55peAsUr9LuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11Emg9n2+ffQQF/13dlo+zfr7wX0xxOhNez6+G0xT4aEDnr1Q2qaSRp0hhtStnMvC
         YW7VO3XQS4oCj6zngXzqPFgIhfMagjOblWGUuuglojlGQky185XwbYcu7f5GORixiM
         m0iybA+4lS1+zomO3P+ORJXjkGtt/oEXl7xBj0nA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrien Thierry <athierry@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 229/241] phy: qcom-qmp-usb: initialize PCS_USB registers
Date:   Mon, 23 Oct 2023 12:56:55 +0200
Message-ID: <20231023104839.455519816@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrien Thierry <athierry@redhat.com>

[ Upstream commit 2d3465a75c9f83684d17da6807423824bf260524 ]

Currently, PCS_USB registers that have their initialization data in a
pcs_usb_tbl table are never initialized. Fix that.

Fixes: fc64623637da ("phy: qcom-qmp-combo,usb: add support for separate PCS_USB region")
Signed-off-by: Adrien Thierry <athierry@redhat.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230828152353.16529-2-athierry@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 466f0a56c82e1..f9cb60f12575b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2233,6 +2233,7 @@ static int qmp_usb_power_on(struct phy *phy)
 	void __iomem *tx = qmp->tx;
 	void __iomem *rx = qmp->rx;
 	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_usb = qmp->pcs_usb;
 	void __iomem *status;
 	unsigned int val;
 	int ret;
@@ -2256,6 +2257,9 @@ static int qmp_usb_power_on(struct phy *phy)
 
 	qmp_usb_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
+	if (pcs_usb)
+		qmp_usb_configure(pcs_usb, cfg->pcs_usb_tbl, cfg->pcs_usb_tbl_num);
+
 	if (cfg->has_pwrdn_delay)
 		usleep_range(10, 20);
 
-- 
2.42.0



