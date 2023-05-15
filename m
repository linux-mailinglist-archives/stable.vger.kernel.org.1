Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B57039BF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbjEORpk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244527AbjEORpR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53015264
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0EDC62E88
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E014AC433D2;
        Mon, 15 May 2023 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172586;
        bh=H2uhvKGMd1qnrHSSF1WEw04RWPfBowB9SGTHXNVKFkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4BhHq2ulviyBWRXcfcdFDfm2CV2fzhIX2wfD0ED+a44qaumdEujDRTW4rbz6ZMON
         pR8ugYPcqvpowXNcBXk4KohEmwOI/SCNhVeL4F1lwfOTZaLCykrfeDoYyvJ/3hLZvf
         jX4boDNeasWTIDmrfG84+EMKBHBr47OREkXDQz/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 202/381] ASoC: es8316: Use IRQF_NO_AUTOEN when requesting the IRQ
Date:   Mon, 15 May 2023 18:27:33 +0200
Message-Id: <20230515161745.924014683@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1cf2aa665901054b140eb71748661ceae99b6b5a ]

Use the new IRQF_NO_AUTOEN flag when requesting the IRQ, rather then
disabling it immediately after requesting it.

This fixes a possible race where the IRQ might trigger between requesting
and disabling it; and this also leads to a small code cleanup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20211003132255.31743-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 39db65a0a17b ("ASoC: es8316: Handle optional IRQ assignment")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 609459077f9d9..aa23e4e671897 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -808,12 +808,9 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client,
 	mutex_init(&es8316->lock);
 
 	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					"es8316", es8316);
-	if (ret == 0) {
-		/* Gets re-enabled by es8316_set_jack() */
-		disable_irq(es8316->irq);
-	} else {
+	if (ret) {
 		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
 		es8316->irq = -ENXIO;
 	}
-- 
2.39.2



