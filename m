Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39C713FB1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjE1TsG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjE1TsB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5889E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AC8661FD9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BFDC4339C;
        Sun, 28 May 2023 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303278;
        bh=QLZ1eCGJ+58eBr63e1ucrArrqF/xvK8IEXlCm78ogMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlkHSO0zlbZojL9jjcUSJh6B0pa/22vev9VecODOBNYb3PMOeVV7Gp5yZfclJdLfr
         61aa6SvkHCbNwOnPIWT4Xq3LUZQZFzn3j4m9YKwff18I5LUFserJl2+nLuHhYTGUte
         xSAe6zQNr/SZk8nPTPT4ehn/fp9kVeE5lVhUrwwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org
Subject: [PATCH 5.15 15/69] ASoC: rt5682: Disable jack detection interrupt during suspend
Date:   Sun, 28 May 2023 20:11:35 +0100
Message-Id: <20230528190828.918940416@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

commit 8b271370e963370703819bd9795a54d658071bed upstream.

The rt5682 driver switches its regmap to cache-only when the
device suspends and back to regular mode on resume. When the
jack detect interrupt fires rt5682_irq() schedules the jack
detect work. This can result in invalid reads from the regmap
in cache-only mode if the work runs before the device has
resumed:

[   56.245502] rt5682 9-001a: ASoC: error at soc_component_read_no_lock on rt5682.9-001a for register: [0x000000f0] -16

Disable the jack detection interrupt during suspend and
re-enable it on resume. The driver already schedules the
jack detection work on resume, so any state change during
suspend is still handled.

This is essentially the same as commit f7d00a9be147 ("SoC:
rt5682s: Disable jack detection interrupt during suspend")
for the rt5682s.

Cc: stable@kernel.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org
Reviewed-by: Douglas Anderson <dianders@chromium.org
Reviewed-by: Stephen Boyd <swboyd@chromium.org
Link: https://lore.kernel.org/r/20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5682-i2c.c |    4 +++-
 sound/soc/codecs/rt5682.c     |    6 ++++++
 sound/soc/codecs/rt5682.h     |    1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -268,7 +268,9 @@ static int rt5682_i2c_probe(struct i2c_c
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5682", rt5682);
-		if (ret)
+		if (!ret)
+			rt5682->irq = i2c->irq;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2951,6 +2951,9 @@ static int rt5682_suspend(struct snd_soc
 	if (rt5682->is_sdw)
 		return 0;
 
+	if (rt5682->irq)
+		disable_irq(rt5682->irq);
+
 	cancel_delayed_work_sync(&rt5682->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682->jd_check_work);
 	if (rt5682->hs_jack && (rt5682->jack_type & SND_JACK_HEADSET) == SND_JACK_HEADSET) {
@@ -3019,6 +3022,9 @@ static int rt5682_resume(struct snd_soc_
 	mod_delayed_work(system_power_efficient_wq,
 		&rt5682->jack_detect_work, msecs_to_jiffies(0));
 
+	if (rt5682->irq)
+		enable_irq(rt5682->irq);
+
 	return 0;
 }
 #else
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1462,6 +1462,7 @@ struct rt5682_priv {
 	int pll_out[RT5682_PLLS];
 
 	int jack_type;
+	int irq;
 	int irq_work_delay_time;
 };
 


