Return-Path: <stable+bounces-100769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CBF9ED5D3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC9616B13D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157F2288D5;
	Wed, 11 Dec 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO4EEohn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED442545FB;
	Wed, 11 Dec 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943246; cv=none; b=eiUioESnpJDhxZKXY1bOp94Geo5kTo4n8r5tRHN80IiVYLJ5138+GPVIsdedVAIWSnRgbYXVTGDD4pfv+nDaK3MyNVE9KnrcTUxoZyDgHffTpGMrUOjOh7zoM0uR0uA7MNtImIc4RqbAt/lD1G+D+qXWuiGpc2zGmNFoK6YYz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943246; c=relaxed/simple;
	bh=uzp4v8bSwvgHt4k27kCRh41wAsOdjGCzSbTr09s6fWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CglUpKwOYzqVPRLI+EjUX+Ec3DGEDbL19yIk+/mAyESsgm8r3o7eE0yVfSrD0rutwov9RdEUkiG15oFOj/zfJKTAUiR+EGyb665tvlhAcH5xpU3Fx1iAgpxCmvi1WCFEMhgDWL5tMlaGRhBxTzHEzw/Q7Pm3bjNe4OJCr+mrP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO4EEohn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3340C4CEDE;
	Wed, 11 Dec 2024 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943245;
	bh=uzp4v8bSwvgHt4k27kCRh41wAsOdjGCzSbTr09s6fWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BO4EEohnlMfjjA1D51/A65koZPSQngbw+otfrAd86BZV5U3HsG7s5dVF0DkxrIxhX
	 7+P88RztvEjOYRC1V5jSnfFtbAVlb1nK42tJk1R54V/QLOsJwKz2y+WBylbhkHUxa0
	 V6vWN0Z4xorKzMMNl5pEmwN1wviCSI2NV1TS3M0cF5yn0D+w4UulS+icGp8C+WUUOh
	 Cz1QFUuIkCquYu3UF097n1VY8k4R/CYlK+E6fHZI3hPrxsmxmjOcCXt8JD7B6C8bAd
	 k6dpQ9LzlmFl99fac3z/C9B3rUHyyo1f5lpX3M5SMApNT4BDb2lB7m5VnjXEdeRit8
	 12dNqRQd21XnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 5.15 05/10] regmap: Use correct format specifier for logging range errors
Date: Wed, 11 Dec 2024 13:53:46 -0500
Message-ID: <20241211185355.3842902-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185355.3842902-1-sashal@kernel.org>
References: <20241211185355.3842902-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 3f1aa0c533d9dd8a835caf9a6824449c463ee7e2 ]

The register addresses are unsigned ints so we should use %u not %d to
log them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 893b0615935e9..85d324fd6a872 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1142,13 +1142,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}
-- 
2.43.0


