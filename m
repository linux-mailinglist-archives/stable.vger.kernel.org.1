Return-Path: <stable+bounces-136820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B718A9EA8E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9A176E1B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5049625DAFB;
	Mon, 28 Apr 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7BTwLy5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBF25D53E
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828345; cv=none; b=WF3bWZ/O+qwSyN2ZgsOXDhF4/lYPnCkuMBkguDC2lpoVv3To6RnHo/VDFBJHOb5o8uVXCsUuPS3n7wBhVLy/Na+z/5ueffcl6SxJSm6NSmGWWJ+FoZ+pxCfY3Ys7OWEcutKfhGCqIMSiYvLrWT6b/vc0gGIhQml0rYktfX4YZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828345; c=relaxed/simple;
	bh=kNYs6q3vEJp7mIDEmiWEwoqA+mz/AShAZzGKyx6LR6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flWyHJly8kaw6jp8FggDXyWSNXP4kzgIpN06TG1c8ztzDCx1lRelj9HBwp4vkmozFbTOu2Nol7HMk0R+ZdLUC/9TDfYIFZAnhmU5rBpo1FD3rdzO/oyv+DAQLHqV70V0HMUEMglJDtgipj/RpiA4tLIFW+cZW6b49qXOAiUNAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7BTwLy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E024C4CEE4;
	Mon, 28 Apr 2025 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745828344;
	bh=kNYs6q3vEJp7mIDEmiWEwoqA+mz/AShAZzGKyx6LR6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7BTwLy5VaJtS7If7p21bCxQjS+cQQSQFZchMoxYw8i48QebgbuR5BEZGYb2fYqGC
	 ioQjwIIWc49KWFgglpxIfPFV4gB59EI/ljEBgz1IM/njX+mT+u06NrUebDJyy1Rnpd
	 L/k+tgFVbfGF/nxyy0+TRFCn9pjh1jUatcE6eTPnkaLR8WgxDnvID3F4jekDsY499b
	 6tVlNrvnjqBV8okQXLSbjOQteYUBVakI9LJTHrvCxvWAgh+L/eLe/Oi1UtFUdNJxm9
	 GwIdJDQbdhScpbmSy04aQpJR8p2H6EQYr4KhdaqVtL8yKS15nqG9x8Pr5Jzn42KaQ3
	 8Tfzm1aTeprWg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.6.y 3/4] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Mon, 28 Apr 2025 10:18:53 +0200
Message-ID: <20250428081854.3641-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428081854.3641-1-kabel@kernel.org>
References: <20250428081854.3641-1-kabel@kernel.org>
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
index f8ac209e712e..472fe300b196 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5047,6 +5047,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5097,6 +5098,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


