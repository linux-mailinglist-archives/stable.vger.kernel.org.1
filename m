Return-Path: <stable+bounces-136827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8241DA9EB24
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4DC7A5701
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDB25E80C;
	Mon, 28 Apr 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW7/tiLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460718CC15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830164; cv=none; b=sDMa9KaJ88GAeNv7C9e6QeCLM3qB38eq2y4+HeAidWCFxsEAS441EPbqW92H6jk6UyDuwVV0Ir20NZp6NMfi2uYXVRaN6D2/MMwyF+rqwMfIww/VMsK8GU9Vj3Y2czndVNzp29RzLYRgU+gW0OPLfwm2jTDkc04H7xl6BOVflvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830164; c=relaxed/simple;
	bh=e1+pWjA/4XJMy+FZasobwvu9HkFKH/UFadrX06asL8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlPjkvzPJeTJ2l5ysk+6zesi7eahsfGFGk3a2uQRrxzC1FXpkxt4F8bekDeEXU7+ceTxLXkI/4oqgtthIfp2N9K65dfNWpxajylxsCI6UW4edwdRqOzBK9qMhD+onfVgqmMXexfpPNqcTHJcWqQBYy1sMVOWalYsfr6HemiDv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW7/tiLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352FFC4CEED;
	Mon, 28 Apr 2025 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830163;
	bh=e1+pWjA/4XJMy+FZasobwvu9HkFKH/UFadrX06asL8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EW7/tiLpB6wBWtkKq9Zehv/GxSybnP5GzoZtbUGmmyf7Dos2zXymEEWcgKj1ebIgm
	 XvQCWmzLjWlaUTE/+6BpU4SsiSHAIK2GNi3kvPdWNscEpp4dF+9IqpPhyWz3oRbGix
	 dU0J/7q9SZ1y8nl3vlFUoaI3uork4ZWIm23dCBugnkg/q3qRmhUHiGwcKAlXN7gRGh
	 ULbH+AiL8yfkFEOvdlI+7z6xGG5rYzcnpeMOojiNNw7gqanWmUP44nhkvpotdLYZ+5
	 SIpJrmjI+AEKws5RZFshptLihZpumraqqXfyoYvByEcDKqpQTaABcZflfmDJbbnR3T
	 jRp3Fw3FwvJ3A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 5.15.y 2/3] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Mon, 28 Apr 2025 10:49:15 +0200
Message-ID: <20250428084916.8489-2-kabel@kernel.org>
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

commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 02bcf5a4b073..06ae3440c785 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5639,6 +5639,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


