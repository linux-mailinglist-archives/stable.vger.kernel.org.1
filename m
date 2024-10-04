Return-Path: <stable+bounces-81001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CF1990DB5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E2B285E39
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1F1D90DF;
	Fri,  4 Oct 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIHIVUEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3B1D90CE;
	Fri,  4 Oct 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066471; cv=none; b=TxK0GpOCpXjSRltQSjhFryOG5WL5kFWVtjeoW4TqQX3u73x+/Es2BnCFffE1Nx8JOXjCHzEjPzcLT0Ei9uC2KoFyxxeRRBrqzIYoed1OKjFmPnKc8XGSNwYLtgbl4sW2aWrbYAx1AQWjvtmMozJtuMQP8X4HAvqgHU2sC6GAo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066471; c=relaxed/simple;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOEnucXJES6hpuu9joptsdxNXiKdYu/UmB980yM8f5AceObPeAGZqJVcIQLiaSawf2Y1Zd5Zwy9QMEFwZoQSF6mHyhhU3ognfQ3FABT+Nl69WxAkxmT6MqlcWw6sdJozxC8aemBwzwr/cMCiiOKi46b1XXueT92BwxbbYMTnaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIHIVUEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D889BC4CECC;
	Fri,  4 Oct 2024 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066470;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIHIVUEYDmWjeJTlkZnvdARM/t+5rIkmnmoEYvAAZlfC4DTya4YX0jikurpljwSJm
	 KhwpLtB7CUmHpD/qZjUJKevdqnI/q8FUir/YBFRklIM2CTvFZzj5H0oOC5INp1vZ5Z
	 ap/VEaO2KErimfiJgy6qkFSRBsFDAJzoVfHyT91hADOX/+fZ4x2MsjTcoVJHSgnltf
	 K2xtj9EO9GIe1xS1l95fIDKjS0qLeX+2lOffR4BTg7lczjT1VjaD3PnnjIHLbi317p
	 o89UzXKXJ9aI72awXoQeXQTmM9yVhhkJctECHaC50/RYIkTa9xQMv6hqRixU6crCjE
	 rD6/VjT+eJC9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/42] clk: bcm: bcm53573: fix OF node leak in init
Date: Fri,  4 Oct 2024 14:26:28 -0400
Message-ID: <20241004182718.3673735-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit f92d67e23b8caa81f6322a2bad1d633b00ca000e ]

Driver code is leaking OF node reference from of_get_parent() in
bcm53573_ilp_init().  Usage of of_get_parent() is not needed in the
first place, because the parent node will not be freed while we are
processing given node (triggered by CLK_OF_DECLARE()).  Thus fix the
leak by accessing parent directly, instead of of_get_parent().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240826065801.17081-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/bcm/clk-bcm53573-ilp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm53573-ilp.c b/drivers/clk/bcm/clk-bcm53573-ilp.c
index 84f2af736ee8a..83ef41d618be3 100644
--- a/drivers/clk/bcm/clk-bcm53573-ilp.c
+++ b/drivers/clk/bcm/clk-bcm53573-ilp.c
@@ -112,7 +112,7 @@ static void bcm53573_ilp_init(struct device_node *np)
 		goto err_free_ilp;
 	}
 
-	ilp->regmap = syscon_node_to_regmap(of_get_parent(np));
+	ilp->regmap = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(ilp->regmap)) {
 		err = PTR_ERR(ilp->regmap);
 		goto err_free_ilp;
-- 
2.43.0


