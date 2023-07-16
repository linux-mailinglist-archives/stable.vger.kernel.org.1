Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FD7556EA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjGPUzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjGPUzN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E4E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D47CB60EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F7C433C7;
        Sun, 16 Jul 2023 20:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540910;
        bh=TWe8VXO0A+sGd6iBWSK5I63RxBXg5d4oKd2UdxbZ7gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOASyoaP13SLA1n4FWXqhv+u+rDkSokqe+teXQ2qCA9YKGifRAieIFhwqrqxHgyan
         ++hyyRkVPTCXQMLmaCXVfaXBpztsPAleBHUlg9LGBfNpIOVmxmR/7WXTYedD/s190A
         eEqyby8MuAARHKYGl5m0cJt8udKcc6FNb0e8cZ6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chevron Li <chevron.li@bayhubtech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 532/591] mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.
Date:   Sun, 16 Jul 2023 21:51:11 +0200
Message-ID: <20230716194937.633503073@linuxfoundation.org>
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
@@ -1181,6 +1181,8 @@ static void sdhci_prepare_data(struct sd
 		}
 	}
 
+	sdhci_config_dma(host);
+
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
@@ -1200,8 +1202,6 @@ static void sdhci_prepare_data(struct sd
 		}
 	}
 
-	sdhci_config_dma(host);
-
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 


