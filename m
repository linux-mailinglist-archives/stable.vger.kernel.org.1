Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EE8719D59
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFANWY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjFANWS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425F19D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C036442C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E28DC433D2;
        Thu,  1 Jun 2023 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625724;
        bh=A/O8jTvGvMHj3aNFZLPE359iCxXuHB06rtDAD1+9jIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDDaX/TgfeKGrqoOG2l7rya69Tk4aSr1yjzVJS+bl4y6ROD+I6otufD5o66Twaiy+
         Rel6P47RbUlODc0M4d998VgSEdH/RSsZsk5CwERNhRnO2P2kfZ1vxReRZeZaVc4vL1
         8NALnZ9No9DhkTBuwMJpFMPkpx69DxO3feAwp2vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Bersenev <bay@hackerdom.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 01/16] cdc_ncm: Implement the 32-bit version of NCM Transfer Block
Date:   Thu,  1 Jun 2023 14:20:56 +0100
Message-Id: <20230601131932.013270381@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
References: <20230601131931.947241286@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Bersenev <bay@hackerdom.ru>

[ Upstream commit 0fa81b304a7973a499f844176ca031109487dd31 ]

The NCM specification defines two formats of transfer blocks: with 16-bit
fields (NTB-16) and with 32-bit fields (NTB-32). Currently only NTB-16 is
implemented.

This patch adds the support of NTB-32. The motivation behind this is that
some devices such as E5785 or E5885 from the current generation of Huawei
LTE routers do not support NTB-16. The previous generations of Huawei
devices are also use NTB-32 by default.

Also this patch enables NTB-32 by default for Huawei devices.

During the 2019 ValdikSS made five attempts to contact Huawei to add the
NTB-16 support to their router firmware, but they were unsuccessful.

Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 7e01c7f7046e ("net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ncm.c        | 411 ++++++++++++++++++++++++-------
 drivers/net/usb/huawei_cdc_ncm.c |   8 +-
 include/linux/usb/cdc_ncm.h      |  15 +-
 3 files changed, 340 insertions(+), 94 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 1c9a1b94f6e28..28e306e3ee8d9 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -175,7 +175,11 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 	u32 val, max, min;
 
 	/* clamp new_tx to sane values */
-	min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth16);
+	if (ctx->is_ndp16)
+		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth16);
+	else
+		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
+
 	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
 	if (max == 0)
 		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
@@ -309,10 +313,17 @@ static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr
 	if (enable == (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END))
 		return len;
 
-	if (enable && !ctx->delayed_ndp16) {
-		ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
-		if (!ctx->delayed_ndp16)
-			return -ENOMEM;
+	if (enable) {
+		if (ctx->is_ndp16 && !ctx->delayed_ndp16) {
+			ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp16)
+				return -ENOMEM;
+		}
+		if (!ctx->is_ndp16 && !ctx->delayed_ndp32) {
+			ctx->delayed_ndp32 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp32)
+				return -ENOMEM;
+		}
 	}
 
 	/* flush pending data before changing flag */
@@ -514,6 +525,9 @@ static int cdc_ncm_init(struct usbnet *dev)
 			dev_err(&dev->intf->dev, "SET_CRC_MODE failed\n");
 	}
 
