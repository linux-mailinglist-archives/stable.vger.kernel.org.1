Return-Path: <stable+bounces-80949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A4990D21
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93921F22926
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957B204F73;
	Fri,  4 Oct 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjHq2bGw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A50204F6A;
	Fri,  4 Oct 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066346; cv=none; b=SZdH5raMu/irUHXeF+UHYdmlqSmiXQEP3hk2s95Pm5HCPb+oorXHVf53w4u4cugsXQA0iiNgWGSyKYJL4BM9kwDQCRh/Y4f81rgx3qVfnFir3Wdsku2kYN7bqu6IZDmmoVccYHGs7OWgtzQxF3Mnuu9f19M4bZhnMBq1RGyvO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066346; c=relaxed/simple;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtGKAomlyvuhEBV024j1s0YODn8IOh8s/SqAMs2yqUEGzW5SZs+TB5q3wSEHbK7deBgyd0cxAIsMutAR9zbis4h4DWQa/eAkYfYbtqhsx9EYlzPw30aMsB3T2aBsCJbsCEZULtwC/J1g4zaYRW/7GJ2Xd9tjIv5+C20du9W+6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjHq2bGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDD8C4CECC;
	Fri,  4 Oct 2024 18:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066346;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjHq2bGweARtLGqWosheb+HUh/erYUj9GlLl12ByaH4jdrtSP293MadgU+vKHXjtY
	 jRasZxv5dLPQBdcpvWTksGDazpLSEUV6bRv51Xiq1UdDbZLukJAQ7vlBCUhwflFkpB
	 AabJV3fOwQfTdLvhJNppxdg0fTlwgvZFoIP40rg901gn8mcX7Hj+isDPhcz6xksRwK
	 Av5uNQ8aYKRMaxQAVwKnkT+Uoh+V5fnadDS3L6nlt+J0D1OpcE8xEClTpcCbQ42Iyy
	 sMb0iLH9sp3xnTtnOXw5auc2axSihb+LE5gt2s0HTPkgi74A3023LtK/hLS/VFdGoK
	 CcVqAswo5rh6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/58] clk: bcm: bcm53573: fix OF node leak in init
Date: Fri,  4 Oct 2024 14:23:56 -0400
Message-ID: <20241004182503.3672477-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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


