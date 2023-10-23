Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB47D33AF
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjJWLdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjJWLdG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E6BCC
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:33:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C13C433C9;
        Mon, 23 Oct 2023 11:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060780;
        bh=D8IReDcTvq3DY+4rBt2H76m+yIEgsApWLvqcxZ9Fdp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETtku3LLLL3VicNpThEK7/bd1CpdeNGFwgrbicVRdeQkkr5Q36+VOSMlo2TQVgitt
         iwy24lBRoTErIXizvV5EBHZ+FLPxj3Rm2aKUQOUqXDtGgn6K/IWUVeQygO7FSNJIsA
         zC07/WhCc2jA29yjNXjERuWezFilPSLS0xL6rBO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 090/123] tracing: relax trace_event_eval_update() execution with cond_resched()
Date:   Mon, 23 Oct 2023 12:57:28 +0200
Message-ID: <20231023104820.711454350@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 23cce5f25491968b23fb9c399bbfb25f13870cd9 ]

When kernel is compiled without preemption, the eval_map_work_func()
(which calls trace_event_eval_update()) will not be preempted up to its
complete execution. This can actually cause a problem since if another
CPU call stop_machine(), the call will have to wait for the
eval_map_work_func() function to finish executing in the workqueue
before being able to be scheduled. This problem was observe on a SMP
system at boot time, when the CPU calling the initcalls executed
clocksource_done_booting() which in the end calls stop_machine(). We
observed a 1 second delay because one CPU was executing
eval_map_work_func() and was not preempted by the stop_machine() task.

Adding a call to cond_resched() in trace_event_eval_update() allows
other tasks to be executed and thus continue working asynchronously
like before without blocking any pending task at boot time.

Link: https://lore.kernel.org/linux-trace-kernel/20230929191637.416931-1-cleger@rivosinc.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 51adf0817ef3a..4f42dd0880796 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2236,6 +2236,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_printk(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1