+	/* use ndp16 by default */
+	ctx->is_ndp16 = 1;
+
 	/* set NTB format, if both formats are supported.
 	 *
 	 * "The host shall only send this command while the NCM Data
@@ -521,14 +535,27 @@ static int cdc_ncm_init(struct usbnet *dev)
 	 */
 	if (le16_to_cpu(ctx->ncm_parm.bmNtbFormatsSupported) &
 						USB_CDC_NCM_NTB32_SUPPORTED) {
-		dev_dbg(&dev->intf->dev, "Setting NTB format to 16-bit\n");
-		err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
-				       USB_TYPE_CLASS | USB_DIR_OUT
-				       | USB_RECIP_INTERFACE,
-				       USB_CDC_NCM_NTB16_FORMAT,
-				       iface_no, NULL, 0);
-		if (err < 0)
+		if (ctx->drvflags & CDC_NCM_FLAG_PREFER_NTB32) {
+			ctx->is_ndp16 = 0;
+			dev_dbg(&dev->intf->dev, "Setting NTB format to 32-bit\n");
+			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
+					       USB_TYPE_CLASS | USB_DIR_OUT
+					       | USB_RECIP_INTERFACE,
+					       USB_CDC_NCM_NTB32_FORMAT,
+					       iface_no, NULL, 0);
+		} else {
+			ctx->is_ndp16 = 1;
+			dev_dbg(&dev->intf->dev, "Setting NTB format to 16-bit\n");
+			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
+					       USB_TYPE_CLASS | USB_DIR_OUT
+					       | USB_RECIP_INTERFACE,
+					       USB_CDC_NCM_NTB16_FORMAT,
+					       iface_no, NULL, 0);
+		}
+		if (err < 0) {
+			ctx->is_ndp16 = 1;
 			dev_err(&dev->intf->dev, "SET_NTB_FORMAT failed\n");
+		}
 	}
 
 	/* set initial device values */
@@ -551,7 +578,10 @@ static int cdc_ncm_init(struct usbnet *dev)
 		ctx->tx_max_datagrams = CDC_NCM_DPT_DATAGRAMS_MAX;
 
 	/* set up maximum NDP size */
-	ctx->max_ndp_size = sizeof(struct usb_cdc_ncm_ndp16) + (ctx->tx_max_datagrams + 1) * sizeof(struct usb_cdc_ncm_dpe16);
+	if (ctx->is_ndp16)
+		ctx->max_ndp_size = sizeof(struct usb_cdc_ncm_ndp16) + (ctx->tx_max_datagrams + 1) * sizeof(struct usb_cdc_ncm_dpe16);
+	else
+		ctx->max_ndp_size = sizeof(struct usb_cdc_ncm_ndp32) + (ctx->tx_max_datagrams + 1) * sizeof(struct usb_cdc_ncm_dpe32);
 
 	/* initial coalescing timer interval */
 	ctx->timer_interval = CDC_NCM_TIMER_INTERVAL_USEC * NSEC_PER_USEC;
@@ -736,7 +766,10 @@ static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
 		ctx->tx_curr_skb = NULL;
 	}
 
-	kfree(ctx->delayed_ndp16);
+	if (ctx->is_ndp16)
+		kfree(ctx->delayed_ndp16);
+	else
+		kfree(ctx->delayed_ndp32);
 
 	kfree(ctx);
 }
@@ -774,10 +807,8 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	u8 *buf;
 	int len;
 	int temp;
-	int err;
 	u8 iface_no;
 	struct usb_cdc_parsed_header hdr;
-	__le16 curr_ntb_format;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -881,32 +912,6 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 		goto error2;
 	}
 
-	/*
-	 * Some Huawei devices have been observed to come out of reset in NDP32 mode.
-	 * Let's check if this is the case, and set the device to NDP16 mode again if
-	 * needed.
-	*/
-	if (ctx->drvflags & CDC_NCM_FLAG_RESET_NTB16) {
-		err = usbnet_read_cmd(dev, USB_CDC_GET_NTB_FORMAT,
-				      USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
-				      0, iface_no, &curr_ntb_format, 2);
-		if (err < 0) {
-			goto error2;
-		}
-
-		if (curr_ntb_format == cpu_to_le16(USB_CDC_NCM_NTB32_FORMAT)) {
-			dev_info(&intf->dev, "resetting NTB format to 16-bit");
-			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
-					       USB_TYPE_CLASS | USB_DIR_OUT
-					       | USB_RECIP_INTERFACE,
-					       USB_CDC_NCM_NTB16_FORMAT,
-					       iface_no, NULL, 0);
-
-			if (err < 0)
-				goto error2;
-		}
-	}
-
 	cdc_ncm_find_endpoints(dev, ctx->data);
 	cdc_ncm_find_endpoints(dev, ctx->control);
 	if (!dev->in || !dev->out || !dev->status) {
@@ -931,9 +936,15 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 
 	/* Allocate the delayed NDP if needed. */
 	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
-		ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
-		if (!ctx->delayed_ndp16)
-			goto error2;
+		if (ctx->is_ndp16) {
+			ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp16)
+				goto error2;
+		} else {
+			ctx->delayed_ndp32 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp32)
+				goto error2;
+		}
 		dev_info(&intf->dev, "NDP will be placed at end of frame for this device.");
 	}
 
