Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5E735244
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFSKdG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjFSKc4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB29106
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF51160B68
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03128C433C0;
        Mon, 19 Jun 2023 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170774;
        bh=0l9xbhHO5u6TcLV8LFHbC5RKnck8rAa4xNop448icUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgqnAdbCAce+kFc8UfB9ipOZ3hbfBu4+LedOp0UEfhPnJUB4gG9RVealFfMWdsE++
         kZPq3QjsDKTqimjMc6CvSwZQW/vzeF9eUkmcYHfKjsCNY9wXXSL9VYgFyiGlTZO2V9
         KrmgGw0SmUqmMiC1iFOGTOVZ3bb3O2wL/mx5sHzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 030/187] ASoC: Intel: avs: Add missing checks on FE startup
Date:   Mon, 19 Jun 2023 12:27:28 +0200
Message-ID: <20230619102159.111682430@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 25148f57a2a6d157779bae494852e172952ba980 ]

Constraint functions have return values, they should be checked for
potential errors.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-8-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/pcm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 31c032a0f7e4b..1fbb2c2fadb55 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -468,21 +468,34 @@ static int avs_dai_fe_startup(struct snd_pcm_substream *substream, struct snd_so
 
 	host_stream = snd_hdac_ext_stream_assign(bus, substream, HDAC_EXT_STREAM_TYPE_HOST);
 	if (!host_stream) {
-		kfree(data);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	data->host_stream = host_stream;
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto err;
+
 	/* avoid wrap-around with wall-clock */
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
+	if (ret < 0)
+		goto err;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	if (ret < 0)
+		goto err;
+
 	snd_pcm_set_sync(substream);
 
 	dev_dbg(dai->dev, "%s fe STARTUP tag %d str %p",
 		__func__, hdac_stream(host_stream)->stream_tag, substream);
 
 	return 0;
+
+err:
+	kfree(data);
+	return ret;
 }
 
 static void avs_dai_fe_shutdown(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-- 
2.39.2



