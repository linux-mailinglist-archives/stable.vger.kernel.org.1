Return-Path: <stable+bounces-141312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA89AAB694
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7444C1882276
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B8369079;
	Tue,  6 May 2025 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXsVnXI5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7727875F;
	Mon,  5 May 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485755; cv=none; b=binN7cd19eiwpn0uNzSpI2baMWBBq+JIqlWIq2mAD9EOhZ2ZlCZA5KZfHJCeCFmeaqePyj0dtKtRZxYI703Xs4jw/FN7iGM4kdXI3R6JTZXaaVnZfVkriW0ElsCYqi2A7nikm9xjWs+gikLFuGMSL4o4e4hEtG5mfPo36rrGVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485755; c=relaxed/simple;
	bh=5fB5oUZhc39xpZeWHqD2PSF7T88HaYAVhdoLWGMnc+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHO3f4JmyfcKup6x4IYuDHeNOJD1eSSeK9tJ+SWxAN/r5a/dHZjmBsbDDSjuMHtXouCXeoGiXd+tzXIuDdCt36oOJEevcUr7Fljn9dCmh7mjt3vnEfUBPd6Y5oKUf3BNzX48Io4EGnxw1tYCVe8/cTJHSjZgJHpeK9XaNZJq4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXsVnXI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D9BC4CEEF;
	Mon,  5 May 2025 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485755;
	bh=5fB5oUZhc39xpZeWHqD2PSF7T88HaYAVhdoLWGMnc+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXsVnXI5o4IFqsjdwS4r/attMndy/t2N3TsNTb5qAPJuA9bKXzMc3Xlk+T86jLttX
	 kbHR30IQ40U2Ngt3WvcqUcXnY2ALxtKs1maD8lhN5Xg9z8wE7NeP+2GnkDQDSK24dq
	 jGJEqow/ljq8leelk5RZOJNcflumZT/AtspJ7MtetNm9RAteQv+VRseDjSyXHHBNMu
	 A9nGjsiHDlgg1MRF6I7szjQsE0ZHZF3U8TNXBFkb2r9vhrfPKH+VP0rzqiG3GorMZP
	 ieAYDCLk4ulrIWwgAIXHlbSb54jRO4GSi4mFEZtxs+1himsSAr0cViyX87Bd1OToJe
	 q5yXorpUYLEqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.12 466/486] regulator: ad5398: Add device tree support
Date: Mon,  5 May 2025 18:39:02 -0400
Message-Id: <20250505223922.2682012-466-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


