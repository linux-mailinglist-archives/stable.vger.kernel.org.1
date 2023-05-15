Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81070346D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbjEOQsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbjEOQsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFE5B8A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE106292D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232F8C433EF;
        Mon, 15 May 2023 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169281;
        bh=eneSfdHZZIigCbK4uJJvxm1G7RJebvwOZ+fvEna6Sew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+ngNw+s/MfOO6hAN3eTzspspRfe8AO9C89qFkv9sJ6srd4EZEDfXz4QccoB0ANPv
         +vhYIha1CSrOakuA+9P3QT2HXgUAwg+vHz2p4DE/BiUNMJNaOqQQ2VI1sr54N3OH6j
         P/05eMs4KRb+uVP6mPpLXbpaWi9xgG4vYDzqVvuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 001/246] USB: dwc3: gadget: drop dead hibernation code
Date:   Mon, 15 May 2023 18:23:33 +0200
Message-Id: <20230515161722.658179152@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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
Stable-dep-of: 39674be56fba ("usb: dwc3: gadget: Execute gadget stop after halting the controller")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 46 +++++----------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3faac3244c7db..a995e3f4df37f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2478,7 +2478,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
@@ -2497,17 +2497,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
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
 
@@ -2589,7 +2583,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	return dwc3_gadget_run_stop(dwc, false);
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
@@ -2643,7 +2637,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
+		ret = dwc3_gadget_run_stop(dwc, true);
 	}
 
 	pm_runtime_put(dwc->dev);
@@ -4210,30 +4204,6 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
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
@@ -4251,11 +4221,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
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
@@ -4592,7 +4558,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	dwc3_gadget_run_stop(dwc, false);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
@@ -4613,7 +4579,7 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	if (ret < 0)
 		goto err0;
 
-	ret = dwc3_gadget_run_stop(dwc, true, false);
+	ret = dwc3_gadget_run_stop(dwc, true);
 	if (ret < 0)
 		goto err1;
 
-- 
2.39.2



