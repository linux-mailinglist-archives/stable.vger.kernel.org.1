Return-Path: <stable+bounces-135297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2FA98D75
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E561B648C9
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96548279326;
	Wed, 23 Apr 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlDNcmnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1C2522B9;
	Wed, 23 Apr 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419534; cv=none; b=NA2XdpE+yGpyAB6onljezSnYBXN3VkZcdrl0hgrLzYBjTXdOFThgg5fFMM0uysVWQHX1sImXqmZT773Qx+jv4SAyB9Hsme1mQf2c2AIlUyEckuKXE5KThyXUMhJwdMBXh39JQa8iF5bI7cn5VN7zQI/uTfDroDECY+GtiQzHK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419534; c=relaxed/simple;
	bh=linE5WJJ3i5g7PNRFRgyoVVMUV9vBG1Mh9kNYrl/u3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0VqknjP7RXfEKYeECANxebLtBAWZfBSAk0n5dTLO3YO9HfVZ1xng560Xns/pXLsZCYmUIlMSDyKEDp9PeIj0NpZuLeblT+zUuNsLV5/dp641ULlwg0NglT5KhrKdWKyKDKohu3PkJsLOgTwgMcgyhMQnXXuCRL/C01YCZ6V4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlDNcmnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D72C4CEE2;
	Wed, 23 Apr 2025 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419533;
	bh=linE5WJJ3i5g7PNRFRgyoVVMUV9vBG1Mh9kNYrl/u3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlDNcmnjwjag/XKkqenb8yhRbT3Om7XqO5KRIdjs1ZIgWI8PmyHCeQVNEoyzHMRf6
	 poZGqlT+Vjn/v4g2qhKO7GL8Rfb0OgZZgNC0fELCXKgJbHihSCfBmJj0+3jA7xgMOe
	 IAtkrApJuNUbfa4nYPjGg+A0Eovm3rqCkBSmGScw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 002/223] wifi: at76c50x: fix use after free access in at76_disconnect
Date: Wed, 23 Apr 2025 16:41:14 +0200
Message-ID: <20250423142617.222528839@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdun Nihaal <abdun.nihaal@gmail.com>

[ Upstream commit 27c7e63b3cb1a20bb78ed4a36c561ea4579fd7da ]

The memory pointed to by priv is freed at the end of at76_delete_device
function (using ieee80211_free_hw). But the code then accesses the udev
field of the freed object to put the USB device. This may also lead to a
memory leak of the usb device. Fix this by using udev from interface.

Fixes: 29e20aa6c6af ("at76c50x-usb: fix use after free on failure path in at76_probe()")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Link: https://patch.msgid.link/20250330103110.44080-1-abdun.nihaal@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/atmel/at76c50x-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 504e05ea30f29..97ea7ab0f4910 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2552,7 +2552,7 @@ static void at76_disconnect(struct usb_interface *interface)
 
 	wiphy_info(priv->hw->wiphy, "disconnecting\n");
 	at76_delete_device(priv);
-	usb_put_dev(priv->udev);
+	usb_put_dev(interface_to_usbdev(interface));
 	dev_info(&interface->dev, "disconnected\n");
 }
 
-- 
2.39.5




