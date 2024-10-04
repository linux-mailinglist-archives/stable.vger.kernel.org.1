Return-Path: <stable+bounces-80881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC62B990C46
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC251F25ABD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706721BB15;
	Fri,  4 Oct 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSDchKt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D021BB12;
	Fri,  4 Oct 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066167; cv=none; b=PCtDfhnFRR8Nwc2HRTf+ktXTCfK3mwT0WayThKywhq8yU+FtUzrc5puwci2DJm/MXGDCJ5Hnu6fxBwWZaNw3i+hhqKMo5CQShbn+wzmvCKC4OS09LENR+cJ5LTvIx6yaLgYJxtv0LI1tRtI0kBJpry/faIn9oo+vCzu2LPsgbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066167; c=relaxed/simple;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXvmHIX5jGV7PWHYR4jL4Vktxj2Pj0cqEGARdjj17AQvfIwDCqcndhqH3fJEyEIk/Ig5UYLCYKeiiT6bhCbbI/uRjgkNMDtDvixef+IK5EpvKEud2AmOAfs2W2IFR5eDumes7xbzB5IMZ6FvWw4AbwL5U68bQNCVrzeqibHgcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSDchKt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF19C4CEC6;
	Fri,  4 Oct 2024 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066167;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSDchKt+KwNHkqCo+Pf5dwu4Tv3nr+JxGUaozAY+90cF5nZf+HwWq/YT+uAALRoDW
	 DGMN6vdayeOeTZoVwwjHO0FizFKzn+ynLtNpSOsb0b+t3dO6IAMf54FUzMZIyWns6m
	 oceV6V8WP2wxIZc7m27gedZgpga7e6EZxPQVj9kxYi0n3d+g/d8niDf6n02UcwA61y
	 gymMvHJvzLThyDM91FTKo+8ysLgkBotdKfnz618RRJRkUUaaYaN86rXbETM+ET3D70
	 ezV8UP49cyjfCChyMeR+IJTL1iUpFkyScYrrbwGJ3jzhDx63NMdo104kcnYYeAtJuv
	 j9ZZkNtet06WA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 25/70] clk: bcm: bcm53573: fix OF node leak in init
Date: Fri,  4 Oct 2024 14:20:23 -0400
Message-ID: <20241004182200.3670903-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


