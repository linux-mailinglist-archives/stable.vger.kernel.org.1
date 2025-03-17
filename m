Return-Path: <stable+bounces-124727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6257A65AD6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED80816B02F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3C1ACECE;
	Mon, 17 Mar 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1+SBIXs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25B1A2C0B;
	Mon, 17 Mar 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232779; cv=none; b=cFAlMprSNxLqs/NQXoRpgWwnWjC8AVYbIcZUDhjUJ7IZfKSDz19z1ey7PANBjTPsMH53QkG0xokqDTwRMXfMTfIAzQhZiiY4xB/xF4Ui7SWtiXpGrbdkGb23sgFgAn1RMDMi3+A/t4nF8n+xdiiRIqaZjFEYojZPxwczZiLKRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232779; c=relaxed/simple;
	bh=GWXkJbMmNBZ3iyyjfilxQwj6Vp6gqC7I7iHwyIVQcr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzFjJ4LEb7HVnUmlKW1HhlrStqOCfbSFUWF0fOrk3F+xko5nAay7Jaz+R9J6J9cqpfU99b95OGceTmT8DQQIvnlzm0Pl6Licpru2U5LqqqvQeW6SYHjO1qaTBewFoWsFqPiJ6DKtnXq+8bDLRwBm7QbEYuDv4SvXv2TJI/TPhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1+SBIXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB4CC4CEEF;
	Mon, 17 Mar 2025 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232777;
	bh=GWXkJbMmNBZ3iyyjfilxQwj6Vp6gqC7I7iHwyIVQcr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1+SBIXsszbvs7O3uqpCLhaeOzk7Wu6oPjt85qQsFUFnywbyxvHVeffdgoJOvMx0V
	 YeHAygjPzIQgcrPVyL2Hx/ZiOfJXoXhzvBTTOPnAQ9KaeriflTboJt/BlbMMEuLI9n
	 JNumBCq9S1RsMIQ/OfZqrMOw8YM36pklcXtGdtQOE4G8neNb7Q/67LZw7HPQ5P/E74
	 tCV8eK9qctaP98vl3B6F8L7hYAK1quEil7YqiK89/aL9dIbCkWR16s1YajhGa0V4o8
	 nu/s4XU8L3J3g/JyBAIpLZpIciYI8AuAOVeg4xD7uqiOX+5jvXRl1Gc3Cmm+fN+6RH
	 /NmNpzxWE9S8g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/7] net: dsa: mv88e6xxx: fix VTU methods for 6320 family
Date: Mon, 17 Mar 2025 18:32:44 +0100
Message-ID: <20250317173250.28780-2-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317173250.28780-1-kabel@kernel.org>
References: <20250317173250.28780-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VTU registers of the 6320 family use the 6352 semantics, not 6185.
Fix it.

Fixes: b8fee9571063 ("net: dsa: mv88e6xxx: add VLAN Get Next support")
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 5.15.x
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5db96ca52505..06b17c3b2205 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5169,8 +5169,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5217,8 +5217,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
-- 
2.48.1


