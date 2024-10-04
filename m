Return-Path: <stable+bounces-80806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099BF990B61
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78FAB27A77
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CA221E2D;
	Fri,  4 Oct 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbLY/Usr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F1221E27;
	Fri,  4 Oct 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065956; cv=none; b=c/cZl+AGHRiIZHvud0WP0fL4qoO+YIU8y/2qmv5OeM8iG05DbOjD/v8OexSYMIBEIB6MRZwidaFyb/zihlsbqMNmvCrOCv3buz4ocntW3mGKTujlerbCed9q0S6wG3xT8Nr3atllnWwWmVwAqnpWMqEfvyKCKdPT28wr8OWsRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065956; c=relaxed/simple;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8S2Jiyox5mWxCyupEL7RORKQAda1E2GtMpWetrWRviqZ7AMuMcZ7mJ5CQvSJHf/MIpsvp7Wlq3/ERq/ZegAOxFC6tv0pGr4kpswuAH/huTf2Sl3HKN8H6onx8h6NeSuuJg3PDvb9+Wd02YaCJC76UThnh/oOb9kpRt8qD/s4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbLY/Usr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62139C4CECC;
	Fri,  4 Oct 2024 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065956;
	bh=ABc0QBjQCqeraLJRnvc3Amm0w2qOe4YTPG226MAJ5fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbLY/UsrDqImqLKaT6IZNk9NbLkdsW75YDHFk/z/lT5MLL/e3tsVr6EIJfkwseFU2
	 tDcS6laJ98vT8yY6QcbtR5USLyfQmcbdz5poTVLBQbqqeFOEgVTaZ+MpiCgIPA7sl9
	 uOOt7YBe4QALCyHVgNHkutrqLLPGBi+C2sosqe3o0VHAQjxwbcOzphBoXBp8dlqygG
	 XPz8fX16eXnVYCjT2Vt6iFAnf1Qmk+PbxEjLqaueiY3usB6UKGcB/CiLfnar+3BQfe
	 KvR3vWzdLVzg9yPiocpS+WiymV4S/jDW8S0ljnXcVk+kSlIE5EKaaGcrcnKGHa9Cep
	 dAEq8q6Z0q/rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 26/76] clk: bcm: bcm53573: fix OF node leak in init
Date: Fri,  4 Oct 2024 14:16:43 -0400
Message-ID: <20241004181828.3669209-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


