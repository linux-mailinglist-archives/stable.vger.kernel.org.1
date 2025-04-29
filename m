Return-Path: <stable+bounces-137035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B462AA083D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491253B8E9B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C591278172;
	Tue, 29 Apr 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/BMmb9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5421ADD1
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921593; cv=none; b=L+0vo412NRKxbNUrpAdHSstPb557lxN0v8BU8OLHqBAibO5ROjLOVYTmkY9HyjrAExk82gGrTfCEfUz0xjT/mHk+xT1XiRuFehkV0KOEl2WDzT+6CP/LNbEXJmoPKbikR347qAJwi2640A7g7xGwQZF0uyVXvBWgX/8RT8f7dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921593; c=relaxed/simple;
	bh=k3dbKIwXS2RIClLA4gf+mhX6WvG+xf2Z5BHPGvj9KgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gY3IGh3BW9SRa5J7ISyp5ozzLTToLqcVinHz7R3mZPl+w6PAP9b1QOnOZCaKxrVIF9vECZHCgRdryylCkVS9ARb+NFvTP8D+/skwSEdNr1ZNbkmjdKHjsN/IMbjNVOh+Z1lk3WGAzls/G6oploofgOoViVuYNL7C+szWkdn6hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/BMmb9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89952C4CEE3;
	Tue, 29 Apr 2025 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921593;
	bh=k3dbKIwXS2RIClLA4gf+mhX6WvG+xf2Z5BHPGvj9KgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/BMmb9jFrdwOhZF8mCe9riuar+zNy4646CyN6n7BJLp2f3SNxVvoXZnZYXTpu5HY
	 rdcjC0TnrI3rj1R/HR67l+7opgTm5DkGpvjWc0A83bkKqOCf9t/eID8C2Y7o9GGGzI
	 NOIevzfiAKflc6bi3h8mGxQK5s0WySPgHt+WRvW7JBTv0sz65iDPKqalnuXhmin+yh
	 O44fDyr9zVpWq2lVOqnxUwCVei1Wxil8oYEum+fxMasGwbdo082LZNi+8mDvuorOZx
	 Zt060Xt0azRwpEpCDdW7nXTwU++Y/ngH487CUPWpfh0GVH2ecPzc0nwfSgT96HShFI
	 irqmexngWnO+g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y v2 3/4] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 12:13:02 +0200
Message-ID: <20250429101303.18190-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101303.18190-1-kabel@kernel.org>
References: <20250429101303.18190-1-kabel@kernel.org>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-5-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


