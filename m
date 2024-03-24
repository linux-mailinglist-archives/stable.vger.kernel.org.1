Return-Path: <stable+bounces-29797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4E8887A5
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A2FB23A9C
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E4156251;
	Sun, 24 Mar 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC34KpjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935E1F1AC4;
	Sun, 24 Mar 2024 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321079; cv=none; b=FmG2iOg3SjPYYigJkfiZgOkP4fu/EYoYgMg8qAIDOErHSRHgjo5ryL4itgtDtlAQLAZoXLIvjC04T3QxxV2DdU3J8EzuJvVcATY9YoBDbz5u7fZ7qFn/i6gNW/pEO0guIRIRB9WqY9eSmnHmrF+E5jlRcdrnh3DjF9scpi78CW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321079; c=relaxed/simple;
	bh=q9cK5+CVva2zWZ5121iREcxRFvY+SrqSNGS/pgZCZmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIXuwNPByV82tHvhVRw3Tw3qUq0RXrCVgodyY75ggieIVuho5KscM16dr4Hl/ug9y9CVoUb1J5iLAspnUX9qzp/yI6hJCco1PjtKYgCUqLEPbKem8IhK/BfFQ5DvjGBSxOuG+wCn/6DAN1aR4YFGIP7T+rHRxRUo4bMFd6AxVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC34KpjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3376AC43394;
	Sun, 24 Mar 2024 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321077;
	bh=q9cK5+CVva2zWZ5121iREcxRFvY+SrqSNGS/pgZCZmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CC34KpjXW3CE5xSHGcA7S3VyFU6Nhho72r+vDmJPob9LYLvW3TeKGiTY0Id5PKGv0
	 iNkHfsg8QjrSZlVrr8fTaEbqO8hWXyo+bUqmWp09MkKBjHnrcSdDLIrkZaNLvqFFnd
	 O9TygAex69XkLcpZxdqEUwjJg3IBqY9m1AoTwCugA21TxXm8cJenG3ag2GfhlIk3ac
	 2g9bwMYyYc98zWLzob6vSdWE5S5iHyA+50tD0i5Sn8JsXIk9MxE5EzoxdEfib8fhxm
	 +1Aj1oE8YG04kheWXG/gos4XS/yNCe2jZDL4ToYs/a84CrqSFdaGOxSHSucgSCuy1g
	 BB7b5Iv/FXYuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 641/713] thermal/drivers/qoriq: Fix getting tmu range
Date: Sun, 24 Mar 2024 18:46:07 -0400
Message-ID: <20240324224720.1345309-642-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 4d0642074c67ed9928e9d68734ace439aa06e403 ]

TMU Version 1 has 4 TTRCRs, while TMU Version >=2 has 16 TTRCRs.
So limit the len to 4 will report "invalid range data" for i.MX93.

This patch drop the local array with allocated ttrcr array and
able to support larger tmu ranges.

Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240226003657.3012880-1-peng.fan@oss.nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qoriq_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index ccc2eea7f9f54..404f01cca4dab 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -57,6 +57,9 @@
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
+#define NUM_TTRCR_V1	4
+#define NUM_TTRCR_MAX	16
+
 #define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
 						   * Register n
 						   */
@@ -71,6 +74,7 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	int ver;
+	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
@@ -182,17 +186,17 @@ static int qoriq_tmu_calibration(struct device *dev,
 				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
-	u32 range[4];
 	const u32 *calibration;
 	struct device_node *np = dev->of_node;
 
 	len = of_property_count_u32_elems(np, "fsl,tmu-range");
-	if (len < 0 || len > 4) {
+	if (len < 0 || (data->ver == TMU_VER1 && len > NUM_TTRCR_V1) ||
+	    (data->ver > TMU_VER1 && len > NUM_TTRCR_MAX)) {
 		dev_err(dev, "invalid range data.\n");
 		return len;
 	}
 
-	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
+	val = of_property_read_u32_array(np, "fsl,tmu-range", data->ttrcr, len);
 	if (val != 0) {
 		dev_err(dev, "failed to read range data.\n");
 		return val;
@@ -200,7 +204,7 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	/* Init temperature range registers */
 	for (i = 0; i < len; i++)
-		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
+		regmap_write(data->regmap, REGS_TTRnCR(i), data->ttrcr[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-- 
2.43.0


