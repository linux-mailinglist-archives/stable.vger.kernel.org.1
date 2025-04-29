Return-Path: <stable+bounces-137034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DDEAA083C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FC7484E2C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5A82472A4;
	Tue, 29 Apr 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgQ9Of3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64321ADD1
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921591; cv=none; b=hle2wl9wYhKvtms5YTxUNf2TovIjgFQZijP12frm15je9u5ea3WXwvchDoxVmU1vyjVdwtF3+D/xyIknuYNrwm3PAJalCwHMMxU3GrM8/5efo8/86gSfNKNlaCEUGZ06PaJmrwRn9nFuGjtKvM61Q91dDY4ozX/+11H4dhKzp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921591; c=relaxed/simple;
	bh=ymlU9uKnMtnwWo2A3zUfUChIqbtje997iKS0gD/DSPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/dgrambI2hAm6k6Q83JQyYtR3nDwuk3PHmUTXBZOFAaCbFS1GiQ2+KjFnLUYw8PPkvWHswqVMk0wlow6z7pUofdko7BFpIf/MBcgM/OO/Ob9Jnz+qQ6IHd0lY5SuL9F3F3cINxo/G/MHStyx8nOVVIuVF+SZrjuV6jmagmcvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgQ9Of3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCF8C4CEEE;
	Tue, 29 Apr 2025 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921591;
	bh=ymlU9uKnMtnwWo2A3zUfUChIqbtje997iKS0gD/DSPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WgQ9Of3cZE9M5xarkbqpjnzlN0cJa986hQWJXQ+qgu8z/Y9AJMN1dMHTFY3sFYtij
	 g+lgU3SYtd5Ai4vwFFdLYAulSUlFCFXckxLvXI/GGnbnS8+1BVK/3WEmgEH+BTc1L9
	 wthwYApq5l5Ma0cOSF9lNjJn+7aSPDr0I0vkXMA/+OPJfRwNBMN43ITSg7Z71AMPss
	 jNtCvmP4kx1Jlpzy7LOiTVd9gIYvoOZo7v6aRvinoHarA164dAllMaca7g6oyTYXg2
	 lJdr2AEbteXBEaxVQPKvRXJVYDlFMfkjdYkbjb+pNYyxSneP5WXcUqVzCECUEzfOxi
	 OwWJnJxHqalww==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y v2 2/4] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 12:13:01 +0200
Message-ID: <20250429101303.18190-2-kabel@kernel.org>
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


