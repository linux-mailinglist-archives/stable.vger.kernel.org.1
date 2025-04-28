Return-Path: <stable+bounces-136823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4BA9EAC8
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F1189D2A6
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92241F3BA9;
	Mon, 28 Apr 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTuBuk6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7242222C1
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829003; cv=none; b=hcFr79fPhoK/xIgviHQj4EAiD/us/Ijqu3Hxm7nO08GnfCG3t9XJj9ptHe+tD453T4WM80tQjzLUdRIbsY7gTkpbC4O+hy1PHRDkIzh8WuPWfDKkF24tx9exo/ZxYJsqkBiFuVpFKCP1UQM0csFDx3PBliycFBZIAhNNDY+SKCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829003; c=relaxed/simple;
	bh=1j5GCobPXkTfsK8GtFrof/gRQom/y/O/wOUnEXlFWFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq9NQSb+Ubztnva89cB1vH4SFWx66cn958AreZw/6th7a+7v5pnu+IhV5lnEsnGaMPLe2HK0S1DlcUjohs4H/wwRoOntPWMp5ep3aU6WyIbQ6SOYlB5WA9NTzSNfF1TK6Z/LzCMBYrc/Ds7zBq4n/nRx/WwiJwP7D0PZkTH4+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTuBuk6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF00C4CEED;
	Mon, 28 Apr 2025 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745829003;
	bh=1j5GCobPXkTfsK8GtFrof/gRQom/y/O/wOUnEXlFWFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTuBuk6BvQ3la80FPIBhv8Ia2URFWyBGe7UKlbvOyVqL6/6LuCZ5n8sVgXKRODwx4
	 IEs/uQB6JaahEII6BurnCh3n3pZRuEZwXH9bCmroD1wbPnLQiQGyagdWhnidBVGviZ
	 UpZTE82wsabxAGTOFdlBNaDowMf6Wijvy5SRB6xCsRo13eCc5sq9hTzANmD7n15LiG
	 OtZmFqKsJ/nuyjm6xx9cohd1IJ4kWArQxnRrJew3Nzcn7T8oVcFi6BVpelksi5TrKV
	 S2tTA8K32Lwrq7+xGKWrOBazK54AJZ6Pa/HceAbmc/Ag2oAJjkjKvAA3eV+vzVUmWS
	 fQj5pCyiz7rOQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.1.y 2/4] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Mon, 28 Apr 2025 10:29:54 +0200
Message-ID: <20250428082956.21502-2-kabel@kernel.org>
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

commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b5e06f66cd38..8f53123de004 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6250,6 +6250,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


