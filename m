Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B170384E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbjEORbb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbjEORam (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D3713C31
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E86C562D2D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6E2C433EF;
        Mon, 15 May 2023 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171672;
        bh=pEFcUpcYZtbl28TALAPpC87HYAa8RgslA/pYUpa+PQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrsfMJXNm15k5AvFYmduPgOnCtCqez3CWo6NBQG7sYNxU/gYm8w0UUUCbZpWYcAj3
         26MDKfRue3YGs7tYhGwxtE8sGEDEz6zrntcFWZdrhmNsCnemL5HrtPgWlJzzgt2xCi
         p/vgzJXW9DyaGdoOPcezrt6rv1dyjmEiA9/7/Uao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 014/134] ASoC: soc-pcm: serialize BE triggers
Date:   Mon, 15 May 2023 18:28:11 +0200
Message-Id: <20230515161703.465976313@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b2ae80663008a7662febe7d13f14ea1b2eb0cd51 ]

When more than one FE is connected to a BE, e.g. in a mixing use case,
the BE can be triggered multiple times when the FE are opened/started
concurrently. This race condition is problematic in the case of
SoundWire BE dailinks, and this is not desirable in a general
case.

This patch relies on the existing BE PCM lock, which takes atomicity into
account. The locking model assumes that all interactions start with
the FE, so that there is no deadlock between FE and BE locks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[test, checkpatch fix and clarification of commit message by plbossart]
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d26a1f12c513a..7c7ae69f9410d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -46,12 +46,18 @@ static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
 	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
+#define snd_soc_dpcm_stream_lock_irqsave(rtd, stream, flags) \
+	snd_pcm_stream_lock_irqsave(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
 						  int stream)
 {
 	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
+#define snd_soc_dpcm_stream_unlock_irqrestore(rtd, stream, flags) \
+	snd_pcm_stream_unlock_irqrestore(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 #define DPCM_MAX_BE_USERS	8
 
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
@@ -2094,6 +2100,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 {
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 	int ret = 0;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -2102,9 +2109,11 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		be = dpcm->be;
 		be_substream = snd_soc_dpcm_get_substream(be, stream);
 
+		snd_soc_dpcm_stream_lock_irqsave(be, stream, flags);
+
 		/* is this op for this BE ? */
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
-			continue;
+			goto next;
 
 		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
 			be->dai_link->name, cmd);
@@ -2114,77 +2123,80 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
+next:
+		snd_soc_dpcm_stream_unlock_irqrestore(be, stream, flags);
+		if (ret)
+			break;
 	}
-end:
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
 			__func__, be->dai_link->name, ret);
-- 
2.39.2



