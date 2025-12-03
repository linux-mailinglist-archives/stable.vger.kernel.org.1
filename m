Return-Path: <stable+bounces-199803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97BCA0C37
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375CA30EED1E
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CC93563D6;
	Wed,  3 Dec 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMMCSSPh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98F357A3E;
	Wed,  3 Dec 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780994; cv=none; b=VQtUa11R6dXDHg9CR8MPd09q8GTsj0WhRoz+CltioHULvGdDs/v5T/FCX4X5Q/d36mZhCcDcA48u2JK847FEkXShvDUdagdvJAuJdC3b/j9bbtrzSSDLSRE9FhjGHohtGKcoxq1eucNC8qCilKTyYdXrxNeVOnWGg2vZCY0Klek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780994; c=relaxed/simple;
	bh=dSj8Iy7ZctvRrJW0++/SaYyJcdmUT7R/PEIcVSJxLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL59vK7n+P/ezlwW0zklWVT/n1ZFqCPQI806jvkbPn8fqLM21f0RQ+drUmhbUJH5wdyyU0JDc4fkM8MTS6oB/wXooWZWdu/fEehwFaV+WHcuX8zUzwM+MD/42d5OG+MfsK4xIKkWs+4RIZDfv2mcWUunuLhikriRVuVsLSkJyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMMCSSPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702DDC4CEF5;
	Wed,  3 Dec 2025 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780993;
	bh=dSj8Iy7ZctvRrJW0++/SaYyJcdmUT7R/PEIcVSJxLUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMMCSSPhy38lFiGwP5D675y4FVd6/iGFCK/BPoGZHXz4LkUl+aBP5Fqm6PT0JmcG6
	 Di/Dags0jbGrMUBqjPbiK5jqH2jNHNnB1Hs/olUNBiKvQb03VCyDfxpzWbhCSnrClT
	 DRiOepjIiGlR1Z6eoL6Y/snSCRazbSa4NUaITQlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/93] can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
Date: Wed,  3 Dec 2025 16:28:56 +0100
Message-ID: <20251203152336.627185598@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
References: <20251203152336.494201426@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 6fe9f3279f7d2518439a7962c5870c6e9ecbadcf ]

The driver expects to receive a struct gs_host_frame in
gs_usb_receive_bulk_callback().

Use struct_group to describe the header of the struct gs_host_frame and
check that we have at least received the header before accessing any
members of it.

To resubmit the URB, do not dereference the pointer chain
"dev->parent->hf_size_rx" but use "parent->hf_size_rx" instead. Since
"urb->context" contains "parent", it is always defined, while "dev" is not
defined if the URB it too short.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Link: https://patch.msgid.link/20251114-gs_usb-fix-usb-callbacks-v1-2-a29b42eacada@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1ba6395a5a667..e786616d167b8 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -259,13 +259,15 @@ struct canfd_quirk {
 } __packed;
 
 struct gs_host_frame {
-	u32 echo_id;
-	__le32 can_id;
+	struct_group(header,
+		u32 echo_id;
+		__le32 can_id;
 
-	u8 can_dlc;
-	u8 channel;
-	u8 flags;
-	u8 reserved;
+		u8 can_dlc;
+		u8 channel;
+		u8 flags;
+		u8 reserved;
+	);
 
 	union {
 		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
@@ -573,6 +575,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
+	unsigned int minimum_length;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -591,6 +594,15 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		return;
 	}
 
+	minimum_length = sizeof(hf->header);
+	if (urb->actual_length < minimum_length) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "short read (actual_length=%u, minimum_length=%u)\n",
+				    urb->actual_length, minimum_length);
+
+		goto resubmit_urb;
+	}
+
 	/* device reports out of range channel id */
 	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
@@ -684,7 +696,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
 			  parent->pipe_in,
-			  hf, dev->parent->hf_size_rx,
+			  hf, parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.51.0




