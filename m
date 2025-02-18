Return-Path: <stable+bounces-116828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18BA3A8C9
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646727A3F2D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480151D9A7F;
	Tue, 18 Feb 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcBecBo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC681D9595;
	Tue, 18 Feb 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910313; cv=none; b=pFIjfbbB9HXTEM+ZFxu+/d2gdk02BpTX0Ah+OAy0scAGHSSWd7ZWBR/n7ZSj5+oJ1gtBqg4Mld6crR4Cv3dq/Bgu2M/7Ekk+txBYpR/HL/LK49Ls+3kcjHum/Iq0FNmwmvgN4/fvuaXSQE+ENx8QOM4R1U1JlFwFJXWwtZIbA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910313; c=relaxed/simple;
	bh=O+rOsUS/AbIzIf3D+OiY+wUyjmIouyu6awIC7asUZ3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxbmMDAypGaNmzxrpI/DjlIlvgGCOgVcMZfH61/ksImTBUdQzvP68Ud22ltbLKjmYnzHZj5Pfwk70eV/k3oEio2/ZKBUShL2YOOe3l99sF7hyJz8vPKT0yuJAZ8pk9co+34L0+maFAJG/MRbc8PrWpvO0VYmqEb96u8eaP7CyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcBecBo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F416C4CEE4;
	Tue, 18 Feb 2025 20:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910312;
	bh=O+rOsUS/AbIzIf3D+OiY+wUyjmIouyu6awIC7asUZ3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcBecBo54lfQTuQmVF/9OjilflEGmAano0K6nAj0po04Ug2y6ZEVU05Bygg0Oq5y4
	 cQYFZ5EyPNUvtWsOsY63wKManzKG91L5eVT+I8QLDged//Zl23ay5ZQkost3f+4oH1
	 jet2oo+kYaC8WX8d3GEqLMamR5iJYemLMXt/o7RMs/sf8dUafashHxM341buFAGCL9
	 nWleJ+pvrh4hwMYG/fNACy6Sr62vAQRRMY6yn8gE3nTHcGqgcogUUokbnMKVTZBG8a
	 P2Vz5RMqf8Pdioz7D2cAZ7hIpMdSnxL4zPU71HWLrddVeE8jTud5dnC3NxSWVqkALV
	 n0odcjmZimHDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	u.kleine-koenig@baylibre.com,
	sean.anderson@seco.com,
	m.grzeschik@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 06/31] usb: phy: generic: Use proper helper for property detection
Date: Tue, 18 Feb 2025 15:24:26 -0500
Message-Id: <20250218202455.3592096-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 309005e448c1f3e4b81e4416406991b7c3339c1d ]

Since commit c141ecc3cecd7 ("of: Warn when of_property_read_bool() is
used on non-boolean properties") a warning is raised if this function
is used for property detection. of_property_present() is the correct
helper for this.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20250120144251.580981-1-alexander.stein@ew.tq-group.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 6c3ececf91375..8423be59ec0ff 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -212,7 +212,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		if (of_property_read_u32(node, "clock-frequency", &clk_rate))
 			clk_rate = 0;
 
-		needs_clk = of_property_read_bool(node, "clocks");
+		needs_clk = of_property_present(node, "clocks");
 	}
 	nop->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
 						   GPIOD_ASIS);
-- 
2.39.5


