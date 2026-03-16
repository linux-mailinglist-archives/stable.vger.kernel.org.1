Return-Path: <stable+bounces-225657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E+9HcFNuGlHbwEAu9opvQ
	(envelope-from <stable+bounces-225657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B079C29F1DB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F23DF303C28A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF563292936;
	Mon, 16 Mar 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY5ZISRI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E333A9D3
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686095; cv=none; b=l2zPvuUI7ulXBtdswd9By9t7PKAbAHuJZW1uNFBtiQff3sPNcYtvP/Z2oUzqXUR1lHPNzyEH1uOVU2ZScxi+9kZ+B5c6nGcLzTYfyopBe2S8Iu20rh99qOi9F07WESWihI/AuobEM4wZ8/Lud0XX0zwRXqbYazIJLZv0hYe07WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686095; c=relaxed/simple;
	bh=HqWm2bgX/gK3H9/EMIAXY2CiTkopaY0jur+QA7YYJ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax10FrQh8s0IKrSadrXfkhvVedBiezMALQZKj3X3+YIbwBVIjo2nfePJgtHJTH4KOX7IV5YkmSQ3R6W/PkqFgSeyVNa0FqG771+m3FkVRXqGAdJku1WFYp3ugbHGZgNfCzWLZOOyPdfqnghAlTYruVd+ymShITafoXfPs7MBtD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY5ZISRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38D3C19421;
	Mon, 16 Mar 2026 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773686095;
	bh=HqWm2bgX/gK3H9/EMIAXY2CiTkopaY0jur+QA7YYJ98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UY5ZISRIZl7B+4rGrnQFJepaSBMPO2O1Z2M7FRNyZbIpNwNYoTpLVggPv47sAkB1p
	 i7MyiYQVqgY+5SnN/vozTBRnwk8bv3O+6r/hQ5CtZlkoJFhjHJDjdGYTB4Ix/R3eY3
	 W8AX1gvwqUkbQPyr2FCgmgK16TmahMcZxXtDx7v1nGOJnAeVLzpmx0/N1gf9P+5ZGY
	 U48MNCXqprcSJQRs2Qof2NaHra+yYSy59HrAR4yf6OAy+Fo/mj8VgVPWyZ75LrVdNs
	 vXVLMI3kbLxcvTH+6RsawSbgL9Ta9V4CdVsXj5ajcpcjZeG4FlHa+CyEKsBoHMtzuv
	 Db1kzkCuD/t/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] can: gs_usb: gs_can_open(): always configure bitrates before starting device
Date: Mon, 16 Mar 2026 14:34:53 -0400
Message-ID: <20260316183453.1075555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031635-starved-nervy-a49c@gregkh>
References: <2026031635-starved-nervy-a49c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225657-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: B079C29F1DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 2df6162785f31f1bbb598cfc3b08e4efc88f80b6 ]

So far the driver populated the struct can_priv::do_set_bittiming() and
struct can_priv::fd::do_set_data_bittiming() callbacks.

Before bringing up the interface, user space has to configure the bitrates.
With these callbacks the configuration is directly forwarded into the CAN
hardware. Then the interface can be brought up.

An ifdown-ifup cycle (without changing the bit rates) doesn't re-configure
the bitrates in the CAN hardware. This leads to a problem with the
CANable-2.5 [1] firmware, which resets the configured bit rates during
ifdown.

To fix the problem remove both bit timing callbacks and always configure
the bitrates in the struct net_device_ops::ndo_open() callback.

[1] https://github.com/Elmue/CANable-2.5-firmware-Slcan-and-Candlelight

Cc: stable@vger.kernel.org
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Link: https://patch.msgid.link/20260219-gs_usb-always-configure-bitrates-v2-1-671f8ba5b0a5@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ adapted to different structure of the struct ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 8859e65d4470b..220496b76cd94 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -678,9 +678,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 }
 
-static int gs_usb_set_bittiming(struct net_device *netdev)
+static int gs_usb_set_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -698,9 +697,8 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 				    GFP_KERNEL);
 }
 
-static int gs_usb_set_data_bittiming(struct net_device *netdev)
+static int gs_usb_set_data_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -961,6 +959,20 @@ static int gs_can_open(struct net_device *netdev)
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_MODE_HW_TIMESTAMP;
 
+	rc = gs_usb_set_bittiming(dev);
+	if (rc) {
+		netdev_err(netdev, "failed to set bittiming: %pe\n", ERR_PTR(rc));
+		goto out_usb_kill_anchored_urbs;
+	}
+
+	if (ctrlmode & CAN_CTRLMODE_FD) {
+		rc = gs_usb_set_data_bittiming(dev);
+		if (rc) {
+			netdev_err(netdev, "failed to set data bittiming: %pe\n", ERR_PTR(rc));
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	/* start polling timestamp */
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		gs_usb_timestamp_init(dev);
@@ -1231,7 +1243,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.state = CAN_STATE_STOPPED;
 	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
-	dev->can.do_set_bittiming = gs_usb_set_bittiming;
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
@@ -1255,7 +1266,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
 		dev->can.data_bittiming_const = &dev->bt_const;
-		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {
-- 
2.51.0


