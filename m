Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD4073E9B3
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjFZSjL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjFZSjF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502313D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB14960F52
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3781C433C8;
        Mon, 26 Jun 2023 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804740;
        bh=KT1TO/81Mvfe7pNTkH87qvzHplG6oA4yV72b3XUTkKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKlwkU1KMXVjI9tlVJCqrORGEn0+CPHSwWoF/BwBrPAKmybYSJR0gLABDzn69i2L1
         gBBR+m0EdHXMDVD38eSSEo4dj9s7281+2aGnhnZS1Vu3AKM9rdDyI0xpTNDn5m6IvQ
         cBIUJrSdBgodeKLa58Us1zn+ZPIQRvUkTAeUI/lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 25/96] mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916
Date:   Mon, 26 Jun 2023 20:11:40 +0200
Message-ID: <20230626180747.972108205@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit e6f9e590b72e12bbb86b1b8be7e1981f357392ad upstream.

While SDHCI claims to support 64-bit DMA on MSM8916 it does not seem to
be properly functional. It is not immediately obvious because SDHCI is
usually used with IOMMU bypassed on this SoC, and all physical memory
has 32-bit addresses. But when trying to enable the IOMMU it quickly
fails with an error such as the following:

  arm-smmu 1e00000.iommu: Unhandled context fault:
    fsr=0x402, iova=0xfffff200, fsynr=0xe0000, cbfrsynra=0x140, cb=3
  mmc1: ADMA error: 0x02000000
  mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
  mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002e02
  mmc1: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000000
  mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
  mmc1: sdhci: Present:   0x03f80206 | Host ctl: 0x00000019
  mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
  mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
  mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000001
  mmc1: sdhci: Int enab:  0x03ff900b | Sig enab: 0x03ff100b
  mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
  mmc1: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x00008007
  mmc1: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
  mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x5b590000
  mmc1: sdhci: Resp[2]:   0xe6487f80 | Resp[3]:  0x0a404094
  mmc1: sdhci: Host ctl2: 0x00000008
  mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000ffffff224
  mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP -----------
  mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:  0x60006400 | DLL cfg2: 0x00000000
  mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:  0x00000000 | DDR cfg: 0x00000000
  mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88018a8 Vndr func3: 0x00000000
  mmc1: sdhci: ============================================
  mmc1: sdhci: fffffffff200: DMA 0x0000ffffffffe100, LEN 0x0008, Attr=0x21
  mmc1: sdhci: fffffffff20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x03

Looking closely it's obvious that only the 32-bit part of the address
(0xfffff200) arrives at the SMMU, the higher 16-bit (0xffff...) get
lost somewhere. This might not be a limitation of the SDHCI itself but
perhaps the bus/interconnect it is connected to, or even the connection
to the SMMU.

Work around this by setting SDHCI_QUIRK2_BROKEN_64_BIT_DMA to avoid
using 64-bit addresses.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-msm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2482,6 +2482,9 @@ static inline void sdhci_msm_get_of_prop
 		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
 
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
+
+	if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
 }
 
 static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)


