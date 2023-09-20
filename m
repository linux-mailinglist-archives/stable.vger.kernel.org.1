Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A637A7F0F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjITMXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjITMXc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:23:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9593
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:23:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433D8C433C7;
        Wed, 20 Sep 2023 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212605;
        bh=0z1n0mMOsZN5kyMY5KqQL+zrv1BQL3cty13cUXweBA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsN63IUPNqPL3is66q3huvcUNVST02kZZYs3Efg9k4V95LAjulbYgm36/foI6gUi8
         lYE9Dkf55JveKMYyskQs7DH1m2Z9nkYrVJvT7ns9h1f93MsuU9C8mpdBvFcZzbboAB
         7a7XXYDTbci8Zf4dSFna/rQI4cS9YMbFN2Wtf6T4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 64/83] samples/hw_breakpoint: fix building without module unloading
Date:   Wed, 20 Sep 2023 13:31:54 +0200
Message-ID: <20230920112829.192836671@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b9080468caeddc58a91edd1c3a7d212ea82b0d1d ]

__symbol_put() is really meant as an internal helper and is not available
when module unloading is disabled, unlike the previously used symbol_put():

samples/hw_breakpoint/data_breakpoint.c: In function 'hw_break_module_exit':
samples/hw_breakpoint/data_breakpoint.c:73:9: error: implicit declaration of function '__symbol_put'; did you mean '__symbol_get'? [-Werror=implicit-function-declaration]

The hw_break_module_exit() function is not actually used when module
unloading is disabled, but it still causes the build failure for an
undefined identifier. Enclose this one call in an appropriate #ifdef to
clarify what the requirement is. Leaving out the entire exit function
would also work but feels less clar in this case.

Fixes: 910e230d5f1bb ("samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'")
Fixes: d8a84d33a4954 ("samples/hw_breakpoint: drop use of kallsyms_lookup_name()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 9debd128b2ab8..b99322f188e59 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -70,7 +70,9 @@ static int __init hw_break_module_init(void)
 static void __exit hw_break_module_exit(void)
 {
 	unregister_wide_hw_breakpoint(sample_hbp);
+#ifdef CONFIG_MODULE_UNLOAD
 	__symbol_put(ksym_name);
+#endif
 	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
 }
 
-- 
2.40.1