@@ -1057,7 +1068,7 @@ static void cdc_ncm_align_tail(struct sk_buff *skb, size_t modulus, size_t remai
 /* return a pointer to a valid struct usb_cdc_ncm_ndp16 of type sign, possibly
  * allocating a new one within skb
  */
-static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp(struct cdc_ncm_ctx *ctx, struct sk_buff *skb, __le32 sign, size_t reserve)
+static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp16(struct cdc_ncm_ctx *ctx, struct sk_buff *skb, __le32 sign, size_t reserve)
 {
 	struct usb_cdc_ncm_ndp16 *ndp16 = NULL;
 	struct usb_cdc_ncm_nth16 *nth16 = (void *)skb->data;
@@ -1112,12 +1123,73 @@ static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp(struct cdc_ncm_ctx *ctx, struct sk_
 	return ndp16;
 }
 
+static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct sk_buff *skb, __le32 sign, size_t reserve)
+{
+	struct usb_cdc_ncm_ndp32 *ndp32 = NULL;
+	struct usb_cdc_ncm_nth32 *nth32 = (void *)skb->data;
+	size_t ndpoffset = le32_to_cpu(nth32->dwNdpIndex);
+
+	/* If NDP should be moved to the end of the NCM package, we can't follow the
+	 * NTH32 header as we would normally do. NDP isn't written to the SKB yet, and
+	 * the wNdpIndex field in the header is actually not consistent with reality. It will be later.
+	 */
+	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
+		if (ctx->delayed_ndp32->dwSignature == sign)
+			return ctx->delayed_ndp32;
+
+		/* We can only push a single NDP to the end. Return
+		 * NULL to send what we've already got and queue this
+		 * skb for later.
+		 */
+		else if (ctx->delayed_ndp32->dwSignature)
+			return NULL;
+	}
+
+	/* follow the chain of NDPs, looking for a match */
+	while (ndpoffset) {
+		ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb->data + ndpoffset);
+		if  (ndp32->dwSignature == sign)
+			return ndp32;
+		ndpoffset = le32_to_cpu(ndp32->dwNextNdpIndex);
+	}
+
+	/* align new NDP */
+	if (!(ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END))
+		cdc_ncm_align_tail(skb, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size);
+
+	/* verify that there is room for the NDP and the datagram (reserve) */
+	if ((ctx->tx_curr_size - skb->len - reserve) < ctx->max_ndp_size)
+		return NULL;
+
+	/* link to it */
+	if (ndp32)
+		ndp32->dwNextNdpIndex = cpu_to_le32(skb->len);
+	else
+		nth32->dwNdpIndex = cpu_to_le32(skb->len);
+
+	/* push a new empty NDP */
+	if (!(ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END))
+		ndp32 = skb_put_zero(skb, ctx->max_ndp_size);
+	else
+		ndp32 = ctx->delayed_ndp32;
+
+	ndp32->dwSignature = sign;
+	ndp32->wLength = cpu_to_le32(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
+	return ndp32;
+}
+
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
-	struct usb_cdc_ncm_nth16 *nth16;
-	struct usb_cdc_ncm_ndp16 *ndp16;
+	union {
+		struct usb_cdc_ncm_nth16 *nth16;
+		struct usb_cdc_ncm_nth32 *nth32;
+	} nth;
+	union {
+		struct usb_cdc_ncm_ndp16 *ndp16;
+		struct usb_cdc_ncm_ndp32 *ndp32;
+	} ndp;
 	struct sk_buff *skb_out;
 	u16 n = 0, index, ndplen;
 	u8 ready2send = 0;
