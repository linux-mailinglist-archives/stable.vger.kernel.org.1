Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72479B002
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbjIKW0N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbjIKOn0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3012A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA58CC433C8;
        Mon, 11 Sep 2023 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443401;
        bh=XaFOEmqk6vFmPyUdLfiBCVpDLE6d7N/f16d8ZogNbLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mp8f/psEcH42JW1AnqRCFNCTNjK6ix7gMHO9XMEEqam1331dzweewRHrdMKaeVsc+
         Ie7Whp4r5PvvTycoo5UxO/Sh4O4UyOlK861bJvWoZdkyRKibsO4YGdKTsM55dpgpBO
         1SxxVmRdsZc6+QjcDBldAi/TXpvBdqMeJgKjBrn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 337/737] ASoC: fsl: fsl_qmc_audio: Fix snd_pcm_format_t values handling
Date:   Mon, 11 Sep 2023 15:43:16 +0200
Message-ID: <20230911134659.947395234@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit 5befe22b3eebd07b334b2917f6d14ce7ee4c8404 ]

Running sparse on fsl_qmc_audio (make C=1) raises the following warnings:
 fsl_qmc_audio.c:387:26: warning: restricted snd_pcm_format_t degrades to integer
 fsl_qmc_audio.c:389:59: warning: incorrect type in argument 1 (different base types)
 fsl_qmc_audio.c:389:59:    expected restricted snd_pcm_format_t [usertype] format
 fsl_qmc_audio.c:389:59:    got unsigned int [assigned] i
 fsl_qmc_audio.c:564:26: warning: restricted snd_pcm_format_t degrades to integer
 fsl_qmc_audio.c:569:50: warning: incorrect type in argument 1 (different base types)
 fsl_qmc_audio.c:569:50:    expected restricted snd_pcm_format_t [usertype] format
 fsl_qmc_audio.c:569:50:    got int [assigned] i
 fsl_qmc_audio.c:573:62: warning: incorrect type in argument 1 (different base types)
 fsl_qmc_audio.c:573:62:    expected restricted snd_pcm_format_t [usertype] format
 fsl_qmc_audio.c:573:62:    got int [assigned] i

These warnings are due to snd_pcm_format_t values handling done in the
driver. Some macros and functions exist to handle safely these values.

Use dedicated macros and functions to remove these warnings.

Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20230726161620.495298-1-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_qmc_audio.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 7cbb8e4758ccc..56d6b0b039a2e 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -372,8 +372,8 @@ static int qmc_dai_hw_rule_format_by_channels(struct qmc_dai *qmc_dai,
 	struct snd_mask *f_old = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	unsigned int channels = params_channels(params);
 	unsigned int slot_width;
+	snd_pcm_format_t format;
 	struct snd_mask f_new;
-	unsigned int i;
 
 	if (!channels || channels > nb_ts) {
 		dev_err(qmc_dai->dev, "channels %u not supported\n",
@@ -384,10 +384,10 @@ static int qmc_dai_hw_rule_format_by_channels(struct qmc_dai *qmc_dai,
 	slot_width = (nb_ts / channels) * 8;
 
 	snd_mask_none(&f_new);
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		if (snd_mask_test(f_old, i)) {
-			if (snd_pcm_format_physical_width(i) <= slot_width)
-				snd_mask_set(&f_new, i);
+	pcm_for_each_format(format) {
+		if (snd_mask_test_format(f_old, format)) {
+			if (snd_pcm_format_physical_width(format) <= slot_width)
+				snd_mask_set_format(&f_new, format);
 		}
 	}
 
@@ -551,26 +551,26 @@ static const struct snd_soc_dai_ops qmc_dai_ops = {
 
 static u64 qmc_audio_formats(u8 nb_ts)
 {
-	u64 formats;
-	unsigned int chan_width;
 	unsigned int format_width;
-	int i;
+	unsigned int chan_width;
+	snd_pcm_format_t format;
+	u64 formats_mask;
 
 	if (!nb_ts)
 		return 0;
 
-	formats = 0;
+	formats_mask = 0;
 	chan_width = nb_ts * 8;
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+	pcm_for_each_format(format) {
 		/*
 		 * Support format other than little-endian (ie big-endian or
 		 * without endianness such as 8bit formats)
 		 */
-		if (snd_pcm_format_little_endian(i) == 1)
+		if (snd_pcm_format_little_endian(format) == 1)
 			continue;
 
 		/* Support physical width multiple of 8bit */
-		format_width = snd_pcm_format_physical_width(i);
+		format_width = snd_pcm_format_physical_width(format);
 		if (format_width == 0 || format_width % 8)
 			continue;
 
@@ -581,9 +581,9 @@ static u64 qmc_audio_formats(u8 nb_ts)
 		if (format_width > chan_width || chan_width % format_width)
 			continue;
 
-		formats |= (1ULL << i);
+		formats_mask |= pcm_format_to_bits(format);
 	}
-	return formats;
+	return formats_mask;
 }
 
 static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *np,
-- 
2.40.1



