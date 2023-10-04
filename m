Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543417B893A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbjJDSX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbjJDSX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53DE8
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EA3C433C8;
        Wed,  4 Oct 2023 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443829;
        bh=Y3+bGWp6C7eFs5E5dt59qg0uxOCY3dae8BXUPEvF07s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1F0uAxvu6unl28bCZxJSywDLauZOZ07avE4q7FojRTo/aUbs0dYtQyYugwQ+mF2Xw
         ij5e/kxhJkSuLzqVM7wxQyaRc47cZOBXAaGjc4yqb4AelrK/gPis4J1jJR2OfW2DT8
         pssMDZqNluZqhqASQLfBxp5ZgE01oaqjeLB2aldM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oder Chiou <oder_chiou@realtek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 035/321] ASoC: rt5640: Enable the IRQ on resume after configuring jack-detect
Date:   Wed,  4 Oct 2023 19:53:00 +0200
Message-ID: <20231004175230.789290807@linuxfoundation.org>
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

[ Upstream commit b5e85e535551bf82242aa5896e14a136ed3c156d ]

The jack-detect IRQ should be enabled *after* the jack-detect related
configuration registers have been programmed.

Move the enable_irq() call for this to after the register setup.

Fixes: 5fabcc90e79b ("ASoC: rt5640: Fix Jack work after system suspend")
Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230912113245.320159-5-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5640.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index c2c82da36c625..7522a9803d098 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2827,8 +2827,6 @@ static int rt5640_resume(struct snd_soc_component *component)
 	regcache_sync(rt5640->regmap);
 
 	if (rt5640->jack) {
-		enable_irq(rt5640->irq);
-
 		if (rt5640->jd_src == RT5640_JD_SRC_HDA_HEADER) {
 			snd_soc_component_update_bits(component,
 				RT5640_DUMMY2, 0x1100, 0x1100);
@@ -2855,6 +2853,7 @@ static int rt5640_resume(struct snd_soc_component *component)
 			}
 		}
 
+		enable_irq(rt5640->irq);
 		queue_delayed_work(system_long_wq, &rt5640->jack_work, 0);
 	}
 
-- 
2.40.1



