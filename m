Return-Path: <stable+bounces-204803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F7CF40B8
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C7C3009540
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67F25A62E;
	Mon,  5 Jan 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK4YMU1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7D52F88
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621976; cv=none; b=Nw+6d6glxYK/yv5RE8NKjMTdE/xRAHKd6QuU0Xu/YjD2QTBnsFaw5Y+JWiEgPimMFQqzywFuGFugSL7hZ7GAd43lSa/ngxgaSQfijR8ycg8QM47ye1+zN59/Tv3MnrqbydPbty7ZWemiscSwRJ76OV69VTouOsGLO0zSIcVHJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621976; c=relaxed/simple;
	bh=ChJ0UGlYoL3LmAUvZoJuBIiTzGi0kUWHmU8unQKmgA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNXRd/JQJe/77CA4aX1JIU66yDCsmGX/UC7sw1hQTSl48P/rXs/w62zf1NJKz6+3xyAJYWZ43wAoen7q+vuYm1rZq8m+XRDapFF2i0RuZhMDyZC2upJF3UUUN5EKU9fgK0gfEOuPt3moyqAd4n5wjSpTmxOF6bTNWmWlVHjd0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK4YMU1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAED6C116D0;
	Mon,  5 Jan 2026 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621975;
	bh=ChJ0UGlYoL3LmAUvZoJuBIiTzGi0kUWHmU8unQKmgA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XK4YMU1MF/3ltUXyNpMAw/i7GrGRGSQuhfIGVds20kmEwDgGcRbUVGo4Knyg79HCF
	 FsrLRs1fdu8NiT6U3aotS1NszCuOGWUDUNct5oqey9ckzaiZisGE+3cwgpgk245E+J
	 k/xPTLVawyy4HcutvTonBYu5Mv7RKoMJWtVPX8Qc0Pwk6eMoXEpRI3JDtuoiw1YbcK
	 1FjpYQn0eQyRLx7SzsECkSUoVabKT3xbUdk90tY86E4D+/LoAyFBBrzyXiux20pWSS
	 jmyyFUCaKexaiR+Hwa100HFsebNUkbMfY/CHhLi120J/eSliwI5hGPGC1pvppHUfQs
	 WpmpqRHPrxBhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
Date: Mon,  5 Jan 2026 09:06:12 -0500
Message-ID: <20260105140613.2598547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010531-parole-sharpie-8fc0@gregkh>
References: <2026010531-parole-sharpie-8fc0@gregkh>
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
index 0629aa5f2fe4..a740ee6a3ca7 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1485,12 +1485,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
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


