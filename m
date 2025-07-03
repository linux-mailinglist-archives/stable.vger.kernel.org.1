Return-Path: <stable+bounces-159299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD3AF7081
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FCE163DC0
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A72E4985;
	Thu,  3 Jul 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oml0vLqe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC102E2EFA;
	Thu,  3 Jul 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538964; cv=none; b=YaL4CG2JTkq0yf/RmfFIb5eVZQQDG3RSVtOjYk+jQmxmt0wtPbqfTKyhFhb8dy5tBzv/nLWNAfIHI2z8SiyLNPPVMn4hX0BQNuolUZgzFxpmsDXIAqbgh60PEIp45xUvrDJ7tTKfgHg9DPQroIoLLy4pLEJXrKNrnj2/gB7F+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538964; c=relaxed/simple;
	bh=8GDeykpuAMrcvSeGKcpYVdb9vtGqvD8Aq5P8nLstucc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jejW/2uNtmoBRqzwCwLon+ZKqoN4NxUlYlb059b/4NjzGxe23YH3TJlB4LyTRW9Dh0eDGGEBv56fGJw3sQfTiUT++OHmvF6mlofb/ckbjIwMr51MdJihRMh1BG46VQNxfPl1DRaZWIk6gSVUMtAncRyOXHP4QhRKH7Qj8LKCOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oml0vLqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1081AC4CEEB;
	Thu,  3 Jul 2025 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538964;
	bh=8GDeykpuAMrcvSeGKcpYVdb9vtGqvD8Aq5P8nLstucc=;
	h=From:To:Cc:Subject:Date:From;
	b=Oml0vLqee0sOaYfvVwpdu1JoX8sV+JjlEV1788Wldot00I324HiY0X1m2RkxkIyV8
	 1WZcUo8iojpuf9S9xwf8IgtN/L2Y6r0W0S1N2o7DRyHUH+tnkUOgq6t4qzNjcRaxHA
	 kqhd0LyRg6BoIZZBaf51NZ+50iNjKyQ1ElrMmens/WYSfTatw5dzCCamXUxBpqFnq5
	 vSlY/f5Azj3Nsl2jovjFDW4hzc7q9Enk7O7LT1765htH3G6eX1GEm3DrawMDH4pgc/
	 xwqLNLrcuycVOBPvQNcs7I0WIcbBpF+ld7qS6lgZiLJO9Gm+ZM4mtBT6tVyaEFhK/8
	 kG+++NJozxS6A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods
Date: Thu,  3 Jul 2025 16:05:49 +0530
Message-ID: <20250703103549.16558-1-mani@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drvdata::gpiods is supposed to hold an array of 'gpio_desc' pointers. But
the memory is allocated for only one pointer. This will lead to
out-of-bounds access later in the code if 'config::ngpios' is > 1. So
fix the code to allocate enough memory to hold 'config::ngpios' of GPIO
descriptors.

While at it, also move the check for memory allocation failure to be below
the allocation to make it more readable.

Cc: stable@vger.kernel.org # 5.0
Fixes: d6cd33ad7102 ("regulator: gpio: Convert to use descriptors")
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/regulator/gpio-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 75bd53445ba7..6351ceefdb3e 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -260,8 +260,10 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	drvdata->gpiods = devm_kzalloc(dev, sizeof(struct gpio_desc *),
-				       GFP_KERNEL);
+	drvdata->gpiods = devm_kcalloc(dev, config->ngpios,
+				       sizeof(struct gpio_desc *), GFP_KERNEL);
+	if (!drvdata->gpiods)
+		return -ENOMEM;
 
 	if (config->input_supply) {
 		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
@@ -274,8 +276,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!drvdata->gpiods)
-		return -ENOMEM;
 	for (i = 0; i < config->ngpios; i++) {
 		drvdata->gpiods[i] = devm_gpiod_get_index(dev,
 							  NULL,
-- 
2.45.2


