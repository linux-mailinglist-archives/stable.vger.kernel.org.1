Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17873575E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFSMxM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjFSMxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 08:53:00 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4911FF6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:52:36 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-558cb7f201cso2176153eaf.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687179151; x=1689771151;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyt+wpkaGWCL4HRIgjO4jhm/qs1LqswqHICYbuQiwco=;
        b=IYpD6qk3Pwvrhtv37scbvD3chDWu7ec6IpX85/olGCZV4ayuEuRmwlcgojN69R22w2
         JykpDkgV0ejYByHBplSApW8XD41XOw8hWRhIZ4mulLe27lUBBeD3gBrkQmkF/L/TSoT9
         3gVi9CpSHFlYljobgIu1sKWiy1H/jRrBVyqsCbnHREU6i14h9jqjeAZIwK4brsJruxqC
         DR6EZbNdpC1w0PCGd7nPeQV0kT98/ECtvsEM7a2K6kWKeR4YCAGJzCZsF2lEidf1rNTN
         RYggPGIKD4RCDHG+qqS0Egu2V/bdwFMMLK6XE+uehGBcJdz6F7YNi0gfz8zhhLIn5ltk
         mHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179151; x=1689771151;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dyt+wpkaGWCL4HRIgjO4jhm/qs1LqswqHICYbuQiwco=;
        b=K1qzGBVZm1ET/BZgWaEPPROgCDW9qlyN0Ntmb0aBDL1Ye8uWZp7V3ToOujydVSKncs
         D6WDsIHh14Z+SWF+6ItwlElM9HMompZMOMEViG6E7wDgtsqUB6opcb9cTGlZ4xCgibqw
         mC0hxXZVw/CWeGGBu3XZIUY9c4wwdWUDQkqV/UW8qd3zrI+n1PxVyZeDq5WmGe9ot30k
         SkOvFiK/nJqOv00RKruAjSih4jqeZnaVMaZv1m72fN1iGDOXujTvZGBPdgrIIhRdLOE6
         j59GITcp76whX4zI58q0PD3M9nW9CFnKhfzJ53MBvBFMB5ieWnAAM8KBhrV5zEDKMeH1
         i8SQ==
X-Gm-Message-State: AC+VfDyG9SWYPXdQ2JqNz5ZdxNeRZaq5spz2eMeYU7EQyU5bV7mgmU+k
        en+YdSC+k7cvNMH8brHPCu+R58bZPw==
X-Google-Smtp-Source: ACHHUZ4ylNsqDeu0SgSg32WUM/FBMETvrG7/qe7VX/pb4x9RwJLxVw4wapB3LYTIHW5p+ssBb9s7Kg==
X-Received: by 2002:a4a:eb86:0:b0:55e:14a2:e99f with SMTP id d6-20020a4aeb86000000b0055e14a2e99fmr5729206ooj.9.1687179151165;
        Mon, 19 Jun 2023 05:52:31 -0700 (PDT)
Received: from serve.minyard.net ([47.184.157.108])
        by smtp.gmail.com with ESMTPSA id bf14-20020a056820174e00b0051134f333d3sm9310452oob.16.2023.06.19.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:52:30 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:f28b:4a5a:d6b1:259b])
        by serve.minyard.net (Postfix) with ESMTPSA id B57821800BA;
        Mon, 19 Jun 2023 12:52:29 +0000 (UTC)
Date:   Mon, 19 Jun 2023 07:52:28 -0500
From:   Corey Minyard <minyard@acm.org>
To:     "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: IPMI related kernel panics since v4.19.286
Message-ID: <ZJBPjOL8chqtPck2@mail.minyard.net>
Reply-To: minyard@acm.org
References: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 11:11:16AM +0000, Janne Huttunen (Nokia) wrote:
> 
> We recently updated an internal test server from kernel v4.19.273
> to v4.19.286 and since then it has already multiple times triggered
> a kernel panic due to a hard lockup. The lockups look e.g. like
> this:

It looks like

  b4a34aa6d "ipmi: Fix how the lower layers are told to watch for messages"

was backported to fullfill a dependency for another backport, but there
was another change:

  e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately when not needed"

That is needed to avoid calling a lower layer function with
xmit_msgs_lock held.  It doesn't apply completely cleanly because of
other changes, but you just need to leave in the free_user_work()
function and delete the other function in the conflict.  In addition to
that, you will also need:

  383035211c79 "ipmi: move message error checking to avoid deadlock"

to fix a bug in that change.

Can you try this out?

Thanks,

-corey

