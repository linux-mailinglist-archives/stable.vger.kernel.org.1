Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048575DC00
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGVLvI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 22 Jul 2023 07:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVLvH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 22 Jul 2023 07:51:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB12D47
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 04:51:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A4084320084E;
        Sat, 22 Jul 2023 07:51:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 22 Jul 2023 07:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690026660; x=1690113060; bh=KI
        Z5JYrEXhvZZQyDG2wOlSZyD8b1CDF5O2rvxi8AyKI=; b=KlKr3H7GBvBZ59QVoo
        iDp8YsEde9ORqbIaxsLQq8zfhd+PEGBISFRYlCpz+60WvRDz4az2xXN+zDD/Ixdl
        tXZgdZN1FgrgVPpQa7isQazIBhNuCafFbI5YB4gH9GDgf7teRfhQ5l3AiS0g+OAN
        EvLUlT/5huioLu+Usf7m0Ke1s8+cYTpNxOd3V/J37IepG4W8wuydUcGC+aOpa8Vs
        Sd6cACPfzVm73e9t5hPD1qyMcTshG2KansB5Y4R0TT/HnTluohEuvPtGRUP7RY5C
        t3oqLlq+as3bPGFAoDHcCCKrLXtsKXPjODQIZ/eh7io1K34VuIoigr4TNJNkIGUA
        vFnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690026660; x=1690113060; bh=KIZ5JYrEXhvZZ
        QyDG2wOlSZyD8b1CDF5O2rvxi8AyKI=; b=VQLMFlFulJX5BYDnaEryB60a9XpNo
        eFZJnxYTOIeLkRZOA/OEbmiOXNI7wx3WDj+SlpYLPEeVRKT+giX87pkIQXAzl/l+
        kb4EXtmjGpERjTtcXyKZk0LWPwXmyVtMSHhpXY/xOxE945dGjOJCNuXpZ2gIcmYO
        0+FNKvOLgejaucn+l9rbkPRDmOppsm5T3/XMf9D7F+jNK8MZJ59OWA0Gfy6aSEN2
        Bbw632zeHBt8EbrQJvruEG4ELpcaAOM8y1rliweAZkv8ZUEdpW3QSzaZJbcJV9hF
        0lJLdLnq+2vYz72QQVGmnj/IJPYBXCVz5JZ8cUvqNv8yaWPHYXRrMZL2A==
X-ME-Sender: <xms:o8K7ZIZyFnXsExvL37pxafOgYmgixk8E6bm2A__AZeZbRnlhm43OLg>
    <xme:o8K7ZDZD8RREmz_ztMyp6zpWE-hFwxGsdYgJSwJEakFzozOwZBKDVfQ1ODQBCM2Uc
    hyHe7mE6QWfag>
X-ME-Received: <xmr:o8K7ZC96RG6HMIswn6NCCO4gN_kxpwuCDYzJokNVieJE-R_-hRiwQYHRjRooBrKE-YFS5zs-RrCMoXWU1fOLucKvxPz-3nC3CMWgVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeggdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:o8K7ZCqsJSN1iK0tTei0nnH8QKdW2cJcxN21Mr3OSC1WYqgGE09VWw>
    <xmx:o8K7ZDrOsy4b7gw6v43AxbmGpxY3KTqJ30SSC6wgGWdq5mJ9jOZ6yg>
    <xmx:o8K7ZASHNVhzDcS_v7lCa5ILlWPYVw_VjZdVUSgVZSzfotd03t607g>
    <xmx:pMK7ZEkCrJja-LONio9v5UvQbbPZJVwF6uavuq8nvd4KWCZJSjHQzw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Jul 2023 07:50:59 -0400 (EDT)
Date:   Sat, 22 Jul 2023 13:50:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Mohamed Khalfella <mkhalfella@purestorage.com>
Cc:     stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4.19.y] tracing/histograms: Add histograms to hist_vars
 if they have referenced variables
Message-ID: <2023072220-distinct-radial-fbab@gregkh>
References: <2023072114-radiantly-gilled-72c0@gregkh>
 <20230721194426.144050-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721194426.144050-1-mkhalfella@purestorage.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 07:44:26PM +0000, Mohamed Khalfella wrote:
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
> (cherry picked from commit 6018b585e8c6fa7d85d4b38d9ce49a5b67be7078)
> ---
>  kernel/trace/trace_events_hist.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 455cf41aedbb..892dd7085365 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5787,13 +5787,15 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
>  	if (get_named_trigger_data(trigger_data))
>  		goto enable;
>  
> -	if (has_hist_vars(hist_data))
> -		save_hist_vars(hist_data);
> -
>  	ret = create_actions(hist_data, file);
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

Now queued up, thanks.

greg k-h