@@ -1184,11 +1256,19 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			}
 			ctx->tx_low_mem_val--;
 		}
-		/* fill out the initial 16-bit NTB header */
-		nth16 = skb_put_zero(skb_out, sizeof(struct usb_cdc_ncm_nth16));
-		nth16->dwSignature = cpu_to_le32(USB_CDC_NCM_NTH16_SIGN);
-		nth16->wHeaderLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16));
-		nth16->wSequence = cpu_to_le16(ctx->tx_seq++);
+		if (ctx->is_ndp16) {
+			/* fill out the initial 16-bit NTB header */
+			nth.nth16 = skb_put_zero(skb_out, sizeof(struct usb_cdc_ncm_nth16));
+			nth.nth16->dwSignature = cpu_to_le32(USB_CDC_NCM_NTH16_SIGN);
+			nth.nth16->wHeaderLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16));
+			nth.nth16->wSequence = cpu_to_le16(ctx->tx_seq++);
+		} else {
+			/* fill out the initial 32-bit NTB header */
+			nth.nth32 = skb_put_zero(skb_out, sizeof(struct usb_cdc_ncm_nth32));
+			nth.nth32->dwSignature = cpu_to_le32(USB_CDC_NCM_NTH32_SIGN);
+			nth.nth32->wHeaderLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_nth32));
+			nth.nth32->wSequence = cpu_to_le16(ctx->tx_seq++);
+		}
 
 		/* count total number of frames in this NTB */
 		ctx->tx_curr_frame_num = 0;
@@ -1210,13 +1290,17 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 		}
 
 		/* get the appropriate NDP for this skb */
-		ndp16 = cdc_ncm_ndp(ctx, skb_out, sign, skb->len + ctx->tx_modulus + ctx->tx_remainder);
+		if (ctx->is_ndp16)
+			ndp.ndp16 = cdc_ncm_ndp16(ctx, skb_out, sign, skb->len + ctx->tx_modulus + ctx->tx_remainder);
+		else
+			ndp.ndp32 = cdc_ncm_ndp32(ctx, skb_out, sign, skb->len + ctx->tx_modulus + ctx->tx_remainder);
 
 		/* align beginning of next frame */
 		cdc_ncm_align_tail(skb_out,  ctx->tx_modulus, ctx->tx_remainder, ctx->tx_curr_size);
 
 		/* check if we had enough room left for both NDP and frame */
