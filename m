Return-Path: <stable+bounces-137030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A34AA082F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA73B9DF2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699F2BE7C8;
	Tue, 29 Apr 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1nnfxQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0A2BE7A7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921458; cv=none; b=hf6OIc6QU8MSNOjdQJ7QlaG2Wmqi+gSOishb1LNKPinqFlChR694W9OZPrPkTb5A+m8sAYDx9NEYLu3q/sfGvtcgqF1FkSKk9eW3eve5jX5i79QuCzdh04971p6JZYr6fyObaUPb1mLDjibmqQJMTBC6PUXIwzkW0a7GhHVqZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921458; c=relaxed/simple;
	bh=3s+Iu/Xm+qP4Ai6UJk7B2lvJCcueI0/0W82r3P2BF9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qauMuYueDmW6LJ/xWvXLrUqd+em0gD67ljrXetf8tHeb/01CnhQDcbLPiXoLOxByAFt0+obrU7L7ICfXUxr1YNvpCnsIvMYj6krENV98/LwqHAeQy44bqr/cvWrjK/u+ylssGs9n+foNVAULnTUHAbrnaq4NpgUNluy3W/dn0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1nnfxQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DFBC4CEE3;
	Tue, 29 Apr 2025 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921458;
	bh=3s+Iu/Xm+qP4Ai6UJk7B2lvJCcueI0/0W82r3P2BF9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1nnfxQVA1ADNPJFfbgFPF18nAgPy/DGadHUI3+E23sxjXokLpqbnc/OVhPwIPs6i
	 Asz03w9XWA/jztPXaZdmY6v3JSShRSFCxZtLF08WtXXEUUmyR5pLi6fbNZc5cdXvn4
	 Hgy5V+uOqnL6JwnBItdPakNLpCz9jQe6mpXUj8WBNWwucaW5T7DFYP26FuTf09vvJu
	 ZpF7H0U3+vNH494uIZh4TOmYzdDwnWVsT9MxSQHt8rMgCDPT3BW0cILsenj40TbIkI
	 BsvEMZCfruxPCs6lPqFq08oqBsWpqIvuA7BSflTum2SvyqOiDL+fGAa7RQtAIPVdgH
	 EB1wCiuge3Kyw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y v2 2/4] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 12:10:48 +0200
Message-ID: <20250429101050.17539-2-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101050.17539-1-kabel@kernel.org>
References: <20250429101050.17539-1-kabel@kernel.org>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-4-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index be42de54e7df..f8ac209e712e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6152,6 +6152,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


