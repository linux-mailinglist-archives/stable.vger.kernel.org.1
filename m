Return-Path: <stable+bounces-128618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21BA7E9E9
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A998416D016
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10DC257443;
	Mon,  7 Apr 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWTTnxjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CD257438;
	Mon,  7 Apr 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049504; cv=none; b=I801J3lNyLE4oaJiT6mOHk+Hrt0mxzcG0FB4nT9lTZ//F8D7kCchZfrGAxtHiJISP77hnKqBrp5K3UQmFhHZMfZ4K44ju7iuR6ecQfosSjORmRzbO0gsE99fOFWPfuR2ahQmqmEJt6lLrMmjIWx2Mpy1tPkE/LsqYHLawmyKI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049504; c=relaxed/simple;
	bh=PLdpN6rz20+ajRaei7RLj6DvYTOdzktW43uHvQjTSf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHdpNYHP5VlE9E4XBBx7lgBU9/V1/vSN6mqDg/g+KhU6Rcfwk1Mjxc7SITZufzFqPiCFlN4og2OkxoouKhh2iTOlgY8rNMlovKSEIYCGMkTg4oJXWFgd9HmOrdEizEm+Dw+tJPi7MOGLm4JgY0FJJk/Lbs/alxeZyZffOKIXk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWTTnxjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC4FC4CEDD;
	Mon,  7 Apr 2025 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049504;
	bh=PLdpN6rz20+ajRaei7RLj6DvYTOdzktW43uHvQjTSf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWTTnxjWhTmVyX9dbla7BKbF0KxZDgwiXb+3QkJo7pjNiyit7aqnCBh9ql5XPKBDy
	 sYe+8HAwxReyW2JQE0ajgQtCapWcMusERJQB/pUV5WyF6RxC31tIF5JqO7BmKCy96k
	 LKFgoOV0zjDhsTywtsrfOX7yB9XZEeCl9yz5Rh/MEHOaCzUe3tr+MvUNGGgF7XcNYX
	 JriPyW7wKFY07GLPwY+7bbdstO8/gYCnhL7Um6iMYEvhd8CbQ27NePrLNSnCdQ+UsZ
	 P5wSWPScZpTmO0CA7A43bgeETrZL2sxjTQpr2A0I4HaKSuQIyn8262wNxK3m1r65h5
	 P8tWM8dvtcGKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 21/31] usb: host: xhci-plat: mvebu: use ->quirks instead of ->init_quirk() func
Date: Mon,  7 Apr 2025 14:10:37 -0400
Message-Id: <20250407181054.3177479-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 64eb182d5f7a5ec30227bce4f6922ff663432f44 ]

Compatible "marvell,armada3700-xhci" match data uses the
struct xhci_plat_priv::init_quirk() function pointer to add
XHCI_RESET_ON_RESUME as quirk on XHCI.

Instead, use the struct xhci_plat_priv::quirks field.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://lore.kernel.org/r/20250205-s2r-cdns-v7-1-13658a271c3c@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mvebu.c | 10 ----------
 drivers/usb/host/xhci-mvebu.h |  6 ------
 drivers/usb/host/xhci-plat.c  |  2 +-
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 87f1597a0e5ab..257e4d79971fd 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -73,13 +73,3 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 
 	return 0;
 }
-
-int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
-{
-	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
-
-	/* Without reset on resume, the HC won't work at all */
-	xhci->quirks |= XHCI_RESET_ON_RESUME;
-
-	return 0;
-}
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index 3be021793cc8b..9d26e22c48422 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -12,16 +12,10 @@ struct usb_hcd;
 
 #if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
 int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd);
-int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd);
 #else
 static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 {
 	return 0;
 }
-
-static inline int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
-{
-	return 0;
-}
 #endif
 #endif /* __LINUX_XHCI_MVEBU_H */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d85ffa9ffaa70..ff813dca2d1d3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -106,7 +106,7 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 };
 
 static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
-	.init_quirk = xhci_mvebu_a3700_init_quirk,
+	.quirks = XHCI_RESET_ON_RESUME,
 };
 
 static const struct xhci_plat_priv xhci_plat_brcm = {
-- 
2.39.5


