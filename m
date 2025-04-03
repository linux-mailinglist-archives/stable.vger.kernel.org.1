Return-Path: <stable+bounces-127797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308FA7ABC4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BFE17BA2B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B44265CC5;
	Thu,  3 Apr 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3dUCYFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231252566DE;
	Thu,  3 Apr 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707115; cv=none; b=NNXe8Ob1+sz8tUSSuGz8AuBwPNFeM1ubeuPkqjKbTI5XUTcV9bgQ/VqzS2AymZ1jXTEkzO1jQej9a8b5o5gAk/UiFf7bmCR9VfG/2a0q9J2Bgfg8NO+8xH2YOEp6muSn+DkVzeiF5UI+TviYIh2QBihWnzaZqoeXYRNSI+aszDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707115; c=relaxed/simple;
	bh=gXsEj8UjjtOmll3mukiHGHK0tAM8sjldPqEV7KznP/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VX06CKbql9zCUGw/34qxtWO5cZs+98BEhBuSTqFHKLVdTYcsXZkaZSK73NJUPOZyFYa4FAtJNJ2hL9w5TCj2FaOV8K6PqR10167t1hvoWzK+X051jZIBTnvlEAPfzwJdlReWdHvQn/ZejUF1jaCZp5W2YnxN073C4v95WlOiaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3dUCYFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F430C4CEE3;
	Thu,  3 Apr 2025 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707114;
	bh=gXsEj8UjjtOmll3mukiHGHK0tAM8sjldPqEV7KznP/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3dUCYFTW3NJtod2jrIsHwORFQp9OM0r/Io1IbQRK4N2AjhEmovKTUZOyyX7+7zvw
	 lf6NJz0jPXkFrxKAtKl9j+Xbx3BRKw7xHkwFyMT4PgLpvpOrJqm4kLtmGxqcF2egc3
	 uVJjI6gzWz8y5WER2inVhfyObb/gRo0LlTrBVGLszqf8Z/OPrKb9TE1IPfOzvJsoWv
	 T7g3Bh5fveeMg/OQPAxpvQmKs3C+iW0ILTvC8bE8L8ODPip+JoM3Q2UPPlO/EkR+F0
	 /M0YnltraFObvteSq0XK2c+G38+vebNIsiJjjxR9V6RrH77oOGVhrUHN1CU4E+vMFL
	 NT2EZwUJ0yMxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Schiller <ms@dev.tdt.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 28/49] net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module
Date: Thu,  3 Apr 2025 15:03:47 -0400
Message-Id: <20250403190408.2676344-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 05ec5c085eb7ae044d49e04a3cff194a0b2a3251 ]

Add quirk for a copper SFP that identifies itself as "FS" "SFP-10GM-T".
It uses RollBall protocol to talk to the PHY and needs 4 sec wait before
probing the PHY.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Link: https://patch.msgid.link/20250227071058.1520027-1-ms@dev.tdt.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9369f52977694..c88217af44a14 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,7 +385,7 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
-static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
+static void sfp_fixup_rollball_wait4s(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
 
@@ -399,7 +399,7 @@ static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
 static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
-	sfp_fixup_fs_2_5gt(sfp);
+	sfp_fixup_rollball_wait4s(sfp);
 }
 
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
@@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
-	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
-	// needs 4 sec wait before probing the PHY.
-	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
+	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
+	// to the PHY and needs 4 sec wait before probing the PHY.
+	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_rollball_wait4s),
+	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_rollball_wait4s),
 
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
 	// NRZ in their EEPROM
-- 
2.39.5


