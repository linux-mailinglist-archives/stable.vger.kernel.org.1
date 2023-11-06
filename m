Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8367E23E2
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjKFNPt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjKFNPs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:15:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7DA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:15:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E288BC433C7;
        Mon,  6 Nov 2023 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276545;
        bh=JxZscK3rDOGNiHptFuQG8H6QVMFLyBn2f8FHX4iAae0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMHwThHB9S37XL7BMAIkaLaFN354zKaEKGCEX7q98Pw7ITwqksQ56u5YmXVG5secy
         aefb6JBTzFYOrlevw6fwDw/05EQoy9fJ2QMiNoBffNcvXs/FaKFGI21myuh0tIXRwx
         9wkhpQCkmtVBBIy0oX1N13E5BJ/D0/QqfV2q4QJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 05/88] ASoC: core: Do not call link_exit() on uninitialized rtd objects
Date:   Mon,  6 Nov 2023 14:02:59 +0100
Message-ID: <20231106130305.963933242@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit dd9f9cc1e6b9391140afa5cf27bb47c9e2a08d02 ]

On init we have sequence:

	for_each_card_prelinks(card, i, dai_link) {
		ret = snd_soc_add_pcm_runtime(card, dai_link);

	ret = init_some_other_things(...);
	if (ret)
		goto probe_end:

	for_each_card_rtds(card, rtd) {
		ret = soc_init_pcm_runtime(card, rtd);

probe_end:

while on exit:
	for_each_card_rtds(card, rtd)
		snd_soc_link_exit(rtd);

If init_some_other_things() step fails due to error we end up with
not fully setup rtds and try to call snd_soc_link_exit on them, which
depending on contents on .link_exit handler, can end up dereferencing
NULL pointer.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230929103243.705433-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b27f84580c5b0..cf34810882347 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1125,6 +1125,8 @@ struct snd_soc_pcm_runtime {
 	unsigned int pop_wait:1;
 	unsigned int fe_compr:1; /* for Dynamic PCM */
 
+	bool initialized;
+
 	int num_components;
 	struct snd_soc_component *components[]; /* CPU/Codec/Platform */
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a0bde23f5e6f..2d85164457f73 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1259,7 +1259,7 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 	snd_soc_runtime_get_dai_fmt(rtd);
 	ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
 	if (ret)
-		return ret;
+		goto err;
 
 	/* add DPCM sysfs entries */
 	soc_dpcm_debugfs_add(rtd);
@@ -1284,17 +1284,26 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 	/* create compress_device if possible */
 	ret = snd_soc_dai_compress_new(cpu_dai, rtd, num);
 	if (ret != -ENOTSUPP)
-		return ret;
+		goto err;
 
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 			dai_link->stream_name, ret);
-		return ret;
+		goto err;
 	}
 
-	return snd_soc_pcm_dai_new(rtd);
+	ret = snd_soc_pcm_dai_new(rtd);
+	if (ret < 0)
+		goto err;
+
+	rtd->initialized = true;
+
+	return 0;
+err:
+	snd_soc_link_exit(rtd);
+	return ret;
 }
 
 static void soc_set_name_prefix(struct snd_soc_card *card,
@@ -1892,7 +1901,8 @@ static void soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	/* release machine specific resources */
 	for_each_card_rtds(card, rtd)
-		snd_soc_link_exit(rtd);
+		if (rtd->initialized)
+			snd_soc_link_exit(rtd);
 	/* remove and free each DAI */
 	soc_remove_link_dais(card);
 	soc_remove_link_components(card);
-- 
2.42.0



