Return-Path: <stable+bounces-46337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868E8D042F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120A6B2FE23
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A516D32F;
	Mon, 27 May 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLSBRIuU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DED416D325;
	Mon, 27 May 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819166; cv=none; b=FAqRu8qV+O2z5UxWzFyszNtywBWVYdZ+T9c+gN7TuZIgnMvLrSoutraphT5d+6BmGZq3c4c8PYKliw7GVmAcKrO7fUQMS0Nj6zFoxf2aC8fsGAbvcD0l17942rKO0eWbXEKCtVBnEJferokeMiYyPCTO4aIJS8x47/xsJXoXQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819166; c=relaxed/simple;
	bh=etjAyQemO/7YnJLLdqANw2A3NWliFralIXkWEsiy8S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8Wo+5SLSA0vynDUkrSY3t9950EkXkymcsNrupwmEmbW+lKPo+ZFvFPzpPo3r18Ju/Fxf6GS8PIMqNmi/AaW54s3exCWAXmB+6tkDf3Yxik9e6U4ympx6tNyucDEXFeksu5moUpVe72FwoMrq2DcakbpIDmaUWvLE3k1EfGRRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLSBRIuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38498C2BBFC;
	Mon, 27 May 2024 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819165;
	bh=etjAyQemO/7YnJLLdqANw2A3NWliFralIXkWEsiy8S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLSBRIuUD/hRPg5PKB9cPh9QnjHgnTT5wDwLfxhqICQGRsIU1oQCh/qEHGZTwRwIO
	 M4DtsdQslUQgO2rOV96njwzokVjYOGHaE/eSW3o8LbK7QdTfVU+Bvkl9UcZjuzNqUp
	 s0r0de4rQhCI5mQ6k9w1ub3tG6o6mg21qakXOOkwxS9qmnSxBESipZF9ahzBeuGjEx
	 u0rZjvUDaE2jqQp+MS0E/cyb2xUreU1rEMX8QmoWNWw8xLPUApNKzWASRoUEi0TdDo
	 k9i0clPI2pUU318L5s2beoje483W9qzX3vpR0bVNJPTXIECZlOA+lWueFvMbhqOsLf
	 Al8f48GjBuznA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 17/35] net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module
Date: Mon, 27 May 2024 10:11:22 -0400
Message-ID: <20240527141214.3844331-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

[ Upstream commit cd4a32e60061789676f7f018a94fcc9ec56732a0 ]

Enhance the quirk for Fibrestore 2.5G copper SFP module. The original
commit e27aca3760c0 ("net: sfp: add quirk for FS's 2.5G copper SFP")
introducing the quirk says that the PHY is inaccessible, but that is
not true.

The module uses Rollball protocol to talk to the PHY, and needs a 4
second wait before probing it, same as FS 10G module.

The PHY inside the module is Realtek RTL8221B-VB-CG PHY. The realtek
driver recently gained support to set it up via clause 45 accesses.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240423085039.26957-2-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6e7639fc64ddc..44c47d34a5c68 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,18 +385,23 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
-static void sfp_fixup_fs_10gt(struct sfp *sfp)
+static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
 {
-	sfp_fixup_10gbaset_30m(sfp);
 	sfp_fixup_rollball(sfp);
 
-	/* The RollBall fixup is not enough for FS modules, the AQR chip inside
+	/* The RollBall fixup is not enough for FS modules, the PHY chip inside
 	 * them does not return 0xffff for PHY ID registers in all MMDs for the
 	 * while initializing. They need a 4 second wait before accessing PHY.
 	 */
 	sfp->module_t_wait = msecs_to_jiffies(4000);
 }
 
+static void sfp_fixup_fs_10gt(struct sfp *sfp)
+{
+	sfp_fixup_10gbaset_30m(sfp);
+	sfp_fixup_fs_2_5gt(sfp);
+}
+
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 {
 	/* Ignore the TX_FAULT and LOS signals on this module.
@@ -472,6 +477,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Rollball protocol to talk to the PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
+	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
+	// needs 4 sec wait before probing the PHY.
+	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
+
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
 	// NRZ in their EEPROM
 	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
@@ -488,9 +497,6 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
-	// FS 2.5G Base-T
-	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
-
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
-- 
2.43.0


