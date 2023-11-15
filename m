Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27517ECED7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjKOTox (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjKOTow (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582371A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B703C433CB;
        Wed, 15 Nov 2023 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077489;
        bh=y2/PV3/rMnSjUlHYhnzpTCHosRTEBkzwWVDXMNBRaZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgusZSdHBYORslE0YnPIZ+rksrChUuG/Td8frsn+xQT31n1G+HkI5rmtSvIqV42Y4
         5zJ/2k0AoVOelETh3KG+BRrbeUeaVBU4QpFWU9XT2OfC4R4Nd32JWL3InnCBQ6K1Wg
         GPZsdgBDdMGxung+ISbsl7lt6wPL4d6ZyMO+w3mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 334/603] ASoC: cs35l41: Undo runtime PM changes at driver exit time
Date:   Wed, 15 Nov 2023 14:14:39 -0500
Message-ID: <20231115191636.629957852@linuxfoundation.org>
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

[ Upstream commit 2d5661e6008ae1a1cd6df7cc844908fb8b982c58 ]

According to the documentation, drivers are responsible for undoing at
removal time all runtime PM changes done during probing.

Hence, add the missing calls to pm_runtime_dont_use_autosuspend(), which
are necessary for undoing pm_runtime_use_autosuspend().

Note this would have been handled implicitly by
devm_pm_runtime_enable(), but there is a need to continue using
pm_runtime_enable()/pm_runtime_disable() in order to ensure the runtime
PM is disabled as soon as the remove() callback is entered.

Fixes: f517ba4924ad ("ASoC: cs35l41: Add support for hibernate memory retention mode")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230907171010.1447274-7-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index a31cb9ba7f7de..5456e6bfa242f 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1334,6 +1334,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	return 0;
 
 err_pm:
+	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
 	pm_runtime_put_noidle(cs35l41->dev);
 
@@ -1350,6 +1351,7 @@ EXPORT_SYMBOL_GPL(cs35l41_probe);
 void cs35l41_remove(struct cs35l41_private *cs35l41)
 {
 	pm_runtime_get_sync(cs35l41->dev);
+	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
 
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
-- 
2.42.0



