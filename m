Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7B7614D5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjGYLXP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjGYLXI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3701AA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B466167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A600DC433C8;
        Tue, 25 Jul 2023 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284185;
        bh=TmFCbMQWgCEViApQTymdYPsJYzjQtTcf9RdAopETO+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1DbMXWeh9RctxK1mDKYsbkXualvCkOhp/Mrnj9EsGAp2q+WXPNcf8ygwyZWUJN/6
         fdTRtT6Z0BsJie2j55Pv7LF76YYJykCb7hTllBz6QEF9tDMm2XICeXlAl3FLZZSV7V
         8psLM8a+bVE3DR40bPcQbiNujQzn3a8+QgnP7xog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 248/509] Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
Date:   Tue, 25 Jul 2023 12:43:07 +0200
Message-ID: <20230725104605.101523538@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit df49f2a0ac4a34c0cb4b5c233fcfa0add644c43c ]

This reverts commit edd60d24bd858cef165274e4cd6cab43bdc58d15.

Heikki reports that this should not be a global flag just to work around
one broken driver and should be fixed differently, so revert it.

Reported-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Fixes: edd60d24bd85 ("usb: common: usb-conn-gpio: Set last role to unknown before initial detection")
Link: https://lore.kernel.org/r/ZImE4L3YgABnCIsP@kuha.fi.intel.com
Cc: Prashanth K <quic_prashk@quicinc.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.c                       | 2 --
 drivers/usb/common/usb-conn-gpio.c             | 3 ---
 drivers/usb/musb/jz4740.c                      | 2 --
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 --
 include/linux/usb/role.h                       | 1 -
 5 files changed, 10 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index e5fe640b2bb01..8fe7420de033d 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -243,8 +243,6 @@ static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
 		if (!vbus)
 			role = USB_ROLE_NONE;
 		break;
-	default:
-		break;
 	}
 
 	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 5754e467c16a8..c9545a4eff664 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -276,9 +276,6 @@ static int usb_conn_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	/* Set last role to unknown before performing the initial detection */
-	info->last_role = USB_ROLE_UNKNOWN;
-
 	/* Perform initial detection */
 	usb_conn_queue_dwork(info, 0);
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index f283629091ec4..c4fe1f4cd17a3 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -91,8 +91,6 @@ static int jz4740_musb_role_switch_set(struct usb_role_switch *sw,
 	case USB_ROLE_HOST:
 		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_ID, phy);
 		break;
-	default:
-		break;
 	}
 
 	return 0;
diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 4d6a3dd06e011..5c96e929acea0 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -97,8 +97,6 @@ static int intel_xhci_usb_set_role(struct usb_role_switch *sw,
 		val |= SW_VBUS_VALID;
 		drd_config = DRD_CONFIG_STATIC_DEVICE;
 		break;
-	default:
-		break;
 	}
 	val |= SW_IDPIN_EN;
 	if (data->enable_sw_switch) {
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index aecfce46d3544..b9ccaeb8a4aef 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -11,7 +11,6 @@ enum usb_role {
 	USB_ROLE_NONE,
 	USB_ROLE_HOST,
 	USB_ROLE_DEVICE,
-	USB_ROLE_UNKNOWN,
 };
 
 typedef int (*usb_role_switch_set_t)(struct usb_role_switch *sw,
-- 
2.39.2



