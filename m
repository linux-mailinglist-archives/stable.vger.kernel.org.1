Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56270383A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjEORaF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjEOR3i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7511D100C7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4103062D15
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFC7C433D2;
        Mon, 15 May 2023 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171634;
        bh=bUMy21/0iYRg7ZAaLCgw7jbRBx3nDz1or4P4qOhg7R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wuw2EEVjsB1DA0EJsHZKLL9PV3M665LsTO2aimMCE5Id5UrC/8uuq6h6o+lk6dw2i
         EpHsBXEROjKaHPD4ELW4i6zgjmmJ4/kVdT5fUKqLfqhMDgLuG8W+//V63qzgekYCq/
         SseTMQ5LHdDVws+xPwvCy8oA6taTiZdNDIml4FPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hayes Wang <hayeswang@realtek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 030/134] r8152: fix the poor throughput for 2.5G devices
Date:   Mon, 15 May 2023 18:28:27 +0200
Message-Id: <20230515161704.063189259@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 61b0ad6f58e2066e054c6d4839d67974d2861a7d ]

Fix the poor throughput for 2.5G devices, when changing the speed from
auto mode to force mode. This patch is used to notify the MAC when the
mode is changed.

Fixes: 195aae321c82 ("r8152: support new chips")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1c45f5dd0be4c..b0e1ef97c4951 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -199,6 +199,7 @@
 #define OCP_EEE_AR		0xa41a
 #define OCP_EEE_DATA		0xa41c
 #define OCP_PHY_STATUS		0xa420
+#define OCP_INTR_EN		0xa424
 #define OCP_NCTL_CFG		0xa42c
 #define OCP_POWER_CFG		0xa430
 #define OCP_EEE_CFG		0xa432
@@ -620,6 +621,9 @@ enum spd_duplex {
 #define PHY_STAT_LAN_ON		3
 #define PHY_STAT_PWRDN		5
 
+/* OCP_INTR_EN */
+#define INTR_SPEED_FORCE	BIT(3)
+
 /* OCP_NCTL_CFG */
 #define PGA_RETURN_EN		BIT(1)
 
@@ -7547,6 +7551,11 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 				      ((swap_a & 0x1f) << 8) |
 				      ((swap_a >> 8) & 0x1f));
 		}
+
+		/* Notify the MAC when the speed is changed to force mode. */
+		data = ocp_reg_read(tp, OCP_INTR_EN);
+		data |= INTR_SPEED_FORCE;
+		ocp_reg_write(tp, OCP_INTR_EN, data);
 		break;
 	default:
 		break;
@@ -7942,6 +7951,11 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
+	/* Notify the MAC when the speed is changed to force mode. */
+	data = ocp_reg_read(tp, OCP_INTR_EN);
+	data |= INTR_SPEED_FORCE;
+	ocp_reg_write(tp, OCP_INTR_EN, data);
+
 	if (rtl_phy_patch_request(tp, true, true))
 		return;
 
-- 
2.39.2



