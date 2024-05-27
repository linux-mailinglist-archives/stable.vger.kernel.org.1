Return-Path: <stable+bounces-46369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7B8D037F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522BA29ECE9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A5175568;
	Mon, 27 May 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYr11NEl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67828174EE5;
	Mon, 27 May 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819285; cv=none; b=CCD2XZuGYsBMIvSjqDHs6NLukv7QwrEAfHtJtyGzFR7i1iN8mbfpXZflxrjLny9As3XoSvvHwdCPtMKrdynLvVSaPwiT2Jv0J1Aiy7xNV6TRojKMPZGO9mn+tJ/xcitZNYN1Seg2S0NuAUCio3yKrfmkW4pxyAJbz+qo/weQ8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819285; c=relaxed/simple;
	bh=etjAyQemO/7YnJLLdqANw2A3NWliFralIXkWEsiy8S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnPEX37wljiPfyfUWOV9BaGstTgOYTjLPtiKRjnv2gVK89do0/p3MwQlTriOkSHdSGWdjgzM1yIoHiw1uuPerj/TiFp9cPAuk/YKnt39W68EowKfPX4k1jqB/kJiFc+2nuTiGLTLv64Kv0BT/wkDG2mufR++dISYpxxHnxokSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYr11NEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB6C4AF08;
	Mon, 27 May 2024 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819285;
	bh=etjAyQemO/7YnJLLdqANw2A3NWliFralIXkWEsiy8S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYr11NEli6Vy9EUhePAZVhv6wVoYTl7dSr1DKtkMSCHs/OR97Fw3ZAqOqQPIdqSQb
	 lmZX4+6Kc3zu06qGnse/3IvwrIJdpscG0BJKT2Kbz78ayq3pOn85Z2tZDkaF0EQDMp
	 nSig4na3ncncMqMOc2+vb743BJ2Gh+snMPKGX1g8g4C/zItTdd6jLiHmPCnPMQWFFY
	 U4DFl5gsn1th+U4TRCLzYoPafUTkIcQ2X3JJgE1z11OWG7KABkD5WUj2oPFZh5/pm0
	 iottgvg18c2WJ0nLZsL9woyXQGd/YFf8QZupErtZsPxj/qrK6PpL3b6kVwXBtV6oYs
	 VfHskPB/4xPIA==
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
Subject: [PATCH AUTOSEL 6.8 14/30] net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module
Date: Mon, 27 May 2024 10:13:23 -0400
Message-ID: <20240527141406.3852821-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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


