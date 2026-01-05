Return-Path: <stable+bounces-204818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF5CF440A
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98F5F301D9C2
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05721E9B3F;
	Mon,  5 Jan 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZAgGDo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA719049B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624698; cv=none; b=Mp7d+9p8MJCTkgG5Q/foz8IrNuKSZBD423hN7SjcT4Q7dDKkza9SW0opujvUbe6taGGn6kvakh644V0aRmqBdFkXZi9tJ5NVDr5NDZeZW347iSE86jCejk4CsRHLD94Z1RoiZwRgHKywkz0uGYSy7/67FRASXrPwjEk3d1UtSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624698; c=relaxed/simple;
	bh=7hWMCHMQOvAmyIz2TVn/HcOUHlzVh/CJxxoQMX1NEug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJBtC+oOekx3+jJ2oeghB/X1+cUFuCyU+APWkwMCpNGyTaqYawzrBvZt05wogDFEavEwAHeGK7qMaqoTXkx72y1dKaUIjUi+qjuElpclOIxr/+Ii/JMlqcm5BYoJho9fvspLYUt4nAhZY4JIrw98bZvUWw2wxOerDrt1On/2KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZAgGDo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD4CC19421;
	Mon,  5 Jan 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624698;
	bh=7hWMCHMQOvAmyIz2TVn/HcOUHlzVh/CJxxoQMX1NEug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZAgGDo3htJPMu0lS9ObFNMlDeocQgIb289U74XsAAgmcv+vxEvrGqJXQQVMh7+nz
	 4ugUidQMeycNhaVpIUTfjRqDgq5eQlbUjmqajx/22+KTBceBhiuGXKbnJf5H/V4WSP
	 8FQPA1qFJLhkCh61GkCwGFSupxuRC2AcNX4nFEd7eGhI/wgF8Gv3B2xEmo2Qa9bbM3
	 2smCW5dOU8Jz1e4L8Fh5nRlaNaoUnv7+736iW30X2v/CPSWPqdFazSFxhBuKqx/UQw
	 DUrI732kTchrSINfp08CnaOZEpW5Fr+MN80cfXOpbDZezFyzJrHTJVzBWTW4skCIPH
	 hblsEqfwdZOqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
Date: Mon,  5 Jan 2026 09:51:32 -0500
Message-ID: <20260105145135.2613585-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105145135.2613585-1-sashal@kernel.org>
References: <2026010551-divinity-dislodge-aca5@gregkh>
 <20260105145135.2613585-1-sashal@kernel.org>
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
index 935e0dc05689..cc0e9429fc21 100644
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