> 
> [29397.950589] RIP: 0010:native_queued_spin_lock_slowpath+0x57/0x190
> [29397.950590] Code: 74 38 81 e6 00 ff ff ff 75 60 f0 0f ba 2f 08 8b 07 72 57 89 c2 30 e6 a9 00 00 ff ff 75 48 85 d2 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 5d 66 89 07 c3 8b 37 81 fe 00 01
> [29397.950591] RSP: 0000:ffff93d07f703de8 EFLAGS: 00000002
> [29397.950591] RAX: 0000000000000101 RBX: ffff93cf90087220 RCX: 0000000000000006
> [29397.950592] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff93cf90087220
> [29397.950592] RBP: ffff93d07f703de8 R08: 0000000000000000 R09: ffff93d07f71fb70
> [29397.950593] R10: ffff93d07f71fb28 R11: ffff93d07f703ee8 R12: 0000000000000002
> [29397.950593] R13: ffff93cf852cde58 R14: ffff93cf852cc000 R15: 0000000000000003
> [29397.950594]  ? native_queued_spin_lock_slowpath+0x57/0x190
> [29397.950594]  ? native_queued_spin_lock_slowpath+0x57/0x190
> [29397.950594]  </NMI>
> [29397.950595]  <IRQ>
> [29397.950595]  _raw_spin_lock_irqsave+0x46/0x50
> [29397.950595]  set_need_watch+0x2d/0x70 [ipmi_si]
> [29397.950596]  ? _raw_spin_lock_irqsave+0x25/0x50
> [29397.950596]  ipmi_timeout+0x2b4/0x530 [ipmi_msghandler]
> [29397.950597]  ? ipmi_set_gets_events+0x260/0x260 [ipmi_msghandler]
> [29397.950597]  call_timer_fn+0x30/0x130
> [29397.950597]  ? ipmi_set_gets_events+0x260/0x260 [ipmi_msghandler]
> [29397.950598]  run_timer_softirq+0x1ce/0x3f0
> [29397.950598]  ? ktime_get+0x40/0xa0
> [29397.950598]  ? sched_clock+0x9/0x10
> [29397.950599]  ? sched_clock_cpu+0x11/0xc0
> [29397.950599]  __do_softirq+0x104/0x32d
> [29397.950600]  ? sched_clock_cpu+0x11/0xc0
> [29397.950600]  irq_exit+0x11b/0x120
> [29397.950600]  smp_apic_timer_interrupt+0x79/0x140
> [29397.950601]  apic_timer_interrupt+0xf/0x20
> [29397.950601]  </IRQ>
> 
> 
> And like this:
> 
> [16944.269585] RIP: 0010:native_queued_spin_lock_slowpath+0x57/0x190
> [16944.269586] Code: 74 38 81 e6 00 ff ff ff 75 60 f0 0f ba 2f 08 8b 07 72 57 89 c2 30 e6 a9 00 00 ff ff 75 48 85 d2 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 5d 66 89 07 c3 8b 37 81 fe 00 01
> [16944.269587] RSP: 0018:ffff9a4e40b03dd0 EFLAGS: 00000002
> [16944.269588] RAX: 0000000000580101 RBX: ffff9a4ac5089e98 RCX: ffff9a2b9574b538
> [16944.269588] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9a4ac5089e98
> [16944.269589] RBP: ffff9a4e40b03dd0 R08: ffff9a4ac5089e58 R09: ffff9a4e40b1fb70
> [16944.269589] R10: ffff9a4e40b1fb28 R11: ffff9a4e40b03ee8 R12: 0000000000000002
> [16944.269590] R13: ffff9a4ac5089e98 R14: ffff9a4ac5089e58 R15: ffff9a4ac5089e54
> [16944.269590]  ? native_queued_spin_lock_slowpath+0x57/0x190
> [16944.269591]  ? native_queued_spin_lock_slowpath+0x57/0x190
> [16944.269591]  </NMI>
> [16944.269592]  <IRQ>
> [16944.269592]  _raw_spin_lock_irqsave+0x46/0x50
> [16944.269592]  ipmi_smi_msg_received+0x1bc/0x300 [ipmi_msghandler]
> [16944.269593]  smi_event_handler+0x26c/0x650 [ipmi_si]
> [16944.269593]  smi_timeout+0x46/0xc0 [ipmi_si]
> [16944.269594]  ? ipmi_si_irq_handler+0x70/0x70 [ipmi_si]
> [16944.269594]  call_timer_fn+0x30/0x130
> [16944.269595]  ? ipmi_si_irq_handler+0x70/0x70 [ipmi_si]
> [16944.269595]  run_timer_softirq+0x1ce/0x3f0
> [16944.269595]  ? ktime_get+0x40/0xa0
> [16944.269596]  ? sched_clock+0x9/0x10
> [16944.269596]  ? sched_clock_cpu+0x11/0xc0
> [16944.269597]  __do_softirq+0x104/0x32d
> [16944.269597]  ? sched_clock_cpu+0x11/0xc0
> [16944.269597]  irq_exit+0x11b/0x120
> [16944.269598]  smp_apic_timer_interrupt+0x79/0x140
> [16944.269598]  apic_timer_interrupt+0xf/0x20
> [16944.269599]  </IRQ>
> 
> 
> To me these would look like an ordering violation between
> "smi_info->si_lock" and "intf->xmit_msgs_lock", probably
> introduced by this commit:
> 
> commit b4a34aa6dfbca67610e56ad84a3595f537c85af9
> Author: Corey Minyard <cminyard@mvista.com>
> Date:   Tue Oct 23 11:29:02 2018 -0500
> 
>     ipmi: Fix how the lower layers are told to watch for messages
>     
>     [ Upstream commit c65ea996595005be470fbfa16711deba414fd33b ]
>     
> 
> In order to test the theory further I built and booted
> a kernel with lockdep and this happened:
> 
> [  215.679605] kipmi0/1465 is trying to acquire lock:
> [  215.684490] 00000000fc1528d3 (&(&new_smi->si_lock)->rlock){..-.}, at: set_need_watch+0x2d/0x70 [ipmi_si]
> [  215.694073] 
>                but task is already holding lock:
> [  215.699995] 00000000e2eea01c (&(&intf->xmit_msgs_lock)->rlock){..-.}, at: smi_recv_tasklet+0x170/0x260 [ipmi_msghandler]
> [  215.710966] 
>                which lock already depends on the new lock.
> 
> [  215.719243] 
>                the existing dependency chain (in reverse order) is:
> [  215.726824] 
>                -> #1 (&(&intf->xmit_msgs_lock)->rlock){..-.}:
> [  215.733890]        lock_acquire+0xae/0x180
> [  215.738111]        _raw_spin_lock_irqsave+0x4d/0x8a
> [  215.743113]        ipmi_smi_msg_received+0x1bc/0x300 [ipmi_msghandler]
> [  215.749766]        smi_event_handler+0x26c/0x660 [ipmi_si]
> [  215.755378]        ipmi_thread+0x5d/0x200 [ipmi_si]
> [  215.760377]        kthread+0x13c/0x160
> [  215.764247]        ret_from_fork+0x24/0x50
> [  215.768457] 
>                -> #0 (&(&new_smi->si_lock)->rlock){..-.}:
> [  215.775220]        __lock_acquire+0xa61/0xfb0
> [  215.779700]        lock_acquire+0xae/0x180
> [  215.783912]        _raw_spin_lock_irqsave+0x4d/0x8a
> [  215.788915]        set_need_watch+0x2d/0x70 [ipmi_si]
> [  215.794091]        smi_tell_to_watch.constprop.39+0x4a/0x50 [ipmi_msghandler]
> [  215.801353]        smi_recv_tasklet+0xe8/0x260 [ipmi_msghandler]
> [  215.807484]        tasklet_action_common.isra.14+0x83/0x1a0
> [  215.813177]        tasklet_action+0x22/0x30
> [  215.817479]        __do_softirq+0xd4/0x3ef
> [  215.821698]        irq_exit+0x120/0x130
> [  215.825649]        smp_irq_work_interrupt+0x8c/0x190
> [  215.830732]        irq_work_interrupt+0xf/0x20
> [  215.835296]        _raw_spin_unlock_irqrestore+0x56/0x60
> [  215.840725]        ipmi_thread+0x13e/0x200 [ipmi_si]
> [  215.845811]        kthread+0x13c/0x160
> [  215.849683]        ret_from_fork+0x24/0x50
> [  215.853894] 
>                other info that might help us debug this:
> 
> [  215.862075]  Possible unsafe locking scenario:
> 
> [  215.868139]        CPU0                    CPU1
> [  215.872788]        ----                    ----
> [  215.877433]   lock(&(&intf->xmit_msgs_lock)->rlock);
> [  215.882512]                                lock(&(&new_smi->si_lock)->rlock);
> [  215.889776]                                lock(&(&intf->xmit_msgs_lock)->rlock);
> [  215.897413]   lock(&(&new_smi->si_lock)->rlock);
> [  215.902151] 
>                 *** DEADLOCK ***
> 
> [  215.908250] 2 locks held by kipmi0/1465:
> 
> 
> This seems to also indicate the same locks as culprits
> although the backtraces look different from the actual
> crashes.
> 
