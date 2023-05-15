Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9277039C0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbjEORpo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244661AbjEORpU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348E116909
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9A1624D7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5A8C433D2;
        Mon, 15 May 2023 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172589;
        bh=I1gjs/dqDsEvpT52N82iIXa5uIH0QL9Eb+ptCs56eVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgD2vqVBXAC4YMCBHUzNK7bekHVHXfhSQlKRo1bb4hmIS21gz28i0e5WHDv+mS6D3
         A1lDosr3EiEBoWLvrFv/inhoWBotAaAote82sVW/F7bHpeA8TRqH/KgDyOcl8XGjqT
         G0PR+0n05Ssu9+qLK7TTttOmBARYugBIAnMu5kas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 203/381] ASoC: es8316: Handle optional IRQ assignment
Date:   Mon, 15 May 2023 18:27:34 +0200
Message-Id: <20230515161745.971691574@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 39db65a0a17b54915b269d3685f253a4731f344c ]

The driver is able to work fine without relying on a mandatory interrupt
being assigned to the I2C device. This is only needed when making use of
the jack-detect support.

However, the following warning message is always emitted when there is
no such interrupt available:

  es8316 0-0011: Failed to get IRQ 0: -22

Do not attempt to request an IRQ if it is not available/valid. This also
ensures the rather misleading message is not displayed anymore.

Also note the IRQ validation relies on commit dab472eb931bc291 ("i2c /
ACPI: Use 0 to indicate that device does not have interrupt assigned").

Fixes: 822257661031 ("ASoC: es8316: Add jack-detect support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230328094901.50763-1-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index aa23e4e671897..bc3d46617a113 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -807,12 +807,14 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client,
 	es8316->irq = i2c_client->irq;
 	mutex_init(&es8316->lock);
 
-	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"es8316", es8316);
-	if (ret) {
-		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
-		es8316->irq = -ENXIO;
+	if (es8316->irq > 0) {
+		ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						"es8316", es8316);
+		if (ret) {
+			dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
+			es8316->irq = -ENXIO;
+		}
 	}
 
 	return devm_snd_soc_register_component(&i2c_client->dev,
-- 
2.39.2



