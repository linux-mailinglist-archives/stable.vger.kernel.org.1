Return-Path: <stable+bounces-132148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF431A848ED
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55A0189F948
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B181EB5D5;
	Thu, 10 Apr 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs6/31Yr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F471E5201
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300429; cv=none; b=KX9UhXsrEXgxHlcVg82S/RIiiXoxaOndmE8V6eUO2Jyze0BJ9CTMdvwomUCLqsau3WpM3Hf3UptojbArQZpxXPXj1C/e0ygEWa+SnUu0fBebvrfOzxXsJnmgU4dLxUK9z+UBGf2uVK9zTh1flujmgASxz/jJpdVji6pkBYLazrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300429; c=relaxed/simple;
	bh=xjLgnUtWXfUdYegbskiPJFztrJhYoVLywjDxG8Ps80I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7GClG1jxJlwh0Nzzqh4P5SstTgSoDJUGb8DA6EnUMg5v3W8UrID85I0cEBmbf+1nIgyGNxXBSvvrXOYfl48o1QUO+AvBwSH//D5N8Vy5CImSD5k0DfIcdNRQ6Yn+e7mGzPPhzyYQR98SVgNxE+9rGw0IHlGYtTKa1adPiQLncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs6/31Yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CA0C4CEDD;
	Thu, 10 Apr 2025 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300429;
	bh=xjLgnUtWXfUdYegbskiPJFztrJhYoVLywjDxG8Ps80I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hs6/31YrU7KkynDKuO0E3FyCV6M+I2+H5zCUD6Zuug9akJX+jeQ9QrZKs/ir3Ak4K
	 BNH7shw0wfo+tD8UJOSBWxOk4j7VwSNB9JsNX8uPut8/u/u+CNkC3x6PMdmkCrAJxv
	 Dvznr07HmZWwgCGKIX4TKwsS+uOBkANYuJEhC6boAh4iEwksAfRxiMdWjEEcYwXR7f
	 zIfXrN+01oHgssubWaU4CoqCkmV9VaoKHT/6uJdBASfHLvRFIktLZFGM7RvBbrrszr
	 JbnQDCaNot85JjgvuK6mTq7dokg7q1m4/NEj/ZjPx5cC4JczszfqCuWFq8u1yF3fpX
	 kl6Th1EJFFSCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	xiangyu.chen@eng.windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] perf: Fix perf_pending_task() UaF
Date: Thu, 10 Apr 2025 11:53:47 -0400
Message-Id: <20250410104653-ae35cbb8469d8d56@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408061044.3786102-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 517e6a301f34613bff24a8e35b5455884f2d83d8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 8bffa95ac19f)

Found fixes commits:
3a5465418f5f perf: Fix event leak upon exec and file release
2fd5ad3f310d perf: Fix event leak upon exit

Note: The patch differs from the upstream commit:
---
1:  517e6a301f346 ! 1:  b2173ec15f3b2 perf: Fix perf_pending_task() UaF
    @@ Metadata
      ## Commit message ##
         perf: Fix perf_pending_task() UaF
     
    +    [ Upstream commit 517e6a301f34613bff24a8e35b5455884f2d83d8 ]
    +
         Per syzbot it is possible for perf_pending_task() to run after the
         event is free()'d. There are two related but distinct cases:
     
    @@ Commit message
         Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Tested-by: Marco Elver <elver@google.com>
    +    [ Discard the changes in event_sched_out() due to 5.10 don't have the
    +    commit: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
    +    and commit: ca6c21327c6a ("perf: Fix missing SIGTRAPs") ]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## kernel/events/core.c ##
    -@@ kernel/events/core.c: event_sched_out(struct perf_event *event,
    - 		    !event->pending_work) {
    - 			event->pending_work = 1;
    - 			dec = false;
    -+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
    - 			task_work_add(current, &event->pending_task, TWA_RESUME);
    - 		}
    - 		if (dec)
     @@ kernel/events/core.c: group_sched_out(struct perf_event *group_event,
    + }
      
      #define DETACH_GROUP	0x01UL
    - #define DETACH_CHILD	0x02UL
     +#define DETACH_DEAD	0x04UL
      
      /*
    @@ kernel/events/core.c: __perf_remove_from_context(struct perf_event *event,
      	event_sched_out(event, cpuctx, ctx);
      	if (flags & DETACH_GROUP)
      		perf_group_detach(event);
    - 	if (flags & DETACH_CHILD)
    - 		perf_child_detach(event);
      	list_del_event(event, ctx);
     +	if (flags & DETACH_DEAD)
     +		event->state = PERF_EVENT_STATE_DEAD;
    @@ kernel/events/core.c: int perf_event_release_kernel(struct perf_event *event)
      
      	perf_event_ctx_unlock(event, ctx);
      
    -@@ kernel/events/core.c: static void perf_pending_task(struct callback_head *head)
    +@@ kernel/events/core.c: static void perf_pending_event(struct irq_work *entry)
    + 
      	if (rctx >= 0)
      		perf_swevent_put_recursion_context(rctx);
    - 	preempt_enable_notrace();
     +
     +	put_event(event);
      }
      
    - #ifdef CONFIG_GUEST_PERF_EVENTS
    + /*
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.10.y:
    kernel/trace/trace_events_synth.c: In function 'synth_event_reg':
    kernel/trace/trace_events_synth.c:769:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      769 |         int ret = trace_event_reg(call, type, data);
          |         ^~~
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
    drivers/firmware/efi/mokvar-table.c:107:23: warning: unused variable 'size' [-Wunused-variable]
      107 |         unsigned long size;
          |                       ^~~~
    .tmp_vmlinux.kallsyms2.S:196892:57: internal compiler error: Segmentation fault
    196892 |         .byte 0x0b, 0x74, 0x77, 0x77, 0x5f, 0xb6, 0x73, 0xfc, 0x6e, 0xbd, 0x6d, 0xed
           |                                                         ^~~~
    0x7f74e8f6cd1f ???
    	./signal/../sysdeps/unix/sysv/linux/x86_64/libc_sigaction.c:0
    0x7f74e8f56d67 __libc_start_call_main
    	../sysdeps/nptl/libc_start_call_main.h:58
    0x7f74e8f56e24 __libc_start_main_impl
    	../csu/libc-start.c:360
    Please submit a full bug report, with preprocessed source (by using -freport-bug).
    Please include the complete backtrace with any bug report.
    See <https://gcc.gnu.org/bugs/> for instructions.
    make: *** [Makefile:1212: vmlinux] Error 1
    make: Target '__all' not remade because of errors.

