Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA49475554C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjGPUjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGPUjb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23E0BA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83E7960DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCECC433C8;
        Sun, 16 Jul 2023 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539969;
        bh=4WUeVJuHlvRvNHZpsK894FJJymCsAj/agbtLGYFsVkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emZI/tT3JDRVGw8lxSmhagrZNuBPZWb3Q5iL9WTx7PL6/n7TdY1G/AXKcbw/wB+wo
         zfBzqFU389En1mcWx/H6RQCAXZB0lT5F4IrggV/uJY2EQLuBP0f3+gV4VyJu2JaAvj
         IUSrAhJvlODv4I9zKe8oZMnQ4Wx6h+IIhHqC/83Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 169/591] ASoC: Intel: sof_sdw: remove SOF_SDW_TGL_HDMI for MeteorLake devices
Date:   Sun, 16 Jul 2023 21:45:08 +0200
Message-ID: <20230716194928.238159026@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 0db94947c9d3da16aa31d152b7d26fab78b02cb9 ]

Topologies support three HDMI links on MeteorLake devices only.

Fixes: 18489174e4fb ("ASoC: intel: sof_sdw: add RT711 SDCA card for MTL platform")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Link: https://lore.kernel.org/r/20230512173305.65399-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d4f92bb5e29f8..a37c85d301471 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -372,7 +372,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_mtlrvp"),
 		},
-		.driver_data = (void *)(RT711_JD1 | SOF_SDW_TGL_HDMI),
+		.driver_data = (void *)(RT711_JD1),
 	},
 	{}
 };
-- 
2.39.2



