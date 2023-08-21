Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70F9783306
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjHUTyS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHUTyS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4060EE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A53064559
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C611C433C7;
        Mon, 21 Aug 2023 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647655;
        bh=ZG6CXfQVPEcgKf8Q6ZsnrJBeMAokzq6ZEH4Kn6F8oOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+7Zvs0Ore/+2xkJHoPNdgqdAZTUszfiqOKMa7enyq04iAYy95mvaAmsAnMurpSeS
         2uFkKckl2ZBl3vYdVZs/GvrEspnTh2hGy6/jCp3rOYGfrPAD1rhVU6qbSFMrzKBaDz
         w3ORTEDLpupGVgtUFr+3SvmMxepGaHy+b+99aNsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Parker Newman <pnewman@connecttech.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.1 091/194] i2c: tegra: Fix i2c-tegra DMA config option processing
Date:   Mon, 21 Aug 2023 21:41:10 +0200
Message-ID: <20230821194126.733991792@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Parker Newman <pnewman@connecttech.com>

commit 27ec43c77b5db780a56fc3a6d6de6bf2f74614f7 upstream.

Tegra processors prior to Tegra186 used APB DMA for I2C requiring
CONFIG_TEGRA20_APB_DMA=y while Tegra186 and later use GPC DMA requiring
CONFIG_TEGRA186_GPC_DMA=y.

The check for if the processor uses APB DMA is inverted and so the wrong
DMA config options are checked.

This means if CONFIG_TEGRA20_APB_DMA=y but CONFIG_TEGRA186_GPC_DMA=n
with a Tegra186 or later processor the driver will incorrectly think DMA is
enabled and attempt to request DMA channels that will never be availible,
leaving the driver in a perpetual EPROBE_DEFER state.

Fixes: 48cb6356fae1 ("i2c: tegra: Add GPCDMA support")
Signed-off-by: Parker Newman <pnewman@connecttech.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Akhil R <akhilrajeev@nvidia.com>
Link: https://lore.kernel.org/r/fcfcf9b3-c8c4-9b34-2ff8-cd60a3d490bd@connecttech.com
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -449,7 +449,7 @@ static int tegra_i2c_init_dma(struct teg
 	if (i2c_dev->is_vi)
 		return 0;
 
-	if (!i2c_dev->hw->has_apb_dma) {
+	if (i2c_dev->hw->has_apb_dma) {
 		if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA)) {
 			dev_dbg(i2c_dev->dev, "APB DMA support not enabled\n");
 			return 0;


