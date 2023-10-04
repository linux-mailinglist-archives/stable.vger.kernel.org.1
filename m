Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0E7B8813
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbjJDSMO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbjJDSMG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:12:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57773D7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:11:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2AAC433C8;
        Wed,  4 Oct 2023 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443113;
        bh=WTLYbaxWFfCrpXJnDsGPeHjBxdpdrnxtBB5naFqI9yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxVscakCQTc1Zo6XIU8vhzT7pdZLflN3KZdcqmHSodlfI+HNTufj0P+aYJgudErCA
         vRMP5eSHTWIwJy6L5WzfbrfhmbCvg5nqv04pHbPdbeCuGcnQWhdAq5la3iiMNl9hyL
         Ym7SZeQjtw0imVtrLS7cZi/Wnw0651oKBBOQtKRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oder Chiou <oder_chiou@realtek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/259] ASoC: rt5640: Fix IRQ not being free-ed for HDA jack detect mode
Date:   Wed,  4 Oct 2023 19:53:34 +0200
Message-ID: <20231004175219.330655448@linuxfoundation.org>
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

[ Upstream commit 8c8bf3df6b7c0ed1c4dd373b23eb0ce13a63f452 ]

Set "rt5640->irq_requested = true" after a successful request_irq()
in rt5640_enable_hda_jack_detect(), so that rt5640_disable_jack_detect()
properly frees the IRQ.

This fixes the IRQ not being freed on rmmod / driver unbind.

Fixes: 2b9c8d2b3c89 ("ASoC: rt5640: Add the HDA header support")
Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230912113245.320159-6-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0f8e6dd214b0d..37ea4d854cb58 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2624,6 +2624,7 @@ static void rt5640_enable_hda_jack_detect(
 		rt5640->irq = -ENXIO;
 		return;
 	}
+	rt5640->irq_requested = true;
 
 	/* sync initial jack state */
 	queue_delayed_work(system_long_wq, &rt5640->jack_work, 0);
-- 
2.40.1



