Return-Path: <stable+bounces-116888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E79A3A98C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3997179D2B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5821518B;
	Tue, 18 Feb 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx/exAqD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D34215180;
	Tue, 18 Feb 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910476; cv=none; b=KOZQGEFjxSyVuU+VDbc+YaM00pslg1xwfZ/n3Q7NL85XpRlWlZ2vbsZSM2oIBQ0+maexYZldAttc+v+9yY+tuqrBS0GjfpxK/wQ9qGgc4fO0HPhTmiEH2q87d8LpU0SZvTj+ka5dHKbEht6tBmzsFJTKiojE3C8TWU0uOtXwDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910476; c=relaxed/simple;
	bh=dS0tIPmJnk30ZcZsTmo0d4TLA5GQgfHmTKYexrxnuZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZmIr35iBa5ckIGjvXNVQD3PjvP4pe1D+BlX+G5QZQHPFK5m5GTP6rHpn241vSykr9h9KkvlFYNHZqLvir+Utaakzh0HAxLZR0tpnCSz0PEWDfAgsqegBvbc2ctabml7keyWmRWhsJG/o/iMFOqqVywb9kuhyVu5ZNziJiNY0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx/exAqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA62C4CEE9;
	Tue, 18 Feb 2025 20:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910476;
	bh=dS0tIPmJnk30ZcZsTmo0d4TLA5GQgfHmTKYexrxnuZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx/exAqDyUjaQRNST9sAPg0BH7nXKGAHMkgREyp6SN8T2fTly6WPHM9QYgBAp0LSC
	 QS55oXhDxBcs4FwJHS8zBgH9urG+MZHojPO0c+WA3D0eulb9Fc++1difLegcv+u+Vd
	 n8MeI0q6iDuJqzYRf2/+YpeT1G3B5cDwVMzDAjcKg2NXzeXKcms9ZQwV9Lq60VaKV/
	 ukp/AXWf3x14TXnQgqPcLhhKQdum26Xpps7pR3TGWwdYrNt1CpKZuEEl+0epleFL2r
	 YBsrR/UVHUERhIfOpuJwZyWKwO1ceR+NgKU2aLedhJDn1OgB6JNS28shy8LYOPyh7P
	 YnPmRLaVQdcrg==
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
Subject: [PATCH AUTOSEL 6.6 04/17] usb: phy: generic: Use proper helper for property detection
Date: Tue, 18 Feb 2025 15:27:28 -0500
Message-Id: <20250218202743.3593296-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202743.3593296-1-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.78
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
index 770081b828a42..2b4d2cbafe748 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -217,7 +217,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		if (of_property_read_u32(node, "clock-frequency", &clk_rate))
 			clk_rate = 0;
 
-		needs_clk = of_property_read_bool(node, "clocks");
+		needs_clk = of_property_present(node, "clocks");
 	}
 	nop->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
 						   GPIOD_ASIS);
-- 
2.39.5


