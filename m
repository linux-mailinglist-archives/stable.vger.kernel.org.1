Return-Path: <stable+bounces-92538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AC9C54DE
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A0F28543E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD38226B91;
	Tue, 12 Nov 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4YgFNSE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8A226B84;
	Tue, 12 Nov 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407856; cv=none; b=OCv45o5HEig+5XRqLGKX56+ORdVmECJuijoGVjWgvvgCyYbmZXWlkHY3xuAvVyO4wpnXEZNHjhAKow6OWInPxeRaYNlBkYnjEy/PjpiphVYajUpJL3eqMF0DvD6UIBN7y9bWiMq4mqSVlakQ71AWCMPXKtdBC3UUjpZGVqi9Nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407856; c=relaxed/simple;
	bh=lcduc60GNebFCYDHb+GQvYHyFjg9yhZLS6nfuLgYaqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX24azmOi1B40L/XRHMp2VGEs+2WYsmpKzQOfarG4B0mkMEz4pb9OGpuEsi2xo22zKgRLAnhT0QnzV8KcdxwmhKHvgqEhTOuL7AKHBYxvv0Pwm+Te2BQvD2UAgVnSYcnZkOmlKphfTh28qJ5zSreb3XjHp06LeRpvv2vghlr08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4YgFNSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4DDC4CED8;
	Tue, 12 Nov 2024 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407856;
	bh=lcduc60GNebFCYDHb+GQvYHyFjg9yhZLS6nfuLgYaqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4YgFNSE2Js6HV9ohpgTmgXM/6dmh9kiLnKZceJF5OcdG8vPEG5Gm1eBzMgYW+H0j
	 WOumfIJDBrCMzUfnu4qLs89rQxOVipXjvlfO92xVg7a53g8SlfIPuTyuYxhV0qTndI
	 qkTd5mMWfNa3iFc4STkVI8I71Pkf8j8z2dWWlJ/6OqyoFEp7STARqRt07RZL41jYGD
	 7WpMIrtueFZbpJCh36hOIZeOcOMXd4/WRCNBpyt5Jyl7bBGxo4xezCaLmABw1nLrDl
	 SCh1mC3U78epy8gUYYYWDmH2xaPbmC5vcnlqS5LqsaDKnRyJ8pXjbg0fqq3BhjDmRB
	 huQ3nTxhY9SAA==
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
Subject: [PATCH AUTOSEL 6.1 09/12] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:37:11 -0500
Message-ID: <20241112103718.1653723-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
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
index eb31b49e65978..3d237f75e81f5 100644
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


