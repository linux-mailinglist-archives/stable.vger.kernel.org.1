Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC57A7B18
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjITLt1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjITLtZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:49:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4BFB0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:49:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCCFC433CA;
        Wed, 20 Sep 2023 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210559;
        bh=FJreXha/AJEvOvmVZMdSGuKiNDIUOvm5Kswv+bgab14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBCsH7SwPY/tQmeLSN4VFvnGf74+c/cR/KwJxZ2pzPkzNXcHkCTm9/miMo/JMPIEL
         SCQO6gXLAkWZg4DixDrUk5Jp+rHZecnoHyuluAgccTtdesCeUJIMwuIbypCfqe8S5/
         jTqm+K7w8K/SCKcPJN3jGYfCo3FKCRETzBgL91xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ladislav Michl <ladis@linux-mips.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 121/211] usb: dwc3: dwc3-octeon: Verify clock divider
Date:   Wed, 20 Sep 2023 13:29:25 +0200
Message-ID: <20230920112849.546943004@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ladislav Michl <ladis@linux-mips.org>

[ Upstream commit fb57f829beefd4b3746f1b23d51e80ed5d4bb87b ]

Although valid USB clock divider will be calculated for all valid
Octeon core frequencies, make code formally correct limiting
divider not to be greater that 7 so it fits into H_CLKDIV_SEL
field.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230808/testrun/18882876/suite/build/test/gcc-8-cavium_octeon_defconfig/log
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/ZNIM7tlBNdHFzXZG@lenoch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/cavium-octeon/octeon-usb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 2add435ad0387..165e032d08647 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -243,11 +243,11 @@ static int dwc3_octeon_get_divider(void)
 	while (div < ARRAY_SIZE(clk_div)) {
 		uint64_t rate = octeon_get_io_clock_rate() / clk_div[div];
 		if (rate <= 300000000 && rate >= 150000000)
-			break;
+			return div;
 		div++;
 	}
 
-	return div;
+	return -EINVAL;
 }
 
 static int dwc3_octeon_config_power(struct device *dev, void __iomem *base)
@@ -374,6 +374,10 @@ static int dwc3_octeon_clocks_start(struct device *dev, void __iomem *base)
 
 	/* Step 4b: Select controller clock frequency. */
 	div = dwc3_octeon_get_divider();
+	if (div < 0) {
+		dev_err(dev, "clock divider invalid\n");
+		return div;
+	}
 	val = dwc3_octeon_readq(uctl_ctl_reg);
 	val &= ~USBDRD_UCTL_CTL_H_CLKDIV_SEL;
 	val |= FIELD_PREP(USBDRD_UCTL_CTL_H_CLKDIV_SEL, div);
-- 
2.40.1



