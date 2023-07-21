Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E678E75C9BF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGUOWg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjGUOWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3F2D4E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9835D61CD4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C8EC433CB;
        Fri, 21 Jul 2023 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689949351;
        bh=IHsDXd3+aFBWhPa7nzRrLVIM/HVdoLZSFcL3bnnh/Fk=;
        h=Subject:To:Cc:From:Date:From;
        b=dnKcA+8vizcfNoV05Y9XjgfMrOoqjiW33qEVob80/g/oqGdtiooX7G5JA3SNPhogo
         2jzv/7kX9PGcHixFinDvYhO4hgwveHDuTWAgRvcKpmxYzKAmnkweMbjNN+AvGUpyj0
         ZHDt5fIrslIsZKND6z8cMiJ8NPFUtNnSj+aCJIto=
Subject: FAILED: patch "[PATCH] tracing: Fix memory leak of iter->temp when reading" failed to apply to 5.10-stable tree
To:     zhengyejian1@huawei.com, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:22:28 +0200
Message-ID: <2023072128-pavilion-employer-0a22@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d5a821896360cc8b93a15bd888fabc858c038dc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072128-pavilion-employer-0a22@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

d5a821896360 ("tracing: Fix memory leak of iter->temp when reading trace_pipe")
649e72070cbb ("tracing: Fix memory leak in tracing_read_pipe()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5a821896360cc8b93a15bd888fabc858c038dc0 Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian1@huawei.com>
Date: Thu, 13 Jul 2023 22:14:35 +0800
Subject: [PATCH] tracing: Fix memory leak of iter->temp when reading
 trace_pipe

kmemleak reports:
  unreferenced object 0xffff88814d14e200 (size 256):
    comm "cat", pid 336, jiffies 4294871818 (age 779.490s)
    hex dump (first 32 bytes):
      04 00 01 03 00 00 00 00 08 00 00 00 00 00 00 00  ................
      0c d8 c8 9b ff ff ff ff 04 5a ca 9b ff ff ff ff  .........Z......
    backtrace:
      [<ffffffff9bdff18f>] __kmalloc+0x4f/0x140
      [<ffffffff9bc9238b>] trace_find_next_entry+0xbb/0x1d0
      [<ffffffff9bc9caef>] trace_print_lat_context+0xaf/0x4e0
      [<ffffffff9bc94490>] print_trace_line+0x3e0/0x950
      [<ffffffff9bc95499>] tracing_read_pipe+0x2d9/0x5a0
      [<ffffffff9bf03a43>] vfs_read+0x143/0x520
      [<ffffffff9bf04c2d>] ksys_read+0xbd/0x160
      [<ffffffff9d0f0edf>] do_syscall_64+0x3f/0x90
      [<ffffffff9d2000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8

when reading file 'trace_pipe', 'iter->temp' is allocated or relocated
in trace_find_next_entry() but not freed before 'trace_pipe' is closed.

To fix it, free 'iter->temp' in tracing_release_pipe().

Link: https://lore.kernel.org/linux-trace-kernel/20230713141435.1133021-1-zhengyejian1@huawei.com

Cc: stable@vger.kernel.org
Fixes: ff895103a84ab ("tracing: Save off entry when peeking at next entry")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20122eeccf97..be847d45d81c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6781,6 +6781,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
+	kfree(iter->temp);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 

