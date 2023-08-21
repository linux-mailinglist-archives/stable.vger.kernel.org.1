Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4497B783232
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjHUT7P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjHUT7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44975123
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D888C64705
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C4C433C7;
        Mon, 21 Aug 2023 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647945;
        bh=Ys87YkibDy+FcXVl/iCEpFRzhmMOMcBvNv6IT2QmaZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdRY2wAnOQq1McyKRNlJlj6K5seNNkFsU5kOl3CZFmT1AOCk8zgp2jBkCsf2QCOCW
         rF/6C8/XY7SYKHn8xtesfFQjbpLqCnN1iByUu0d49uyYPsofwK/cQ/xsOCmDXvH8eU
         ef1Y6ZJy88Mu9iEuCTJ/m6gwpY6S6mzP5XPzhS8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 165/194] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
Date:   Mon, 21 Aug 2023 21:42:24 +0200
Message-ID: <20230821194129.949966895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 812a05256d673b2b9c5db906775d1e6625ba4787 upstream.

The vangogh driver just gained a link time dependency that now causes
randconfig builds to fail:

x86_64-linux-ld: sound/soc/amd/vangogh/pci-acp5x.o: in function `snd_acp5x_probe':
pci-acp5x.c:(.text+0xbb): undefined reference to `snd_amd_acp_find_config'

Fixes: e89f45edb747e ("ASoC: amd: vangogh: Add check for acp config flags in vangogh platform")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230602124447.863476-1-arnd@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -81,6 +81,7 @@ config SND_SOC_AMD_VANGOGH_MACH
 	tristate "AMD Vangogh support for NAU8821 CS35L41"
 	select SND_SOC_NAU8821
 	select SND_SOC_CS35L41_SPI
+	select SND_AMD_ACP_CONFIG
 	depends on SND_SOC_AMD_ACP5x && I2C && SPI_MASTER
 	help
 	  This option enables machine driver for Vangogh platform


