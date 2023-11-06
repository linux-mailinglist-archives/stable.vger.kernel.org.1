Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A327E23E3
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKFNPw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjKFNPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:15:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82132BD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:15:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7352C433C8;
        Mon,  6 Nov 2023 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276548;
        bh=47Hpf3k9N8rWxxd3MH47aiMiCAxl+SW2pCQ/vH/c3R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2nKtvbzVQQybvh1xL5dhlvbYvkY4HAdNk3tfEPY6palJYK9EZMMuDwJhTas+10k2
         UqtMqk35125ZQcTeZVQNUzXHW8SgP+Y7S2Hr/rSA0x9pxkrInMi7Ia6NYa2tZsA2Kf
         ybk4eIBEIxr9m1rp72DEFteyejcWqpMDQaoVEev8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Antoine Gennart <gennartan@disroot.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 06/88] ASoC: tlv320adc3xxx: BUG: Correct micbias setting
Date:   Mon,  6 Nov 2023 14:03:00 +0100
Message-ID: <20231106130306.002488950@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Antoine Gennart <gennartan@disroot.org>

[ Upstream commit e930bea4124b8a4a47ba4092d99da30099b9242d ]

The micbias setting for tlv320adc can also have the value '3' which
means that the micbias ouput pin is connected to the input pin AVDD.

Signed-off-by: Antoine Gennart <gennartan@disroot.org>
Link: https://lore.kernel.org/r/20230929130117.77661-1-gennartan@disroot.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adc3xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index b976c1946286a..420bbf588efea 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -293,7 +293,7 @@
 #define ADC3XXX_BYPASS_RPGA		0x80
 
 /* MICBIAS control bits */
-#define ADC3XXX_MICBIAS_MASK		0x2
+#define ADC3XXX_MICBIAS_MASK		0x3
 #define ADC3XXX_MICBIAS1_SHIFT		5
 #define ADC3XXX_MICBIAS2_SHIFT		3
 
@@ -1099,7 +1099,7 @@ static int adc3xxx_parse_dt_micbias(struct adc3xxx *adc3xxx,
 	unsigned int val;
 
 	if (!of_property_read_u32(np, propname, &val)) {
-		if (val >= ADC3XXX_MICBIAS_AVDD) {
+		if (val > ADC3XXX_MICBIAS_AVDD) {
 			dev_err(dev, "Invalid property value for '%s'\n", propname);
 			return -EINVAL;
 		}
-- 
2.42.0



