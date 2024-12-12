Return-Path: <stable+bounces-102807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A49EF55A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C116A512
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63D222D79;
	Thu, 12 Dec 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tBJxbb2f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C7222D58;
	Thu, 12 Dec 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022564; cv=none; b=P5EdWH9Ilbqe1YCKrs8XIQU+SS98h+eJJUT2jvhlTUj6Z21e9CT3F7i7Otaz3XlyPMtnYKjKgOH3LFEQZNuv60AE0sFHWW5oEigzE3rp/ZZSFrb7qYaZ3/Oq51oej484972f/EYvJ4ItiSf6iyx+5RQN5k8iEuC007tkECwDcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022564; c=relaxed/simple;
	bh=OqpScns4Gfwn7oAf9PYZUTMqWAXQS/qyX2IYU3b4h9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEarAOEIRC2QzejT/kNUFLurahFu1/WkfEprU17NXWharjwr7zet1EP2kaGoWlyI91oHqqtZDcXI1W1/A4N2bP/xeltvbnbhBe7cnLeDkkWvZEGN6gnl6xIDaVRP5q3/STrAB8Lt5YaRPvy7wx3A7FKJppJJsWe3FfpAjlRSy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tBJxbb2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E39FC4CED3;
	Thu, 12 Dec 2024 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022564;
	bh=OqpScns4Gfwn7oAf9PYZUTMqWAXQS/qyX2IYU3b4h9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBJxbb2fKBrT3kCUAho5qJB4OMI3OeQxVo9HMkME+2LqZDzBOxvJlP7YRS22gHXPC
	 /7O31ofgWMBxADu/p9IsWarOGKiqy7tO/rpvlI4CqqnoL/p/qeqIqgKXsQYY91Zq+j
	 wwgfI8eoaTIOHkYc1KLrQ+hZIqqK0TMhyGkje1E0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raghuram Chary J <raghuramchary.jallipalli@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 275/565] net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
Date: Thu, 12 Dec 2024 15:57:50 +0100
Message-ID: <20241212144322.331951738@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit ae7370e61c5d8f5bcefc2d4fca724bd4e9bbf789 ]

Add calls to `phy_device_free` after `fixed_phy_unregister` to fix a
memory leak that occurs when the device is unplugged. This ensures
proper cleanup of pseudo fixed-link PHYs.

Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
Cc: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20241116130558.1352230-2-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 77cb30259dca7..9d0d67e11eb14 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2220,6 +2220,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 			if (phy_is_pseudo_fixed_link(phydev)) {
 				fixed_phy_unregister(phydev);
+				phy_device_free(phydev);
 			} else {
 				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
 							     0xfffffff0);
@@ -3930,8 +3931,10 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	phy_disconnect(net->phydev);
 
-	if (phy_is_pseudo_fixed_link(phydev))
+	if (phy_is_pseudo_fixed_link(phydev)) {
 		fixed_phy_unregister(phydev);
+		phy_device_free(phydev);
+	}
 
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
-- 
2.43.0




