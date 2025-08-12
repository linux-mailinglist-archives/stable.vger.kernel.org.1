Return-Path: <stable+bounces-168980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6DB23798
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D980D175F6A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD826FA77;
	Tue, 12 Aug 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IdLzUrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117512882CE;
	Tue, 12 Aug 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025978; cv=none; b=cbQ1t73gU52YRQsvVVqkc+RqHS3TLUe5V+gepsnQWGBXDRCyy5sHYjFkPEdKSZU7S7JSHqx/fUFRzzAA3tsdAG1l05v8aOrN3PQeLXfhDIHarniSgGDmaZZSnOixp6RCS52kplY1giZtDMvbgF7KWUxYd9OyDDR/fsBENDDxgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025978; c=relaxed/simple;
	bh=9F9xvO0OWxnNO0bycqmbEGqeBNBvDTSWJQeWT1jHJk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnfFtB9a7u8AAfGV06IhDvE06bUsEanhlpEqKYZ4YQ+RZQoGfDN931kW5G9tAvIKwxhaHoVeidr0YaE6uDT0kb/BrW/PNVUF4KvIahwAjZWxCuwdYt5yXC3bDF8H1+HFna/tEtN3tG6AvgEEb54naQDxPaeuAJiLjG+RBKHJHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IdLzUrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3968AC4CEF1;
	Tue, 12 Aug 2025 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025976;
	bh=9F9xvO0OWxnNO0bycqmbEGqeBNBvDTSWJQeWT1jHJk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1IdLzUrIujxT7htI5wZaOCzDHf0r1OOFrW74bGW/oDyrVUVFwR6a0BmRxeeLhK4+p
	 upyZ1jwQLC6ZG/xeZJDFvKYVKMYmgNM/46EoDnHzhhKNlLtW5sD/hPZ/AR6ugVxbyJ
	 GPqfMlB1oHAt+8+kXkj/eESGVIZ+T3zCJ7If/TKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 201/480] can: peak_usb: fix USB FD devices potential malfunction
Date: Tue, 12 Aug 2025 19:46:49 +0200
Message-ID: <20250812174405.771354368@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Grosjean <stephane.grosjean@hms-networks.com>

[ Upstream commit 788199b73b6efe4ee2ade4d7457b50bb45493488 ]

The latest firmware versions of USB CAN FD interfaces export the EP numbers
to be used to dialog with the device via the "type" field of a response to
a vendor request structure, particularly when its value is greater than or
equal to 2.

Correct the driver's test of this field.

Fixes: 4f232482467a ("can: peak_usb: include support for a new MCU")
Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Link: https://patch.msgid.link/20250724081550.11694-1-stephane.grosjean@free.fr
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
[mkl: rephrase commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 4d85b29a17b7..ebefc274b50a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -49,7 +49,7 @@ struct __packed pcan_ufd_fw_info {
 	__le32	ser_no;		/* S/N */
 	__le32	flags;		/* special functions */
 
-	/* extended data when type == PCAN_USBFD_TYPE_EXT */
+	/* extended data when type >= PCAN_USBFD_TYPE_EXT */
 	u8	cmd_out_ep;	/* ep for cmd */
 	u8	cmd_in_ep;	/* ep for replies */
 	u8	data_out_ep[2];	/* ep for CANx TX */
@@ -982,10 +982,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
 		}
 
-		/* if vendor rsp is of type 2, then it contains EP numbers to
-		 * use for cmds pipes. If not, then default EP should be used.
+		/* if vendor rsp type is greater than or equal to 2, then it
+		 * contains EP numbers to use for cmds pipes. If not, then
+		 * default EP should be used.
 		 */
-		if (fw_info->type != cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+		if (le16_to_cpu(fw_info->type) < PCAN_USBFD_TYPE_EXT) {
 			fw_info->cmd_out_ep = PCAN_USBPRO_EP_CMDOUT;
 			fw_info->cmd_in_ep = PCAN_USBPRO_EP_CMDIN;
 		}
@@ -1018,11 +1019,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
-	/* if vendor rsp is of type 2, then it contains EP numbers to
-	 * use for data pipes. If not, then statically defined EP are used
-	 * (see peak_usb_create_dev()).
+	/* if vendor rsp type is greater than or equal to 2, then it contains EP
+	 * numbers to use for data pipes. If not, then statically defined EP are
+	 * used (see peak_usb_create_dev()).
 	 */
-	if (fw_info->type == cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+	if (le16_to_cpu(fw_info->type) >= PCAN_USBFD_TYPE_EXT) {
 		dev->ep_msg_in = fw_info->data_in_ep;
 		dev->ep_msg_out = fw_info->data_out_ep[dev->ctrl_idx];
 	}
-- 
2.39.5