-		if (!ndp16 || skb_out->len + skb->len + delayed_ndp_size > ctx->tx_curr_size) {
+		if ((ctx->is_ndp16 && !ndp.ndp16) || (!ctx->is_ndp16 && !ndp.ndp32) ||
+		    skb_out->len + skb->len + delayed_ndp_size > ctx->tx_curr_size) {
 			if (n == 0) {
 				/* won't fit, MTU problem? */
 				dev_kfree_skb_any(skb);
@@ -1238,13 +1322,22 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 		}
 
 		/* calculate frame number withing this NDP */
-		ndplen = le16_to_cpu(ndp16->wLength);
-		index = (ndplen - sizeof(struct usb_cdc_ncm_ndp16)) / sizeof(struct usb_cdc_ncm_dpe16) - 1;
+		if (ctx->is_ndp16) {
+			ndplen = le16_to_cpu(ndp.ndp16->wLength);
+			index = (ndplen - sizeof(struct usb_cdc_ncm_ndp16)) / sizeof(struct usb_cdc_ncm_dpe16) - 1;
+
+			/* OK, add this skb */
+			ndp.ndp16->dpe16[index].wDatagramLength = cpu_to_le16(skb->len);
+			ndp.ndp16->dpe16[index].wDatagramIndex = cpu_to_le16(skb_out->len);
+			ndp.ndp16->wLength = cpu_to_le16(ndplen + sizeof(struct usb_cdc_ncm_dpe16));
+		} else {
+			ndplen = le16_to_cpu(ndp.ndp32->wLength);
+			index = (ndplen - sizeof(struct usb_cdc_ncm_ndp32)) / sizeof(struct usb_cdc_ncm_dpe32) - 1;
 
-		/* OK, add this skb */
-		ndp16->dpe16[index].wDatagramLength = cpu_to_le16(skb->len);
-		ndp16->dpe16[index].wDatagramIndex = cpu_to_le16(skb_out->len);
-		ndp16->wLength = cpu_to_le16(ndplen + sizeof(struct usb_cdc_ncm_dpe16));
+			ndp.ndp32->dpe32[index].dwDatagramLength = cpu_to_le32(skb->len);
+			ndp.ndp32->dpe32[index].dwDatagramIndex = cpu_to_le32(skb_out->len);
+			ndp.ndp32->wLength = cpu_to_le16(ndplen + sizeof(struct usb_cdc_ncm_dpe32));
+		}
 		skb_put_data(skb_out, skb->data, skb->len);
 		ctx->tx_curr_frame_payload += skb->len;	/* count real tx payload data */
 		dev_kfree_skb_any(skb);
@@ -1291,13 +1384,22 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 
 	/* If requested, put NDP at end of frame. */
 	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
-		nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
-		cdc_ncm_align_tail(skb_out, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size - ctx->max_ndp_size);
-		nth16->wNdpIndex = cpu_to_le16(skb_out->len);
-		skb_put_data(skb_out, ctx->delayed_ndp16, ctx->max_ndp_size);
+		if (ctx->is_ndp16) {
+			nth.nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
+			cdc_ncm_align_tail(skb_out, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size - ctx->max_ndp_size);
+			nth.nth16->wNdpIndex = cpu_to_le16(skb_out->len);
+			skb_put_data(skb_out, ctx->delayed_ndp16, ctx->max_ndp_size);
+
+			/* Zero out delayed NDP - signature checking will naturally fail. */
+			ndp.ndp16 = memset(ctx->delayed_ndp16, 0, ctx->max_ndp_size);
+		} else {
+			nth.nth32 = (struct usb_cdc_ncm_nth32 *)skb_out->data;
+			cdc_ncm_align_tail(skb_out, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size - ctx->max_ndp_size);
+			nth.nth32->dwNdpIndex = cpu_to_le32(skb_out->len);
+			skb_put_data(skb_out, ctx->delayed_ndp32, ctx->max_ndp_size);
 
-		/* Zero out delayed NDP - signature checking will naturally fail. */
-		ndp16 = memset(ctx->delayed_ndp16, 0, ctx->max_ndp_size);
+			ndp.ndp32 = memset(ctx->delayed_ndp32, 0, ctx->max_ndp_size);
+		}
 	}
 
 	/* If collected data size is less or equal ctx->min_tx_pkt
@@ -1320,8 +1422,13 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 	}
 
 	/* set final frame length */
-	nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
-	nth16->wBlockLength = cpu_to_le16(skb_out->len);
+	if (ctx->is_ndp16) {
+		nth.nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
+		nth.nth16->wBlockLength = cpu_to_le16(skb_out->len);
+	} else {
+		nth.nth32 = (struct usb_cdc_ncm_nth32 *)skb_out->data;
+		nth.nth32->dwBlockLength = cpu_to_le32(skb_out->len);
+	}
 
 	/* return skb */
 	ctx->tx_curr_skb = NULL;
@@ -1404,7 +1511,12 @@ cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 		goto error;
 
 	spin_lock_bh(&ctx->mtx);
-	skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN));
+
+	if (ctx->is_ndp16)
+		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN));
+	else
+		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP32_NOCRC_SIGN));
+
 	spin_unlock_bh(&ctx->mtx);
 	return skb_out;
 
