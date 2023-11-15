Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7346C7ED51B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbjKOVAE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbjKOU7H (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:59:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBE1BCC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:58:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E8C433D9;
        Wed, 15 Nov 2023 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081904;
        bh=0Dl1DfgtwuwZf43z1lOWHI0H3nXDo9oOVefmZMunrN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sml9aRPxiDyhJWANy5uxQG73zABqsZHvEunBReLdL4VG2fVtaWqoX6DzA+42ouT5D
         ev8L55BhheKprkhPUqJQOwiNUYhpgUuiok5rkv8RSuj9lKQw+jyLuMwtQ+MOoATnXZ
         gO4QIN/n8KDxWjPVjZWT0LkctefdGbXLlcf7idzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 185/191] spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies
Date:   Wed, 15 Nov 2023 15:47:40 -0500
Message-ID: <20231115204655.540751326@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

[ Upstream commit c2ded280a4b1b7bd93e53670528504be08d24967 ]

Zynq QSPI driver has been converted to use spi-mem framework so
add spi-mem to driver kconfig dependencies.

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://lore.kernel.org/r/1699037031-702858-1-git-send-email-radhey.shyam.pandey@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4d98ce7571df0..5fd9b515f6f14 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -949,6 +949,7 @@ config SPI_XTENSA_XTFPGA
 config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on SPI_MEM
 	help
 	  This enables support for the Zynq Quad SPI controller
 	  in master mode.
-- 
2.42.0



