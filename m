Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158FA75D527
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGUTlV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUTlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:41:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B51BDC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:41:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ed230c81so2048754b3a.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1689968478; x=1690573278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/QEaPMyL9cy7Wwnv7JhB0qnxL1xTT1cBgOx8JH26JA=;
        b=NPBSCJcv0p/INROUR3jJC06XGaDe+w9jKq8+lLHoWB4wD6CcG32BEjUnLCcM15tOSW
         OfBdW0GJDhPAyeY6kdIozB36XinAj0ZwN2ot9bAj1wFiq5Ma4OAm/ciVfCH6J5Cte21I
         o0iFRRLVN59YK+Kag0QN9McwTq4oiSbdFhBdOUORYYiEDh3W/pTow327hKSC7wdfKD8A
         BH7t3GSY+aLmmonkZbcAT3MAZ3c3pVFvM3fh3eOqC0Kx2vkI5ev7RLkNt95w0aFIJLX8
         WT3Y1wYcRtrKYjqEpLjgaOwQSNs1CPkDTzT7BIZSlkuBMuNkcEqfSMyxm8HeUyZRfmGf
         fBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968478; x=1690573278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/QEaPMyL9cy7Wwnv7JhB0qnxL1xTT1cBgOx8JH26JA=;
        b=AKSETPMjrOjmTDwBXqOaW1jPJffLH8/uehmstkz3fQfWR1NT7zdwmF90csCfM/IaOO
         T7ojw6H4/OQgVZQRlvFR63Wg/FM9wLeqyJHQUiOR1Y5MLDNBwm6Q1IifGcqpxkCrGKCz
         OtlXKBdd2ZGWtY0+nzulBgewybFMnpXusMrO/iY4EenUapf0gcOjTDW/xeEqjkji9j3x
         howmxsYW1BrMH1SyqAHlodG0Yis+LjUEn3ui9uO3kiNDjpR6ta52fqcEFJ+ISLWIT91I
         oxvJ9VBKQD2guflZC2PHoY8v4VzPrm6mqcgtNvrW2Us+S1dnaB2mq6crOEGU+X8jDoej
         pUgw==
X-Gm-Message-State: ABy/qLbRvqSNcHStvIrM3iUHZm3anhXyd3XE/XkYS656PpGR4xJWqoGh
        SkoZTcyVyGBWrwJu8HeadGy7jWkN+SLQQOg8fxU=
X-Google-Smtp-Source: APBJJlHtSGPASSocJ1ai1nEL2g5UE1YWrr4d2Yj6pRMnF7uCniRrhUfZ8EZoGrfDYqbqF/Rgh8lZdQ==
X-Received: by 2002:a05:6a21:3984:b0:137:74f8:62ee with SMTP id ad4-20020a056a21398400b0013774f862eemr2938407pzc.18.1689968477530;
        Fri, 21 Jul 2023 12:41:17 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a639812000000b00563709c8647sm3480121pgd.7.2023.07.21.12.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:41:17 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:41:15 -0700
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     gregkh@linuxfoundation.org
Cc:     rostedt@goodmis.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing/histograms: Add histograms to
 hist_vars if they have" failed to apply to 4.19-stable tree
Message-ID: <20230721194115.GB3521501@medusa>
References: <2023072114-radiantly-gilled-72c0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072114-radiantly-gilled-72c0@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-07-21 16:22:14 +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 

