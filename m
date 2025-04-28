Return-Path: <stable+bounces-136824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3100A9EAC9
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34153B4A25
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE122D530;
	Mon, 28 Apr 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5KGeyOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD481CD15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829005; cv=none; b=MEalGrL06jjc1iXy7InCNiG53x6hZPSSJTwt9FN0SmjxVo87p3OawxLmLCmR+jNzhokY6BbyDV0nLeemfUD9CdMOIg2YxasgSEnaO2OUHeAhOHZauCcMuDrPTIiT8xK5il4KxCoTn5Bx37S4bYqepycnGO03yyp53txmWVSUTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829005; c=relaxed/simple;
	bh=D5uT+qWVj5vwV9ZVg9poVQ2shJ9wFbbtgQKrirxAogs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpUAtKkxI3UJWqRQW0XPgUkdPIS/7FhM7Om9czIMxvLiUUYVr6oT1UI5q/cCdpWqIOC6jRmOGbKkX3mrILB0b7GXgdBdE8870LcFV35F2yOPq1vuIROTSxVAf/J2Jt7au6gbe+tVHmLkGwYcFHRjxZGwNqRzQbGh99Gj9tGlKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5KGeyOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B1FC4CEE4;
	Mon, 28 Apr 2025 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745829005;
	bh=D5uT+qWVj5vwV9ZVg9poVQ2shJ9wFbbtgQKrirxAogs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5KGeyOee+yr/kewOH4I2rTNYzq6194BNwmxhX+bctep2yjyWqH4WozbKrTHYE9bs
	 C2yxK5m6+Sft9k3wtY4f/MP0NYcWTz7qkLZHzL9qLwd2jK4ICBRF+UjWJY5O3oPUee
	 dUQ5EvlPYCnEiswJORfvBrESx01m2A0iSXGoSMm1HPpb/61IQsQDE9AlTXSndUgr5X
	 Inf9EvxLLkkkEcrFsrnYV4eNACNcroP4r4uK6lUnZZNZwF3Oe86to9dutCbSTSiNpd
	 GY2pJ5JdA3QYtNmEZRNM6iAEmj+N38UyCRsDkTAYf72AVgs0lJWa92sH77R6/YLeC2
	 mk1TpASus8oIA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.1.y 3/4] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Mon, 28 Apr 2025 10:29:55 +0200
Message-ID: <20250428082956.21502-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428082956.21502-1-kabel@kernel.org>
References: <20250428082956.21502-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 upstream.

Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
did not add the .port_set_policy() method for the 6320 family. Fix it.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8f53123de004..96b989e336ae 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5173,6 +5173,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5221,6 +5222,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


