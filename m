Return-Path: <stable+bounces-220568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF2BJaA9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:10:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F20CB1C6AA2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848A034A8D38
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379243DBD27;
	Sat, 28 Feb 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb0hqDEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC13DBD20;
	Sat, 28 Feb 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300450; cv=none; b=PK0hqu5xvNWHO3dTn+qMDWI41v6G3wrz2ii1bBFb3FAl/KdnIPzFzBbIlyWK0nG/Nbq2bKQps5391lqBfRoy39mpIFE8zw5iyBTAB76KakbqPX4IBRHxWsI8VX/ocgf/vtkuB8eg4sIOChkK7nNe3elKsgAt1Apm3tWuQXme3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300450; c=relaxed/simple;
	bh=4VyEYONTL+TgY1a7SDXvB0Bl/lU4+G5iJWVq4kmxXU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uum6VgTdex2paMvuKGcj89ic2BI5lk1vb+CMZ0txHP+/ek+og450+4/CStcyBQQsYryoLcxz8DxT8bQEyD97y80yMnp3Qu3IOLqGFVcv80+4qgNg+8lC8wyqcBsP8nqssROvifM4f5NSSWWaRzN2ftZGlM2fjCLHNoKchGLv51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb0hqDEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B8C19424;
	Sat, 28 Feb 2026 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300449;
	bh=4VyEYONTL+TgY1a7SDXvB0Bl/lU4+G5iJWVq4kmxXU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cb0hqDEYS/XvtShnmBkudVBEmVR1w5dRHBOBT+yeVUmkbTYejgqJ5X0YP0WG2i2MM
	 /JvDYXIkGoaZqFFKBY4rnayIfUtBsuXJrfadKwqerYPZXK6i7tbnjtGOkz6hFZW3tw
	 ULkTGaxnJh36WA/KfAzmaufRROhmKaptVrrLcgTn9/BpCA3s1fB4GFLIpsv1H85oaB
	 XvgN4fnYini2a5CbMNNi0rrmEMKaRuwwFZMwlMGDmjMMOUlIXH2HuXYVcTweot+LsQ
	 HNiFNbQtu+C9Gjw/UlUJwLnkrdZcJiI8+XOGYz0tQAmAVAAm1FSiOTRwPy9VoHoF2y
	 RsyXEiegEJtBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 489/844] net: usb: pegasus: enable basic endpoint checking
Date: Sat, 28 Feb 2026 12:26:42 -0500
Message-ID: <20260228173244.1509663-490-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220568-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,northwestern.edu:email]
X-Rspamd-Queue-Id: F20CB1C6AA2
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 3d7e6ce34f4fcc7083510c28b17a7c36462a25d4 ]

pegasus_probe() fills URBs with hardcoded endpoint pipes without
verifying the endpoint descriptors:

  - usb_rcvbulkpipe(dev, 1) for RX data
  - usb_sndbulkpipe(dev, 2) for TX data
  - usb_rcvintpipe(dev, 3)  for status interrupts

A malformed USB device can present these endpoints with transfer types
that differ from what the driver assumes.

Add a pegasus_usb_ep enum for endpoint numbers, replacing magic
constants throughout. Add usb_check_bulk_endpoints() and
usb_check_int_endpoints() calls before any resource allocation to
verify endpoint types before use, rejecting devices with mismatched
descriptors at probe time, and avoid triggering assertion.

Similar fix to
- commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
- commit 9e7021d2aeae ("net: usb: catc: enable basic endpoint checking")

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260222050633.410165-1-n7l8m4@u.northwestern.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/pegasus.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index c514483134f05..0f16a133c75d1 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -31,6 +31,17 @@ static const char driver_name[] = "pegasus";
 			BMSR_100FULL | BMSR_ANEGCAPABLE)
 #define CARRIER_CHECK_DELAY (2 * HZ)
 
