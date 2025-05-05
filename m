Return-Path: <stable+bounces-141552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2352AAB73C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6220D17E9CC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF7342C37;
	Tue,  6 May 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuT933/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5CE283C86;
	Mon,  5 May 2025 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486679; cv=none; b=t/UuJKWT6Gg7bqMUfhLWQln9Z1pwEuFVtlbVk4+rchy9wzvsaG9bVXl2LJKfQyKCw331nTzon3+MBJ2a+ROavytnyPe5Y5prylEQ+4J7NxrHUEO8cVLsxlIeb8QxAiP5NZ4hTDMNrotHX7U/GTEsSZV7spYa2JYZDbzfm/oPcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486679; c=relaxed/simple;
	bh=oxeGttg3SoJ505VY3yrwYPkfynDRPeZkZ0HzLDrc7gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVA0uBJdzlOrohKpcT7fD64GWHQEwNkoefF5LRDxpURkAfrc/cSudvWGUlOXeh1HMiMfS+TnUik5l8nNhWp+Ph7glApKf67tUDrmHRm9XS6ESNPc8+SPWVEtTu+xh0CwW6zsEtCmBdQmkAMJLUq8Khdfp4De6OPFK4kPsrnB2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuT933/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E059BC4CEE4;
	Mon,  5 May 2025 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486677;
	bh=oxeGttg3SoJ505VY3yrwYPkfynDRPeZkZ0HzLDrc7gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuT933/d+uf/GcHdrR1Pwpc5KfGSR3a8hySKOStKrPhiO5BW2ewV3WMAcahXoV8NJ
	 bWza/D/qKu9VArNoL7vrx67ScJQyFKD9DjcBXw4H+eL/7J8IlwqPfzaKttel7NVJPw
	 E5z897aIfIiL70Nk+y4H/rhzhXNwwFgF5hyzkTue4EYfJgPr65AHR2M50sxQhrZp7Z
	 GhHcaWthDOSHaqbTqYD9cETz/5gSs2XlR+WVeDp68r+IohzbJO3iFklC43Ql/6pgKN
	 t3bGfU5WITnPppR2Ps7GBjuyy3RrNN/Hm7lKJ9A0937ReMp2RY2rUM7SvaAeR5Ql6z
	 rfZcnp5P1JB4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 146/212] pmdomain: imx: gpcv2: use proper helper for property detection
Date: Mon,  5 May 2025 19:05:18 -0400
Message-Id: <20250505230624.2692522-146-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 6568cb40e73163fa25e2779f7234b169b2e1a32e ]

Starting with commit c141ecc3cecd7 ("of: Warn when of_property_read_bool()
is used on non-boolean properties"), probing the gpcv2 device on i.MX8M
SoCs leads to warnings when LOCKDEP is enabled.

Fix this by checking property presence with of_property_present as
intended.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Link: https://lore.kernel.org/r/20250218-gpcv2-of-property-present-v1-1-3bb1a9789654@pengutronix.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 88aee59730e39..6d5b6ed36169f 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1347,7 +1347,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
-	    of_property_read_bool(domain->dev->of_node, "power-domains"))
+	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
-- 
2.39.5


