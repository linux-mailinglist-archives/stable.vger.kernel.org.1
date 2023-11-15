Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB57ED37C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjKOUw7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjKOUw6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:52:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ADFB7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:52:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ECCC4E77A;
        Wed, 15 Nov 2023 20:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081575;
        bh=t67KCA7ZndBlesX5yvRZp1FFPBi9quQBkMYt07a03nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdSGlpUNlZE/SFcT6xV3qXvIEUWOtutnnK8EeGEnbeqT6LkVpXL0LVMFU86cX1jyO
         cFhVVGC46/KMHmcmf1lUy5rd5bEyQMmcwZD/JC+aSoUiRtJRdP3mnXpCAKAgiXpvPC
         gFPj1F/mYvxuu49mBbFrxzP9cvLS9QSl/aRBx9Js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 238/244] spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies
Date:   Wed, 15 Nov 2023 15:37:10 -0500
Message-ID: <20231115203602.609884028@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 4fc23236d3bd2..123689e457d12 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -976,6 +976,7 @@ config SPI_XTENSA_XTFPGA
 config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on SPI_MEM
 	help
 	  This enables support for the Zynq Quad SPI controller
 	  in master mode.
-- 
2.42.0



