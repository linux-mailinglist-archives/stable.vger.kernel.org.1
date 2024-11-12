Return-Path: <stable+bounces-92491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6B9C5570
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01CBB31BC9
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA7219E34;
	Tue, 12 Nov 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRGOKg2N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E353219E22;
	Tue, 12 Nov 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407790; cv=none; b=Uvz4vQYOxEM2GY0TusKc7BUTciVncW9nM8bztCcZej1JLPzYgvc1NgtkLpwjikHmT5MDCUgq021g+6HSR+E3chTVVmM7p3JCTcQLHdGDbfu02+SLjWdAb2/znqPszA9KMr07SnDNbz4yw4nBHlVm5X3ujPE0F/UpxfJhhOD7vR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407790; c=relaxed/simple;
	bh=4rsZ7XKzD7PO2tZLFTEdw8ukKSap/AdkY01vjvFPy7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua48UsktTh3siCp4EXhjs6UcUKeb0cM/IR/h6l05Ik52gIQ/KpafbIiOnmB0rGGq3t4ExQMtF1eIiPWZro6pK9FSjUqFaerns7Bw37UJWglTtChnWPu3Anb/0Qpm4GiaIaqBWtIJvyo96kB4623nshdKz8uyqlmblUhw2y++eO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRGOKg2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30D6C4CED6;
	Tue, 12 Nov 2024 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407790;
	bh=4rsZ7XKzD7PO2tZLFTEdw8ukKSap/AdkY01vjvFPy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRGOKg2NDA6ciN67AJOduf2CqZFn2EKLiZ9mxmpiV8H5Z7Zq4kdVbP2F8bUArTBXw
	 D7fHssYX5pC2UcFIvgge/qF4TiEs9e77RKc1eNfv7LfuQwx6WJOAKwEZ8HnUW1iWXK
	 qkp3NtbR+tFy5/BSJltbSN/CUiShABmN2AsCEXBu/eQ1LpxyFQEBWRB8rxbMb+Hgpg
	 wa6jJ+YEhnE3LyuBbwIlmjHrHrDTGXY0gCFpBlKIws8osa+PgGBOiQC46AKxQzdqdm
	 yvoOrzxw9G8PJNUE1/d22kodEEOe+VbKicwInS3IyaLZhX7fTXl07cQs+kR5o9tzkG
	 smyxmqqDbu0CQ==
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
Subject: [PATCH AUTOSEL 6.11 13/16] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:35:55 -0500
Message-ID: <20241112103605.1652910-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
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
index ad2492efb1cdc..19307812ec765 100644
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