@@ -1465,6 +1577,54 @@ int cdc_ncm_rx_verify_nth16(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in)
 }
 EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_nth16);
 
+int cdc_ncm_rx_verify_nth32(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in)
+{
+	struct usbnet *dev = netdev_priv(skb_in->dev);
+	struct usb_cdc_ncm_nth32 *nth32;
+	int len;
+	int ret = -EINVAL;
+
+	if (ctx == NULL)
+		goto error;
+
+	if (skb_in->len < (sizeof(struct usb_cdc_ncm_nth32) +
+					sizeof(struct usb_cdc_ncm_ndp32))) {
+		netif_dbg(dev, rx_err, dev->net, "frame too short\n");
+		goto error;
+	}
+
+	nth32 = (struct usb_cdc_ncm_nth32 *)skb_in->data;
+
+	if (nth32->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH32_SIGN)) {
+		netif_dbg(dev, rx_err, dev->net,
+			  "invalid NTH32 signature <%#010x>\n",
+			  le32_to_cpu(nth32->dwSignature));
+		goto error;
+	}
+
+	len = le32_to_cpu(nth32->dwBlockLength);
+	if (len > ctx->rx_max) {
+		netif_dbg(dev, rx_err, dev->net,
+			  "unsupported NTB block length %u/%u\n", len,
+			  ctx->rx_max);
+		goto error;
+	}
+
+	if ((ctx->rx_seq + 1) != le16_to_cpu(nth32->wSequence) &&
+	    (ctx->rx_seq || le16_to_cpu(nth32->wSequence)) &&
+	    !((ctx->rx_seq == 0xffff) && !le16_to_cpu(nth32->wSequence))) {
+		netif_dbg(dev, rx_err, dev->net,
+			  "sequence number glitch prev=%d curr=%d\n",
+			  ctx->rx_seq, le16_to_cpu(nth32->wSequence));
+	}
+	ctx->rx_seq = le16_to_cpu(nth32->wSequence);
+
+	ret = le32_to_cpu(nth32->dwNdpIndex);
+error:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_nth32);
+
 /* verify NDP header and return number of datagrams, or negative error */
 int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 {
@@ -1501,6 +1661,42 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 }
 EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp16);
 
+/* verify NDP header and return number of datagrams, or negative error */
+int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
+{
+	struct usbnet *dev = netdev_priv(skb_in->dev);
+	struct usb_cdc_ncm_ndp32 *ndp32;
+	int ret = -EINVAL;
+
+	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
+		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
+			  ndpoffset);
+		goto error;
+	}
+	ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb_in->data + ndpoffset);
+
+	if (le16_to_cpu(ndp32->wLength) < USB_CDC_NCM_NDP32_LENGTH_MIN) {
+		netif_dbg(dev, rx_err, dev->net, "invalid DPT32 length <%u>\n",
+			  le16_to_cpu(ndp32->wLength));
+		goto error;
+	}
+
+	ret = ((le16_to_cpu(ndp32->wLength) -
+					sizeof(struct usb_cdc_ncm_ndp32)) /
+					sizeof(struct usb_cdc_ncm_dpe32));
+	ret--; /* we process NDP entries except for the last one */
+
+	if ((sizeof(struct usb_cdc_ncm_ndp32) +
+	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
+		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
+		ret = -EINVAL;
+	}
+
+error:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp32);
+
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
@@ -1509,34 +1705,66 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 	int nframes;
 	int x;
 	int offset;
-	struct usb_cdc_ncm_ndp16 *ndp16;
-	struct usb_cdc_ncm_dpe16 *dpe16;
+	union {
+		struct usb_cdc_ncm_ndp16 *ndp16;
+		struct usb_cdc_ncm_ndp32 *ndp32;
+	} ndp;
+	union {
+		struct usb_cdc_ncm_dpe16 *dpe16;
+		struct usb_cdc_ncm_dpe32 *dpe32;
+	} dpe;
+
 	int ndpoffset;
 	int loopcount = 50; /* arbitrary max preventing infinite loop */
 	u32 payload = 0;
 
