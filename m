Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB44F7ED0BA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbjKOT5M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjKOT5I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:57:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E4B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:57:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C95C433C8;
        Wed, 15 Nov 2023 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078225;
        bh=C77g1k+B2R2zW4In+rWiT18E0Rz8Sbv18Sy9e95qzD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qC1LZEtLb+sqVu1KuE3lCQHJZtScnmjdwdbhwIyXG3UcvHwL1RnL+qJIkYdGWgnrP
         dephdZVyr2UTblfDQZEy5ZAJgft8Ikgr7vrl3EPYgtgUBLdAfcpmTizpYwTqNDw7mm
         wrJhQBM1ufH4fUoK/ISvsa8J8kgrFGFL9CUPdDho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 188/379] ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()
Date:   Wed, 15 Nov 2023 14:24:23 -0500
Message-ID: <20231115192656.224482781@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 486465508f8a5fe441939a7d97607f4460a60891 ]

If component_add() fails, probe() returns without calling
pm_runtime_put(), which leaves the runtime PM usage counter incremented.

Fix the issue by jumping to err_pm label and drop the now unnecessary
pm_runtime_disable() call.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230907171010.1447274-10-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index a5b10a6a33a5e..f92fc84199bc8 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1501,8 +1501,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	ret = component_add(cs35l41->dev, &cs35l41_hda_comp_ops);
 	if (ret) {
 		dev_err(cs35l41->dev, "Register component failed: %d\n", ret);
-		pm_runtime_disable(cs35l41->dev);
-		goto err;
+		goto err_pm;
 	}
 
 	dev_info(cs35l41->dev, "Cirrus Logic CS35L41 (%x), Revision: %02X\n", regid, reg_revid);
-- 
2.42.0



