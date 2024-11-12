Return-Path: <stable+bounces-92564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97CC9C5519
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F75B28B406
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBE1FB728;
	Tue, 12 Nov 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxioDTNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B28215C77;
	Tue, 12 Nov 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407891; cv=none; b=PfxcxN0pryS1px4EYVeNgd57fwMO4AOS8ySayJSBuHP30IdeSQI8QIVMtfi0Rl/6zx/f6uqOeTCegTrcxjx4SSqr/9jLWybrnBQqPWkHZ4RkEGwUOt1uEHkQaImq77xgVUKnn95/52cjGYWg/OlHCnFpL4vtkr9S0FrVehyftec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407891; c=relaxed/simple;
	bh=QhD5Wrr4zZ8WGJRryVvw7+4qMinM3ZvNb9LGCp/cyiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGfiNjpA9MiXPzVlG1n0rlFjHc7LHjZDGMwM9AtSxbsoTUxHJKq60XGWj+rn9twvcalUgOCqqUNKtLRoWQeaydLugQC7UoJQ+6KW3czoTLVuddNvdhEjuZc5So8E0Q+06E597aloYtsmHEZflZlzVSO83DmlrFx91Q6S8SxkCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxioDTNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B449C4CED4;
	Tue, 12 Nov 2024 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407891;
	bh=QhD5Wrr4zZ8WGJRryVvw7+4qMinM3ZvNb9LGCp/cyiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxioDTNU+dwIPLLZPVNlDm6PoZKAfUNFRfJfx3+Q1QElgmFlopY1OF7yn4/kKofk4
	 ZZ9j0n9DTlDjfVMX9oulH/a+HEf/LfJHksk/7SfpAZnRwzV8wEI2DiwKzJEdWWS/YD
	 oQq4dGsTmfgs73biHX8QqzJPIkh30FZHvqt8C1BLl4NukzAFNE43yctvf79niOeWst
	 7VwIsnW9xWjVySlGeIMwSRdSW4NWSO1bkthvkbgibov236YrlwXzTSXh9vcLmccvqA
	 tJC/PKuo+9nazM10KwJtZgAnfwjos3og2uX93XCeRN07Ds/ZSwpeA2s4i19aAWKKGV
	 dx9TdfQ6Jhk8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 4/6] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:37:59 -0500
Message-ID: <20241112103803.1654174-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103803.1654174-1-sashal@kernel.org>
References: <20241112103803.1654174-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.229
Content-Transfer-Encoding: 8bit

From: Luo Yifan <luoyifan@cmss.chinamobile.com>

[ Upstream commit 63c1c87993e0e5bb11bced3d8224446a2bc62338 ]

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation (*prate / div) is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
Link: https://patch.msgid.link/20241106014654.206860-1-luoyifan@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3aa1cf2624020..3a7f0102b4c5c 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -380,8 +380,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	div = stm32_sai_get_clk_div(sai, *prate, rate);
-	if (div < 0)
-		return div;
+	if (div <= 0)
+		return -EINVAL;
 
 	mclk->freq = *prate / div;
 
-- 
2.43.0


