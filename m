Return-Path: <stable+bounces-204831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D4CF4507
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 164913007649
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D73093CB;
	Mon,  5 Jan 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/iJ6aun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C83093C3
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625838; cv=none; b=ictMR2dUEz8pbrp8Z/YOK6JEsXxdPSnugB3sZIEfaRk+FWiPmoAKPyz/Uxt3VdHcvwMlFF0TY1ZlaMKgFuE5PmYFOhp2xVzrguZOHKEuqlmPGwSc4HE347p3f+xWSAoiLgK2iqgr6YORV4GYpN2zsIUx5YffRlCPc+AA7YKyX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625838; c=relaxed/simple;
	bh=k8Ix1Uu/wEdCgDoHLWI7dMCdtwOSBNslUh8JSc22pg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJgbCy3lD840cA9pqj2Bcb77W2soNtMxq9SSd2V68TPaLc6AUr7EziZYPtfQwAMFNBNS9GCCs+LOA8C+FmkuG179JRXNIhPFAkM+K6f4EBU5UDMtVI16wYI23Pe1KTHu+wELuy1TAHpswZFuKix81p8wBm6dV2vFXLZjz2QxA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/iJ6aun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DF0C19425;
	Mon,  5 Jan 2026 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625837;
	bh=k8Ix1Uu/wEdCgDoHLWI7dMCdtwOSBNslUh8JSc22pg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/iJ6aunLfnWZNYWVZItdvFcS0C94/X43X7lWqfOV6ywwIl55FYMl8jMMbovvp5gV
	 BvzVj8hPrPz831q4ZhXvlUMAtonnpv6LafG6TMvVHl4j2eyJKWDDkE10MTfwvLTZ6q
	 9/BRQNuAtrODcAEe7f/Pz3Dj09YgljaJfBxP36iO5ttdaL6Atd4v9kGVcOs4XA9ViU
	 NHdRtwWzEZ979DaVtT257k4jxDpjCOGBm0amwNCbhZH4EVBQloJMGMI1a5xetfhazD
	 yqWyKlt0tfGSzzXX5Sua9MJz+qpcPqXhQpEAoFXkuMLJ72D4zavpn0SfjOjdalfk9E
	 Mrgliehc2742g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
Date: Mon,  5 Jan 2026 10:10:30 -0500
Message-ID: <20260105151034.2625317-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105151034.2625317-1-sashal@kernel.org>
References: <2026010551-backpedal-chatroom-a9c7@gregkh>
 <20260105151034.2625317-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 374628fb668e50b42fe81f2a63af616182415bcd ]

Use devm_clk_get_optional() instead of hand writing it.
This saves some LoC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/f7987f18dadf77bfa09969fd4c82d5a0f4e4e3b7.1684594838.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 23261f0de094 ("ASoC: stm32: sai: fix OF node leak on probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d179400b9b09..e4ee4c800275 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1486,12 +1486,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 	} else {
-		sai->sai_mclk = devm_clk_get(&pdev->dev, "MCLK");
-		if (IS_ERR(sai->sai_mclk)) {
-			if (PTR_ERR(sai->sai_mclk) != -ENOENT)
-				return PTR_ERR(sai->sai_mclk);
-			sai->sai_mclk = NULL;
-		}
+		sai->sai_mclk = devm_clk_get_optional(&pdev->dev, "MCLK");
+		if (IS_ERR(sai->sai_mclk))
+			return PTR_ERR(sai->sai_mclk);
 	}
 
 	return 0;
-- 
2.51.0