+/*
+ * USB endpoints.
+ */
+
+enum pegasus_usb_ep {
+	PEGASUS_USB_EP_CONTROL	= 0,
+	PEGASUS_USB_EP_BULK_IN	= 1,
+	PEGASUS_USB_EP_BULK_OUT	= 2,
+	PEGASUS_USB_EP_INT_IN	= 3,
+};
+
 static bool loopback;
 static bool mii_mode;
 static char *devid;
@@ -545,7 +556,7 @@ static void read_bulk_callback(struct urb *urb)
 		goto tl_sched;
 goon:
 	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
-			  usb_rcvbulkpipe(pegasus->usb, 1),
+			  usb_rcvbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_IN),
 			  pegasus->rx_skb->data, PEGASUS_MTU,
 			  read_bulk_callback, pegasus);
 	rx_status = usb_submit_urb(pegasus->rx_urb, GFP_ATOMIC);
@@ -585,7 +596,7 @@ static void rx_fixup(struct tasklet_struct *t)
 		return;
 	}
 	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
-			  usb_rcvbulkpipe(pegasus->usb, 1),
+			  usb_rcvbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_IN),
 			  pegasus->rx_skb->data, PEGASUS_MTU,
 			  read_bulk_callback, pegasus);
 try_again:
@@ -713,7 +724,7 @@ static netdev_tx_t pegasus_start_xmit(struct sk_buff *skb,
 	((__le16 *) pegasus->tx_buff)[0] = cpu_to_le16(l16);
 	skb_copy_from_linear_data(skb, pegasus->tx_buff + 2, skb->len);
 	usb_fill_bulk_urb(pegasus->tx_urb, pegasus->usb,
-			  usb_sndbulkpipe(pegasus->usb, 2),
+			  usb_sndbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_OUT),
 			  pegasus->tx_buff, count,
 			  write_bulk_callback, pegasus);
 	if ((res = usb_submit_urb(pegasus->tx_urb, GFP_ATOMIC))) {
@@ -840,7 +851,7 @@ static int pegasus_open(struct net_device *net)
 	set_registers(pegasus, EthID, 6, net->dev_addr);
 
 	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
-			  usb_rcvbulkpipe(pegasus->usb, 1),
+			  usb_rcvbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_IN),
 			  pegasus->rx_skb->data, PEGASUS_MTU,
 			  read_bulk_callback, pegasus);
 	if ((res = usb_submit_urb(pegasus->rx_urb, GFP_KERNEL))) {
@@ -851,7 +862,7 @@ static int pegasus_open(struct net_device *net)
 	}
 
 	usb_fill_int_urb(pegasus->intr_urb, pegasus->usb,
-			 usb_rcvintpipe(pegasus->usb, 3),
+			 usb_rcvintpipe(pegasus->usb, PEGASUS_USB_EP_INT_IN),
 			 pegasus->intr_buff, sizeof(pegasus->intr_buff),
 			 intr_callback, pegasus, pegasus->intr_interval);
 	if ((res = usb_submit_urb(pegasus->intr_urb, GFP_KERNEL))) {
@@ -1136,10 +1147,24 @@ static int pegasus_probe(struct usb_interface *intf,
 	pegasus_t *pegasus;
 	int dev_index = id - pegasus_ids;
 	int res = -ENOMEM;
+	static const u8 bulk_ep_addr[] = {
+		PEGASUS_USB_EP_BULK_IN | USB_DIR_IN,
+		PEGASUS_USB_EP_BULK_OUT | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		PEGASUS_USB_EP_INT_IN | USB_DIR_IN,
+		0};
 
 	if (pegasus_blacklisted(dev))
 		return -ENODEV;
 
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(&intf->dev, "Missing or invalid endpoints\n");
+		return -ENODEV;
+	}
+
 	net = alloc_etherdev(sizeof(struct pegasus));
 	if (!net)
 		goto out;
-- 
2.51.0


