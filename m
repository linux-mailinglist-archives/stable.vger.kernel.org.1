Return-Path: <stable+bounces-212470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODo9Gaczeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0368A5081
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BB8830A221B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DC30E834;
	Wed, 28 Jan 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uEoZIIsZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3012F25EF;
	Wed, 28 Jan 2026 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615628; cv=none; b=PSoHQIrMGYRJVebjsAE4FNE4Bu0jLHeB8si2imjLy0Svoyix2YE4AlPR++pLuPhl3KzeUXCrWO7Iv/wOS9wkwZ53Sj7hE2JB4iqNodqHlThwsolVkgT/tkr9LUVrLckRqyRNdSeQUKDsmcxEI8l2x5KNeluRwb/oiX9ZZT3WaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615628; c=relaxed/simple;
	bh=9KYV42BCiGA9uYUvd9Pz+SbDyk2NCwlr+7VpJe+nIJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haKUW2QKwiS7Y+aW5RPK1sG8ZXDVuiRFArLuFbZ9VQQAQTU5kD9T/r8W4FrLHKSlyZsrmBasEjDjQjf/zxai4ZzBO4/tCwTlzTTRNdmOP3Ur3LHpOl3n29EJIHh0N0lLqxIudse1IHEYOyAoBxLcrOTLcRbDQmtIpW3lanMtfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uEoZIIsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7494DC4CEF1;
	Wed, 28 Jan 2026 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615627;
	bh=9KYV42BCiGA9uYUvd9Pz+SbDyk2NCwlr+7VpJe+nIJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEoZIIsZNrUzjycl4Gc0NHvEYP/5gg9BfWvDegflnMQaRIDkvSRmsHeLsgRptjdCf
	 PnArHjpOJgGK7MpVyBiXdhffZv8+KBr0aqNh32z9A7QEEAX4ONOEa9Ak39VWYWSu6+
	 9FaQVOH0vvx07hK3J56G7yLkDMuWDfSGPUXLj7p4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 033/227] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
Date: Wed, 28 Jan 2026 16:21:18 +0100
Message-ID: <20260128145345.536281652@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212470-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: D0368A5081
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 79a6d1bfe1148bc921b8d7f3371a7fbce44e30f7 ]

In commit 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix
URB memory leak"), the URB was re-anchored before usb_submit_urb() in
gs_usb_receive_bulk_callback() to prevent a leak of this URB during
cleanup.

However, this patch did not take into account that usb_submit_urb() could
fail. The URB remains anchored and
usb_kill_anchored_urbs(&parent->rx_submitted) in gs_can_close() loops
infinitely since the anchor list never becomes empty.

To fix the bug, unanchor the URB when an usb_submit_urb() error occurs,
also print an info message.

Fixes: 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
Link: https://patch.msgid.link/20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b14b132ad8e6a..fd7fb21b10989 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -754,6 +754,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	usb_anchor_urb(urb, &parent->rx_submitted);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!rc)
+		return;
+
+	usb_unanchor_urb(urb);
 
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
@@ -762,6 +766,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
+	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
+		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
+			    ERR_PTR(urb->status));
 	}
 }
 
-- 
2.51.0




