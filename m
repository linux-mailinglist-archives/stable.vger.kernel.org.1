Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40675D52A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGUTou (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUTos (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:44:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C41BDC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:44:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9c90527a0so1941388a34.1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1689968686; x=1690573486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj4RxNfm8i5ZSC0EE8hCRE4Cergfx4lUFDiYEtcMFSk=;
        b=NAd/Ex6MTkvZbBDj4rEPOJ9xwC/FnP2gRjo0bso4Dxh34j10prMijZdg0yWmLrIyD6
         O5+ni0L7GsTEXyRDM4qgH2VgY4s/XaIP3urozzj/CFa+uqCXnzHCPch6z/jM28vFxGXE
         +Ue4royIRuuPAq8gtdHkmhlTLIB6lu4uvpBr4R+BDFBhsWfQImA1NhFZTnkHJKs6a+vJ
         gJfOXBZRE6NMdxpEgb3dWgJdAIEOyoB8OoA5woy9UmdH4awafX3OvYXcf8mhpvKw36W3
         wH/NnRzgrnMy1uFrLy/EoR0NBZuyvjv8OmFqnznCbTWjB13HJc8nsCyNUossVTnhcATV
         buwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968686; x=1690573486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj4RxNfm8i5ZSC0EE8hCRE4Cergfx4lUFDiYEtcMFSk=;
        b=c1rGEUNhnXyJ4bnakrGOzF9VJtCkFtz69nrYSALBHRbHLEsaP4HoSxpIXZOzjAQscj
         aAOqBHN7S38FH2C+UP4TQ+UOKmggd31ZoepNuyV9BNiFOH29ZHTbAHF1fHPeXiKi7vxU
         Bsdsge30iohCCoCyaW82pCsYvA+4UbU5KfFIli4khkYLbdKN3YDpZwx+3FmSXTHUD8im
         J7WgtBlDpSBh7nipSdqpVG3cmzupHBVXqNQtwfDkqnNox4izyMHv758DoHvFenQz+7eM
         z6eSk8ZCBPdfTg32twj3yHapReKncBGWwMyVlJRnGc3KGrIRx6zRYVwnpmIOA4VAqrrY
         rZLg==
X-Gm-Message-State: ABy/qLaebLEqjwVsqaRoM1ly8mpyIa2J1dFfN5vvjfe1w3wDC4Wt9210
        9ZQMHJnsEsmD5EugsX6D8YWSmkdnKCwX0uq2r0Ljf/ABBvbah0xB3w0zZsQfT0pkWJzRLUkUW1l
        PHGtIfTYQEeQd6Dii5Pb1giIoW1JeILeB/jGPxDz+1piD22kxGpq0Nc50vluS7hBQadoakoJDmS
        Tv1hLU3Dw=
X-Google-Smtp-Source: APBJJlEVoczXdFLUm4v1mS+Fb82Twt0cd1Qs69PmC0bNp43sGTywGRvo45wsJtqIjdjD/QjNT4zH6g==
X-Received: by 2002:a05:6358:906:b0:137:7bcd:6334 with SMTP id r6-20020a056358090600b001377bcd6334mr1089759rwi.8.1689968686272;
        Fri, 21 Jul 2023 12:44:46 -0700 (PDT)
Received: from gaia.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id i22-20020a633c56000000b005633311c70dsm3477127pgn.32.2023.07.21.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:44:45 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     stable@vger.kernel.org
Cc:     Mohamed Khalfella <mkhalfella@purestorage.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4.19.y] tracing/histograms: Add histograms to hist_vars if they have referenced variables
Date:   Fri, 21 Jul 2023 19:44:26 +0000
Message-Id: <20230721194426.144050-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023072114-radiantly-gilled-72c0@gregkh>
References: <2023072114-radiantly-gilled-72c0@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hist triggers can have referenced variables without having direct
variables fields. This can be the case if referenced variables are added
for trigger actions. In this case the newly added references will not
have field variables. Not taking such referenced variables into
consideration can result in a bug where it would be possible to remove
hist trigger with variables being refenced. This will result in a bug
that is easily reproducable like so

$ cd /sys/kernel/tracing
$ echo 'synthetic_sys_enter char[] comm; long id' >> synthetic_events
$ echo 'hist:keys=common_pid.execname,id.syscall:vals=hitcount:comm=common_pid.execname' >> events/raw_syscalls/sys_enter/trigger
$ echo 'hist:keys=common_pid.execname,id.syscall:onmatch(raw_syscalls.sys_enter).synthetic_sys_enter($comm, id)' >> events/raw_syscalls/sys_enter/trigger
$ echo '!hist:keys=common_pid.execname,id.syscall:vals=hitcount:comm=common_pid.execname' >> events/raw_syscalls/sys_enter/trigger

[  100.263533] ==================================================================
[  100.264634] BUG: KASAN: slab-use-after-free in resolve_var_refs+0xc7/0x180
[  100.265520] Read of size 8 at addr ffff88810375d0f0 by task bash/439
[  100.266320]
[  100.266533] CPU: 2 PID: 439 Comm: bash Not tainted 6.5.0-rc1 #4
[  100.267277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
[  100.268561] Call Trace:
[  100.268902]  <TASK>
[  100.269189]  dump_stack_lvl+0x4c/0x70
[  100.269680]  print_report+0xc5/0x600
[  100.270165]  ? resolve_var_refs+0xc7/0x180
[  100.270697]  ? kasan_complete_mode_report_info+0x80/0x1f0
[  100.271389]  ? resolve_var_refs+0xc7/0x180
[  100.271913]  kasan_report+0xbd/0x100
[  100.272380]  ? resolve_var_refs+0xc7/0x180
[  100.272920]  __asan_load8+0x71/0xa0
[  100.273377]  resolve_var_refs+0xc7/0x180
[  100.273888]  event_hist_trigger+0x749/0x860
[  100.274505]  ? kasan_save_stack+0x2a/0x50
[  100.275024]  ? kasan_set_track+0x29/0x40
[  100.275536]  ? __pfx_event_hist_trigger+0x10/0x10
[  100.276138]  ? ksys_write+0xd1/0x170
[  100.276607]  ? do_syscall_64+0x3c/0x90
[  100.277099]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  100.277771]  ? destroy_hist_data+0x446/0x470
[  100.278324]  ? event_hist_trigger_parse+0xa6c/0x3860
[  100.278962]  ? __pfx_event_hist_trigger_parse+0x10/0x10
[  100.279627]  ? __kasan_check_write+0x18/0x20
[  100.280177]  ? mutex_unlock+0x85/0xd0
[  100.280660]  ? __pfx_mutex_unlock+0x10/0x10
[  100.281200]  ? kfree+0x7b/0x120
[  100.281619]  ? ____kasan_slab_free+0x15d/0x1d0
[  100.282197]  ? event_trigger_write+0xac/0x100
[  100.282764]  ? __kasan_slab_free+0x16/0x20
[  100.283293]  ? __kmem_cache_free+0x153/0x2f0
[  100.283844]  ? sched_mm_cid_remote_clear+0xb1/0x250
[  100.284550]  ? __pfx_sched_mm_cid_remote_clear+0x10/0x10
[  100.285221]  ? event_trigger_write+0xbc/0x100
[  100.285781]  ? __kasan_check_read+0x15/0x20
[  100.286321]  ? __bitmap_weight+0x66/0xa0
[  100.286833]  ? _find_next_bit+0x46/0xe0
[  100.287334]  ? task_mm_cid_work+0x37f/0x450
[  100.287872]  event_triggers_call+0x84/0x150
[  100.288408]  trace_event_buffer_commit+0x339/0x430
[  100.289073]  ? ring_buffer_event_data+0x3f/0x60
[  100.292189]  trace_event_raw_event_sys_enter+0x8b/0xe0
[  100.295434]  syscall_trace_enter.constprop.0+0x18f/0x1b0
[  100.298653]  syscall_enter_from_user_mode+0x32/0x40
[  100.301808]  do_syscall_64+0x1a/0x90
[  100.304748]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  100.307775] RIP: 0033:0x7f686c75c1cb
[  100.310617] Code: 73 01 c3 48 8b 0d 65 3c 10 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 21 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 35 3c 10 00 f7 d8 64 89 01 48
[  100.317847] RSP: 002b:00007ffc60137a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000021
[  100.321200] RAX: ffffffffffffffda RBX: 000055f566469ea0 RCX: 00007f686c75c1cb
[  100.324631] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 000000000000000a
[  100.328104] RBP: 00007ffc60137ac0 R08: 00007f686c818460 R09: 000000000000000a
[  100.331509] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
[  100.334992] R13: 0000000000000007 R14: 000000000000000a R15: 0000000000000007
[  100.338381]  </TASK>

We hit the bug because when second hist trigger has was created
has_hist_vars() returned false because hist trigger did not have
variables. As a result of that save_hist_vars() was not called to add
the trigger to trace_array->hist_vars. Later on when we attempted to
remove the first histogram find_any_var_ref() failed to detect it is
being used because it did not find the second trigger in hist_vars list.

With this change we wait until trigger actions are created so we can take
into consideration if hist trigger has variable references. Also, now we
check the return value of save_hist_vars() and fail trigger creation if
save_hist_vars() fails.

Link: https://lore.kernel.org/linux-trace-kernel/20230712223021.636335-1-mkhalfella@purestorage.com

Cc: stable@vger.kernel.org
Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist triggers")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 6018b585e8c6fa7d85d4b38d9ce49a5b67be7078)
---
 kernel/trace/trace_events_hist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 455cf41aedbb..892dd7085365 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5787,13 +5787,15 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	if (has_hist_vars(hist_data))
-		save_hist_vars(hist_data);
-
 	ret = create_actions(hist_data, file);
 	if (ret)
 		goto out_unreg;
 
+	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+		if (save_hist_vars(hist_data))
+			goto out_unreg;
+	}
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
-- 
2.34.1

