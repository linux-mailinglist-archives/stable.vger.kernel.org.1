Return-Path: <stable+bounces-136828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E50A9EB23
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F5A3BCD13
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D525E829;
	Mon, 28 Apr 2025 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX+YfWnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864818CC15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830166; cv=none; b=qhOha6hOM+oKYMaaKw2znRm3YcC0PLHTpd8qJU0YQTYHKR1/ha4fkpcn6PU1bKMTHS9hwH7NJ7KfBUQ1iW+Zvq6QqOdI/botGewe2Mke8VB5kolc+xTS0oJOUhl0QMHQqv2r98Kc44PRV2csy4s4kcgCfSIPM0cjlOhVaaH0oTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830166; c=relaxed/simple;
	bh=ObcPCJnmQdNABzmc3aDX8G+jXp82e5sGVjHwcA6AC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3jHAbVF6kY+6ybcpTV+biQhaEv6Cn58FftkHdOe65s/TUO4/k1F1yFafMds2TqUqGO8sPeqkmJlOtY4k23pRq+bKP0MFkPQMf+If0HPSOVy6pUFmSQFZyraGa8JQDVHutj1K+TJNf+o8fO0O353BVbOgQvskUxlpBWTaQuUhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX+YfWnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210BC4CEE4;
	Mon, 28 Apr 2025 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830165;
	bh=ObcPCJnmQdNABzmc3aDX8G+jXp82e5sGVjHwcA6AC+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SX+YfWndpREuF/L1aQZ4cwxVV+nr8H0tp/tmLXTn/s+nhd/b7S5zGfKht8q4nAuzE
	 PqG7weI1Y1qiYwnP2CWANDznyYWgrISPZG42AOTHRIy/eqepU70ouSr3PWfCMEJbLI
	 vukxkzDcbEJPyn7p6FmrF26cd53wRDKV20DDZr+Yo7e3AwQNZRCSSxMXWbds/O87QX
	 ceDlNoxRR68Frma0T1xvTQ/1wTbtfkcOQlmMD7k7SC7qRPekNn/YvOzfdJ78SWrgss
	 MoxnKadFjtiONR2cBhE2JGIZ17nqvBVTF1piZX9wCDpmQNoLho7jI3O3HV3mjfylY2
	 RKk3AfgxVLQJA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 5.15.y 3/3] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Mon, 28 Apr 2025 10:49:16 +0200
Message-ID: <20250428084916.8489-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428084916.8489-1-kabel@kernel.org>
References: <20250428084916.8489-1-kabel@kernel.org>
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
index 06ae3440c785..2d1d60dbe7f0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4597,6 +4597,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -4644,6 +4645,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


