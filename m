Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6597A701B90
	for <lists+stable@lfdr.de>; Sun, 14 May 2023 06:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjENEmD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 00:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENEmC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 00:42:02 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD0A1FFD
        for <stable@vger.kernel.org>; Sat, 13 May 2023 21:42:00 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34E4flrK090392;
        Sun, 14 May 2023 13:41:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sun, 14 May 2023 13:41:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34E4flQw090389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 May 2023 13:41:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <adafe5d2-7bf2-81a1-d9de-541b417be209@I-love.SAKURA.ne.jp>
Date:   Sun, 14 May 2023 13:41:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 4.14.y] printk: declare printk_deferred_{enter,safe}() in
 include/linux/printk.h
Content-Language: en-US
To:     stable@vger.kernel.org
References: <2023042455-skinless-muzzle-1c50@gregkh>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2023042455-skinless-muzzle-1c50@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 85e3e7fbbb720b9897fba9a99659e31cbd1c082e upstream.

[This patch implements subset of original commit 85e3e7fbbb72 ("printk:
remove NMI tracking") where commit 1007843a9190 ("mm/page_alloc: fix
potential deadlock on zonelist_update_seq seqlock") depends on, for
commit 3d36424b3b58 ("mm/page_alloc: fix race condition between
build_all_zonelists and page allocation") was backported to stable.]

All NMI contexts are handled the same as the safe context: store the
message and defer printing. There is no need to have special NMI
context tracking for this. Using in_nmi() is enough.

There are several parts of the kernel that are manually calling into
the printk NMI context tracking in order to cause general printk
deferred printing:

    arch/arm/kernel/smp.c
    arch/powerpc/kexec/crash.c
    kernel/trace/trace.c

For arm/kernel/smp.c and powerpc/kexec/crash.c, provide a new
function pair printk_deferred_enter/exit that explicitly achieves the
same objective.

For ftrace, remove the printk context manipulation completely. It was
added in commit 03fc7f9c99c1 ("printk/nmi: Prevent deadlock when
accessing the main log buffer in NMI"). The purpose was to enforce
storing messages directly into the ring buffer even in NMI context.
It really should have only modified the behavior in NMI context.
There is no need for a special behavior any longer. All messages are
always stored directly now. The console deferring is handled
transparently in vprintk().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
[pmladek@suse.com: Remove special handling in ftrace.c completely.
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20210715193359.25946-5-john.ogness@linutronix.de
[penguin-kernel: Copy only printk_deferred_{enter,safe}() definition ]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6106befed756..77429d3eb0de 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -528,4 +528,23 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+#ifdef CONFIG_PRINTK
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+/*
+ * The printk_deferred_enter/exit macros are available only as a hack for
+ * some code paths that need to defer all printk console printing. Interrupts
+ * must be disabled for the deferred duration.
+ */
+#define printk_deferred_enter __printk_safe_enter
+#define printk_deferred_exit __printk_safe_exit
+#else
+static inline void printk_deferred_enter(void)
+{
+}
+static inline void printk_deferred_exit(void)
+{
+}
+#endif
+
 #endif
-- 
2.34.1

