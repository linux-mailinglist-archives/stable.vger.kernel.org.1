Return-Path: <stable+bounces-227909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P9yC271wGkwPAQAu9opvQ
	(envelope-from <stable+bounces-227909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:10:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C197E2EE15D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6449330541C7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA036EAAE;
	Mon, 23 Mar 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BjslTPg1"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56491240611;
	Mon, 23 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253031; cv=none; b=kTqvsfRIrgwkOPY88dKRsM4dCTbgBTZTbMRDyuDPbynDxgUOe25oMZ2sOKSuGiR+r5pQ0bknJvYBj6vEuYsWNpMNopP8c7j+TGHfk5lSVdpRPgCgeYHEF+BjrIqBIb6V1s5U14U0IwVZ2kE1Po8wsZ/3mZhc+EABqjYWum2wldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253031; c=relaxed/simple;
	bh=45Acm3jZNtBoCVKP1X/Aj5SoP/riK+hHkRXESoea040=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmRtzDvF3xZrIBQM/ebe4whyzYjrTtO27rw97SXsIDhq+UjvQ+mfMfTt/kZU9QCawcPJ02+uxKDOQ8v/XhubTO+Q/U3TT2F22DIOLpnTtY0KreNZ76nwkQ/k7oBC7zq8Mzo+4RaoRrqRUlHU7M1SC1f4HD8hwjJu9aOpHMiEH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BjslTPg1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3b
	W6lEjTTF+QWR7bh90rR8QkO0XvhhElmtSJMTk6weM=; b=BjslTPg19P1zkT1PzQ
	lPoV/RY6nd8Xasecn1cN6GOeDF0mdYYM7NL+hRHrysUOmQplxh/w5mUdiqrbLjx6
	lhnOpLFOYdW8WJoY1jR1qgkS+x1Ntp7ZgBr8y/Bv1R3kh1kOrr6fCb/swqjJcOBK
	TinqWskcSdo425uxGtF5JDKVg=
Received: from Ubuntu24 (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXdNsn88Bp2Ar8Ww--.58300S2;
	Mon, 23 Mar 2026 16:00:56 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	John Efstathiades <john.efstathiades@pebblebay.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
Date: Mon, 23 Mar 2026 16:00:21 +0800
Message-Id: <20260323080021.1172236-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXdNsn88Bp2Ar8Ww--.58300S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1fCryrWryUCw1DWw15urg_yoW5AFWfpa
	yfJFnxKF1DJr47W3yDAF4kZ3yY9a18KFyUCFWS9w40va4fA34aq34ftrWSqFyUCrZ8AFsa
	qF1Ut3yjgr4Y9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE4E_NUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BmVXmnA8znmwQAA36
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227909-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,pebblebay.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,pengutronix.de:email,pebblebay.com:email]
X-Rspamd-Queue-Id: C197E2EE15D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/net/usb/lan78xx.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index dbd9bd23e60c..b160d7a94f32 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4105,29 +4105,30 @@ static int lan78xx_probe(struct usb_interface *intf,
 
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
@@ -4135,7 +4136,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	ret = lan78xx_phy_init(dev);
 	if (ret < 0)
-		goto out5;
+		goto free_urbs;
 
 	ret = register_netdev(netdev);
 	if (ret != 0) {
@@ -4157,10 +4158,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 
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
2.43.0


