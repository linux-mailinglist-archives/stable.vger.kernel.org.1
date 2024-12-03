Return-Path: <stable+bounces-96405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F25E9E2546
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D309DB80E14
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D71F7086;
	Tue,  3 Dec 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xc2Z7IhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F11F6666;
	Tue,  3 Dec 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236688; cv=none; b=aUmBXaRMCHmqpziWf3SWRfxzFROyhHS4okXiM0RnEkhHMPv0D+yX75Duh56QAnQPCVbogZL11/UVE216SdCenfovZx3M98t6L0sI2fYI8RcAKGSV/RkUHglCcY7uQfYHqRJ0k4/c2MniJYOQtHGJ5Y/nzKXtK2TgEMwg9teM/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236688; c=relaxed/simple;
	bh=mMCMkTCDjJ/icFsJeZjBFxYdAE75QH5babuvuj8GfX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDjvZTiS0lgX62MhB2MrUoj/gf6qc7LqXFS9RhZyl1Wz947g0Vuj67+A7a08lyJlRz3L2/NVGS5gJJ9ZSOzft19x+8zw10KydYPvMHhbbCi9t2ERSqDMSB8cPSqlEajh9r/k7FHowC12WaLVRZhOVG9NMJQQ9T6nEBWUdw+l22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xc2Z7IhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F66DC4CECF;
	Tue,  3 Dec 2024 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733236688;
	bh=mMCMkTCDjJ/icFsJeZjBFxYdAE75QH5babuvuj8GfX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xc2Z7IhG+nezaljHoTM6JnTfkOMIVw9JJj9sf6W4VNyNFL1fbY+QiH7sWvBY4LqPT
	 bguUUfwiszIK8i4OH6wsW0irVqoKsPh5gRmuW86AItWsIllBVBoBDTU/uOUTDPGezV
	 /TqQiJh9HF2/+7zbIULTum1tb1rGpIhVjYljJhnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/138] net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration
Date: Tue,  3 Dec 2024 15:32:00 +0100
Message-ID: <20241203141927.049819328@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit e863ff806f72098bccaf8fa89c80d9ad6187c3b0 ]

Validate Wake-on-LAN (WoL) options in `lan78xx_set_wol` before calling
`usb_autopm_get_interface`. This prevents USB autopm refcounting issues
and ensures the adapter can properly enter autosuspend when invalid WoL
options are provided.

Fixes: eb9ad088f966 ("lan78xx: Check for supported Wake-on-LAN modes")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://patch.msgid.link/20241118140351.2398166-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index de07d90038205..44c2433b55a76 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1440,13 +1440,13 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 	int ret;
 
+	if (wol->wolopts & ~WAKE_ALL)
+		return -EINVAL;
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
 		return ret;
 
-	if (wol->wolopts & ~WAKE_ALL)
-		return -EINVAL;
-
 	pdata->wol = wol->wolopts;
 
 	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
-- 
2.43.0




