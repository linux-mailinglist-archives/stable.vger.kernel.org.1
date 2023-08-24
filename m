Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CE7876A8
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbjHXRSc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjHXRSO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A0E50
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56D32674C6
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EEBC433C7;
        Thu, 24 Aug 2023 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897490;
        bh=D/3AFMExJ/H4/zI2OfusU3GUOOk8h8G8h9V8wM/bN20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fErhci0ylk0Q8CVV3Vpw7/9YKjNDtncfKsms1mb2GVjn6kcZBDhTmubrAkz1N0wFv
         ea5OkGMYy3mJ+MlraDD3mlp2gK8FnnaRoyvtZW8E2s5C+vKYgP3cQ4VKgwm4KbfX+E
         Wr+Y+igUJLSeoofGC8JOp2czIkIvuinOY+1x9maU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Chen <peter.chen@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/135] usb: cdns3: allocate TX FIFO size according to composite EP number
Date:   Thu, 24 Aug 2023 19:08:48 +0200
Message-ID: <20230824170619.598501654@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit dce49449e04ff150838a31386ee65917beb9ebb5 ]

Some devices have USB compositions which may require multiple endpoints.
To get better performance, need bigger CDNS3_EP_BUF_SIZE.

But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
multiple endpoints.

By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.

Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
cnds3_device:ep_iso_burst

Using a simple algorithm to calculate ep_buf_size.
ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
1).

Test at 8qxp:

	Gadget			ep_buf_size

	RNDIS:				5
	RNDIS+ACM:			3
	Mass Storage + NCM + ACM	2

Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
exceed FIFO memory.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20220509164055.1815081-1-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: dbe678f6192f ("usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/gadget.c | 47 ++++++++++++++++++++++++++++++++++----
 drivers/usb/cdns3/gadget.h |  9 +++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index e3a8b6c71aa1d..24dab7006b823 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2041,7 +2041,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	u8 mult = 0;
 	int ret;
 
-	buffering = CDNS3_EP_BUF_SIZE - 1;
+	buffering = priv_dev->ep_buf_size - 1;
 
 	cdns3_configure_dmult(priv_dev, priv_ep);
 
@@ -2060,7 +2060,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		break;
 	default:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
-		mult = CDNS3_EP_ISO_HS_MULT - 1;
+		mult = priv_dev->ep_iso_burst - 1;
 		buffering = mult + 1;
 	}
 
@@ -2076,14 +2076,14 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		mult = 0;
 		max_packet_size = 1024;
 		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
-			maxburst = CDNS3_EP_ISO_SS_BURST - 1;
+			maxburst = priv_dev->ep_iso_burst - 1;
 			buffering = (mult + 1) *
 				    (maxburst + 1);
 
 			if (priv_ep->interval > 1)
 				buffering++;
 		} else {
-			maxburst = CDNS3_EP_BUF_SIZE - 1;
+			maxburst = priv_dev->ep_buf_size - 1;
 		}
 		break;
 	default:
@@ -2098,6 +2098,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
+	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
+	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
+
 	/* onchip buffer is only allocated before configuration */
 	if (!priv_dev->hw_configured_flag) {
 		ret = cdns3_ep_onchip_buffer_reserve(priv_dev, buffering + 1,
@@ -2971,6 +2975,40 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
+/**
+ * cdns3_gadget_check_config - ensure cdns3 can support the USB configuration
+ * @gadget: pointer to the USB gadget
+ *
+ * Used to record the maximum number of endpoints being used in a USB composite
+ * device. (across all configurations)  This is to be used in the calculation
+ * of the TXFIFO sizes when resizing internal memory for individual endpoints.
+ * It will help ensured that the resizing logic reserves enough space for at
+ * least one max packet.
+ */
+static int cdns3_gadget_check_config(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct usb_ep *ep;
+	int n_in = 0;
+	int total;
+
+	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
+		if (ep->claimed && (ep->address & USB_DIR_IN))
+			n_in++;
+	}
+
+	/* 2KB are reserved for EP0, 1KB for out*/
+	total = 2 + n_in + 1;
+
+	if (total > priv_dev->onchip_buffers)
+		return -ENOMEM;
+
+	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
+			(priv_dev->onchip_buffers - 2) / (n_in + 1);
+
+	return 0;
+}
+
 static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.get_frame = cdns3_gadget_get_frame,
 	.wakeup = cdns3_gadget_wakeup,
@@ -2979,6 +3017,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.udc_start = cdns3_gadget_udc_start,
 	.udc_stop = cdns3_gadget_udc_stop,
 	.match_ep = cdns3_gadget_match_ep,
+	.check_config = cdns3_gadget_check_config,
 };
 
 static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 21fa461c518ec..32825477edd3e 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -561,15 +561,18 @@ struct cdns3_usb_regs {
 /* Max burst size (used only in SS mode). */
 #define EP_CFG_MAXBURST_MASK	GENMASK(11, 8)
 #define EP_CFG_MAXBURST(p)	(((p) << 8) & EP_CFG_MAXBURST_MASK)
+#define EP_CFG_MAXBURST_MAX	15
 /* ISO max burst. */
 #define EP_CFG_MULT_MASK	GENMASK(15, 14)
 #define EP_CFG_MULT(p)		(((p) << 14) & EP_CFG_MULT_MASK)
+#define EP_CFG_MULT_MAX		2
 /* ISO max burst. */
 #define EP_CFG_MAXPKTSIZE_MASK	GENMASK(26, 16)
 #define EP_CFG_MAXPKTSIZE(p)	(((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
 /* Max number of buffered packets. */
 #define EP_CFG_BUFFERING_MASK	GENMASK(31, 27)
 #define EP_CFG_BUFFERING(p)	(((p) << 27) & EP_CFG_BUFFERING_MASK)
+#define EP_CFG_BUFFERING_MAX	15
 
 /* EP_CMD - bitmasks */
 /* Endpoint reset. */
@@ -1093,9 +1096,6 @@ struct cdns3_trb {
 #define CDNS3_ENDPOINTS_MAX_COUNT	32
 #define CDNS3_EP_ZLP_BUF_SIZE		1024
 
-#define CDNS3_EP_BUF_SIZE		4	/* KB */
-#define CDNS3_EP_ISO_HS_MULT		3
-#define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
 #define CDNS3_WA2_NUM_BUFFERS		128
@@ -1330,6 +1330,9 @@ struct cdns3_device {
 	/*in KB */
 	u16				onchip_buffers;
 	u16				onchip_used_size;
+
+	u16				ep_buf_size;
+	u16				ep_iso_burst;
 };
 
 void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
-- 
2.40.1



