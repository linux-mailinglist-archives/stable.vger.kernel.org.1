Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF37A7AE6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjITLrN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjITLrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:47:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990BDCE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:47:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ADBC433C8;
        Wed, 20 Sep 2023 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210426;
        bh=Y1hugOxe+URL1bQJ2KgkrS29YN+0WTpMus2hTbyB2bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA+B+Bd9xcRE4fsyUIxpZIGW2F8XKLREFF5FNBa3pKpTOPrh2ZMZNDTF5oMIOZ52q
         89c81ukQr5DOUgqq2Fqpkeg6Vwsz5l3ka5CrZRD9wJXos34rboAgtWEch0d+kEOuew
         j+doVd+uzJj49cAWXo9OqqMJPsOA4TF/J+XQTyG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rong Tao <rongtao@cestc.cn>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 073/211] samples/hw_breakpoint: Fix kernel BUG invalid opcode: 0000
Date:   Wed, 20 Sep 2023 13:28:37 +0200
Message-ID: <20230920112848.061030710@linuxfoundation.org>
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

From: Rong Tao <rongtao@cestc.cn>

[ Upstream commit 910e230d5f1bb72c54532e94fbb1705095c7bab6 ]

Macro symbol_put() is defined as __symbol_put(__stringify(x))

    ksym_name = "jiffies"
    symbol_put(ksym_name)

will be resolved as

    __symbol_put("ksym_name")

which is clearly wrong. So symbol_put must be replaced with __symbol_put.

When we uninstall hw_breakpoint.ko (rmmod), a kernel bug occurs with the
following error:

[11381.854152] kernel BUG at kernel/module/main.c:779!
[11381.854159] invalid opcode: 0000 [#2] PREEMPT SMP PTI
[11381.854163] CPU: 8 PID: 59623 Comm: rmmod Tainted: G      D    OE      6.2.9-200.fc37.x86_64 #1
[11381.854167] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B360M-HDV, BIOS P3.20 10/23/2018
[11381.854169] RIP: 0010:__symbol_put+0xa2/0xb0
[11381.854175] Code: 00 e8 92 d2 f7 ff 65 8b 05 c3 2f e6 78 85 c0 74 1b 48 8b 44 24 30 65 48 2b 04 25 28 00 00 00 75 12 48 83 c4 38 c3 cc cc cc cc <0f> 0b 0f 1f 44 00 00 eb de e8 c0 df d8 00 90 90 90 90 90 90 90 90
[11381.854178] RSP: 0018:ffffad8ec6ae7dd0 EFLAGS: 00010246
[11381.854181] RAX: 0000000000000000 RBX: ffffffffc1fd1240 RCX: 000000000000000c
[11381.854184] RDX: 000000000000006b RSI: ffffffffc02bf7c7 RDI: ffffffffc1fd001c
[11381.854186] RBP: 000055a38b76e7c8 R08: ffffffff871ccfe0 R09: 0000000000000000
[11381.854188] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[11381.854190] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[11381.854192] FS:  00007fbf7c62c740(0000) GS:ffff8c5badc00000(0000) knlGS:0000000000000000
[11381.854195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11381.854197] CR2: 000055a38b7793f8 CR3: 0000000363e1e001 CR4: 00000000003726e0
[11381.854200] DR0: ffffffffb3407980 DR1: 0000000000000000 DR2: 0000000000000000
[11381.854202] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[11381.854204] Call Trace:
[11381.854207]  <TASK>
[11381.854212]  s_module_exit+0xc/0xff0 [symbol_getput]
[11381.854219]  __do_sys_delete_module.constprop.0+0x198/0x2f0
[11381.854225]  do_syscall_64+0x58/0x80
[11381.854231]  ? exit_to_user_mode_prepare+0x180/0x1f0
[11381.854237]  ? syscall_exit_to_user_mode+0x17/0x40
[11381.854241]  ? do_syscall_64+0x67/0x80
[11381.854245]  ? syscall_exit_to_user_mode+0x17/0x40
[11381.854248]  ? do_syscall_64+0x67/0x80
[11381.854252]  ? exc_page_fault+0x70/0x170
[11381.854256]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Rong Tao <rongtao@cestc.cn>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc3..9debd128b2ab8 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -70,7 +70,7 @@ static int __init hw_break_module_init(void)
 static void __exit hw_break_module_exit(void)
 {
 	unregister_wide_hw_breakpoint(sample_hbp);
-	symbol_put(ksym_name);
+	__symbol_put(ksym_name);
 	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
 }
 
-- 
2.40.1



