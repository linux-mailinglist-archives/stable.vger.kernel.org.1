Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15D761594
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjGYLak (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjGYLaj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF511B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBA66168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC69C433C8;
        Tue, 25 Jul 2023 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284637;
        bh=d3tRm0jycDi/q0kW0hpLMYm4sV61GxnPDeQna2/nS0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ApLdtdX+2H904VDdAeOa06mI+DeBNTu6tuMXTkFGtMBJyH9tMOEnGU7SE6oXijhkc
         BlZx1ayI1c7vsK33zigcQDdspjZDE3nBmqzrhtiSsxaJKp5fyjduwG9J1wSqN2xu9U
         qfSXqN112AxzvodRWrA8LeK4yBroQEd1mRFMRUSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mateusz Stachyra <m.stachyra@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 5.10 427/509] tracing: Fix null pointer dereference in tracing_err_log_open()
Date:   Tue, 25 Jul 2023 12:46:06 +0200
Message-ID: <20230725104613.250724115@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mateusz Stachyra <m.stachyra@samsung.com>

commit 02b0095e2fbbc060560c1065f86a211d91e27b26 upstream.

Fix an issue in function 'tracing_err_log_open'.
The function doesn't call 'seq_open' if the file is opened only with
write permissions, which results in 'file->private_data' being left as null.
If we then use 'lseek' on that opened file, 'seq_lseek' dereferences
'file->private_data' in 'mutex_lock(&m->lock)', resulting in a kernel panic.
Writing to this node requires root privileges, therefore this bug
has very little security impact.

Tracefs node: /sys/kernel/tracing/error_log

Example Kernel panic:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
Call trace:
 mutex_lock+0x30/0x110
 seq_lseek+0x34/0xb8
 __arm64_sys_lseek+0x6c/0xb8
 invoke_syscall+0x58/0x13c
 el0_svc_common+0xc4/0x10c
 do_el0_svc+0x24/0x98
 el0_svc+0x24/0x88
 el0t_64_sync_handler+0x84/0xe4
 el0t_64_sync+0x1b4/0x1b8
Code: d503201f aa0803e0 aa1f03e1 aa0103e9 (c8e97d02)
---[ end trace 561d1b49c12cf8a5 ]---
Kernel panic - not syncing: Oops: Fatal exception

Link: https://lore.kernel.org/linux-trace-kernel/20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4
Link: https://lore.kernel.org/linux-trace-kernel/20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f@eucms1p3

Cc: stable@vger.kernel.org
Fixes: 8a062902be725 ("tracing: Add tracing error log")
Signed-off-by: Mateusz Stachyra <m.stachyra@samsung.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7529,7 +7529,7 @@ static const struct file_operations trac
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
 


