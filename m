Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68874C318
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjGIL2R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjGIL2Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9213D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABE360C01
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B07C433C7;
        Sun,  9 Jul 2023 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902094;
        bh=10j1Frk/ueb+VoqDTk2nuLV2V3gqO5AUO/J0HVVXp3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjy4tloXgLmHAEK0T/BD4l7cBYO8AmpmLeUXRh2IxQ8g9pGchMon2wLVGH9aOc4K+
         1S4BEShWSyyhsTHTGivvVuC3zZpafpgvHrWnYw8xT5IG0hzgVa8pVUmbuxtmX+FUuF
         O/CIMeDcwhf5IB0gytveE4nv9Xrnz8lD44QKdqvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 254/431] ASoC: es8316: Increment max value for ALC Capture Target Volume control
Date:   Sun,  9 Jul 2023 13:13:22 +0200
Message-ID: <20230709111457.109780652@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 6f073429037cd79d7311cd8236311c53f5ea8f01 ]

The following error occurs when trying to restore a previously saved
ALSA mixer state (tested on a Rock 5B board):

  $ alsactl --no-ucm -f /tmp/asound.state store hw:Analog
  $ alsactl --no-ucm -I -f /tmp/asound.state restore hw:Analog
  alsactl: set_control:1475: Cannot write control '2:0:0:ALC Capture Target Volume:0' : Invalid argument

According to ES8316 datasheet, the register at address 0x2B, which is
related to the above mixer control, contains by default the value 0xB0.
Considering the corresponding ALC target bits (ALCLVL) are 7:4, the
control is initialized with 11, which is one step above the maximum
value allowed by the driver:

 ALCLVL | dB gain
 -------+--------
  0000  |  -16.5
  0001  |  -15.0
  0010  |  -13.5
  ....  |  .....
  0111  |   -6.0
  1000  |   -4.5
  1001  |   -3.0
  1010  |   -1.5
  ....  |  .....
  1111  |   -1.5

The tests performed using the VU meter feature (--vumeter=TYPE) of
arecord/aplay confirm the specs are correct and there is no measured
gain if the 1011-1111 range would have been mapped to 0 dB:

 dB gain | VU meter %
 --------+-----------
   -6.0  |  30-31
   -4.5  |  35-36
   -3.0  |  42-43
   -1.5  |  50-51
    0.0  |  50-51

Increment the max value allowed for ALC Capture Target Volume control,
so that it matches the hardware default.  Additionally, update the
related TLV to prevent an artificial extension of the dB gain range.

Fixes: b8b88b70875a ("ASoC: add es8316 codec driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20230530181140.483936-2-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index f7d7a9c91e04c..2bfcd9af39172 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -52,7 +52,12 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_max_gain_tlv, -650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_min_gain_tlv, -1200, 150, 0);
-static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_target_tlv, -1650, 150, 0);
+
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(alc_target_tlv,
+	0, 10, TLV_DB_SCALE_ITEM(-1650, 150, 0),
+	11, 11, TLV_DB_SCALE_ITEM(-150, 0, 0),
+);
+
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
 	0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
 	8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
@@ -115,7 +120,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 		       alc_max_gain_tlv),
 	SOC_SINGLE_TLV("ALC Capture Min Volume", ES8316_ADC_ALC2, 0, 28, 0,
 		       alc_min_gain_tlv),
-	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 10, 0,
+	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 11, 0,
 		       alc_target_tlv),
 	SOC_SINGLE("ALC Capture Hold Time", ES8316_ADC_ALC3, 0, 10, 0),
 	SOC_SINGLE("ALC Capture Decay Time", ES8316_ADC_ALC4, 4, 10, 0),
-- 
2.39.2



