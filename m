Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB287A7C2A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjITL6p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjITL6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:58:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C84C2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:58:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97D0C433C7;
        Wed, 20 Sep 2023 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211117;
        bh=Qbo0SpsZ1YRJOVxlmWaNXA0w55bo2/vqC67b4ahusZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJbwW0ChaQSPq1hXkwAXvZTWxashWLDYn1I7RmiklJ0M4ZYbdPH+xKO8NjKsSXO5l
         dlB+XNQCy2Ldy5nxvx0wQyhlOKn98YAqHOaQXJJWvGnNvsq1IRQ5nCR6HgxTQGdXDf
         9YneWyDZYdgPFzCt57P+uPGr0atIEGDkotMRygXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 107/139] samples/hw_breakpoint: fix building without module unloading
Date:   Wed, 20 Sep 2023 13:30:41 +0200
Message-ID: <20230920112839.548442247@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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



