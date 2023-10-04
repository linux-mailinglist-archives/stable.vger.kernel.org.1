Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADD7B8A10
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbjJDSbz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbjJDSby (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:31:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B7C6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ED0C433C8;
        Wed,  4 Oct 2023 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444309;
        bh=s/jse598CLQt/PmNG9JXMDDRWQtanooR5fXBjQBNTo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ys8FfJr0rGYdVrbB7QtFhJJmd0g8v4JMqf3CIPE3A/HN/ZUAf+ekTpmgUmReYW9A/
         nJ+jyPJNc3JVnjqYkpsJ6vGkT3s3wNedTFFtpUho0yGDiHAqdq0eGLAArkvhdiXYJ2
         1cElz0oyVQGmZZN4FGAvKn5Ira4vRTz7ghXDeWWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Han Xu <han.xu@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 204/321] spi: nxp-fspi: reset the FLSHxCR1 registers
Date:   Wed,  4 Oct 2023 19:55:49 +0200
Message-ID: <20231004175238.695457187@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Han Xu <han.xu@nxp.com>

[ Upstream commit 18495676f7886e105133f1dc06c1d5e8d5436f32 ]

Reset the FLSHxCR1 registers to default value. ROM may set the register
value and it affects the SPI NAND normal functions.

Signed-off-by: Han Xu <han.xu@nxp.com>
Link: https://lore.kernel.org/r/20230906183254.235847-1-han.xu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 5440176557875..8e44de084bbe3 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1085,6 +1085,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
 		 base + FSPI_AHBCR);
 
+	/* Reset the FLSHxCR1 registers. */
+	reg = FSPI_FLSHXCR1_TCSH(0x3) | FSPI_FLSHXCR1_TCSS(0x3);
+	fspi_writel(f, reg, base + FSPI_FLSHA1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHA2CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
+
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
-- 
2.40.1



