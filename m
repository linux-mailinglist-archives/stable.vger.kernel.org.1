Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3670383C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbjEORaT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244319AbjEOR3p (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E246D49D5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFCF62D02
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EACC433EF;
        Mon, 15 May 2023 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171638;
        bh=HMXSNWa3BbqbPQPwd0T4khpp2wtGAad2TU520hCocYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9L25aLpltG34KRS47aySn81UMmyKqyhdInZnEWY/SR33rjsYlC0pio7V+CaXOgkD
         nc/zsdmFKjrxktIf1g2RQoUHb2UZtxnEeYihB1YrRv52WoHJ5BRsPWO2nmO/cuMIjs
         YxdlQvVcEiMQ4zgzbFIw+hEEP6zsGr9nUmMCsCaM=
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
Subject: [PATCH 5.15 013/134] ASoC: soc-pcm: Fix and cleanup DPCM locking
Date:   Mon, 15 May 2023 18:28:10 +0200
Message-Id: <20230515161703.426839808@linuxfoundation.org>
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

[ Upstream commit b7898396f4bbe160f546d0c5e9fa17cca9a7d153 ]

The existing locking for DPCM has several issues
a) a confusing mix of card->mutex and card->pcm_mutex.
b) a dpcm_lock spinlock added inconsistently and on paths that could
be recursively taken. The use of irqsave/irqrestore was also overkill.

The suggested model is:

1) The pcm_mutex is the top-most protection of BE links in the FE. The
pcm_mutex is applied always on either the top PCM callbacks or the
external call from DAPM, not taken in the internal functions.

2) the FE stream lock is taken in higher levels before invoking
dpcm_be_dai_trigger()

3) when adding and deleting a BE, both the pcm_mutex and FE stream
lock are taken.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[clarification of commit message by plbossart]
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h  |   2 -
 sound/soc/soc-core.c |   1 -
 sound/soc/soc-pcm.c  | 229 ++++++++++++++++++++++++++++---------------
 3 files changed, 152 insertions(+), 80 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e6dd8a257c56..5872a8864f3b6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -893,8 +893,6 @@ struct snd_soc_card {
 	struct mutex pcm_mutex;
 	enum snd_soc_pcm_subclass pcm_subclass;
 
-	spinlock_t dpcm_lock;
-
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1b1749b920f45..a5b3ee69fb886 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2339,7 +2339,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 	mutex_init(&card->pcm_mutex);
-	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7bea8fa59f676..d26a1f12c513a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -27,6 +27,31 @@
 #include <sound/soc-link.h>
 #include <sound/initval.h>
 
+static inline void snd_soc_dpcm_mutex_lock(struct snd_soc_pcm_runtime *rtd)
+{
+	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+}
+
+static inline void snd_soc_dpcm_mutex_unlock(struct snd_soc_pcm_runtime *rtd)
+{
+	mutex_unlock(&rtd->card->pcm_mutex);
+}
+
+#define snd_soc_dpcm_mutex_assert_held(rtd) \
+	lockdep_assert_held(&(rtd)->card->pcm_mutex)
+
+static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
+						int stream)
+{
+	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
+}
+
+static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
+						  int stream)
+{
+	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
+}
+
 #define DPCM_MAX_BE_USERS	8
 
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
@@ -73,7 +98,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
 	struct snd_soc_dpcm *dpcm;
 	ssize_t offset = 0;
-	unsigned long flags;
 
 	/* FE state */
 	offset += scnprintf(buf + offset, size - offset,
@@ -101,7 +125,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		goto out;
 	}
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
@@ -122,7 +145,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 					   params_channels(params),
 					   params_rate(params));
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 out:
 	return offset;
 }
@@ -145,11 +167,13 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
+	snd_soc_dpcm_mutex_lock(fe);
 	for_each_pcm_streams(stream)
 		if (snd_soc_dai_stream_valid(asoc_rtd_to_cpu(fe, 0), stream))
 			offset += dpcm_show_state(fe, stream,
 						  buf + offset,
 						  out_count - offset);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
 
@@ -221,14 +245,14 @@ static void dpcm_set_fe_update_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_substream *substream =
 		snd_soc_dpcm_get_substream(fe, stream);
 
