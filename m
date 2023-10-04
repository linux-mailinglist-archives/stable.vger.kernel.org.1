Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43D7B893D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjJDSX6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbjJDSX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBCC6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F4EC433C8;
        Wed,  4 Oct 2023 18:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443826;
        bh=E5g6+hG5f83qAXTTk7H5geSBwdqJyv+9fSN8mAt+yfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XN95U6IG9/KwjJkXQmBs4dJQnYghFsgnnS2CoXq/WpepaAYDe0WmJwc7hZVYuqYer
         RvJVn8cYwAcq6nSitlAHYco4q1XIFKXCjH+EyRRUB8TAVRnorKFbfQNQvWrMmZvqVJ
         UlD3tRpjl1QddB0rO0AYcERueuolIaMyDGSF49Xs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oder Chiou <oder_chiou@realtek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 034/321] ASoC: rt5640: Do not disable/enable IRQ twice on suspend/resume
Date:   Wed,  4 Oct 2023 19:52:59 +0200
Message-ID: <20231004175230.739792055@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 786120ebb649b166021f0212250e8627e53d068a ]

When jack-detect was originally added disabling the IRQ during suspend
was done by the sound/soc/intel/boards/bytcr_rt5640.c driver
calling snd_soc_component_set_jack(NULL) on suspend, which calls
rt5640_disable_jack_detect(), which calls free_irq() which also
disables it.

Commit 5fabcc90e79b ("ASoC: rt5640: Fix Jack work after system suspend")
added disable_irq() / enable_irq() calls on suspend/resume for machine
drivers which do not call snd_soc_component_set_jack(NULL) on suspend.

The new disable_irq() / enable_irq() are made conditional by
"if (rt5640->irq)" statements, but this is true for the machine drivers
which do call snd_soc_component_set_jack(NULL) on suspend too, causing
a disable_irq() call there on the already free-ed IRQ.

Change the "if (rt5640->irq)" condition to "if (rt5640->jack)" to fix this,
rt5640->jack is only set if the jack-detect IRQ handler is still active
when rt5640_suspend() runs.

And adjust rt5640_enable_hda_jack_detect()'s request_irq() error handling
to set rt5640->jack to NULL to match (note that the old setting of irq to
-ENOXIO still resulted in disable_irq(-ENOXIO) calls on suspend).

Fixes: 5fabcc90e79b ("ASoC: rt5640: Fix Jack work after system suspend")
Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230912113245.320159-4-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5640.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 10086755ae82c..c2c82da36c625 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2623,7 +2623,7 @@ static void rt5640_enable_hda_jack_detect(
 			  IRQF_TRIGGER_RISING | IRQF_ONESHOT, "rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to request IRQ %d: %d\n", rt5640->irq, ret);
-		rt5640->irq = -ENXIO;
+		rt5640->jack = NULL;
 		return;
 	}
 
@@ -2798,7 +2798,7 @@ static int rt5640_suspend(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	if (rt5640->irq) {
+	if (rt5640->jack) {
 		/* disable jack interrupts during system suspend */
 		disable_irq(rt5640->irq);
 	}
@@ -2826,10 +2826,9 @@ static int rt5640_resume(struct snd_soc_component *component)
 	regcache_cache_only(rt5640->regmap, false);
 	regcache_sync(rt5640->regmap);
 
-	if (rt5640->irq)
+	if (rt5640->jack) {
 		enable_irq(rt5640->irq);
 
-	if (rt5640->jack) {
 		if (rt5640->jd_src == RT5640_JD_SRC_HDA_HEADER) {
 			snd_soc_component_update_bits(component,
 				RT5640_DUMMY2, 0x1100, 0x1100);
-- 
2.40.1



