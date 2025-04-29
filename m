Return-Path: <stable+bounces-137026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C7EAA081C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30771B61BC0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C22949F7;
	Tue, 29 Apr 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD3jnTVK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BD25D1F7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921311; cv=none; b=hxIEXM7RsSkf7McVt8MsTXnu8cQNqbgqYtwxoEOZoi22pyUOoduOah9SHZydFIoXsBfwBX8CNWiVq3UjsrixsKGuwz9hOCeM98Cb7UYmaYvzcKur/cONgyFEUv/Z4TQAFZgHTa3822ttcX5vvXQebK48FEDK41ixfsLB4HzUwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921311; c=relaxed/simple;
	bh=fJ8TG0yh71fO45MF1mZXoIV21ifr4g7iuYy0AGeGBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6tDs6AtXDV4l0xuZjF7QAcTqsEIFjSnTR/Byr/k35dL2tk2Gkrn4kftfiA0JSWl/0Gb4CBkFO4l/tw4zh1HWUZrhKFkYYgL3HYRklbQ/SB11DK8ZF6dIPsByBaLwhVa0vYXYpwA24IFxp+CpvUMOnWrC2xBdGX2Op6KgmboYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD3jnTVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CAAC4CEE3;
	Tue, 29 Apr 2025 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921311;
	bh=fJ8TG0yh71fO45MF1mZXoIV21ifr4g7iuYy0AGeGBMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD3jnTVKZMcOeyxrSJnZrAlqaLW5i03XnTHF5+gpdRwDOX/5/4qic55Lma1T9kWGG
	 q5F8vZA9mBNKlXgjbwQTOT98MdkUR8eD6OUrGbOoY1brLbjizKFUZhhTukktqvvisS
	 O9eK0tAg3FtFXLbzLAKYqNgQ5ArC9hzgyvWwCYWo4ouS2b9lrg0Tvie58h/qtg1HIT
	 tDhvUSn/D9uZ1KGQCKPYRQUtAeaHYHADxfOEsWIyHyDQphgyfG6OQZV0JFYdFoq04J
	 mQUFdITzwMVMnYEKAK2rFYpwu8S5mzL76jNlwKm8We2QQZ/kvDsOIqdOTJZCC7trr4
	 jAAZ9sE3+9mDw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v2 3/5] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 12:08:16 +0200
Message-ID: <20250429100818.17101-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429100818.17101-1-kabel@kernel.org>
References: <20250429100818.17101-1-kabel@kernel.org>
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
index 03c94178612c..a56b1d5a0cd0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6289,6 +6289,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


