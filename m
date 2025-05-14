Return-Path: <stable+bounces-144384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D9AB6E0B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12954C592E
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C319CC22;
	Wed, 14 May 2025 14:20:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7A199FAB;
	Wed, 14 May 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232422; cv=none; b=L/Fkwd27H744T8vqE8+hGfupwHuLak9j+hw0DPzS6YrtzrWq3tJOmSFn15WwxJpmwJQT39W9IBNBv+Uy1+FwerP/4k3vpgKVWwDE01+UwM7aTQZ9x/zPQZN9O3LLfeolDcRibikJLGufmo4OcCZ/4K5si9L9Fmw2/5MbBr/YOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232422; c=relaxed/simple;
	bh=6ZlHp5+n6qxvzjAudRpWJc8ejLU2WjsX4VaTriOdCzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odNzSvFx9gEkD4GSGURxWdCHIjQjfNuY5bD3bEBZl80LvEEw7mEMOmKKrNzNuXGZporwTd7ayB6P03p5mK+lbQVLDYpXwbCX+aZRe+Hybktyn61H+ntuqaPmQTiCwU5iXGJJ/eYGufqj1c0dHhASCj2+B4PHZGcYUNVVygbqFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAnYQmVpiRoMqdLFQ--.32116S2;
	Wed, 14 May 2025 22:20:07 +0800 (CST)
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
Subject: [PATCH] ASoC: Intel: avs: rt274: Add null pointer check for snd_soc_card_get_codec_dai()
Date: Wed, 14 May 2025 22:19:47 +0800
Message-ID: <20250514141947.998-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnYQmVpiRoMqdLFQ--.32116S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUJFWrXrW7tw15uF18uFg_yoW8AF17pF
	1qgrZxKFW5Jr4xGF1rXa9Yva45ua48CFWfGrWxta4xAF1xJr93Wrn8t34qkFySkry8J3WU
	Xr1j9ay0k34rJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeT5lUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUCA2gkZEjUxQAAs5

The avs_card_suspend_pre() and avs_card_resume_post() in rt274
calls the snd_soc_card_get_codec_dai(), but does not check its return
value which is a null pointer if the function fails. This can result
in a null pointer dereference. A proper implementation can be found
in acp5x_nau8821_hw_params() and card_suspend_pre().

Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
pointer dereference when the function fails.

Fixes: a08797afc1f9 ("ASoC: Intel: avs: rt274: Refactor jack handling")
Cc: stable@vger.kernel.org # v6.2
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/intel/avs/boards/rt274.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
index 4b6c02a40204..7a8b6ee79f4c 100644
--- a/sound/soc/intel/avs/boards/rt274.c
+++ b/sound/soc/intel/avs/boards/rt274.c
@@ -194,6 +194,11 @@ static int avs_card_suspend_pre(struct snd_soc_card *card)
 {
 	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, RT274_CODEC_DAI);
 
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EINVAL;
+	}
+
 	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
 }
 
@@ -202,6 +207,11 @@ static int avs_card_resume_post(struct snd_soc_card *card)
 	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, RT274_CODEC_DAI);
 	struct snd_soc_jack *jack = snd_soc_card_get_drvdata(card);
 
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EINVAL;
+	}
+
 	return snd_soc_component_set_jack(codec_dai->component, jack, NULL);
 }
 
-- 
2.42.0.windows.2


