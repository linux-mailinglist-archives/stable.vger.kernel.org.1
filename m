Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D37ECC61
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjKOTaB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjKOTaB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D012C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:29:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F75C433C8;
        Wed, 15 Nov 2023 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076597;
        bh=Wb/uWYqAAkzq9Sn9ZJYtPj4XLsC1Ei8UjD9vyVMobpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTzj1OL97cIaV4Jm8SDkrnMPSm89KYRi+h6kaMNVI3ggqBkN07uLyNTA19L6pDyiU
         96oWXbL8FFN2QUSyUsYettjGNO3kKcXgFl18zjJ3l1QQi78KPY7YJ4Hn0xQkGYAYo+
         w/aHG30eK3NsV730Vx74vW1BnwlpJ7nCYbUGxXHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 307/550] ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler
Date:   Wed, 15 Nov 2023 14:14:51 -0500
Message-ID: <20231115191622.098785429@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 9f8948db9849d202dee3570507d3a0642f92d632 ]

The interrupt handler invokes pm_runtime_get_sync() without checking the
returned error code.

Add a proper verification and switch to pm_runtime_resume_and_get(), to
avoid the need to call pm_runtime_put_noidle() for decrementing the PM
usage counter before returning from the error condition.

Fixes: f517ba4924ad ("ASoC: cs35l41: Add support for hibernate memory retention mode")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230907171010.1447274-6-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c9f033d2782d2..abbe82071c1a4 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -386,10 +386,18 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	struct cs35l41_private *cs35l41 = data;
 	unsigned int status[4] = { 0, 0, 0, 0 };
 	unsigned int masks[4] = { 0, 0, 0, 0 };
-	int ret = IRQ_NONE;
 	unsigned int i;
+	int ret;
 
-	pm_runtime_get_sync(cs35l41->dev);
+	ret = pm_runtime_resume_and_get(cs35l41->dev);
+	if (ret < 0) {
+		dev_err(cs35l41->dev,
+			"pm_runtime_resume_and_get failed in %s: %d\n",
+			__func__, ret);
+		return IRQ_NONE;
+	}
+
+	ret = IRQ_NONE;
 
 	for (i = 0; i < ARRAY_SIZE(status); i++) {
 		regmap_read(cs35l41->regmap,
-- 
2.42.0