-	ndpoffset = cdc_ncm_rx_verify_nth16(ctx, skb_in);
+	if (ctx->is_ndp16)
+		ndpoffset = cdc_ncm_rx_verify_nth16(ctx, skb_in);
+	else
+		ndpoffset = cdc_ncm_rx_verify_nth32(ctx, skb_in);
+
 	if (ndpoffset < 0)
 		goto error;
 
 next_ndp:
-	nframes = cdc_ncm_rx_verify_ndp16(skb_in, ndpoffset);
-	if (nframes < 0)
-		goto error;
+	if (ctx->is_ndp16) {
+		nframes = cdc_ncm_rx_verify_ndp16(skb_in, ndpoffset);
+		if (nframes < 0)
+			goto error;
 
-	ndp16 = (struct usb_cdc_ncm_ndp16 *)(skb_in->data + ndpoffset);
+		ndp.ndp16 = (struct usb_cdc_ncm_ndp16 *)(skb_in->data + ndpoffset);
 
-	if (ndp16->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
-		netif_dbg(dev, rx_err, dev->net,
-			  "invalid DPT16 signature <%#010x>\n",
-			  le32_to_cpu(ndp16->dwSignature));
-		goto err_ndp;
+		if (ndp.ndp16->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
+			netif_dbg(dev, rx_err, dev->net,
+				  "invalid DPT16 signature <%#010x>\n",
+				  le32_to_cpu(ndp.ndp16->dwSignature));
+			goto err_ndp;
+		}
+		dpe.dpe16 = ndp.ndp16->dpe16;
+	} else {
+		nframes = cdc_ncm_rx_verify_ndp32(skb_in, ndpoffset);
+		if (nframes < 0)
+			goto error;
+
+		ndp.ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb_in->data + ndpoffset);
+
+		if (ndp.ndp32->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP32_NOCRC_SIGN)) {
+			netif_dbg(dev, rx_err, dev->net,
+				  "invalid DPT32 signature <%#010x>\n",
+				  le32_to_cpu(ndp.ndp32->dwSignature));
+			goto err_ndp;
+		}
+		dpe.dpe32 = ndp.ndp32->dpe32;
 	}
-	dpe16 = ndp16->dpe16;
 
-	for (x = 0; x < nframes; x++, dpe16++) {
-		offset = le16_to_cpu(dpe16->wDatagramIndex);
-		len = le16_to_cpu(dpe16->wDatagramLength);
+	for (x = 0; x < nframes; x++) {
+		if (ctx->is_ndp16) {
+			offset = le16_to_cpu(dpe.dpe16->wDatagramIndex);
+			len = le16_to_cpu(dpe.dpe16->wDatagramLength);
+		} else {
+			offset = le32_to_cpu(dpe.dpe32->dwDatagramIndex);
+			len = le32_to_cpu(dpe.dpe32->dwDatagramLength);
+		}
 
 		/*
 		 * CDC NCM ch. 3.7
@@ -1567,10 +1795,19 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 			usbnet_skb_return(dev, skb);
 			payload += len;	/* count payload bytes in this NTB */
 		}
+
+		if (ctx->is_ndp16)
+			dpe.dpe16++;
+		else
+			dpe.dpe32++;
 	}
 err_ndp:
 	/* are there more NDPs to process? */
-	ndpoffset = le16_to_cpu(ndp16->wNextNdpIndex);
+	if (ctx->is_ndp16)
+		ndpoffset = le16_to_cpu(ndp.ndp16->wNextNdpIndex);
+	else
+		ndpoffset = le32_to_cpu(ndp.ndp32->dwNextNdpIndex);
+
 	if (ndpoffset && loopcount--)
 		goto next_ndp;
 
