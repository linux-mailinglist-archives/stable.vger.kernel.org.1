Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158D7CA2B0
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjJPIxO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJPIxN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:53:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66150EB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:53:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF51C433C9;
        Mon, 16 Oct 2023 08:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446390;
        bh=tJCUVv2eU7GHdyjx8CmJ9tFyNooK+dCDLs1CiWwf9DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2aSJpF8+Gp1/xeeolxQIGaOvi/kMkohKrwHW12Q5srsg373Xr8AbmGPUduZ+JMjq
         G4JGkEb4IrKmwQNlTtvZhZp14Vcl5kONNAZ1MffMU2W19SthooTLPX6K/m1hrhnSQO
         G8uUP4kFTPk6mQHJcGOBcsazQrgdzzZ37IRTB3RA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, coolstar <coolstarorganization@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 021/131] ASoC: SOF: amd: fix for firmware reload failure after playback
Date:   Mon, 16 Oct 2023 10:40:04 +0200
Message-ID: <20231016084000.593923833@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

commit 7e1fe5d9e7eae67e218f878195d1d348d01f9af7 upstream.

Setting ACP ACLK as clock source when ACP enters D0 state causing
firmware load failure as mentioned in below scenario.

- Load snd_sof_amd_rembrandt
- Play or Record audio
- Stop audio
- Unload snd_sof_amd_rembrandt
- Reload snd_sof_amd_rembrandt

If acp_clkmux_sel register field is set, then clock source will be
set to ACP ACLK when ACP enters D0 state.

During stream stop, if there is no active stream is running then
acp firmware will set the ACP ACLK value to zero.

When driver is reloaded and clock source is selected as ACP ACLK,
as ACP ACLK is programmed to zero, firmware loading will fail.

For RMB platform, remove the clock mux selection field so that
ACP will use internal clock source when ACP enters D0 state.

Fixes: 41cb85bc4b52 ("ASoC: SOF: amd: Add support for Rembrandt plaform.")
Reported-by: coolstar <coolstarorganization@gmail.com>
Closes: https://github.com/thesofproject/sof/issues/8137
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230927071412.2416250-1-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/amd/pci-rmb.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -54,7 +54,6 @@ static const struct sof_amd_acp_desc rem
 	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
 	.i2s_pin_config_offset = ACP6X_I2S_PIN_CONFIG,
 	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
-	.acp_clkmux_sel = ACP6X_CLKMUX_SEL,
 	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
 };
 


