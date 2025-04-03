Return-Path: <stable+bounces-127846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D3BA7AC51
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DEF188A786
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BF3270EAA;
	Thu,  3 Apr 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inGOpBJQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2F26FDBF;
	Thu,  3 Apr 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707227; cv=none; b=YCun1QQjAG5CQeeGsNIlPyYJkOeaIiOwHlqY8w+Ja/Xw+vHRxQNZobLLhOKtp641AeUWp4qRG9QvA6dhTnnJivnLcsKTX/c7nBFC5jhthavSr/GXL7qf9jt4JsP7AhdRYPD/jIikJHdTXI+OTH67k/bN0PnW31QHWXa/4ryu+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707227; c=relaxed/simple;
	bh=Xxspr6XRpl8ZiS0CyiHskloMrMzy5bkF/MsYq5SU6i0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Do3a6Vkx+OZA6dep1Uz3IUyY945CC78cptCVSTBaUSaZlklExXRdm28asBWQVFoWFP5zJxmN1glPXgtv/TmXDyVreWG3Awqfk2fAfmWlZgUCtlzs9qEf0coM8dJ3nx6fSwx4KBIMywcbIwfV7StlWzwdw1NpzRRbXYLAf0BcLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inGOpBJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B65C4CEEB;
	Thu,  3 Apr 2025 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707227;
	bh=Xxspr6XRpl8ZiS0CyiHskloMrMzy5bkF/MsYq5SU6i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inGOpBJQAo59Pp5SLMmAJ+jMeAkrPfrRydoF+7YeKb3RtOAy5w8cGogR4NjJEjv9S
	 jxE50N+h3Q+GzBkRh8iMUGBw6PoDUZ731Ojv+5CmNbHysHgmgoORBTcybNocBvnwSQ
	 C+BEMjq+PiEC7TUi63TiT89SZuoDxJz908+/GySAT+od8ChfLuRv/oVmjImshz5MMi
	 L1m5o5REFCSzAK9fy2XZDIp/NHuUoH/MNRsy4ZL7ajWhZ5T2FGbrOe7HiCU7NIxRMp
	 JFvVdHPb3sxe8INOL45iWWBITVXjZzFbiOdxQxtpOhdTNCY4x4ErqZDhv54K0s15s1
	 FPci6D+ICIMYw==
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
Subject: [PATCH AUTOSEL 6.12 28/47] net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module
Date: Thu,  3 Apr 2025 15:05:36 -0400
Message-Id: <20250403190555.2677001-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 9a5de80acd2f7..7b33993f7001e 100644
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


