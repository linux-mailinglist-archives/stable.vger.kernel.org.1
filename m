Return-Path: <stable+bounces-85730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5E99E8AD
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF312B22EF9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A4C1EF0A5;
	Tue, 15 Oct 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ma9D5tzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15051EF0A0;
	Tue, 15 Oct 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994102; cv=none; b=erC8MNOFeknseGvxRjXYj7FsWqi1yhcGSU5nKhU4ekla3D2PHd1P0Y9KUy6mLTo+VoxP11BgVNJ6bHx36V8gHbuanYsxCh0hk6oVR/MX7M+85sY/n0xWGVXeRGzJHiiVRjtNKvK4qUwbrsEBD9WIlq0cwh9QApiKyFcirg6K72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994102; c=relaxed/simple;
	bh=nUQYKL171i7AiGD6lHqgZ1hKHDldtJc1Ng6VwscVAKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA2JEK3GlQMBdawVAW5q17uG7RF94izVQc+M9fJ+5A1hvS5Fg6TmkwvgNuX8RoNYKGdWVHYG57J0FvkPs4GdWT9wpoo3q0MVkO2HaCM7Djh8g6bFumylbqr8Lk3/PYTgvQU2P5xKl10lcaIdk7JTVikmO6V+wTH++B9bU1j5gxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ma9D5tzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A4FC4CECF;
	Tue, 15 Oct 2024 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994102;
	bh=nUQYKL171i7AiGD6lHqgZ1hKHDldtJc1Ng6VwscVAKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ma9D5tzvVJFeHi9nUdBOFA42LxDlezeVcDoNhuiUneMJI9krgYASsg4FwTV5OrB/J
	 07sj94Y1gkYzQKaj7b6lTUbLA0/VSi6T10YqNgrChsUtXYbQqZkGixr0hniksl3S6G
	 NAO4ybbwmtfuAaiCHuujLXEr+jhU4KNNY4aAu25A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 607/691] clk: bcm: bcm53573: fix OF node leak in init
Date: Tue, 15 Oct 2024 13:29:15 +0200
Message-ID: <20241015112504.432394401@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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




