Return-Path: <stable+bounces-43343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E18BF205
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A8AB25469
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30997149E06;
	Tue,  7 May 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPxhBsxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B7149DFC;
	Tue,  7 May 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123456; cv=none; b=ixrFEdCkH6fySV3Vwuv7eaLkZOamhX4M35bcO4ddq2Is8THznVLpOHUFl1pEu3ONTxbAx+JdT2SllhWlQaM+c/FAIJZMSO/oU9jo5FJh1b88wBUwr8PgDs0A7Lxoa14BOxRChHOixGDudkPaObNkyi/6Yc9ow39ZgyNCQBBHOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123456; c=relaxed/simple;
	bh=sAAr9VYn+hvAOzBBZthjzXP3fDcDZfnu5BuEBB9blKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU5XJX7nPNKXz4WSlB432Rz5vTRQMNGhXx20Oi8y0rIDnUZsHsv9F0pCJiVRCuOC9i9DCRYJQ+I2hKVS+uXI9cE4ADghpy03Kklk/DQrRZysFQtUETS8ygS1j6sVB79Irp9aGMsKnm1mbvq5eydc6s/Tffm6XGdFkFLt9yVJBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPxhBsxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACD9C4AF17;
	Tue,  7 May 2024 23:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123455;
	bh=sAAr9VYn+hvAOzBBZthjzXP3fDcDZfnu5BuEBB9blKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPxhBsxFUAjNyDVILyASJ2Zh7QUDm9FKMj2Y8lFQCawg+ZqF2B7uIQqTPgjRm7YBt
	 WmGlJaKPuwXXnN9rdXBTelxvj4vGpd6P3mZkIYpBa4G8Wkwmbjhqo8FdyYvWpISpaS
	 nM+J/qFm+OrR+mRnkS9+7/6uMbZOms4fmJHf9IcYnkzBWYTjIZW9OBY37uBMqc1NDy
	 aBRxXJ14HcPYwFSV61vxqX/UTP6v4NFJ9sSp/cALtZlk3LSp81K77vBx4dApUaaQaG
	 63GtYANT/6Sj2daBgHCS7Riv+vc1czFplXov8JRUihbWo0JpiIggvkPsg9fiCmgWKx
	 pqWPYqPscE6bA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/43] ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config
Date: Tue,  7 May 2024 19:09:33 -0400
Message-ID: <20240507231033.393285-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit eefb831d2e4dd58d58002a2ef75ff989e073230d ]

Currently, all ASoC systems are set to use VPMON for DSP1RX5_SRC,
however, this is required only for internal boost systems.
External boost systems require VBSTMON instead of VPMON to be the
input to DSP1RX5_SRC.
Shared Boost Active acts like Internal boost (requires VPMON).
Shared Boost Passive acts like External boost (requires VBSTMON)
All systems require DSP1RX6_SRC to be set to VBSTMON.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240411142648.650921-1-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 5456e6bfa242f..bc541293089f0 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1095,6 +1095,7 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 {
 	struct wm_adsp *dsp;
+	uint32_t dsp1rx5_src;
 	int ret;
 
 	dsp = &cs35l41->dsp;
@@ -1114,16 +1115,29 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 		return ret;
 	}
 
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX5_SRC,
-			   CS35L41_INPUT_SRC_VPMON);
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_INT_BOOST:
+	case CS35L41_SHD_BOOST_ACTV:
+		dsp1rx5_src = CS35L41_INPUT_SRC_VPMON;
+		break;
+	case CS35L41_EXT_BOOST:
+	case CS35L41_SHD_BOOST_PASS:
+		dsp1rx5_src = CS35L41_INPUT_SRC_VBSTMON;
+		break;
+	default:
+		dev_err(cs35l41->dev, "wm_halo_init failed - Invalid Boost Type: %d\n",
+			cs35l41->hw_cfg.bst_type);
+		goto err_dsp;
+	}
+
+	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX5_SRC, dsp1rx5_src);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write INPUT_SRC_VPMON failed: %d\n", ret);
+		dev_err(cs35l41->dev, "Write DSP1RX5_SRC: %d failed: %d\n", dsp1rx5_src, ret);
 		goto err_dsp;
 	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX6_SRC,
-			   CS35L41_INPUT_SRC_CLASSH);
+	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX6_SRC, CS35L41_INPUT_SRC_VBSTMON);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write INPUT_SRC_CLASSH failed: %d\n", ret);
+		dev_err(cs35l41->dev, "Write CS35L41_INPUT_SRC_VBSTMON failed: %d\n", ret);
 		goto err_dsp;
 	}
 	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX7_SRC,
-- 
2.43.0


