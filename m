Return-Path: <stable+bounces-116859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88362A3A935
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D411880394
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250311F4183;
	Tue, 18 Feb 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8bph32l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A11F417E;
	Tue, 18 Feb 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910397; cv=none; b=YqhzW40DIIGYJBg42nJNy6uQKINEg+MJ4eRxp7s5GW1uXV9+JYntuDEoMWI2FuHz4jY9mCjschF/H4IncBP4S/Jj98g0Laj8WESiLD9CclDDliS77Jd2VFF9JTpDH5gvgUyYtSWHx7A0BYnPP2lIO3PWVYd5FdCA+yAKfUH4peI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910397; c=relaxed/simple;
	bh=EKeHXbc6LekQeWW1oBkFc0hNQS24CKvENjCWIkt4U7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DuVHgpHjpGcIblJxovmUIl5tNb4lTWTfxt9GcUO30yVaYEjDzjIHxok1UaRrd/45Ca1xbV7lo1q2wXvidUFYdR+LfCUXBFM87q9/TllMHfbqg83d93+SZT6M2svC//OmLdjRil87p3xp5yR3jqlTVJ00vX1yHfYKSn6Zo8fjVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8bph32l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643E4C4CEE2;
	Tue, 18 Feb 2025 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910397;
	bh=EKeHXbc6LekQeWW1oBkFc0hNQS24CKvENjCWIkt4U7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8bph32lfyLg4Wn6hMOCn48kpNvb7aU3HwjJVZk7lJQ6wD9/pn89GPwAuHc3RcZaq
	 6OoSP6jBdijopUmFHaRY5vU5IynqMjY3h8sQgvnarZFrHZRLD5J6Om6pKYI+h4k8v6
	 2Ioc66lZM46NDUGhAWWlqyNUNGW16f3AgS+78Jf4oZ7D8ioJygegqptNLC7riYM0NB
	 iiZjVGyExefQ/fZJzPje5XzoKdAdDBEBuo4K2JHoW2APaDzOJVRCXCMDdeKSTl/HDE
	 1E4Y19p/v1/RyOI52X4UnhdEcQZL9nyReDZYDb9ypIjw4LJJyaoE4PGwpZxuSL77FV
	 DKQ4fBhF4bHSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	m.grzeschik@pengutronix.de,
	sean.anderson@seco.com,
	u.kleine-koenig@baylibre.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/31] usb: phy: generic: Use proper helper for property detection
Date: Tue, 18 Feb 2025 15:25:52 -0500
Message-Id: <20250218202619.3592630-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
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
index e7d50e0a16123..aadf98f65c608 100644
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


