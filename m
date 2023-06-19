Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DC7352B2
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjFSKhZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFSKhM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53463CD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD76560B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A7C433C8;
        Mon, 19 Jun 2023 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171030;
        bh=v3zHjLvEo+AfNXUvrJl3Ua8pNEyiCqt6CoCyLaVrUdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9WK0OvqC4QRIqI8w0inJmn5r17WTNWA9E3q2zagbHt7mDf3YeD6VpllQcXkIjYer
         coXKxwjAW3lSlVx3T1TzPRLdPUXQIHTIFhTWpkr+0xqO0xkJEHq3XWYeU5QSNErZhP
         jwTYtnhALxDvz2MsFIEewnBns4qo6mxSssvXL5Ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.3 096/187] clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr
Date:   Mon, 19 Jun 2023 12:28:34 +0200
Message-ID: <20230619102202.236201473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 23200a4c8ac284f8b4263d7cecaefecaa3ad6732 upstream.

sparse points out an embarrasing bug in an older patch of mine,
which uses the register offset instead of an __iomem pointer:

drivers/clk/pxa/clk-pxa3xx.c:167:9: sparse: sparse: Using plain integer as NULL pointer

Unlike sparse, gcc and clang ignore this bug and fail to warn
because a literal '0' is considered a valid representation of
a NULL pointer.

Fixes: 3c816d950a49 ("ARM: pxa: move clk register definitions to driver")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305111301.RAHohdob-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230511105845.299859-1-arnd@kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/pxa/clk-pxa3xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -164,7 +164,7 @@ void pxa3xx_clk_update_accr(u32 disable,
 	accr &= ~disable;
 	accr |= enable;
 
-	writel(accr, ACCR);
+	writel(accr, clk_regs + ACCR);
 	if (xclkcfg)
 		__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
 


