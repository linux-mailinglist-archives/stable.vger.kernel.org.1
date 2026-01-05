Return-Path: <stable+bounces-204813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DECF42ED
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7043065222
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEB30C610;
	Mon,  5 Jan 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btvpt7O6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9D30C37B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623790; cv=none; b=gD87fySvbb/fKFKiw9lZV4yiEL3aFv/mmc2Y9FTOp/PnpQZIKlVjFwV8FYRoL64E2D/EN9KA1b4hjU4l1ESZSp7g+tiQ5uemunrWBoQK8Ut+64gsGr83egQlLM0k1gRTLNXGni/U9J3sDA3j9wkFQQ0TVRtu7mWlbBDxjHKL2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623790; c=relaxed/simple;
	bh=6f8EgH4sGVmFuM9dl+wcbavsrSIqYnv1olBVsRO2Plw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utA7ZT2+jY+OIy6G3tEAYINywsmoJIJRdEqhT9kR0b4JPYMFPCUI4+ekN8jB/yC3VCc/tqjgb9KKrOrNkKbXsV6qUyMi/NKPhX8hj+LTAuaWYE1FMqnL0XaVx9lwVaml5qnqaB07oLo/znGN69ruCZSucj3pLAs8ZCg6fTOCzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btvpt7O6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FCFC19421;
	Mon,  5 Jan 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767623790;
	bh=6f8EgH4sGVmFuM9dl+wcbavsrSIqYnv1olBVsRO2Plw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Btvpt7O6QNm2TZN7tD7en8F7gQg5cfeoa/rvDuHl+ZjIx+823mZKZ4Dhi2a9TT+bg
	 naNffxyKHocE49JEqZwN6G2symqPsNcmHtA+N1MQt7PZdLlmLpc7moUo6OYxabo2w1
	 620JF+u6y+7v2MArOboLlpB2KA6qc96FlnYA66oTI7LdJoW8NqbYTLIQ0X1IgHnH8D
	 bE8ztfcVy/SIU+5+8y7r/ksTdHxspHDoOS0ruvX3opeIYC8Itfq3fIItZKGwmGpCQy
	 LJGKk/lfOmzxkp02CcOcHeY2QkHSNDzkkmhEuVuNVk93bd3/85JDlIyT+NuowZi33U
	 DphkSfxifitjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
Date: Mon,  5 Jan 2026 09:36:25 -0500
Message-ID: <20260105143626.2605607-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105143626.2605607-1-sashal@kernel.org>
References: <2026010531-relapse-parcel-11e0@gregkh>
 <20260105143626.2605607-1-sashal@kernel.org>
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
Stable-dep-of: 312ec2f0d9d1 ("ASoC: stm32: sai: fix clk prepare imbalance on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 0deaeb3d3c13..1ea083725655 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1487,12 +1487,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
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


