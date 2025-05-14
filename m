Return-Path: <stable+bounces-144383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1E2AB6DC9
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B8C1B67906
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFF18C008;
	Wed, 14 May 2025 14:05:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D884A0F;
	Wed, 14 May 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231530; cv=none; b=PDbjWVbMvpXFB4JPj07dblOpWixKfnJ1y+lfN+N4aEx4yn8zVDVTPld9r5LGPVmLYlyLzpSb3sxzLzXOorKmMi26oIXiyYUKwV40T78p8esmFiIh+0gpF7N/0sq0MA4jQDEj2WChxtnv3zBChBx++IzJZlHvpWyP59JfGs0p6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231530; c=relaxed/simple;
	bh=OCh3WFD+GEk0VpuZnvvOan+j8YIlhGrX2+r7yw6GV8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoMMQ/4ytjpH/sKBrb4dWAd6cJb5JO8TXgvqIFYxSjBFCvuFbdRiGorthr2EeBy2vpZEBge0XGaW7Ru2aZudFaK+UlqP1bVWymyB/5x86FDZDGsndcJge3D+fj1pewoQOAm419vI6KKlqDL4mmCo2viDLFLukjGlzZ6So5z2GaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowACX1Q0UoyRoyB5KFQ--.32042S2;
	Wed, 14 May 2025 22:05:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avs: nau8825: Add null pointer check for snd_soc_card_get_codec_dai()
Date: Wed, 14 May 2025 22:04:33 +0800
Message-ID: <20250514140433.862-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX1Q0UoyRoyB5KFQ--.32042S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1UGw4DZryrXw43Gw1kAFb_yoW8Gr17pa
	1vgrZFgFyrGr4rua4rXFZYvF15u3y8CFWfGrWxt397XF48Gr95WFs8t3yUCFWIkry8ta4U
	XFyj9ay09a4rC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0CA2gkY9m-eAABs6

The function avs_card_suspend_pre() in nau8825 calls the function
snd_soc_card_get_codec_dai(), but does not check its return
value which is a null pointer if the function fails. This can result
in a null pointer dereference. A proper implementation can be found
in acp5x_nau8821_hw_params() and card_suspend_pre().

Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
pointer dereference when the function fails.

Fixes: 9febcd7a0180 ("ASoC: Intel: avs: nau8825: Refactor jack handling")
Cc: stable@vger.kernel.org # v6.2
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/intel/avs/boards/nau8825.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
index bf902540744c..5baeb95cd5a6 100644
--- a/sound/soc/intel/avs/boards/nau8825.c
+++ b/sound/soc/intel/avs/boards/nau8825.c
@@ -220,6 +220,11 @@ static int avs_card_suspend_pre(struct snd_soc_card *card)
 {
 	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
 
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EINVAL;
+	}
+
 	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
 }
 
-- 
2.42.0.windows.2


