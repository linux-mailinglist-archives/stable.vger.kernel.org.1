Return-Path: <stable+bounces-194182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F188C4AF07
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CCE94FABDD
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2FC339714;
	Tue, 11 Nov 2025 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a18w5y+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2C26A1B6;
	Tue, 11 Nov 2025 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824998; cv=none; b=W4FBIvAbQEUSO/CbJ1z7VJ0HZxEtXUlm3xFVhjq+F7eOAIL9H5ZUsXY4KgPYII6E2b2PKY86ya+wpg6qOSkTpuixcMCsegqvUr7Nk8WeQKeq6Yycy8t8P+N+7bmQD7HrYkJVfkldpAwGgNVo1ITTzfRqWvOV91utb5346LGsBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824998; c=relaxed/simple;
	bh=u4/Um56TefT29mI7fklvrXM9THKXX7yFiIGNExWNw8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjyCA3+v5M6SwSN7mC2xzfh8V1L5Ke8IZZfenedZ06KkeOHeWVy9OOLVS9lb5S0mK4xMH88s6Ytya8HimXb6nLKX5e6Aejiz/25mw9AihZYZCoRyBpY4zLtjoA4Nv7eV8VT3xGR7cR6oyzM1u8CXAQ0iqhKGi8F3tjl7ID7eFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a18w5y+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C624C113D0;
	Tue, 11 Nov 2025 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824998;
	bh=u4/Um56TefT29mI7fklvrXM9THKXX7yFiIGNExWNw8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a18w5y+KPZ6szyQ7U53oXF3TR365zFKASpf/9LYPD+EsBzde+FV7a+mjD6yHwO0JE
	 0U+izLul5RT4bVEAXwFD6EdLRD3g08MAbvMNUMXfUkUVoysYDrYWC8RCs/pp0q9IUI
	 zmuB4X4sdUsohXe+LmiorY0e9Byo2g88p7ebEGoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 565/565] net: phy: fix phy_disable_eee
Date: Tue, 11 Nov 2025 09:47:01 +0900
Message-ID: <20251111004539.732368164@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit c83ca5a4df7cf0ce9ccc25e8481043e05aed6ad0 upstream.

genphy_c45_write_eee_adv() becomes a no-op if phydev->supported_eee
is cleared. That's not what we want because this function is still
needed to clear the EEE advertisement register(s).
Fill phydev->eee_broken_modes instead to ensure that userspace
can't re-enable EEE advertising.

Fixes: b55498ff14bd ("net: phy: add phy_disable_eee")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://patch.msgid.link/57e2ae5f-4319-413c-b5c4-ebc8d049bc23@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3054,10 +3054,11 @@ EXPORT_SYMBOL(phy_support_eee);
  */
 void phy_disable_eee(struct phy_device *phydev)
 {
-	linkmode_zero(phydev->supported_eee);
 	linkmode_zero(phydev->advertising_eee);
 	phydev->eee_cfg.tx_lpi_enabled = false;
 	phydev->eee_cfg.eee_enabled = false;
+	/* don't let userspace re-enable EEE advertisement */
+	linkmode_fill(phydev->eee_broken_modes);
 }
 EXPORT_SYMBOL_GPL(phy_disable_eee);
 



