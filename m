Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B71703379
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbjEOQh1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbjEOQh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12953C13
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E9C162823
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F99C433D2;
        Mon, 15 May 2023 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168644;
        bh=j5e+lCVoCmVxZTlp7q4ccaZq+tw4YDcvEPll5BsSS4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFa6FZmq1bxI+YCqxcJ5jK28nzwjmS9EURKFaUHsTNBVoVD81HD37YlGrq/FUvmcG
         eKfNtpXyJXYSQrlvnA7kscR+jv+dfZ9QFBU5x3hH1PGRt3lgnGKDinJ88Vs+6mz1ku
         899S9/wWlLXnss41Fw0UB8qctYGnnGMTXIBju90Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 4.14 115/116] printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h
Date:   Mon, 15 May 2023 18:26:52 +0200
Message-Id: <20230515161702.048591213@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/printk.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -528,4 +528,23 @@ static inline void print_hex_dump_debug(
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


