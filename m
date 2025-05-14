Return-Path: <stable+bounces-144376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E8AB6CCF
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572461B66AEB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6527A12C;
	Wed, 14 May 2025 13:34:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B761F428F;
	Wed, 14 May 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229689; cv=none; b=DFTNbHMPCKQ04dI6kc9NF3fY7qQQGZNaVFlVLO7IV9OepYJXQJr0G0Z/JbBs3L9VaQlAVJt2jPu9KXHy8WTQqHEokmFmLwwbrh2IOKmJPP3Y9jgCvosxtklmfvaHZaoSJ8WGIrOCByKram9WzLk9Ag+RSGiGCrsrN4okUoScB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229689; c=relaxed/simple;
	bh=wVOcW9WcqwQ0MaauWnzbqHVaQ+oh6npsussaYish+00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpIIUFknL3JR6+NevNMb2UhqZjibBfmp40C4eakgEYGCOwbRMsT30CIMvMVp/PYCz9mIxxUZlmgjmAKMi27C37Oli8D1q3fU3Wg+p+Q0UuSqv+8rRy04MVVyXUAYkuU4qfBCjuPARipGxjLOo/RqEhUTl2/06lND3+V6WlwxG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowADnkj_mmyRoeFwhFQ--.7405S2;
	Wed, 14 May 2025 21:34:32 +0800 (CST)
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
	tony.luck@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avs: Add null pointer check for es8366
Date: Wed, 14 May 2025 21:34:08 +0800
Message-ID: <20250514133409.713-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADnkj_mmyRoeFwhFQ--.7405S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45KrW5Zr15Cw4kJrW5Wrg_yoW8WFy5pF
	1DWrZrKFW5Jr4xG345XayFvFy7Za48CFZ3GrWxK3s7AF4fJr93Wr1YqryjyFyakryxJw47
	Xryj9ay8C34rJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRx-BiUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsCA2gkZJ+0pQAAsr

The avs_card_suspend_pre() and avs_card_resume_post() in es8336
calls the snd_soc_card_get_codec_dai(), but does not check its return
value which is a null pointer if the function fails. This can result
in a null pointer dereference. A proper implementation can be found
in acp5x_nau8821_hw_params() and card_suspend_pre().

Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
pointer dereference when the function fails.

Fixes: 32e40c8d6ff9 ("ASoC: Intel: avs: Add es8336 machine board")
Cc: stable@vger.kernel.org # v6.6
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/intel/avs/boards/es8336.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 426ce37105ae..e31cc656f076 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -243,6 +243,9 @@ static int avs_card_suspend_pre(struct snd_soc_card *card)
 {
 	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, ES8336_CODEC_DAI);
 
+	if (!codec_dai)
+		return -EINVAL;
+
 	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
 }
 
@@ -251,6 +254,9 @@ static int avs_card_resume_post(struct snd_soc_card *card)
 	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, ES8336_CODEC_DAI);
 	struct avs_card_drvdata *data = snd_soc_card_get_drvdata(card);
 
+	if (!codec_dai)
+		return -EINVAL;
+
 	return snd_soc_component_set_jack(codec_dai->component, &data->jack, NULL);
 }
 
-- 
2.42.0.windows.2


