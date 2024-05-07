Return-Path: <stable+bounces-43434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B216C8BF2BE
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416331F20F0E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2C1A125B;
	Tue,  7 May 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI0nzPmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8941A1A55;
	Tue,  7 May 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123684; cv=none; b=iUlzQ1O+x402VkBjOmos4E8M6YaGGufDoSZG9y3w2yNOKTprCKzrnIN0WU+m+nZ8u39ttT4rnbSXvjsi3DAcGsdUFimloJ3x4+RDO5j4ohV7L5pyYMaHScWYv3EfGh7uevGJtYc3RsGdeBFdx1zAGACp5eCiZ8kKW0RxqlOJd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123684; c=relaxed/simple;
	bh=O7QeIx8IfjjR0rfzi6cLm3Gwg7F1iSnuL1pU/5yQQv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFz2VUkTe58TLkTVYWe0fzFcqt5cZfrWcKsWSq3PYWhafriB6Ui86vcW4z5v9ZFjJmUnbmInhjeTAXUJGUTkMfkgx6/sjJTKzN6afXOUmp7/7kbR4wHPSZbRZcW9JICk7VL03m3mObjBgoVwv/uujkJ7E34zmUHzsJT5Uo3a2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI0nzPmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B10FC4AF63;
	Tue,  7 May 2024 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123684;
	bh=O7QeIx8IfjjR0rfzi6cLm3Gwg7F1iSnuL1pU/5yQQv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HI0nzPmWjj39YL3crlDWeg4Y+uXaHC6vnTiHka5kRvAjzOU2WgZnBxTx5KgUHU1tK
	 scUgzuWChSvv4e/lK/PstBxbv31XSBhEcYrULLj2teQEOTwTpBbbIg+5cQ++6KFlE3
	 fR6S1iVxz3JcBnXtIGrsNGSDSAMXrhG/j0La2Lf2ulFr0559pJB+l/npXuP3XsqCvI
	 JrcxlVTl/0eFnpWf2jQepNiiVnh6Ef4gF8eEaR4RuGgfeUwZC2niJWQezHHlM0DXOk
	 YIKLN/CTAjVjxBN/AQbY5u2anZbmNRkkJPzGOgPFHTWmIWJ4gquxbznpgQ60oGgqLP
	 lQX9TiItn764g==
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
Subject: [PATCH AUTOSEL 4.19 4/4] ASoC: da7219-aad: fix usage of device_get_named_child_node()
Date: Tue,  7 May 2024 19:14:35 -0400
Message-ID: <20240507231436.395448-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231436.395448-1-sashal@kernel.org>
References: <20240507231436.395448-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.313
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
index e3515ac8b223f..c7c800f8133b6 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -634,8 +634,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_component
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -710,6 +712,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_component
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
-- 
2.43.0


