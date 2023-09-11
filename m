Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27479B94F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjIKVOB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbjIKP3l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:29:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D3F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:29:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC2EC43395;
        Mon, 11 Sep 2023 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446176;
        bh=8ABMsgVXMHDcQXJPDfm8BrOSo7OCB7e9pcicEahb8g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToqA4yMwdJmlsoasWcJqw8THT7mwG0npOBPUEM11f7UrJy5K0bFzaNaMxryIVwRLc
         Yq2YV+IKyWAA0jFcrn8+3fG6NMTlVoDyCYRVDebFujKsDU5ElPvr0YC2FsObj43DD4
         9SRYty0tr+YlEm4XnVaY164mqWIewnotDOf8F7A0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.1 600/600] clk: Avoid invalid function names in CLK_OF_DECLARE()
Date:   Mon, 11 Sep 2023 15:50:33 +0200
Message-ID: <20230911134651.374782834@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 5cf9d015be160e2d90d29ae74ef1364390e8fce8 upstream.

After commit c28cd1f3433c ("clk: Mark a fwnode as initialized when using
CLK_OF_DECLARE() macro"), drivers/clk/mvebu/kirkwood.c fails to build:

 drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
 CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
 ^
 include/linux/clk-provider.h:1367:21: note: expanded from macro 'CLK_OF_DECLARE'
         static void __init name##_of_clk_init_declare(struct device_node *np) \
                            ^
 <scratch space>:124:1: note: expanded from here
 98dx1135_clk_of_clk_init_declare
 ^
 drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
 include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
         OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                         ^
 <scratch space>:125:3: note: expanded from here
 98dx1135_clk_of_clk_init_declare
   ^
 drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
 include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
         OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                         ^
 <scratch space>:125:3: note: expanded from here
 98dx1135_clk_of_clk_init_declare
   ^
 drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
 include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
         OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                         ^
 <scratch space>:125:3: note: expanded from here
 98dx1135_clk_of_clk_init_declare
   ^

C function names must start with either an alphabetic letter or an
underscore. To avoid generating invalid function names from clock names,
add two underscores to the beginning of the identifier.

Fixes: c28cd1f3433c ("clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro")
Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230308-clk_of_declare-fix-v1-1-317b741e2532@kernel.org
Reviewed-by: Saravana Kannan <saravanak@google.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/clk-provider.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1362,12 +1362,12 @@ struct clk_hw_onecell_data {
 };
 
 #define CLK_OF_DECLARE(name, compat, fn) \
-	static void __init name##_of_clk_init_declare(struct device_node *np) \
+	static void __init __##name##_of_clk_init_declare(struct device_node *np) \
 	{								\
 		fn(np);							\
 		fwnode_dev_initialized(of_fwnode_handle(np), true);	\
 	}								\
-	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
+	OF_DECLARE_1(clk, name, compat, __##name##_of_clk_init_declare)
 
 /*
  * Use this macro when you have a driver that requires two initialization