-	snd_pcm_stream_lock_irq(substream);
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	if (state == SND_SOC_DPCM_UPDATE_NO && fe->dpcm[stream].trigger_pending) {
 		dpcm_fe_dai_do_trigger(substream,
 				       fe->dpcm[stream].trigger_pending - 1);
 		fe->dpcm[stream].trigger_pending = 0;
 	}
 	fe->dpcm[stream].runtime_update = state;
-	snd_pcm_stream_unlock_irq(substream);
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 }
 
 static void dpcm_set_be_update_state(struct snd_soc_pcm_runtime *be,
@@ -256,7 +280,7 @@ void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dai *dai;
 	int i;
 
-	lockdep_assert_held(&rtd->card->pcm_mutex);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	for_each_rtd_dais(rtd, i, dai)
 		snd_soc_dai_action(dai, stream, action);
@@ -309,6 +333,8 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 {
 	struct snd_soc_dpcm *dpcm;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	for_each_dpcm_be(fe, dir, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
@@ -646,14 +672,14 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
+static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
+			 struct snd_pcm_substream *substream, int rollback)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	if (!rollback)
 		snd_soc_runtime_deactivate(rtd, substream->stream);
@@ -665,9 +691,6 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
 
 	soc_pcm_components_close(substream, rollback);
 
-
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	snd_soc_pcm_component_pm_runtime_put(rtd, substream, rollback);
 
 	for_each_rtd_components(rtd, i, component)
@@ -682,9 +705,21 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
  * freed here. The cpu DAI, codec DAI, machine and components are also
  * shutdown.
  */
+static int __soc_pcm_close(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_substream *substream)
+{
+	return soc_pcm_clean(rtd, substream, 0);
+}
+
+/* PCM close ops for non-DPCM streams */
 static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
-	return soc_pcm_clean(substream, 0);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	soc_pcm_clean(rtd, substream, 0);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return 0;
 }
 
 static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
@@ -730,21 +765,21 @@ static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
  * then initialized and any private data can be allocated. This also calls
  * startup for the cpu DAI, component, machine and codec DAI.
  */
-static int soc_pcm_open(struct snd_pcm_substream *substream)
+static int __soc_pcm_open(struct snd_soc_pcm_runtime *rtd,
+			  struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
+	snd_soc_dpcm_mutex_assert_held(rtd);
+
 	for_each_rtd_components(rtd, i, component)
 		pinctrl_pm_select_default_state(component->dev);
 
 	ret = snd_soc_pcm_component_pm_runtime_get(rtd, substream);
 	if (ret < 0)
-		goto pm_err;
-
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+		goto err;
 
 	ret = soc_pcm_components_open(substream);
 	if (ret < 0)
@@ -786,16 +821,26 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	snd_soc_runtime_activate(rtd, substream->stream);
 	ret = 0;
 err:
-	mutex_unlock(&rtd->card->pcm_mutex);
-pm_err:
 	if (ret < 0) {
-		soc_pcm_clean(substream, 1);
+		soc_pcm_clean(rtd, substream, 1);
 		dev_err(rtd->dev, "%s() failed (%d)", __func__, ret);
 	}
 
 	return ret;
 }
 
+/* PCM open ops for non-DPCM streams */
+static int soc_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_open(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
 {
 	/*
@@ -811,13 +856,13 @@ static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
  * rate, etc.  This function is non atomic and can be called multiple times,
  * it can refer to the runtime info.
  */
-static int soc_pcm_prepare(struct snd_pcm_substream *substream)
+static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	ret = snd_soc_link_prepare(substream);
 	if (ret < 0)
@@ -845,14 +890,24 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		snd_soc_dai_digital_mute(dai, 0, substream->stream);
 
 out:
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	if (ret < 0)
 		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
 
 	return ret;
 }
 
+/* PCM prepare ops for non-DPCM streams */
+static int soc_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_prepare(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 				       unsigned int mask)
 {
@@ -864,13 +919,13 @@ static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 	interval->max = channels;
 }
 
-static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
+static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_substream *substream, int rollback)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int i;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	/* clear the corresponding DAIs parameters when going to be inactive */
 	for_each_rtd_dais(rtd, i, dai) {
@@ -900,16 +955,28 @@ static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
 		snd_soc_dai_hw_free(dai, substream, rollback);
 	}
 
-	mutex_unlock(&rtd->card->pcm_mutex);
 	return 0;
 }
 
 /*
  * Frees resources allocated by hw_params, can be called multiple times
  */
