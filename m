Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE29075D4E6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGUT0J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGUT0I (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFD30E3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D427261D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6480C433CD;
        Fri, 21 Jul 2023 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967563;
        bh=ZOQXdNmGbuVkk2O3AMLUfEnO8BJM69fpGFBy8Y77HSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEVIMsBoZTFcFsN3xFvH/wCyHQMVGXhm/mOv9a6nu7k7oAydg3qTCDkPUzvgls6Wj
         1lxJLoVCT7V9uQxHMVXBnt7fG1D7bVofeC/rg/5H25P+hYTy5qQRXZ6dn4pK3s8auv
         dylqgFf8sBGxD0Hj+NWzOIcl1XM/NWR0CV39ePo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 177/223] tracing: Fix memory leak of iter->temp when reading trace_pipe
Date:   Fri, 21 Jul 2023 18:07:10 +0200
Message-ID: <20230721160528.424507955@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

commit d5a821896360cc8b93a15bd888fabc858c038dc0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6679,6 +6679,7 @@ static int tracing_release_pipe(struct i
 
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
+	kfree(iter->temp);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 


