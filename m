Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1387A7F4B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjITM0F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjITM0A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:26:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E140AD;
        Wed, 20 Sep 2023 05:25:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CBFC433CA;
        Wed, 20 Sep 2023 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212753;
        bh=xampwJrDgUPBW5IdS2FwQ8YpTDThr/O5fTHxxk/9SQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIdGd1DnH54xKROi5LpmOTymNYzBy98iPhv7sycAMgmOeExK7L0TAJ6imi6HrZ76T
         pUuwZ+mk4h5bvWBLp97yYzGoFWBLjNzcn1L/YF0JSPDP2hEChyjG7nwZhra7GYQiNu
         vd8kregAEI4485j3Efz1wttPcbrH7VAyysrVt6qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Baoquan He <bhe@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 032/367] clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
Date:   Wed, 20 Sep 2023 13:26:49 +0200
Message-ID: <20230920112859.343978008@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baoquan He <bhe@redhat.com>

[ Upstream commit e7dd44f4f3166db45248414f5df8f615392de47a ]

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM so that it won't
be built to cause below compiling error if PCI is unset:

------
ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
clk-fixed-mmio.c:(.text+0x5e): undefined reference to `of_iomap'
ld: clk-fixed-mmio.c:(.text+0xba): undefined reference to `iounmap'
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Link: https://lore.kernel.org/r/20230707135852.24292-8-bhe@redhat.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index cc871ae3a1792..5b34dbc830ee4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -302,6 +302,7 @@ config COMMON_CLK_BD718XX
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
-- 
2.40.1