+static int __soc_pcm_hw_free(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_pcm_substream *substream)
+{
+	return soc_pcm_hw_clean(rtd, substream, 0);
+}
+
+/* hw_free PCM ops for non-DPCM streams */
 static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	return soc_pcm_hw_clean(substream, 0);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_hw_free(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
 }
 
 /*
@@ -917,15 +984,15 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
  * function can also be called multiple times and can allocate buffers
  * (using snd_pcm_lib_* ). It's non-atomic.
  */
-static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
+			       struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret = 0;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	ret = soc_pcm_params_symmetry(substream, params);
 	if (ret)
@@ -997,16 +1064,27 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_pcm_component_hw_params(substream, params);
 out:
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	if (ret < 0) {
-		soc_pcm_hw_clean(substream, 1);
+		soc_pcm_hw_clean(rtd, substream, 1);
 		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
 	}
 
 	return ret;
 }
 
+/* hw_params PCM ops for non-DPCM streams */
+static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_hw_params(rtd, substream, params);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -1126,7 +1204,8 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_substream *fe_substream;
 	struct snd_pcm_substream *be_substream;
 	struct snd_soc_dpcm *dpcm;
-	unsigned long flags;
+
+	snd_soc_dpcm_mutex_assert_held(fe);
 
 	/* only add new dpcms */
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -1156,10 +1235,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	dpcm->fe = fe;
 	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
 	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 
 	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
 			stream ? "capture" : "playback",  fe->dai_link->name,
@@ -1204,8 +1283,10 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
-	unsigned long flags;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	for_each_dpcm_be_safe(fe, stream, dpcm, d) {
 		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
 				stream ? "capture" : "playback",
@@ -1223,12 +1304,11 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 
 		dpcm_remove_debugfs_state(dpcm);
 
-		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
 		list_del(&dpcm->list_fe);
-		spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 		kfree(dpcm);
 	}
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 }
 
 /* get BE for DAI widget and stream */
@@ -1442,12 +1522,9 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm_set_be_update_state(dpcm->be, stream, SND_SOC_DPCM_UPDATE_NO);
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 }
 
 void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
@@ -1483,12 +1560,12 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
 				continue;
 
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) {
-				soc_pcm_hw_free(be_substream);
+				__soc_pcm_hw_free(be, be_substream);
 				be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 			}
 		}
 
-		soc_pcm_close(be_substream);
+		__soc_pcm_close(be, be_substream);
 		be_substream->runtime = NULL;
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	}
@@ -1536,7 +1613,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			stream ? "capture" : "playback", be->dai_link->name);
 
 		be_substream->runtime = be->dpcm[stream].runtime;
-		err = soc_pcm_open(be_substream);
+		err = __soc_pcm_open(be, be_substream);
 		if (err < 0) {
 			be->dpcm[stream].users--;
 			if (be->dpcm[stream].users < 0)
@@ -1784,7 +1861,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	dev_dbg(fe->dev, "ASoC: open FE %s\n", fe->dai_link->name);
 
 	/* start the DAI frontend */
-	ret = soc_pcm_open(fe_substream);
+	ret = __soc_pcm_open(fe, fe_substream);
 	if (ret < 0)
 		goto unwind;
 
@@ -1815,6 +1892,8 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	/* shutdown the BEs */
@@ -1823,7 +1902,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	dev_dbg(fe->dev, "ASoC: close FE %s\n", fe->dai_link->name);
 
 	/* now shutdown the frontend */
-	soc_pcm_close(substream);
+	__soc_pcm_close(fe, substream);
 
 	/* run the stream stop event */
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
@@ -1868,7 +1947,7 @@ void dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
 			be->dai_link->name);
 
