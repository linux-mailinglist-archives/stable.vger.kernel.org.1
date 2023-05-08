Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA836FAC16
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjEHLUl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjEHLUk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A737C6E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F8D62C7D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4EEC433D2;
        Mon,  8 May 2023 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544838;
        bh=hqR9NBU7VaQmbbTWi1w16gir0uIP3YlovBnJBhRyTQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUK72uJOlvMBGs2PCO1Udj/B/mDF+HCEv2lfFXG59I5d2bBQG935cs8AB290OZnsA
         Rch/z3ixdJZHivAel++htBorqRoZAQqKm7JhQKAjt+WY//MBuAtq4GSXvAPiYgorwX
         03SRfURQOpl1o+jBRBPZMD55YLpyE92vQAxsC9n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 512/694] spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and resume
Date:   Mon,  8 May 2023 11:45:47 +0200
Message-Id: <20230508094450.799450012@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>

[ Upstream commit 4266d21669de62cf3fb6774f7d404c1eb95a5ab3 ]

pci1xxxx_spi_resume API masks SPI interrupt bit which prohibits interrupt
from coming to the host at the end of the transaction after suspend-resume.
This patch unmasks this bit at resume.

Fixes: 1cc0cbea7167 ("spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch")
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Link: https://lore.kernel.org/r/20230404171613.1336093-3-tharunkumar.pasumarthi@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 0805c441b4065..13efbfeff92ce 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -58,7 +58,7 @@
 #define VENDOR_ID_MCHP 0x1055
 
 #define SPI_SUSPEND_CONFIG 0x101
-#define SPI_RESUME_CONFIG 0x303
+#define SPI_RESUME_CONFIG 0x203
 
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
-- 
2.39.2



