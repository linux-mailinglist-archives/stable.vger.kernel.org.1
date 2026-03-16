Return-Path: <stable+bounces-225556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKHJM9oTuGk7YwEAu9opvQ
	(envelope-from <stable+bounces-225556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:29:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ED29B632
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FB6030233DB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2140288C39;
	Mon, 16 Mar 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSBaFgBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552C2882B6
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671326; cv=none; b=RV+AYil9tJOdAh6xx/gTNg+fnAWGDWQuFNqjn5379GhgVm0u5j1WyfXCxMkVl7YF77HCVPQk6UZhtQdeCb6mnzFMP62wdiasjuyHnipdUEiR0HLwW99liX7Kvv4wUyrx8hEbeqZaguQ1UYP2AvHritPdESggp4AjkVXI2IEnkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671326; c=relaxed/simple;
	bh=dzL39RUX7ocdaiGrpCfUJNgZ4DYpl2nMOff+076rMts=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bnjIqFWO7Q/1Synn7/msP99SlPEg5/EKNcV7bw/abd2cc5/0GkgpFyYnqWfSL79Tf1Ubopo8q7s8KWZeJaJW2J4dVPfZbiY9KmFoP62SNoqOFBbXqhWNJist4B0YDZM0vgG+GJ4/ZlB5MC01a4hZh0i+N/r18woE0QWB41CQgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSBaFgBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09DBC2BC9E;
	Mon, 16 Mar 2026 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773671326;
	bh=dzL39RUX7ocdaiGrpCfUJNgZ4DYpl2nMOff+076rMts=;
	h=Subject:To:Cc:From:Date:From;
	b=zSBaFgBD01BJXQzhba46JCDr420pZ4JMxbsse/H6a85L+4lbY+wBQs58uihJwaulH
	 uqJmGN3BFWKJKulgTLe4Uktq0tuIu7aiaGlwkTY2KmeuGMIHTRnr/M6+L+ho4iu4gS
	 G2nDrkMvgTB428Tj69mKF8mYnDvduQLTMDu2U7KQ=
Subject: FAILED: patch "[PATCH] can: gs_usb: gs_can_open(): always configure bitrates before" failed to apply to 5.15-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 15:28:35 +0100
Message-ID: <2026031635-revocable-cyclic-cf21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225556-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,pengutronix.de:email]
X-Rspamd-Queue-Id: 319ED29B632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2df6162785f31f1bbb598cfc3b08e4efc88f80b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031635-revocable-cyclic-cf21@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2df6162785f31f1bbb598cfc3b08e4efc88f80b6 Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Feb 2026 13:57:34 +0100
Subject: [PATCH] can: gs_usb: gs_can_open(): always configure bitrates before
 starting device

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

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 9d27d6f0c0b5..ec9a7cbbbc69 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -772,9 +772,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 }
 
-static int gs_usb_set_bittiming(struct net_device *netdev)
+static int gs_usb_set_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -791,9 +790,8 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 				    GFP_KERNEL);
 }
 
-static int gs_usb_set_data_bittiming(struct net_device *netdev)
+static int gs_usb_set_data_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -1057,6 +1055,20 @@ static int gs_can_open(struct net_device *netdev)
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
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -1370,7 +1382,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.state = CAN_STATE_STOPPED;
 	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
-	dev->can.do_set_bittiming = gs_usb_set_bittiming;
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
@@ -1394,7 +1405,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
 		dev->can.fd.data_bittiming_const = &dev->bt_const;
-		dev->can.fd.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {


