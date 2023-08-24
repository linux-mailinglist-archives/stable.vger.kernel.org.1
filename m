Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9457178735C
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbjHXPCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbjHXPCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3E1BD4
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297C461027
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDECC433C9;
        Thu, 24 Aug 2023 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889344;
        bh=XeygF5EK9fvawY0vJD0vGuwKbM2EsgUbUPcTGtfwsPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNV/JJf3tQDsTvtUCqzJ9yq58txStfpUqyz/722XNGFXjX6qEQCbetKqSewiJ5giQ
         cFu/aBCUvHTdkgXUsumMXh8tNJTsXOwuWlzIHRE00o2UdjVxBH3QI5kd3jvU0BvBcv
         x/YU4zRKW4Q1bQNiHuhbJJnhcO3weFvV8W9wtW8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 103/135] ASoC: meson: axg-tdm-formatter: fix channel slot allocation
Date:   Thu, 24 Aug 2023 16:50:46 +0200
Message-ID: <20230824145031.423913642@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit c1f848f12103920ca165758aedb1c10904e193e1 ]

When the tdm lane mask is computed, the driver currently fills the 1st lane
before moving on to the next. If the stream has less channels than the
lanes can accommodate, slots will be disabled on the last lanes.

Unfortunately, the HW distribute channels in a different way. It distribute
channels in pair on each lanes before moving on the next slots.

This difference leads to problems if a device has an interface with more
than 1 lane and with more than 2 slots per lane.

For example: a playback interface with 2 lanes and 4 slots each (total 8
slots - zero based numbering)
- Playing a 8ch stream:
  - All slots activated by the driver
  - channel #2 will be played on lane #1 - slot #0 following HW placement
- Playing a 4ch stream:
  - Lane #1 disabled by the driver
  - channel #2 will be played on lane #0 - slot #2

This behaviour is obviously not desirable.

Change the way slots are activated on the TDM lanes to follow what the HW
does and make sure each channel always get mapped to the same slot/lane.

Fixes: 1a11d88f499c ("ASoC: meson: add tdm formatter base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20230809171931.1244502-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdm-formatter.c | 42 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index cab7fa2851aa8..4834cfd163c03 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -30,27 +30,32 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 					struct axg_tdm_stream *ts,
 					unsigned int offset)
 {
-	unsigned int val, ch = ts->channels;
-	unsigned long mask;
-	int i, j;
+	unsigned int ch = ts->channels;
+	u32 val[AXG_TDM_NUM_LANES];
+	int i, j, k;
+
+	/*
+	 * We need to mimick the slot distribution used by the HW to keep the
+	 * channel placement consistent regardless of the number of channel
+	 * in the stream. This is why the odd algorithm below is used.
+	 */
+	memset(val, 0, sizeof(*val) * AXG_TDM_NUM_LANES);
 
 	/*
 	 * Distribute the channels of the stream over the available slots
-	 * of each TDM lane
+	 * of each TDM lane. We need to go over the 32 slots ...
 	 */
-	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
-		val = 0;
-		mask = ts->mask[i];
-
-		for (j = find_first_bit(&mask, 32);
-		     (j < 32) && ch;
-		     j = find_next_bit(&mask, 32, j + 1)) {
-			val |= 1 << j;
-			ch -= 1;
+	for (i = 0; (i < 32) && ch; i += 2) {
+		/* ... of all the lanes ... */
+		for (j = 0; j < AXG_TDM_NUM_LANES; j++) {
+			/* ... then distribute the channels in pairs */
+			for (k = 0; k < 2; k++) {
+				if ((BIT(i + k) & ts->mask[j]) && ch) {
+					val[j] |= BIT(i + k);
+					ch -= 1;
+				}
+			}
 		}
-
-		regmap_write(map, offset, val);
-		offset += regmap_get_reg_stride(map);
 	}
 
 	/*
@@ -63,6 +68,11 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
+		regmap_write(map, offset, val[i]);
+		offset += regmap_get_reg_stride(map);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
-- 
2.40.1



