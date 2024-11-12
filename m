Return-Path: <stable+bounces-92517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998219C54AC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5C289516
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7521F4D7;
	Tue, 12 Nov 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcuzQBaD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E421F4D0;
	Tue, 12 Nov 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407828; cv=none; b=axD0cm5F0D3hZcLdNFPqfNkx7DrOu9522P4ScDX1LXgnyIgodZKhdvw3GF7NRQru4kA3I0oKAbe6glnyUbYlQw7/7JxK8Ts68mkuzNUNNZ8kYWUrwQWMwLcpztsX1k334MkrGZioih7pDa8g9Ss+YMYuJYMqAASChmnuHoBmJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407828; c=relaxed/simple;
	bh=gcv43duiZlx3LiKyePNQ3QLqwqId7kWDW/PegWv9o20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXSv0M/2wdPE6xG91qaU5O4RBENBpozVMXKzYJK/SU28NSnTunXF6S1HZ+RnmNpy97lR/KpZLy4Xen9o3WO0YwqXn0nB5ARRBcVbVosl2ek/nB5MvVwb1HXqF5OD4LPBqRS++kn2VoBCiepQ6w7OySUSrFr9oaufJvTxciTCJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcuzQBaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1245AC4CED7;
	Tue, 12 Nov 2024 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407827;
	bh=gcv43duiZlx3LiKyePNQ3QLqwqId7kWDW/PegWv9o20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcuzQBaDCvka7cJavNwqvkZQkLkwdocA4aFbdSevA0WHGWlIpbVCawiOT8vlny9Ip
	 0HIdSVmpnOg9lZ67hv8eTmcWn7PxKWGIBLXtJX4xnxRygCmo4MzrH3Deb19iNTfXhY
	 DPxKQr7kka2AKiOc28zClQc78eX+aJuOtnMsWE1Tx5gwrTvNlieMMNe4MiJCECmBgc
	 jZQCN20Ow5wv27rV6EzFYRQcD7PqarofcyzHuJh282ok9wIEmyJJo2E/jOqEpPtYkY
	 cVUCQdVCxF22FTTbn1/YwQvVVapqwCVB+INzGqOxVXqFSh3iYpUpRQyRpDIvLyj7PN
	 GAThcyuMpL1Jg==
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
Subject: [PATCH AUTOSEL 6.6 12/15] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:36:33 -0500
Message-ID: <20241112103643.1653381-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
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
index 0acc848c1f004..1b61110cb9174 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -378,8 +378,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	div = stm32_sai_get_clk_div(sai, *prate, rate);
-	if (div < 0)
-		return div;
+	if (div <= 0)
+		return -EINVAL;
 
 	mclk->freq = *prate / div;
 
-- 
2.43.0


