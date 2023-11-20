Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F67F1556
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 15:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjKTOJ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjKTOJz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 09:09:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1666CA
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 06:09:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f61312eso18479885e9.3
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700489390; x=1701094190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qbIlp7SV0+H2O3jObbpSfHh9BdOWXzuYWUXUHiIfpzM=;
        b=RizKEIQgWXMaEwXs91l8Ff8J+ZrjGAxeYv4iWNyILl1oiPuoqFBhu5ROBvITFrIuVb
         Vrw7yyvokABMJEQVL964LnjKh8J8PP79yfIcvaf+C2cgrB1Dev3pbY/Mbh2ReFW8Fku9
         LNBk2jxjSNX2vHvhCRTasGVEIRru32q9aCvlqw0U/y0MiwZgCWls/I79BMx/85jhvz2m
         uLR2Mg5JqFwhmv6jJNy9G/yuan8uMfnnMhj2Mf7+giZ9YadR8EgtZ09IhSj4DwQV6fXG
         JnIfITqiZEx37WcM3lRVaRydNvc6R804vvzrb84l2HMjiJMH2AEvpf6VQOMGmwgiVd5f
         Kocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489390; x=1701094190;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbIlp7SV0+H2O3jObbpSfHh9BdOWXzuYWUXUHiIfpzM=;
        b=w8EPz0RFvo4hYxV7CU8EcGOipYrLb2Ps/gqIML7qYE7QG5a+QDkCy0shItaN+AOmMG
         /WDjooJLuQbgyZnivd1vDqA41BOilPPB56lThiFrKWx4V2yrpRKQKG1s+5PRjjiG0R9H
         n9nnx3ggLRRJ1RNibTwW8e3H+EjM5xjRKV+O43MRv0wnkSM82G8Y3Eg445jfq5P3p/yX
         J8m3pxTPyKUPshkdNw3VfMSNmyJAYl/RcKjtky5UeJQ2XUKgl5Ttg3x9ouiRD61LjzgR
         lpzjyMxwM+9RGbKZmgEBCq1BOtnDdWbk/fdFpH12NzIuiJstBFtcNiAOvds99QYUvmEn
         96Tw==
X-Gm-Message-State: AOJu0YzIi8AoPFhT4dC9LRgfrvXF2Ax6AJN/S/wsZud9DnHuymCMWIpN
        RGuWH1T0b+/qy32Wa3MHaRI9lo3rO3MTZkAeP95v3ZIXAV0=
X-Google-Smtp-Source: AGHT+IGxFAJtFq10FiI16aGyRwozj+BvjpzXOsflu8TXYJ8/71x23n4iRS+SV+IiBRcl6B6i4ktgUVVampekfn0grD8=
X-Received: by 2002:adf:a31c:0:b0:332:c669:8e81 with SMTP id
 c28-20020adfa31c000000b00332c6698e81mr3163079wrb.30.1700489389863; Mon, 20
 Nov 2023 06:09:49 -0800 (PST)
MIME-Version: 1.0
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Tue, 21 Nov 2023 00:09:38 +1000
Message-ID: <CALk6Uxo5ymxu_P_7=LnLZwTgjYbrdE7gzwyeQVxeR431SPuxyw@mail.gmail.com>
Subject: Backport submission - rcu: Avoid tracing a few functions executed in
 stop machine
To:     stable@vger.kernel.org
Cc:     Ronald Monthero <debug.penguin32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear stable maintainers,
I like to indicate the oops encountered and request the below patch to
be backported to v 5.15. The fix is important to avoid recurring oops
in context of rcu detected stalls.

subject: rcu: Avoid tracing a few functions executed in stop machine
commit  48f8070f5dd8
Target kernel version   v 5.15
Reason for Application: To avoid oops due to rcu_prempt detect stalls
on cpus/tasks

Environment and oops context: Issue was observed in my environment on
5.15.193 kernel (arm platform). The patch is helpful to avoid the
below oops indicated in [1] and [2]

log :
root@ls1021atwr:~# uname -r
5.15.93-rt58+ge0f69a158d5b

oops dump stack

** ID_531 main/smp_fsm.c:1884 <inrcu: INFO: rcu_preempt detected
stalls on CPUs/tasks:   <<< [1]
rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
        (detected by 1, t=2102 jiffies, g=12741, q=1154)
task:irq/31-arm-irq1 state:D stack:    0 pid:  116 ppid:     2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
[<8064bb01>] (schedule) from [<8064fa65>] (schedule_timeout+0x6d/0xa0)
[<8064fa65>] (schedule_timeout) from [<804ba353>]
(fsl_ifc_run_command+0x6f/0x178)
[<804ba353>] (fsl_ifc_run_command) from [<804ba72f>]
(fsl_ifc_cmdfunc+0x203/0x2b8)
[<804ba72f>] (fsl_ifc_cmdfunc) from [<804b135f>] (nand_status_op+0xaf/0xe0)
[<804b135f>] (nand_status_op) from [<804b13b3>] (nand_check_wp+0x23/0x48)
....
< snipped >

Exception stack(0x822bbfb0 to 0x822bbff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
rcu: rcu_preempt kthread timer wakeup didn't happen for 764 jiffies!
g12741 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x1000
rcu:    Possible timer handling issue on cpu=0 timer-softirq=1095
rcu: rcu_preempt kthread starved for 765 jiffies! g12741 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x1000 ->cpu=0    <<< [2]
rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is
now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:D stack:    0 pid:   13 ppid:     2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064ba03>] (schedule_rtlock+0x1b/0x2e)
[<8064ba03>] (schedule_rtlock) from [<8064ea6f>]
(rtlock_slowlock_locked+0x93/0x108)
[<8064ea6f>] (rtlock_slowlock_locked) from [<8064eb1b>] (rt_spin_lock+0x37/0x4a)
[<8064eb1b>] (rt_spin_lock) from [<8021b723>] (__local_bh_disable_ip+0x6b/0x110)
[<8021b723>] (__local_bh_disable_ip) from [<8025a90f>]
(del_timer_sync+0x7f/0xe0)
[<8025a90f>] (del_timer_sync) from [<8064fa6b>] (schedule_timeout+0x73/0xa0)
[<8064fa6b>] (schedule_timeout) from [<80254677>] (rcu_gp_fqs_loop+0x8b/0x1bc)
[<80254677>] (rcu_gp_fqs_loop) from [<8025483f>] (rcu_gp_kthread+0x97/0xbc)
[<8025483f>] (rcu_gp_kthread) from [<8022ca67>] (kthread+0xcf/0xe4)
[<8022ca67>] (kthread) from [<80200149>] (ret_from_fork+0x11/0x28)
Exception stack(0x820fffb0 to 0x820ffff8)
ffa0:                                     00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
rcu: Stack dump where RCU GP kthread last ran:
         <<
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
<  .. >

Thank you for your time and consideration.  Please let me know if you
require any additional information

Best Regards,
Ronald Monthero
