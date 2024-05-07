Return-Path: <stable+bounces-43388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B58BF253
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB71C20E7E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603061C0DD3;
	Tue,  7 May 2024 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAMjw2F8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D81C0DC0;
	Tue,  7 May 2024 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123574; cv=none; b=pprbusB9h5XyhLQy3tF/7L8r2G/erfvT7w/0HPRHcscugiJ2gjo+bJDquY1aWj4izC+ikQsGdef8xToLmLWZsRO0nb7ewvSInztf3hZmKna5XlFAK765pXCveTMTlfHHVZ7y5VGEgmzoZgvJJ8aPpve/KSMQ4/CP2+fxjj+GckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123574; c=relaxed/simple;
	bh=3zFSXmcuGLIb480BIJuMGLzc+nUlr8bq1zGtX3DKV/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYw45YMxW6ymFx0A8n/XrSE15Z8xYpFOgB6gubmo2qnOu7C0DDq/DplhQq+NAR8jM08woH139im0aVHSqn3RspcOFkqfta9wzqdxpeqlt7leCvO89Bb6GIqnDs2HXOTuhPQiGjHvlNcGzuzqyn/MuKBW1dj6HTcboSZi+KrjrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAMjw2F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D925DC4AF17;
	Tue,  7 May 2024 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123574;
	bh=3zFSXmcuGLIb480BIJuMGLzc+nUlr8bq1zGtX3DKV/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAMjw2F8AdxO678RAtc3l42gZvV4Do/rHKMjzGgPDrd7GOeb60663lwy5Na4wamGh
	 R4YAm8RUVI2Wjs1kN3kACLEmh7Z80dt6pR20Fm9+fMYJZMNODJDzCn7/eBU27c8cVH
	 /JfArXXTuihYpdZmKW2UulQ4uihxtxuzqrSisSySteRi8dr98lhyv4abYJBK7gxCtj
	 RTiBKtFgKbWF2cOBORj5vbusvFmd1AmbXQhJmgB8rfXeF3o044H34hB0lgtEyUhGG4
	 osxdsLuLXZUtyYz/ztBxnf7udTSMlEBMcP61bBvPqar6Cl5H6s9H3XsjK9/BQB2NeP
	 54kP2Mlz58w2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/25] ASoC: da7219-aad: fix usage of device_get_named_child_node()
Date: Tue,  7 May 2024 19:12:00 -0400
Message-ID: <20240507231231.394219-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit e8a6a5ad73acbafd98e8fd3f0cbf6e379771bb76 ]

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid a leaked reference.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240426153033.38500-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index c8410769188a0..d613f1074524a 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -638,8 +638,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -714,6 +716,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
-- 
2.43.0


