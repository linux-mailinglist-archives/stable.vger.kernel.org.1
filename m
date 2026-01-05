Return-Path: <stable+bounces-204811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848DFCF41EB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9543081135
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F9217F24;
	Mon,  5 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSD/nw//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3120125F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623253; cv=none; b=iwMUiHqP4jmpGAnP2ZJKTdtpQB9+yJX82ypPfQ5iFYKoYbL41jWY79duWb82ghZ4R4q9i6uQLimAAqg/Fk0dJU37SFPuaelB2AktPQvozioxPsjQaSPcPFeGRfWR268x5XP7Ie1G0c0FrWWIK2P30My4n7SB4loEygS3NsbLPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623253; c=relaxed/simple;
	bh=r8LI+e9IVrmNgE5UvrvtvqaCqK5TmMa1iIbrCt0vr4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpQvYcLJUgVbsfDDHvnB5ZBZejOPIuDx3STZdilgrcrjy2hajxH29mgBmNekWShX1DZAARfqrU8hvJpRIuOSM8ztlUjT2JopiIUpP7QvHR0rNllljlskZyenqPAVrpE1Cqv9G/FUWZg6Tiii8k7LZQg+dlzLiAznkq0304KmY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSD/nw//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E790C19425;
	Mon,  5 Jan 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767623251;
	bh=r8LI+e9IVrmNgE5UvrvtvqaCqK5TmMa1iIbrCt0vr4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSD/nw//uL6jZF/77nB9yuygf7Z8Querhfmp5WCR09/TbUQGHjajBl3778Uu0rBaT
	 BWnQ0dzFmZalP9908tc0ZSz0rNK8SVTiuTc4txaYUN7Td3Av4iJHYX1zRL2Ui20LGz
	 4QV/5/d0fJ97bpEt3p9f+qmZ4T7khfjs5dtJpkjLdU+uq/iWST9HhmdZUt/at3Iglz
	 RsXp9FkBdFnB/QnBWYFbWqksnlrBoJfum9g6/n0EGRxMhETzbJ/tnydPoBShlyZY1/
	 AsjncwlfJWYfL9kIwA95QqS92grssj0ksv7iGz427AS345VUnUPE0Vq27Q8/cFLelo
	 cxNG7tTFXbcsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
Date: Mon,  5 Jan 2026 09:27:27 -0500
Message-ID: <20260105142728.2602716-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105142728.2602716-1-sashal@kernel.org>
References: <2026010531-vendor-unissued-6b5a@gregkh>
 <20260105142728.2602716-1-sashal@kernel.org>
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
index 0db307cdb825..15f8322d2e43 100644
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


