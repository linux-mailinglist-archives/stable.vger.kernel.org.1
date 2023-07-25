Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C2761189
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGYKwb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGYKv2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CB01999
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77596167F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5770C433C7;
        Tue, 25 Jul 2023 10:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282255;
        bh=GGOQBBdRek3AH3MuzMCabXyqd63cH6fXVbP3+8/WVrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSO12PejUTqjIYb+gmig6VbiqTQSBPkt8eFDcdHi4DvGodB00d3Z32whCPxF5c5G4
         ibOPMXSxZODKQtC6VeghQl6SxjFeIwXHqAkWH2WLkR0s8p4fnkBdPUhNvzfLj1bDm5
         oDxKCbvTf0f99JHZSN22Zam6CPJ1EMWeyDdJZcx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marcus Seyfarth <m.seyfarth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 062/227] ASoC: cs35l45: Select REGMAP_IRQ
Date:   Tue, 25 Jul 2023 12:43:49 +0200
Message-ID: <20230725104517.317766590@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

commit d9ba2975e98a4bec0a9f8d4be4c1de8883fccb71 upstream.

After commit 6085f9e6dc19 ("ASoC: cs35l45: IRQ support"), without any
other configuration that selects CONFIG_REGMAP_IRQ, modpost errors out
with:

  ERROR: modpost: "regmap_irq_get_virq" [sound/soc/codecs/snd-soc-cs35l45.ko] undefined!
  ERROR: modpost: "devm_regmap_add_irq_chip" [sound/soc/codecs/snd-soc-cs35l45.ko] undefined!

Add the Kconfig selection to ensure these functions get built and
included, which resolves the build failure.

Cc: stable@vger.kernel.org
Fixes: 6085f9e6dc19 ("ASoC: cs35l45: IRQ support")
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1882
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230703-cs35l45-select-regmap_irq-v1-1-37d7e838b614@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -701,6 +701,7 @@ config SND_SOC_CS35L41_I2C
 
 config SND_SOC_CS35L45
 	tristate
+	select REGMAP_IRQ
 
 config SND_SOC_CS35L45_SPI
 	tristate "Cirrus Logic CS35L45 CODEC (SPI)"


