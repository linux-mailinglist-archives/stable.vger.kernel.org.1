Return-Path: <stable+bounces-128705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52ADA7EAE6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B70444634
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E32550A4;
	Mon,  7 Apr 2025 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZYEDU/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFD268C78;
	Mon,  7 Apr 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049708; cv=none; b=DNMCuOYBGw9WEwZWdEV223rbyo0ZsbhG/UL9QbZYhmEwC4JqApXZ3src4BFx1UFw9DgmzDrsrtylbolg1qr0i7RQa8N6XLI/pDgbf2hrjBOC/pmQArOeDqD/8r38yXdCa86kJTIFliFHRJAEH76PjXzVZTeKDF5N2ZkwsZMnXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049708; c=relaxed/simple;
	bh=NcFlYS8okndtoVq9cjC7vITdkMupOCuhceNjq3w2GsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8vW158X2XPRXIFPm7xlGVt4RF3XuRJ0Tj9o1+Uet0oSvA/DTeFUImFPHuSv4sOrTHfPaXdtjdt7YzkOSRtvC1h/m0EYVZtOowpkCtu8gz9sQcosfy6VAjd29JoF9yv4m+GoWT5WSN2Ig8Fbwy2lTisZA1H1o8+q5AphCf/1ftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZYEDU/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF612C4CEEC;
	Mon,  7 Apr 2025 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049707;
	bh=NcFlYS8okndtoVq9cjC7vITdkMupOCuhceNjq3w2GsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZYEDU/C2FycvRrOOL2NQPLf24z/7CkO1zOGgZjf8Fid3iKaRuitCIwMsols+dSIH
	 sdDZZG+uvb/U0/dqDHooHvaop2k77W+yCGNwcyQ/o6exJY6xwM3LayMCHN7z4G+wLS
	 3nDtXFF6mDnHHPX7McVue5fSbf8X3nHAXC/0x1Nfyyxs3hQYHRWBqMWuhiAh5ExIck
	 HMiMxc7x90jaakPHhE37mRHnDNNJZETgE5Mgs9JPQdc8/ra9U5sQmaq4n70S8MX4GB
	 0fq2zPdXQRPvX59N7HGu1T/xUtyxatShjk3v/jMJ9WN9M8YUsPwof3sKeeBsS+HIRj
	 Ej299ONUB9yxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/13] usb: host: xhci-plat: mvebu: use ->quirks instead of ->init_quirk() func
Date: Mon,  7 Apr 2025 14:14:43 -0400
Message-Id: <20250407181449.3183687-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index b387d39bfb81d..59f1cb68e6579 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -111,7 +111,7 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 };
 
 static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
-	.init_quirk = xhci_mvebu_a3700_init_quirk,
+	.quirks = XHCI_RESET_ON_RESUME,
 };
 
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
-- 
2.39.5


