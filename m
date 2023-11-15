Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAB7E2386
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjKFNM3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjKFNM2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:12:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C33F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:12:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E9BC433C8;
        Mon,  6 Nov 2023 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276345;
        bh=6/YnSjy7eoYajlxcSkCHsXYdcX4MFKTAaNUB15+ZmwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBotzK5zLKOdWrW62RG1e+yO2szcEm96G5woW+BMueS+yUHHND9bIFUD+Y6evyBhb
         QGu+zJ6tpXWN1BXumy29wHePrVYF0YJqs9lU7Ry+FrLIw/0/FB8Xbv3wuj3IjOkfvD
         gt9YJ2IrEIqXnw+iNg0JrYhluH0p60SvM9IXG6M4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Antoine Gennart <gennartan@disroot.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 03/62] ASoC: tlv320adc3xxx: BUG: Correct micbias setting
Date:   Mon,  6 Nov 2023 14:03:09 +0100
Message-ID: <20231106130301.931524283@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 52bb557247244..6bd6da01aafac 100644
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



