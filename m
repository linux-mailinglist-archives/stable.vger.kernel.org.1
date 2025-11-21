Return-Path: <stable+bounces-196528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD875C7AE6C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 300B24EE634
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACF2EBBA4;
	Fri, 21 Nov 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6xYXr6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8F25A341;
	Fri, 21 Nov 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743216; cv=none; b=VZIdyjYF70AfrwETInSAZHZznmtdevJUy49s7jNGc674KjJ6xTllQXIsK7CKoTFeY0euVJS1WmB7Hz6AchUkoT1N2/7QzFkyIv1m5QpCJWvsIBZcDjMeauwFxHgpcR2T4K7aKut06y+Xs4O7c2Sb7M/BHbjka6JKcyqmpFe7XGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743216; c=relaxed/simple;
	bh=rK8BZaRZsq2leGFmU0XZp412oi8cBImVGfOfJVuiS/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0n/9rBuJgTwj66znT2ToPef6HUh+y0Xu04PRfnS2ycxkt4/McUvCRJjMqnPBpSofG34Tu7FZzU0nxSDqi6/JYbdneOUA8kgszDd4zl9edr78FO9iNwkVxy4tJgAJF6rBQpVpmTE9VVuB3VAUrgfQYg5A1cyMCPsL5a4ChgjpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6xYXr6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E6AC4CEF1;
	Fri, 21 Nov 2025 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743216;
	bh=rK8BZaRZsq2leGFmU0XZp412oi8cBImVGfOfJVuiS/I=;
	h=From:To:Cc:Subject:Date:From;
	b=s6xYXr6CLM7zdOsD9G+p5iwk19J47YNPRTZVO37HBo52cVYu50kYXgG8hUbffsD8a
	 PScJ0TnloQTbYD6a4+N5vOQQ8ETLONqymdDkZKXgskENhUWiPZucQ1oipSYtiCspm5
	 6kuuO00aCK4g6gyADpmOAdMEJtCm3dpm/Oe1xnPF8n/UlQFmSWoAKKChAvLKWo0J/3
	 hgXz4F4kSvMPY+/whXvDNnEoC7VwOnWhSdWOU0VXBoAd42+DAmMI5ucvczUO+dM6q9
	 2TeQlbriikxUzEqniOlM6iLxOxLnrI3s16jQnA9xlaMApD5rJ2zoIvLLoKGUSMNL34
	 S/b6Wn68UYjEA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMUBF-000000003Oj-006R;
	Fri, 21 Nov 2025 17:40:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] clk: tegra: tegra124-emc: fix device leak on set_rate()
Date: Fri, 21 Nov 2025 17:40:03 +0100
Message-ID: <20251121164003.13047-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the EMC device and
its driver data on first set_rate().

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
Fixes: 6d6ef58c2470 ("clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver")
Cc: stable@vger.kernel.org	# 4.2: 6d6ef58c2470
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 2a6db0434281..2777e70da8b9 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -197,8 +197,8 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 	tegra->emc_node = NULL;
 
 	tegra->emc = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
 	if (!tegra->emc) {
-		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
-- 
2.51.2


