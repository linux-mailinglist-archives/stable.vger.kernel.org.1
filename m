Return-Path: <stable+bounces-100779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA749ED605
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1070D188454E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FB256AC3;
	Wed, 11 Dec 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ0IdK/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA4256ABB;
	Wed, 11 Dec 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943270; cv=none; b=EXShZ1m7bisIwi7Jq6cS34dYdI+TtF2+XlRlH2C6bSZlrlK0L3UTgun6q2NHCutVipmBLPqb65HcIsr8NDFK7XUqtOZKLjBp0zUxy5I6C5Qtig+vwE72nc83jBgjt3U0CwqwFRyDoF2V389jbIjAHvFFsTn7RiHD++uEzDXVNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943270; c=relaxed/simple;
	bh=+/2APJTlEaO6GwbogEmMv7kAhKz8ORpYko0jAXVVIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqhVhrA4pga7cCNe+tQsA+7muHJ1pcrFoMqJGV5XUcw5DMYKv70bchN+eL85IPDXZoHkE1Tg4QJ7XLdPu5ezJQIoLbtgzuvyZMQSP4h5XwwDTvrapWdTY5WIpyL34jH2A45r1GbTTQdZjLuJ+yEsvjnVoJ/nzSipJYXEyR30w1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ0IdK/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D47C4CED4;
	Wed, 11 Dec 2024 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943270;
	bh=+/2APJTlEaO6GwbogEmMv7kAhKz8ORpYko0jAXVVIN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJ0IdK/7wH9n0TTxA+Na+tQOLLuisZBG4pQz+HvH8yTpU253pYDJZlA6CGzgZIgsw
	 Uo3N9D854XxVsb4Y6kQ0Bq4HpA4v25u+wZkxy4GynwewMe08NJtacBv8LwEoitupUL
	 Wd9rPXimJVNGVyzTY8y4No4ZQCfXWgihRSBSoS53IHny3Io6NP8yQRZb3/kYDEYELp
	 G33hKsF4r3lIEK68dnyKRLPlCeT0VkM5pETMF0K+/X3mI+TPqDBjrzu0gY0Rk5eGPb
	 zwudTchrK2WsaPrLWX751m2bPrPFV9qQBL9dZZqU+t1zBwbEbnU7jq2w5O6MGdikA3
	 bsAXsVgc0OC1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 5.10 05/10] regmap: Use correct format specifier for logging range errors
Date: Wed, 11 Dec 2024 13:54:11 -0500
Message-ID: <20241211185419.3843138-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185419.3843138-1-sashal@kernel.org>
References: <20241211185419.3843138-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index a3c4086603a60..7ce28ae9aa23e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1104,13 +1104,13 @@ struct regmap *__regmap_init(struct device *dev,
 
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


