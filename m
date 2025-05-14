Return-Path: <stable+bounces-144344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DAAB6776
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98E6168412
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B762253FB;
	Wed, 14 May 2025 09:25:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF515199A;
	Wed, 14 May 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214715; cv=none; b=CFC/CsKgDsAyIY8tCr69Q5rvkhVjdctH0/UGTFP/R04y54OGa+QiWku9UfYogtXbLnKhtC2jZsWkjDwUGCKMwjdmQ/uyEC+CwnV157g/yJwsllzODRz5zEYPgBTb7O8ELjt/V6DYcz4hTCsffls3BOT5wcZcho2493NUNutYqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214715; c=relaxed/simple;
	bh=YyTiOvLrUqqL7snvEKnX6X1ZZu9BKtWM9/Wi6+/Rokk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c69oiWKSKzAhy5uwGCqz7ABZr81gUvoMg2fcQl7QnO4FoKecmCVt/3T80RkH3bHvGgq7OadKM0bGfmnTAwHPAAAw1ECf6qI1T1MzPiruONlMjlDir6rjYRdiP5ooNEZRhUE6uwbzOF1dxumzVsVyzSDm1dzKFbZIqHRaKrz+5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABXkQluYSRoo5orFQ--.28100S2;
	Wed, 14 May 2025 17:25:04 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()
Date: Wed, 14 May 2025 17:24:44 +0800
Message-ID: <20250514092444.331-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXkQluYSRoo5orFQ--.28100S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyxur4rXFyfGry8Cr1ftFb_yoW8WFykpF
	W8X34rKr97t3WIvF1qy3Z8Zr1fA34rKF1rt3s7Zw10vr4kWFnaqFW8Aa4YvFyFkr48ua13
	Jr4vvwnxGr1fAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsCA2gkK5voJAABs8

The function snd_es1968_capture_open() calls the function
snd_pcm_hw_constraint_pow2(), but does not check its return
value. A proper implementation can be found in snd_cx25821_pcm_open().

Add error handling for snd_pcm_hw_constraint_pow2() and propagate its
error code.

Fixes: b942cf815b57 ("[ALSA] es1968 - Fix stuttering capture")
Cc: stable@vger.kernel.org # v2.6.22
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/pci/es1968.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index c6c018b40c69..4e0693f0ab0f 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1561,7 +1561,7 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct esschan *es;
-	int apu1, apu2;
+	int err, apu1, apu2;
 
 	apu1 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_CAPTURE);
 	if (apu1 < 0)
@@ -1605,7 +1605,9 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_es1968_capture;
 	runtime->hw.buffer_bytes_max = runtime->hw.period_bytes_max =
 		calc_available_memory_size(chip) - 1024; /* keep MIXBUF size */
-	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	if (err < 0)
+		return err;
 
 	spin_lock_irq(&chip->substream_lock);
 	list_add(&es->list, &chip->substream_list);
-- 
2.42.0.windows.2


