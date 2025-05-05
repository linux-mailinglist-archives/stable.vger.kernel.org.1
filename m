Return-Path: <stable+bounces-140339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A358AAA7D7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09E79A04DF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D533DE16;
	Mon,  5 May 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtbewIhK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95A33DE0A;
	Mon,  5 May 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484658; cv=none; b=Ag/jOrwNywrq2bkLeuoV0H4v9TqbGKRhdTBf25bHUOjZBoDP9Nxk4KmKIOlD4o28jWb42LlPLQj7eo78jU6wxkSl74mdhM3ANqn7ex4Mm+r2hVNhZlcm11/kxaIpTH0shuY2udsmqJkt4EsC9o+ZO4v44UrZqRPiczz5yYdcZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484658; c=relaxed/simple;
	bh=5fB5oUZhc39xpZeWHqD2PSF7T88HaYAVhdoLWGMnc+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6SlVyP/7uqgutKW7wYaiTo+wh+hBh/byVQnxKpDv60VP19DS+u/6gwzbK5zsWiTh1dAvVopwg7UT4s55sw9jaQeNHlQs7FpnqlHd7IeUJa4JfBMBTcG70Q/2WXaBgP0M3Ur6MEsAk5fazIzSmWm/wGJoQ/G2eYnZxxaq9uv3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtbewIhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE34C4CEE4;
	Mon,  5 May 2025 22:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484658;
	bh=5fB5oUZhc39xpZeWHqD2PSF7T88HaYAVhdoLWGMnc+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtbewIhKdirNoB1SUCmlWaLxM2lv0kGzlxww3xVz2MxzWapkHxW/+HZ/+WBMoA8yl
	 Aqw5CrmRsp0PPSZb20w6aEtzUHM1zh0iaLTt5Jgvef+ghFrhrxysV8oTtP7BnTWzYp
	 Kwb6lqJ/psqGBQUmutR4kbR08RjgKpzAqVl4bV8ZMgJHUwSAeflUM5RYIgfxMvUCin
	 P7gZfENLJE84uuXngnNhQbTI2oAOFe21pFDtfvhpJwmMnGQUm2/z0JSlvOKjawjUtk
	 /0sDwgEqjwsu4mScfyuqroSKS9KvANq6hlKq3EawxXuI7gcuSL+OD9lK6ViOnT4pFG
	 GMOEBlrrvv1Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.14 590/642] regulator: ad5398: Add device tree support
Date: Mon,  5 May 2025 18:13:26 -0400
Message-Id: <20250505221419.2672473-590-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Isaac Scott <isaac.scott@ideasonboard.com>

[ Upstream commit 5a6a461079decea452fdcae955bccecf92e07e97 ]

Previously, the ad5398 driver used only platform_data, which is
deprecated in favour of device tree. This caused the AD5398 to fail to
probe as it could not load its init_data. If the AD5398 has a device
tree node, pull the init_data from there using
of_get_regulator_init_data.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Link: https://patch.msgid.link/20250128173143.959600-4-isaac.scott@ideasonboard.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/ad5398.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 40f7dba42b5ad..404cbe32711e7 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define AD5398_CURRENT_EN_MASK	0x8000
 
@@ -221,15 +222,20 @@ static int ad5398_probe(struct i2c_client *client)
 	const struct ad5398_current_data_format *df =
 			(struct ad5398_current_data_format *)id->driver_data;
 
-	if (!init_data)
-		return -EINVAL;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	config.dev = &client->dev;
+	if (client->dev.of_node)
+		init_data = of_get_regulator_init_data(&client->dev,
+						       client->dev.of_node,
+						       &ad5398_reg);
+	if (!init_data)
+		return -EINVAL;
+
 	config.init_data = init_data;
+	config.of_node = client->dev.of_node;
 	config.driver_data = chip;
 
 	chip->client = client;
-- 
2.39.5