-		soc_pcm_hw_free(be_substream);
+		__soc_pcm_hw_free(be, be_substream);
 
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	}
@@ -1879,13 +1958,13 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	dev_dbg(fe->dev, "ASoC: hw_free FE %s\n", fe->dai_link->name);
 
 	/* call hw_free on the frontend */
-	soc_pcm_hw_free(substream);
+	soc_pcm_hw_clean(fe, substream, 0);
 
 	/* only hw_params backends that are either sinks or sources
 	 * to this frontend DAI */
@@ -1894,7 +1973,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return 0;
 }
 
@@ -1938,7 +2017,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
 			be->dai_link->name);
 
-		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
+		ret = __soc_pcm_hw_params(be, be_substream, &dpcm->hw_params);
 		if (ret < 0)
 			goto unwind;
 
@@ -1968,7 +2047,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-		soc_pcm_hw_free(be_substream);
+		__soc_pcm_hw_free(be, be_substream);
 	}
 
 	return ret;
@@ -1980,7 +2059,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int ret, stream = substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	memcpy(&fe->dpcm[stream].hw_params, params,
@@ -1994,7 +2073,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 			params_channels(params), params_format(params));
 
 	/* call hw_params on the frontend */
-	ret = soc_pcm_hw_params(substream, params);
+	ret = __soc_pcm_hw_params(fe, substream, params);
 	if (ret < 0)
 		dpcm_be_dai_hw_free(fe, stream);
 	else
@@ -2002,7 +2081,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 
 out:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s failed (%d)\n", __func__, ret);
@@ -2273,7 +2352,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
 			be->dai_link->name);
 
-		ret = soc_pcm_prepare(be_substream);
+		ret = __soc_pcm_prepare(be, be_substream);
 		if (ret < 0)
 			break;
 
@@ -2291,7 +2370,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream, ret = 0;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 
 	dev_dbg(fe->dev, "ASoC: prepare FE %s\n", fe->dai_link->name);
 
@@ -2310,7 +2389,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 		goto out;
 
 	/* call prepare on the frontend */
-	ret = soc_pcm_prepare(substream);
+	ret = __soc_pcm_prepare(fe, substream);
 	if (ret < 0)
 		goto out;
 
@@ -2318,7 +2397,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 
 out:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
@@ -2369,7 +2448,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int ret = 0;
-	unsigned long flags;
 
 	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
@@ -2438,7 +2516,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	dpcm_be_dai_shutdown(fe, stream);
 disconnect:
 	/* disconnect any pending BEs */
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 
@@ -2450,7 +2527,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			be->dpcm[stream].state == SND_SOC_DPCM_STATE_NEW)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
@@ -2525,7 +2601,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *fe;
 	int ret = 0;
 
-	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	mutex_lock_nested(&card->pcm_mutex, card->pcm_subclass);
 	/* shutdown all old paths first */
 	for_each_card_rtds(card, fe) {
 		ret = soc_dpcm_fe_runtime_update(fe, 0);
@@ -2541,7 +2617,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
 	}
 
 out:
-	mutex_unlock(&card->mutex);
+	mutex_unlock(&card->pcm_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_runtime_update);
@@ -2552,6 +2628,8 @@ static void dpcm_fe_dai_cleanup(struct snd_pcm_substream *fe_substream)
 	struct snd_soc_dpcm *dpcm;
 	int stream = fe_substream->stream;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	/* mark FE's links ready to prune */
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
@@ -2566,12 +2644,12 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(fe_substream);
 	int ret;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	ret = dpcm_fe_dai_shutdown(fe_substream);
 
 	dpcm_fe_dai_cleanup(fe_substream);
 
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return ret;
 }
 
@@ -2582,7 +2660,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	int ret;
 	int stream = fe_substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	ret = dpcm_path_get(fe, stream, &list);
@@ -2599,7 +2677,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	dpcm_clear_pending_state(fe, stream);
 	dpcm_path_put(&list);
 open_end:
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return ret;
 }
 
@@ -2860,10 +2938,8 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 	int ret = 1;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -2877,7 +2953,6 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 			}
 		}
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	/* it's safe to do this BE DAI */
 	return ret;
-- 
2.39.2



