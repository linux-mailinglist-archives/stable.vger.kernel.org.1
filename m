Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B234787275
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbjHXOyI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbjHXOxx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:53:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE31BD3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335D166EBF
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B29C433C7;
        Thu, 24 Aug 2023 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888821;
        bh=Mt2Qbp7V0o/tMirWXSqQgij7lzt3hd7WIhGXd+hvjLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpiXQYC65zvVvW87IggJNNGD5GjymAooJQaMIyQ+n4A3qEEMH0B9T0aCGtI3G/Kfm
         SUWNYeFRZwEIRXNItgDZW4NMhWrbay4yCFb1QV9YTO8WCuUjg1OtglyfevuCG5Tl7V
         VQIW8zAr8runMjwdzKT1agDm0Knycq91DCdhYzoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 054/139] USB: dwc3: gadget: drop dead hibernation code
Date:   Thu, 24 Aug 2023 16:49:37 +0200
Message-ID: <20230824145025.982522276@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit bdb19d01026a5cccfa437be8adcf2df472c5889e ]

The hibernation code is broken and has never been enabled in mainline
and should thus be dropped.

Remove the hibernation bits from the gadget code, which effectively
reverts commits e1dadd3b0f27 ("usb: dwc3: workaround: bogus hibernation
events") and 7b2a0368bbc9 ("usb: dwc3: gadget: set KEEP_CONNECT in case
of hibernation") except for the spurious interrupt warning.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230404072524.19014-5-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 46 +++++----------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2d5a4d0e63c61..a1be110f7ced1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2412,7 +2412,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 500;
@@ -2431,17 +2431,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation)
-			reg |= DWC3_DCTL_KEEP_CONNECT;
-
 		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation && !suspend)
-			reg &= ~DWC3_DCTL_KEEP_CONNECT;
-
 		dwc->pullups_connected = false;
 	}
 
@@ -2487,7 +2481,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	return dwc3_gadget_run_stop(dwc, false);
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
@@ -2555,7 +2549,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
+		ret = dwc3_gadget_run_stop(dwc, true);
 	}
 
 	pm_runtime_put(dwc->dev);
@@ -4053,30 +4047,6 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 	dwc->link_state = next;
 }
 
-static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
-		unsigned int evtinfo)
-{
-	unsigned int is_ss = evtinfo & BIT(4);
-
-	/*
-	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
-	 * have a known issue which can cause USB CV TD.9.23 to fail
-	 * randomly.
-	 *
-	 * Because of this issue, core could generate bogus hibernation
-	 * events which SW needs to ignore.
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
-	 * Device Fallback from SuperSpeed
-	 */
-	if (is_ss ^ (dwc->speed == USB_SPEED_SUPER))
-		return;
-
-	/* enter hibernation here */
-}
-
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_devt *event)
 {
@@ -4094,11 +4064,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-					"unexpected hibernation event\n"))
-			break;
-
-		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
+		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
@@ -4444,7 +4410,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	dwc3_gadget_run_stop(dwc, false);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
@@ -4465,7 +4431,7 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	if (ret < 0)
 		goto err0;
 
-	ret = dwc3_gadget_run_stop(dwc, true, false);
+	ret = dwc3_gadget_run_stop(dwc, true);
 	if (ret < 0)
 		goto err1;
 
-- 
2.40.1



