Return-Path: <stable+bounces-140974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC578AAAD56
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2633B0FB6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D13D14D4;
	Mon,  5 May 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugBSKILU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BF2F70D4;
	Mon,  5 May 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487091; cv=none; b=av6YyKsmvt6Wz3AzGswEYPFZZLqsqVB41Gpkjz5jym5FvqnkgqeMTooRKUfzkrn60zF44slsOCK/TsFSWLSv3oazhJ7ETaZIjWcBrRa3U8A2CMzP5IBzTTETNXlP+CKmGxZGWgKnMCB9S9gP3BPQl8ZSUNw0CJUXMACB8MZW7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487091; c=relaxed/simple;
	bh=zERVQQNvuOQinF99ex3FLAIPNtpSUKafbHMHhaIZqb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb3CLAr+NEamINajw2r0p8LwbougpfTQUUr1DO1AixRpV7FsyI5GBLJ3sjrX1ovUUOrDuILb2IV072qJiVxgrIhvspBau0YlvD448R0YMCpct2KbE0Yn+NoxjT7qx+XMfRDDOsYphFF/sBWjSR6ieGc6mc8Di9jNGJ1V13S0hhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugBSKILU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D464DC4CEED;
	Mon,  5 May 2025 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487090;
	bh=zERVQQNvuOQinF99ex3FLAIPNtpSUKafbHMHhaIZqb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugBSKILUJjZPk6np0q85BaKCo9LKD0jJzCQ3jo13yTXoLzedTqUqHThgcaOKkU6u9
	 d43J332pJ74q6nXqgaLg2IRBe/g8S3wKg3pnLTy38xDBQTx2Izt0oi4puPW6GcUqvj
	 gKo+N/6h1DX1Vg2pfgJIfuIv02T1n9zhi5cECgWLJXdiTuvEx5RXeu5RRsKQRCRJvl
	 nDFm8r3jmCsUuUitkx7+TurYpfQYxaPPdQNZ4qJz93bbspJtringu9/T+63UJFiPaq
	 SM2b0dY49FbHhwrBCLwQrIU6bnGDHjiKnCdhwPF/qhkfgjqla0i1psIsjh0+snpcZr
	 Szs6jJSquYNjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.15 150/153] regulator: ad5398: Add device tree support
Date: Mon,  5 May 2025 19:13:17 -0400
Message-Id: <20250505231320.2695319-150-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 75f432f61e919..f4d6e62bd963e 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define AD5398_CURRENT_EN_MASK	0x8000
 
@@ -221,15 +222,20 @@ static int ad5398_probe(struct i2c_client *client,
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


