Return-Path: <stable+bounces-43422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A58BF2A6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6601F214DE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451119F6B8;
	Tue,  7 May 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/AHEk9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DC19F6A9;
	Tue,  7 May 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123659; cv=none; b=SNgN5ehPP40qMb1o/jq/cFAWvzQmSft5VXU4qAn7n/NHapswmI27/nIZf6fpvE6fxNEN3ci2sJUQ/U0A62dUoGF6OgNXmvHoujOCQ6sysGfrgekqVC6rBbb9rNR7mEhbKho0I2XT8LrVGGLIHRLXIUpBdTaku+4AXtpr7FiVHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123659; c=relaxed/simple;
	bh=nHzSA4DNwV/UEo5OKNUlt8c+RvmXi7PrEc5XpHkupD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olAYeCMXkIg6REWtF0AUWTAQLBBVTrjQGhNxvLne4XO3z51f3mppIlDla9xIDCpMm8uJxe4jgtnOfdaFx1ULtMbIzCEcXOcKQSmTU+CsADQRhPzYdHEL1hiznSn8K+Oc3OdzbvaQrkXlzUHy+WNHGrbfpKRpTcs0FVQqokpz0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/AHEk9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C739BC3277B;
	Tue,  7 May 2024 23:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123658;
	bh=nHzSA4DNwV/UEo5OKNUlt8c+RvmXi7PrEc5XpHkupD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/AHEk9RofA/FZVZKXDWvJUwI0H3+o9oV1vEirA0aqPUOFXyT9AVlQjjszAXczoRg
	 b7a3Z/2axgyo9v3c7PCi/p9B5WZ+QZntDm/NjOFCMbe0kMm7B7a6A0FmhvEUOcx3Xy
	 WIi9as4B6cRPRihjsI+3Ikj34AdROxZyI8GUrG7fsP0n6Ebk3YOk1AmB8R2rP82zaU
	 OdkevadwrrBcsdm0Y/do2x9ZI4x9i/rcHVcQHLJ8E3d3JIc+VPMnPJcsbfIGwyr44p
	 9v8MCelKWpJxJ7pBnnzdiShMEv38xDrWlvEw9fC3SjJ7FEbfN0PcxREpoAM1N52++i
	 /KZuLSve3yLSg==
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
Subject: [PATCH AUTOSEL 5.10 7/9] ASoC: da7219-aad: fix usage of device_get_named_child_node()
Date: Tue,  7 May 2024 19:14:02 -0400
Message-ID: <20240507231406.395123-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index b6030709b6b6d..2fb26dd84bc72 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -629,8 +629,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -705,6 +707,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
-- 
2.43.0


