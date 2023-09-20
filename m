Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4567A8194
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjITMqt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjITMqs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0F135
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60652C433CB;
        Wed, 20 Sep 2023 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213994;
        bh=IglbDi0JK9bmh7tOZZ+zyfcGI4a8XdxJOMw8GliLqmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sB1RrrBFMAutZYNmJP4zhTNfHQhqqE14gRwabvXElS/44DHFuCUabwaMDIYrdIYgB
         kKtx0J24Bewo/tJLaFMFw93vGKobhj8bcH3K8j8ZzDmZ9iedhea7DBVcSwPN6Fci+t
         6IB9FMEkttVDMxvfbyZVlqU1I4BLBj9m/tjSf8LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Yang <xu.yang_2@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 056/110] usb: ehci: add workaround for chipidea PORTSC.PEC bug
Date:   Wed, 20 Sep 2023 13:31:54 +0200
Message-ID: <20230920112832.498403247@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit dda4b60ed70bd670eefda081f70c0cb20bbeb1fa ]

Some NXP processor using chipidea IP has a bug when frame babble is
detected.

As per 4.15.1.1.1 Serial Bus Babble:
  A babble condition also exists if IN transaction is in progress at
High-speed SOF2 point. This is called frame babble. The host controller
must disable the port to which the frame babble is detected.

The USB controller has disabled the port (PE cleared) and has asserted
USBERRINT when frame babble is detected, but PEC is not asserted.
Therefore, the SW isn't aware that port has been disabled. Then the
SW keeps sending packets to this port, but all of the transfers will
fail.

This workaround will firstly assert PCD by SW when USBERRINT is detected
and then judge whether port change has really occurred or not by polling
roothub status. Because the PEC doesn't get asserted in our case, this
patch will also assert it by SW when specific conditions are satisfied.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230809024432.535160-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-hcd.c |  8 ++++++--
 drivers/usb/host/ehci-hub.c | 10 +++++++++-
 drivers/usb/host/ehci.h     | 10 ++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1440803216297..02044d45edded 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -755,10 +755,14 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 
 	/* normal [4.15.1.2] or error [4.15.1.1] completion */
 	if (likely ((status & (STS_INT|STS_ERR)) != 0)) {
-		if (likely ((status & STS_ERR) == 0))
+		if (likely ((status & STS_ERR) == 0)) {
 			INCR(ehci->stats.normal);
-		else
+		} else {
+			/* Force to check port status */
+			if (ehci->has_ci_pec_bug)
+				status |= STS_PCD;
 			INCR(ehci->stats.error);
+		}
 		bh = 1;
 	}
 
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index c4f6a2559a987..0350c03dc97a1 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -674,7 +674,8 @@ ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 
 		if ((temp & mask) != 0 || test_bit(i, &ehci->port_c_suspend)
 				|| (ehci->reset_done[i] && time_after_eq(
-					jiffies, ehci->reset_done[i]))) {
+					jiffies, ehci->reset_done[i]))
+				|| ehci_has_ci_pec_bug(ehci, temp)) {
 			if (i < 7)
 			    buf [0] |= 1 << (i + 1);
 			else
@@ -874,6 +875,13 @@ int ehci_hub_control(
 		if (temp & PORT_PEC)
 			status |= USB_PORT_STAT_C_ENABLE << 16;
 
+		if (ehci_has_ci_pec_bug(ehci, temp)) {
+			status |= USB_PORT_STAT_C_ENABLE << 16;
+			ehci_info(ehci,
+				"PE is cleared by HW port:%d PORTSC:%08x\n",
+				wIndex + 1, temp);
+		}
+
 		if ((temp & PORT_OCC) && (!ignore_oc && !ehci->spurious_oc)){
 			status |= USB_PORT_STAT_C_OVERCURRENT << 16;
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index fdd073cc053b8..9888ca5f5f36f 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -207,6 +207,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		has_fsl_port_bug:1; /* FreeScale */
 	unsigned		has_fsl_hs_errata:1;	/* Freescale HS quirk */
 	unsigned		has_fsl_susp_errata:1;	/* NXP SUSP quirk */
+	unsigned		has_ci_pec_bug:1;	/* ChipIdea PEC bug */
 	unsigned		big_endian_mmio:1;
 	unsigned		big_endian_desc:1;
 	unsigned		big_endian_capbase:1;
@@ -706,6 +707,15 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
  */
 #define ehci_has_fsl_susp_errata(e)	((e)->has_fsl_susp_errata)
 
+/*
+ * Some Freescale/NXP processors using ChipIdea IP have a bug in which
+ * disabling the port (PE is cleared) does not cause PEC to be asserted
+ * when frame babble is detected.
+ */
+#define ehci_has_ci_pec_bug(e, portsc) \
+	((e)->has_ci_pec_bug && ((e)->command & CMD_PSE) \
+	 && !(portsc & PORT_PEC) && !(portsc & PORT_PE))
+
 /*
  * While most USB host controllers implement their registers in
  * little-endian format, a minority (celleb companion chip) implement
-- 
2.40.1



