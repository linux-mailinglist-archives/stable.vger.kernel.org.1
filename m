Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031F37ECEF4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjKOTpV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjKOTpT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2D9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C876AC433C8;
        Wed, 15 Nov 2023 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077516;
        bh=uQ2KDbkNx3ZDknNRS8CIEbofQJc5yDOEwzExSDyNqXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5cRp/6XWyuK6a3Zrb1GA0Cf4abuO9p+HoF24/5JGfhhlCe8sCHnuwsCfUwo1W2lM
         gE/GHFPeK3E8Dx3tNlv7PKiUa0xeyW1lirS0WmugXRX0l5PvJOhwBH4JMgnRlkUcEy
         itYtivfhVVUkXr0eAWbusQv6s+8yspZncI6TXsgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Ser <contact@emersion.fr>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 325/603] soc: qcom: pmic_glink: fix connector type to be DisplayPort
Date:   Wed, 15 Nov 2023 14:14:30 -0500
Message-ID: <20231115191635.997548588@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit f86955f2b1ff9fbc7ae4f6595112b2f896885366 ]

As it was pointed out by Simon Ser, the DRM_MODE_CONNECTOR_USB connector
is reserved for the GUD devices. Other drivers (i915, amdgpu) use
DRM_MODE_CONNECTOR_DisplayPort even if the DP stream is handled by the
USB-C altmode. While we are still working on implementing the proper way
to let userspace know that the DP is wrapped into USB-C, change
connector type to be DRM_MODE_CONNECTOR_DisplayPort.

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: Simon Ser <contact@emersion.fr>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Simon Ser <contact@emersion.fr>
Link: https://lore.kernel.org/r/20231010225229.77027-1-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index d05e0d6edf493..974c14d1e0bfc 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -465,7 +465,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
 		alt_port->bridge.of_node = to_of_node(fwnode);
 		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
-		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
+		alt_port->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
 		if (ret)
-- 
2.42.0



