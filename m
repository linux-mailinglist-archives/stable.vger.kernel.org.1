Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BBA7B8803
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbjJDSMH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbjJDSLy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:11:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8FC9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:11:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0DAC433C8;
        Wed,  4 Oct 2023 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443110;
        bh=pWohnJrcG5dRTg00Kja7DdXx0JKt5O1p4euJAhd1rEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvS36/TIEM6Q5/dRcOnQ39kuMaj8pLX/Fp8kTlNx3NQzrfRjSZ2RB71OeUzmMjN1i
         MOXDoSL4IYqdcwughmN0LCImrShs1XYLL5PdcndIPRmhZhQjOqrZsFj8QW7hO6BxhE
         hoLKZXmKnHQKgVK8XpktLIcdS/sX2bCDjqfSy9Xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sameer Pujar <spujar@nvidia.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/259] ASoC: rt5640: Revert "Fix sleep in atomic context"
Date:   Wed,  4 Oct 2023 19:53:33 +0200
Message-ID: <20231004175219.281855231@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit fa6a0c0c1dd53b3949ca56bf7213648dfd6a62ee ]

Commit 70a6404ff610 ("ASoC: rt5640: Fix sleep in atomic context")
not only switched from request_irq() to request_threaded_irq(),
to fix the sleep in atomic context issue, but it also added
devm management of the IRQ by actually switching to
devm_request_threaded_irq() (without any explanation in the commit
message for this change).

This is wrong since the IRQ was already explicitly managed by
the driver. On unbind the ASoC core will call rt5640_set_jack(NULL)
which in turn will call rt5640_disable_jack_detect() which
frees the IRQ already. So now we have a double free.

Besides the unexplained switch to devm being wrong, the actual fix
for the sleep in atomic context issue also is not the best solution.

The only thing which rt5640_irq() does is cancel + (re-)queue
the jack_work delayed_work. This can be done in a single non sleeping
call by replacing queue_delayed_work() with mod_delayed_work(),
which does not sleep. Using mod_delayed_work() is a much better fix
then adding a thread which does nothing other then queuing a work-item.

This patch is a straight revert of the troublesome changes, the switch
to mod_delayed_work() is done in a separate follow-up patch.

Fixes: 70a6404ff610 ("ASoC: rt5640: Fix sleep in atomic context")
Cc: Sameer Pujar <spujar@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230912113245.320159-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5640.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index a7071d0a2562f..0f8e6dd214b0d 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2562,10 +2562,9 @@ static void rt5640_enable_jack_detect(struct snd_soc_component *component,
 	if (jack_data && jack_data->use_platform_clock)
 		rt5640->use_platform_clock = jack_data->use_platform_clock;
 
-	ret = devm_request_threaded_irq(component->dev, rt5640->irq,
-					NULL, rt5640_irq,
-					IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					"rt5640", rt5640);
+	ret = request_irq(rt5640->irq, rt5640_irq,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			  "rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
 		rt5640_disable_jack_detect(component);
@@ -2618,9 +2617,8 @@ static void rt5640_enable_hda_jack_detect(
 
 	rt5640->jack = jack;
 
-	ret = devm_request_threaded_irq(component->dev, rt5640->irq,
-					NULL, rt5640_irq, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					"rt5640", rt5640);
+	ret = request_irq(rt5640->irq, rt5640_irq,
+			  IRQF_TRIGGER_RISING | IRQF_ONESHOT, "rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
 		rt5640->irq = -ENXIO;
-- 
2.40.1



