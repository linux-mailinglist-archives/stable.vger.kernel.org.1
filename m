Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7C79BA33
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355189AbjIKV5Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbjIKPDY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:03:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4C125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:03:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE28DC433C8;
        Mon, 11 Sep 2023 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444600;
        bh=QoOPl1LJBF/1BPSFlLurcMBfk6zyIbJKCHh+mk4yNOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K++DScaJzGwqb2esVUpZ9S1t8ueOjfsQ2GbWmxW381I9abZefuG4UTaUT3Jqn3Q0C
         92Nc2UklogR6P3Q3d09arps+KACKoPhy/pzF4DqCiVwkwIz4T2qRTHhlI1kUqGrzht
         onIV2O+FHLUx7JknxF73uIjojQMn0geWIvLAop6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmytro Maluka <dmy@semihalf.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/600] ASoC: da7219: Check for failure reading AAD IRQ events
Date:   Mon, 11 Sep 2023 15:40:54 +0200
Message-ID: <20230911134634.240317661@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmytro Maluka <dmy@semihalf.com>

[ Upstream commit f0691dc16206f21b13c464434366e2cd632b8ed7 ]

When handling an AAD interrupt, if IRQ events read failed (for example,
due to i2c "Transfer while suspended" failure, i.e. when attempting to
read it while DA7219 is suspended, which may happen due to a spurious
AAD interrupt), the events array contains garbage uninitialized values.
So instead of trying to interprete those values and doing any actions
based on them (potentially resulting in misbehavior, e.g. reporting
bogus events), refuse to handle the interrupt.

Signed-off-by: Dmytro Maluka <dmy@semihalf.com>
Link: https://lore.kernel.org/r/20230717193737.161784-3-dmy@semihalf.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 49b1622e7bada..9251490548e8c 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -353,11 +353,15 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 events[DA7219_AAD_IRQ_REG_MAX];
 	u8 statusa;
-	int i, report = 0, mask = 0;
+	int i, ret, report = 0, mask = 0;
 
 	/* Read current IRQ events */
-	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
-			 events, DA7219_AAD_IRQ_REG_MAX);
+	ret = regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
+			       events, DA7219_AAD_IRQ_REG_MAX);
+	if (ret) {
+		dev_warn_ratelimited(component->dev, "Failed to read IRQ events: %d\n", ret);
+		return IRQ_NONE;
+	}
 
 	if (!events[DA7219_AAD_IRQ_REG_A] && !events[DA7219_AAD_IRQ_REG_B])
 		return IRQ_NONE;
-- 
2.40.1



