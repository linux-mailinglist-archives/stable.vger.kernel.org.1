Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CFB761513
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbjGYLZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjGYLZX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E0187
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2305C6167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308FAC433C8;
        Tue, 25 Jul 2023 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284321;
        bh=z2i4tqGdIBZVJUZBD/ygEiYHnQ2ow9EvNjNGLvwFwhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbzW8LhrOn/W4Juyp8o6RDaNkVZVN72JdHIfeHM1k6QQ4LJRCyMz0QzIZrQaq2Wcr
         B4VUxESZ+BD3r/f7f3Ri/8wltkvUt67IocHvD27goyhYNXKPPOTv0aYvANwRnpMaR0
         6CD6u6ro5o7mpCmheHi1R4tBk+rFdgHNGaFcXbM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chevron Li <chevron.li@bayhubtech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 286/509] mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.
Date:   Tue, 25 Jul 2023 12:43:45 +0200
Message-ID: <20230725104606.826331838@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Chevron Li <chevron.li@bayhubtech.com>

commit 20dbd07ef0a8bc29eb03d6a95258ac8934cbe52d upstream.

Bayhub SD host has hardware limitation:
1.The upper 32bit address is inhibited to be written at SD Host Register
  [03E][13]=0 (32bits addressing) mode, is admitted to be written only at
  SD Host Register [03E][13]=1 (64bits addressing) mode.
2.Because of above item#1, need to configure SD Host Register [03E][13] to
  1(64bits addressing mode) before set 64bit ADMA system address's higher
  32bits SD Host Register [05F~05C] if 64 bits addressing mode is used.

The hardware limitation is reasonable for below reasons:
1.Normal flow should set DMA working mode first, then do
  DMA-transfer-related configuration, such as system address.
2.The hardware limitation may avoid the software to configure wrong higher
  32bit address at 32bits addressing mode although it is redundant.

The change that set 32bits/64bits addressing mode before set ADMA address,
  has no side-effect to other host IPs for below reason:
The setting order is reasonable and standard: DMA Mode setting first and
  then DMA address setting. It meets all DMA setting sequence.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230523111114.18124-1-chevron_li@126.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1145,6 +1145,8 @@ static void sdhci_prepare_data(struct sd
 		}
 	}
 
+	sdhci_config_dma(host);
+
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
@@ -1164,8 +1166,6 @@ static void sdhci_prepare_data(struct sd
 		}
 	}
 
-	sdhci_config_dma(host);
-
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 


