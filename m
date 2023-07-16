Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4775527E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGPUId (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGPUIc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9A9B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3B660EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D875C433C7;
        Sun, 16 Jul 2023 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538110;
        bh=NHq9jf+4yUZ0pb5/w9s3Vc+L3KLjXR2RVl4Fg8KTLKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itoUAiBWoDh8y2DDqmmK7mUNtzQnrK4drXDLlSeBWOkYnIxszSGxHVmxTS9wH5TM6
         Z8boTzEQhSWxF6HQVkfl6h/rQYKJHC8G19ek6gD+4IryuZr8sJ7dLdRfoIj7DHKy8y
         dOQbzoPH0GwfwiTMXERFHvodEUf+UqFsxWFkjmzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 334/800] ASoC: es8316: Do not set rate constraints for unsupported MCLKs
Date:   Sun, 16 Jul 2023 21:43:07 +0200
Message-ID: <20230716194956.840028403@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 60413129ee2b38a80347489270af7f6e1c1de4d0 ]

When using the codec through the generic audio graph card, there are at
least two calls of es8316_set_dai_sysclk(), with the effect of limiting
the allowed sample rates according to the MCLK/LRCK ratios supported by
the codec:

1. During audio card setup, to set the initial MCLK - see
   asoc_simple_init_dai().

2. Before opening a stream, to update MCLK, according to the stream
   sample rate and the multiplication factor - see
   asoc_simple_hw_params().

In some cases the initial MCLK might be set to a frequency that doesn't
match any of the supported ratios, e.g. 12287999 instead of 12288000,
which is only 1 Hz below the supported clock, as that is what the
hardware reports. This creates an empty list of rate constraints, which
is further passed to snd_pcm_hw_constraint_list() via
es8316_pcm_startup(), and causes the following error on the very first
access of the sound card:

  $ speaker-test -D hw:Analog,0 -F S16_LE -c 2 -t wav
  Broken configuration for playback: no configurations available: Invalid argument
  Setting of hwparams failed: Invalid argument

Note that all subsequent retries succeed thanks to the updated MCLK set
at point 2 above, which uses a computed frequency value instead of a
reading from the hardware registers. Normally this would have mitigated
the issue, but es8316_pcm_startup() executes before the 2nd call to
es8316_set_dai_sysclk(), hence it cannot make use of the updated
constraints.

Since es8316_pcm_hw_params() performs anyway a final validation of MCLK
against the stream sample rate and the supported MCLK/LRCK ratios, fix
the issue by ensuring that sysclk_constraints list is only set when at
least one supported sample rate is autodetected by the codec.

Fixes: b8b88b70875a ("ASoC: add es8316 codec driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20230530181140.483936-3-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 18d485e6921a7..ccecfdf700649 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -369,13 +369,11 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	int count = 0;
 
 	es8316->sysclk = freq;
+	es8316->sysclk_constraints.list = NULL;
+	es8316->sysclk_constraints.count = 0;
 
-	if (freq == 0) {
-		es8316->sysclk_constraints.list = NULL;
-		es8316->sysclk_constraints.count = 0;
-
+	if (freq == 0)
 		return 0;
-	}
 
 	ret = clk_set_rate(es8316->mclk, freq);
 	if (ret)
@@ -391,8 +389,10 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			es8316->allowed_rates[count++] = freq / ratio;
 	}
 
-	es8316->sysclk_constraints.list = es8316->allowed_rates;
-	es8316->sysclk_constraints.count = count;
+	if (count) {
+		es8316->sysclk_constraints.list = es8316->allowed_rates;
+		es8316->sysclk_constraints.count = count;
+	}
 
 	return 0;
 }
-- 
2.39.2



