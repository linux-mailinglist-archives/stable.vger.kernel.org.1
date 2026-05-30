Return-Path: <stable+bounces-259272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMbUOsAzG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68E612EE1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DE530D4A22
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6556231A21;
	Sat, 30 May 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEtWmj51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DE2E7389;
	Sat, 30 May 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167186; cv=none; b=jo8sQx3rtMxJgj7PH9nVDEjTmworAj6vWaVxHrqu51sBuXAZWjyx2sIjOdXAIxd1mvGWWUYNnYd7wyl006rbi/9tgHl7jfMOEWJZDKYcFyYwzL2SZr3eqxYjjDzYTAQbaAJABKjpr3qnQM37LbcGKhiSZGvC3LnMZGAnjdbSd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167186; c=relaxed/simple;
	bh=5c+mUAmKYH7lPhtVds1ezuHVKXxkGCE4mONym8SUwZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOHWlaAvzlBhYq5LpGRviqt4OEhWQVK0tYzR++VXFdxPoofbmJjHWb8xAcTRm8iiAvmHZXN4PEp73Z0JEpQTYMHzWl1e4/8HkVDKwWeCmbD3E5WAHk6CyzsXVVSf7KjyhssIRsJI6OgY5J26yNtpVukW+6Hwz9im4UhYaiC+w5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEtWmj51; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB941F00893;
	Sat, 30 May 2026 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167185;
	bh=64K7rWFtG6GpsGAQqiOclbLGvLPQ1dH9EYd0W15R8s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEtWmj51bRykbeHcWugFlSZ3B0UJSZVmNlchPnOqjyLynOyOAEgnavgFEIsNLNSYZ
	 MbQ9B2FaC4iWNhNTpmL3eQH6a34QUebvqCvIZY0cDmfEPG5dFaiqhHXlqc57se6vGL
	 OTWGOSEVsaOScfI3/x3y4EJFIBcUaZ5KEUumVtpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Efstathiades <john.efstathiades@pebblebay.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 589/589] net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
Date: Sat, 30 May 2026 18:07:50 +0200
Message-ID: <20260530160240.062963614@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,pebblebay.com,pengutronix.de,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-259272-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E68E612EE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 03819abbeb11117dcbba40bfe322b88c0c88a6b6 ]

In lan78xx_probe(), the buffer `buf` was being freed twice: once
implicitly through `usb_free_urb(dev->urb_intr)` with the
`URB_FREE_BUFFER` flag and again explicitly by `kfree(buf)`. This caused
a double free issue.

To resolve this, reordered `kmalloc()` and `usb_alloc_urb()` calls to
simplify the initialization sequence and removed the redundant
`kfree(buf)`.  Now, `buf` is allocated after `usb_alloc_urb()`, ensuring
it is correctly managed by  `usb_fill_int_urb()` and freed by
`usb_free_urb()` as intended.

Fixes: a6df95cae40b ("lan78xx: Fix memory allocation bug")
Cc: John Efstathiades <john.efstathiades@pebblebay.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20241116130558.1352230-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context. Make the function usb_alloc_urb() call before
kmalloc(). ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f0643d9d8ff94..af0622e942584 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4057,29 +4057,30 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	period = ep_intr->desc.bInterval;
 	maxp = usb_maxpacket(dev->udev, dev->pipe_intr, 0);
-	buf = kmalloc(maxp, GFP_KERNEL);
-	if (!buf) {
+
+	dev->urb_intr = usb_alloc_urb(0, GFP_KERNEL);
+	if (!dev->urb_intr) {
 		ret = -ENOMEM;
 		goto out3;
 	}
 
-	dev->urb_intr = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->urb_intr) {
+	buf = kmalloc(maxp, GFP_KERNEL);
+	if (!buf) {
 		ret = -ENOMEM;
-		goto out4;
-	} else {
-		usb_fill_int_urb(dev->urb_intr, dev->udev,
-				 dev->pipe_intr, buf, maxp,
-				 intr_complete, dev, period);
-		dev->urb_intr->transfer_flags |= URB_FREE_BUFFER;
+		goto free_urbs;
 	}
 
+	usb_fill_int_urb(dev->urb_intr, dev->udev,
+			 dev->pipe_intr, buf, maxp,
+			 intr_complete, dev, period);
+	dev->urb_intr->transfer_flags |= URB_FREE_BUFFER;
+
 	dev->maxpacket = usb_maxpacket(dev->udev, dev->pipe_out, 1);
 
 	/* Reject broken descriptors. */
 	if (dev->maxpacket == 0) {
 		ret = -ENODEV;
-		goto out5;
+		goto free_urbs;
 	}
 
 	/* driver requires remote-wakeup capability during autosuspend. */
@@ -4087,7 +4088,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	ret = lan78xx_phy_init(dev);
 	if (ret < 0)
-		goto out5;
+		goto free_urbs;
 
 	ret = register_netdev(netdev);
 	if (ret != 0) {
@@ -4109,10 +4110,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 out6:
 	phy_disconnect(netdev->phydev);
-out5:
+free_urbs:
 	usb_free_urb(dev->urb_intr);
-out4:
-	kfree(buf);
 out3:
 	lan78xx_unbind(dev, intf);
 out2:
-- 
2.53.0




