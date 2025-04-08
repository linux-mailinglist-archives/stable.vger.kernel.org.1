Return-Path: <stable+bounces-131354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A155A8096C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718FD1BA65A5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0726E160;
	Tue,  8 Apr 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnAse2wz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6326B2AE;
	Tue,  8 Apr 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116170; cv=none; b=QYz8PfVLUAfZqMo+S4k/vNSlVvOB2DwJ+m4sfE2VXLx0gYeVfcd5Dy/oABZwyc9ge1bqyGWy+c7V/Tgw/8SqVfqFF6qvcdEuEGsgeQQySOINS2iA/xsG2YY5bfKMbqpbhrf+sXte1jKlJp8izaCh0rF/ZaZ8Kb7Lnc+loUrpAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116170; c=relaxed/simple;
	bh=JGALhGb7th8lDBqpdDtl3DG8p5k4x51TcLXekBwExp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc1lVYUdAZJJUqafZGmnGF6G+hvSm33If3ol0TgbIJRQ+S1o4qZcfjzfYI1NaIV1dtFksPGuf9m/oRbNxfsjUmuohV0njg70aeXnmxvH4Pqp5Et7EcZKWBHmMP8wOj4NdtXs4eK17zHF2ofvMkq70DhhUc5aGhyHLao3SXqHW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnAse2wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E5FC4CEE5;
	Tue,  8 Apr 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116170;
	bh=JGALhGb7th8lDBqpdDtl3DG8p5k4x51TcLXekBwExp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnAse2wzN5wds86UHO96TSaJClJRvSndJl/NbTJF7FuZGLuH2Wsflh7fhguomZZCk
	 erlGzWcO1Uy0S3FEUEpmUXp/lOsEnOmpYKOaxyv4ZxGdAbwDCAeitiTYwHCII8C8A5
	 vqQSAwJM5MGS/DpD9DXHq3st7Y7s+bMWSZL6uEBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 040/423] ASoC: cs35l41: check the return value from spi_setup()
Date: Tue,  8 Apr 2025 12:46:06 +0200
Message-ID: <20250408104846.684200992@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>

[ Upstream commit ad5a0970f86d82e39ebd06d45a1f7aa48a1316f8 ]

Currently the return value from spi_setup() is not checked for a failure.
It is unlikely it will ever fail in this particular case but it is still
better to add this check for the sake of completeness and correctness. This
is cheap since it is performed once when the device is being probed.

Handle spi_setup() return value.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 872fc0b6bde8 ("ASoC: cs35l41: Set the max SPI speed for the whole device")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Link: https://patch.msgid.link/20250304115643.2748-1-v.shevtsov@mt-integration.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41-spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index a6db44520c060..f9b6bf7bea9c9 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -32,13 +32,16 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 	const struct regmap_config *regmap_config = &cs35l41_regmap_spi;
 	struct cs35l41_hw_cfg *hw_cfg = dev_get_platdata(&spi->dev);
 	struct cs35l41_private *cs35l41;
+	int ret;
 
 	cs35l41 = devm_kzalloc(&spi->dev, sizeof(struct cs35l41_private), GFP_KERNEL);
 	if (!cs35l41)
 		return -ENOMEM;
 
 	spi->max_speed_hz = CS35L41_SPI_MAX_FREQ;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
 
 	spi_set_drvdata(spi, cs35l41);
 	cs35l41->regmap = devm_regmap_init_spi(spi, regmap_config);
-- 
2.39.5