diff --git a/drivers/net/usb/huawei_cdc_ncm.c b/drivers/net/usb/huawei_cdc_ncm.c
index e15a472c6a54c..099d848270042 100644
--- a/drivers/net/usb/huawei_cdc_ncm.c
+++ b/drivers/net/usb/huawei_cdc_ncm.c
@@ -77,11 +77,11 @@ static int huawei_cdc_ncm_bind(struct usbnet *usbnet_dev,
 	 */
 	drvflags |= CDC_NCM_FLAG_NDP_TO_END;
 
-	/* Additionally, it has been reported that some Huawei E3372H devices, with
-	 * firmware version 21.318.01.00.541, come out of reset in NTB32 format mode, hence
-	 * needing to be set to the NTB16 one again.
+	/* For many Huawei devices the NTB32 mode is the default and the best mode
+	 * they work with. Huawei E5785 and E5885 devices refuse to work in NTB16 mode at all.
 	 */
-	drvflags |= CDC_NCM_FLAG_RESET_NTB16;
+	drvflags |= CDC_NCM_FLAG_PREFER_NTB32;
+
 	ret = cdc_ncm_bind_common(usbnet_dev, intf, 1, drvflags);
 	if (ret)
 		goto err;
diff --git a/include/linux/usb/cdc_ncm.h b/include/linux/usb/cdc_ncm.h
index 1646c06989df7..0ce4377545f82 100644
--- a/include/linux/usb/cdc_ncm.h
+++ b/include/linux/usb/cdc_ncm.h
@@ -46,9 +46,12 @@
 #define CDC_NCM_DATA_ALTSETTING_NCM		1
 #define CDC_NCM_DATA_ALTSETTING_MBIM		2
 
-/* CDC NCM subclass 3.2.1 */
+/* CDC NCM subclass 3.3.1 */
 #define USB_CDC_NCM_NDP16_LENGTH_MIN		0x10
 
+/* CDC NCM subclass 3.3.2 */
+#define USB_CDC_NCM_NDP32_LENGTH_MIN		0x20
+
 /* Maximum NTB length */
 #define	CDC_NCM_NTB_MAX_SIZE_TX			32768	/* bytes */
 #define	CDC_NCM_NTB_MAX_SIZE_RX			32768	/* bytes */
@@ -84,7 +87,7 @@
 /* Driver flags */
 #define CDC_NCM_FLAG_NDP_TO_END			0x02	/* NDP is placed at end of frame */
 #define CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE	0x04	/* Avoid altsetting toggle during init */
-#define CDC_NCM_FLAG_RESET_NTB16 0x08	/* set NDP16 one more time after altsetting switch */
+#define CDC_NCM_FLAG_PREFER_NTB32 0x08	/* prefer NDP32 over NDP16 */
 
 #define cdc_ncm_comm_intf_is_mbim(x)  ((x)->desc.bInterfaceSubClass == USB_CDC_SUBCLASS_MBIM && \
 				       (x)->desc.bInterfaceProtocol == USB_CDC_PROTO_NONE)
@@ -113,7 +116,11 @@ struct cdc_ncm_ctx {
 
 	u32 timer_interval;
 	u32 max_ndp_size;
-	struct usb_cdc_ncm_ndp16 *delayed_ndp16;
+	u8 is_ndp16;
+	union {
+		struct usb_cdc_ncm_ndp16 *delayed_ndp16;
+		struct usb_cdc_ncm_ndp32 *delayed_ndp32;
+	};
 
 	u32 tx_timer_pending;
 	u32 tx_curr_frame_num;
@@ -150,6 +157,8 @@ void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf);
 struct sk_buff *cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign);
 int cdc_ncm_rx_verify_nth16(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in);
 int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset);
+int cdc_ncm_rx_verify_nth32(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in);
+int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset);
 struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags);
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in);
-- 
2.39.2



