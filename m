Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE847ECC49
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjKOT15 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjKOT14 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EFA1BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DDDC433C8;
        Wed, 15 Nov 2023 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076471;
        bh=eh1bWmoANyz79YhE5xdaAmDHSrANpUa8h3rMfxMU47A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1EHfEZCBCZP4PCN4HsryySKfMhBREUaf2M09KyCxMACXGkPD6doOvDuuljI6dC11A
         hY0703Gxwmb+yLA3gRNpR9DCD+3gvhRgIGxleckCZLPCZjNVlYeLcpkxouFcoL4xfl
         WY+SAjcT3gcjMeDfy5p3F4NeV1myLNx/oV6M8cn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 310/550] ALSA: hda: cs35l41: Undo runtime PM changes at driver exit time
Date:   Wed, 15 Nov 2023 14:14:54 -0500
Message-ID: <20231115191622.312785923@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 85a1bf86fac0c195929768b4e92c78cad107523b ]

According to the documentation, drivers are responsible for undoing at
removal time all runtime PM changes done during probing.

Hence, add the missing calls to pm_runtime_dont_use_autosuspend(), which
are necessary for undoing pm_runtime_use_autosuspend().

Fixes: 1873ebd30cc8 ("ALSA: hda: cs35l41: Support Hibernation during Suspend")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230907171010.1447274-11-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f9ce8567d068f..297ba795c71b9 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1547,6 +1547,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	return 0;
 
 err_pm:
+	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
 	pm_runtime_put_noidle(cs35l41->dev);
 
@@ -1565,6 +1566,7 @@ void cs35l41_hda_remove(struct device *dev)
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	pm_runtime_get_sync(cs35l41->dev);
+	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
 
 	if (cs35l41->halo_initialized)
-- 
2.42.0



