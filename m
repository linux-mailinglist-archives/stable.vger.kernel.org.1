Return-Path: <stable+bounces-81043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2A990E31
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF251C22114
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1E1DE88F;
	Fri,  4 Oct 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGk0oFYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD21DE886;
	Fri,  4 Oct 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066565; cv=none; b=Huj5Q0Bc5PIZo+3JwwVxf947aiQQ+yFjvRJgFxUc/YWgLVQL5O7XhFCW6pzawKlpuF4Vj9m/kxu/Y2aZAj/PmL48/85y1SzY2gSm0ZzkRQ8Mu4plceOp+TMmHIEgIuC98yz5r/6yQUyez+JWQzcDAvB0hYjTIlLd5W/aciKk71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066565; c=relaxed/simple;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp1wi3IJNN6J+pxuG2z6Ezpk7pEIWeyCMaQsxUNEVDuDC5a67bXXRDWSL0HnMEDW9kj9hyqXH13TBnEIlA4VUm5ms8NUOaKEEGNMeOOUS0XOegMv0CbRaDse/ca1v18fuku4wZRQqGgpZka+Dx75E5CK6nbs8GvXhoW+vBuJYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGk0oFYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850BAC4CECD;
	Fri,  4 Oct 2024 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066565;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGk0oFYR8620vT9+z8mSNUM9jzhlnYXoeoQrlkQfJnLpUtqPqW4FHGTPya/IJGrZf
	 udO2EFVXPdRQ9kfBzxyiEAcoJKufpO5U3cpKlpQazHWEj1oYlhs5WSn+fV8MYO9dHY
	 wL4tGMcl9bpQ+JJ1bMizLcj0hqurnljnklxphRZ96h0Pynbo7Z6xS4OlpMG2/gNkXL
	 B14hyxhTQqhteko2P4uzwsD3sk0OJXpWxEXUwYYaIZzm2tuVnC/NWS6W0PEa7v1BpS
	 +RAHoEVeWjzvr/rb0kr+cZ0ElYaPsAR2MbhAUYOxjZk4gJ0CpN6K3G0uYZZ7jmpHLb
	 1/sbDyUHe1Qfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/31] clk: bcm: bcm53573: fix OF node leak in init
Date: Fri,  4 Oct 2024 14:28:24 -0400
Message-ID: <20241004182854.3674661-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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