I think the patch does not apply cleanly because of 7d18a10c3167 ("tracing:
Refactor hist trigger action code"). Will post backport shortly.

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 6018b585e8c6fa7d85d4b38d9ce49a5b67be7078
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072114-radiantly-gilled-72c0@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> 
> Possible dependencies:
> 
> 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if they have referenced variables")
> 7d18a10c3167 ("tracing: Refactor hist trigger action code")
> 036876fa5620 ("tracing: Have the historgram use the result of str_has_prefix() for len of prefix")
> 754481e6954c ("tracing: Use str_has_prefix() helper for histogram code")
> de40f033d4e8 ("tracing: Remove open-coding of hist trigger var_ref management")
> 2f31ed9308cc ("tracing: Change strlen to sizeof for hist trigger static strings")
> 0e2b81f7b52a ("tracing: Remove unneeded synth_event_mutex")
> 7bbab38d07f3 ("tracing: Use dyn_event framework for synthetic events")
> faacb361f271 ("tracing: Simplify creation and deletion of synthetic events")
> fc800a10be26 ("tracing: Lock event_mutex before synth_event_mutex")
> 343a9f35409b ("Merge tag 'trace-v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 6018b585e8c6fa7d85d4b38d9ce49a5b67be7078 Mon Sep 17 00:00:00 2001
> From: Mohamed Khalfella <mkhalfella@purestorage.com>
> Date: Wed, 12 Jul 2023 22:30:21 +0000
> Subject: [PATCH] tracing/histograms: Add histograms to hist_vars if they have
>  referenced variables
> 
> Hist triggers can have referenced variables without having direct
> variables fields. This can be the case if referenced variables are added
> for trigger actions. In this case the newly added references will not
> have field variables. Not taking such referenced variables into
> consideration can result in a bug where it would be possible to remove
> hist trigger with variables being refenced. This will result in a bug
> that is easily reproducable like so
> 
> $ cd /sys/kernel/tracing
> $ echo 'synthetic_sys_enter char[] comm; long id' >> synthetic_events
> $ echo 'hist:keys=common_pid.execname,id.syscall:vals=hitcount:comm=common_pid.execname' >> events/raw_syscalls/sys_enter/trigger
> $ echo 'hist:keys=common_pid.execname,id.syscall:onmatch(raw_syscalls.sys_enter).synthetic_sys_enter($comm, id)' >> events/raw_syscalls/sys_enter/trigger
> $ echo '!hist:keys=common_pid.execname,id.syscall:vals=hitcount:comm=common_pid.execname' >> events/raw_syscalls/sys_enter/trigger
> 
> [  100.263533] ==================================================================
> [  100.264634] BUG: KASAN: slab-use-after-free in resolve_var_refs+0xc7/0x180
> [  100.265520] Read of size 8 at addr ffff88810375d0f0 by task bash/439
> [  100.266320]
> [  100.266533] CPU: 2 PID: 439 Comm: bash Not tainted 6.5.0-rc1 #4
> [  100.267277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
> [  100.268561] Call Trace:
> [  100.268902]  <TASK>
> [  100.269189]  dump_stack_lvl+0x4c/0x70
> [  100.269680]  print_report+0xc5/0x600
> [  100.270165]  ? resolve_var_refs+0xc7/0x180
> [  100.270697]  ? kasan_complete_mode_report_info+0x80/0x1f0
> [  100.271389]  ? resolve_var_refs+0xc7/0x180
> [  100.271913]  kasan_report+0xbd/0x100
> [  100.272380]  ? resolve_var_refs+0xc7/0x180
> [  100.272920]  __asan_load8+0x71/0xa0
> [  100.273377]  resolve_var_refs+0xc7/0x180
> [  100.273888]  event_hist_trigger+0x749/0x860
> [  100.274505]  ? kasan_save_stack+0x2a/0x50
> [  100.275024]  ? kasan_set_track+0x29/0x40
> [  100.275536]  ? __pfx_event_hist_trigger+0x10/0x10
> [  100.276138]  ? ksys_write+0xd1/0x170
> [  100.276607]  ? do_syscall_64+0x3c/0x90
> [  100.277099]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  100.277771]  ? destroy_hist_data+0x446/0x470
> [  100.278324]  ? event_hist_trigger_parse+0xa6c/0x3860
> [  100.278962]  ? __pfx_event_hist_trigger_parse+0x10/0x10
> [  100.279627]  ? __kasan_check_write+0x18/0x20
> [  100.280177]  ? mutex_unlock+0x85/0xd0
> [  100.280660]  ? __pfx_mutex_unlock+0x10/0x10
> [  100.281200]  ? kfree+0x7b/0x120
> [  100.281619]  ? ____kasan_slab_free+0x15d/0x1d0
> [  100.282197]  ? event_trigger_write+0xac/0x100
> [  100.282764]  ? __kasan_slab_free+0x16/0x20
> [  100.283293]  ? __kmem_cache_free+0x153/0x2f0
> [  100.283844]  ? sched_mm_cid_remote_clear+0xb1/0x250
> [  100.284550]  ? __pfx_sched_mm_cid_remote_clear+0x10/0x10
> [  100.285221]  ? event_trigger_write+0xbc/0x100
> [  100.285781]  ? __kasan_check_read+0x15/0x20
> [  100.286321]  ? __bitmap_weight+0x66/0xa0
> [  100.286833]  ? _find_next_bit+0x46/0xe0
> [  100.287334]  ? task_mm_cid_work+0x37f/0x450
> [  100.287872]  event_triggers_call+0x84/0x150
> [  100.288408]  trace_event_buffer_commit+0x339/0x430
> [  100.289073]  ? ring_buffer_event_data+0x3f/0x60
> [  100.292189]  trace_event_raw_event_sys_enter+0x8b/0xe0
> [  100.295434]  syscall_trace_enter.constprop.0+0x18f/0x1b0
> [  100.298653]  syscall_enter_from_user_mode+0x32/0x40
> [  100.301808]  do_syscall_64+0x1a/0x90
> [  100.304748]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  100.307775] RIP: 0033:0x7f686c75c1cb
> [  100.310617] Code: 73 01 c3 48 8b 0d 65 3c 10 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 21 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 35 3c 10 00 f7 d8 64 89 01 48
> [  100.317847] RSP: 002b:00007ffc60137a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000021
> [  100.321200] RAX: ffffffffffffffda RBX: 000055f566469ea0 RCX: 00007f686c75c1cb
> [  100.324631] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 000000000000000a
> [  100.328104] RBP: 00007ffc60137ac0 R08: 00007f686c818460 R09: 000000000000000a
> [  100.331509] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
> [  100.334992] R13: 0000000000000007 R14: 000000000000000a R15: 0000000000000007
> [  100.338381]  </TASK>
> 
> We hit the bug because when second hist trigger has was created
> has_hist_vars() returned false because hist trigger did not have
> variables. As a result of that save_hist_vars() was not called to add
> the trigger to trace_array->hist_vars. Later on when we attempted to
> remove the first histogram find_any_var_ref() failed to detect it is
> being used because it did not find the second trigger in hist_vars list.
> 
> With this change we wait until trigger actions are created so we can take
> into consideration if hist trigger has variable references. Also, now we
> check the return value of save_hist_vars() and fail trigger creation if
> save_hist_vars() fails.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230712223021.636335-1-mkhalfella@purestorage.com
> 
> Cc: stable@vger.kernel.org
> Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist triggers")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index b97d3ad832f1..c8c61381eba4 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6663,13 +6663,15 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>  	if (get_named_trigger_data(trigger_data))
>  		goto enable;
>  
> -	if (has_hist_vars(hist_data))
> -		save_hist_vars(hist_data);
> -
>  	ret = create_actions(hist_data);
>  	if (ret)
>  		goto out_unreg;
>  
> +	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
> +		if (save_hist_vars(hist_data))
> +			goto out_unreg;
> +	}
> +
>  	ret = tracing_map_init(hist_data->map);
>  	if (ret)
>  		goto out_unreg;
> 
