Return-Path: <stable+bounces-128673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC66A7EA5B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB808188DA94
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B026D2641C2;
	Mon,  7 Apr 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzXoD/JC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E18263F57;
	Mon,  7 Apr 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049640; cv=none; b=OToEqYJwOEmt4KTifHnxYovqJRUUtKMgUYygzFk6iDBx0RHY3d43o2TBknBfFDQ8uRjs4lc5PkEPZMa8q0VLhirmZxPZ1ODeag5aZHnFjpcCuJAzoqEKs46HTEfBe3bBqGpPMRl96H6/MuKo+5fH2k/SrrJKGgMsMiPH3Ipzt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049640; c=relaxed/simple;
	bh=FBKHsnYMzDkgiOKaCOzoMSLUlu+PhUdWFp4F5EIOj4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXqdMmag0Dpi432HxUdmtfPtOTMkSQUT8e4v1PMK6r5cbBBHGtVtzndUsNiTy8gHHV2Mamc1RX/bWd5B77mgl4omZkb7pm/d4CeeyzSapgMkEdT39J0TakQNgb8ZAWumEbCe6/V8LdY8GoWpy/YajNOpnELytwOkbWJGDBCsh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzXoD/JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7AAC4CEE7;
	Mon,  7 Apr 2025 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049640;
	bh=FBKHsnYMzDkgiOKaCOzoMSLUlu+PhUdWFp4F5EIOj4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzXoD/JC245MkYlxls8ew+PcP6t0rjyVgzgpJg1JxHs9Q4t+DjVKDYRHmozVO0WWY
	 v+pVMrlQp/p0c5OgPjyW/tQOIs5uzfVern6UMMZbj8VbSYdBxaoUkBGce8xYOgXK1U
	 EavEiQsqBeIXpku14962mrJl0Tfe6oIFhdEOPgjv072m7oGW6GkE7fJW5U2anQyMmE
	 YE/oPE80ehEewtY896vD5kkE3CypdnDrpZhrLE1syQDDtU4a0DolLoef054B3pQXbo
	 u6VcP+IQkk9QfPKLAiqzUi7acwOQGLIWd3GFdh1FT9yRFmjp5JusQxE8Jjf9s1qciw
	 qJ0tuJu6EVstQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/22] usb: host: xhci-plat: mvebu: use ->quirks instead of ->init_quirk() func
Date: Mon,  7 Apr 2025 14:13:25 -0400
Message-Id: <20250407181333.3182622-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index e6660472501e4..2379a67e34e12 100644
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


