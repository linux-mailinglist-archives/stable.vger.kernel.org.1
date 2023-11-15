Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E77ECED0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjKOTot (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjKOTop (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C291189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8205C433C9;
        Wed, 15 Nov 2023 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077481;
        bh=dg25mljLHa411KD+Xhxnq3pT5WaiPBSm3kUNRPY+Xac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OixbDWyHWwyaQNDh7VCDKz5qxS2psTZxS+5UjDG6Wz6hcNhFd9jLiDkxqa/ZcyQdC
         qvadk7C0+qTcITxtPm+0rsc3XB8ANG88nY2myJR8bYAAI2CkfpZboO3G6KSMM0TfvA
         XkwJei7a6RODXGmA6uY3y5l39lajhz5YKEVURZD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 330/603] ASoC: cs35l41: Handle mdsync_up reg write errors
Date:   Wed, 15 Nov 2023 14:14:35 -0500
Message-ID: <20231115191636.349745885@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 4bb5870ab60abca6ad18196090831b5e4cf82d93 ]

The return code of regmap_multi_reg_write() call related to "MDSYNC up"
sequence is shadowed by the subsequent regmap_read_poll_timeout()
invocation, which will hit a timeout in case the write operation above
fails.

Make sure cs35l41_global_enable() returns the correct error code instead
of -ETIMEDOUT.

Additionally, to be able to distinguish between the timeouts of
wait_for_completion_timeout() and regmap_read_poll_timeout(), print an
error message for the former and return immediately.  This also avoids
having to wait unnecessarily for the second time.

Fixes: f8264c759208 ("ALSA: cs35l41: Poll for Power Up/Down rather than waiting a fixed delay")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230907171010.1447274-3-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41-lib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index a018f1d984286..a6c6bb23b9574 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1251,15 +1251,18 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 
 		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
 		if (ret == 0) {
-			ret = -ETIMEDOUT;
-		} else {
-			regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
-			pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
-			cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
-			ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
-						     ARRAY_SIZE(cs35l41_mdsync_up_seq));
+			dev_err(dev, "Timed out waiting for pll_lock\n");
+			return -ETIMEDOUT;
 		}
 
+		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
+		pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
+		cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
+		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
+					     ARRAY_SIZE(cs35l41_mdsync_up_seq));
+		if (ret)
+			return ret;
+
 		ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1,
 					int_status, int_status & pup_pdn_mask,
 					1000, 100000);
-- 
2.42.0



