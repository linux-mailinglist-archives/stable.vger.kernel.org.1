Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A878E0A8
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjH3U3F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbjH3U24 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 16:28:56 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15540793F5
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 12:35:12 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-34cacab5e34so474355ab.0
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693423985; x=1694028785; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AM0RaalyZCOyT9irqgr/tdxWag/TXwHth0rD06/c0Q=;
        b=QD9BQbXsiu/prZd89FH6cxM5nVDdT0GnJvalXQQj/92kP1swtj1ylkZ26jKtR1SoUx
         gzt2mRC+rCEsYwBSzmHQnToUBOQNhi4CsUklAGm9Jv9uTfcm2wJA/mA1BRxTKMj9+r3+
         saAswtR3vCnmUWKlbshrV+Eein6yJYKdSvInI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423985; x=1694028785;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AM0RaalyZCOyT9irqgr/tdxWag/TXwHth0rD06/c0Q=;
        b=FjkOeAbJRRG54GX3qSx5t4BWb/Hmd2uENEJ+hlBQ9e3wZ4PkT/nax1ZVW3S9EDn35g
         F+5w76kWq4XnfqSEmIIg0G2oweiR0QPp+eJyPbqgW9AGX3kVZiJ7zNUJFoNiDmWzWOmf
         L2YBEm6DDrCZsxj+T7Z+b3e7pNeH2UNDvFUx3pjQpPHRbrPHLCsDT5Q4Qvrvm7V3AZKm
         hghcWNdXI4ldLKbAiNgDmP2oLrkh8KNn3tsa2AaCz5RllkzO5YRYiKi0dfBFaP6EYb+T
         uHtzZgnAIcu7ebwjewienisTi6vEdbY2qLt9yURguF/G5jeHEYhk1XFNNhLdRAC6+dSX
         xJJQ==
X-Gm-Message-State: AOJu0YyWBdmOktW2+WPqZcCYbeZZrLv/zd88FoPUxlm4/BIXE1NyEPYj
        8hPFn0mzXDyzV2IAmwdpt2f121q3U9zClQDOWNc=
X-Google-Smtp-Source: AGHT+IGxkSbGQLY4iqpxplaZ/GXhsovf4KbCXfsTsDJmJgykjeTt1iPwAMkVMWL7WkRd0Ll6YJ/lhg==
X-Received: by 2002:a05:6e02:130e:b0:349:862e:a863 with SMTP id g14-20020a056e02130e00b00349862ea863mr3487515ilr.15.1693423984677;
        Wed, 30 Aug 2023 12:33:04 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id b7-20020a056e02048700b00348cb9adb38sm3635267ils.7.2023.08.30.12.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:33:04 -0700 (PDT)
Date:   Wed, 30 Aug 2023 19:33:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linux-foundation.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Subject: Please apply the following rcu-tasks fixes to 5.10 and 5.15 stable
 kernels
Message-ID: <20230830193303.GA623680@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Stable team,

Please apply the following rcu-tasks fixes to 5.10 and 5.15 stable kernel.
They cleanly apply and are required to fix a warning [1] that shows up
during rcutorture testing and are all bug fixes merged into Linus tree.

I have verified them on the latest 5.10 and 5.15 stable kernels.

commit 46aa886c483f57ef13cd5ea0a85e70b93eb1d381
rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader

commit cbe0d8d91415c9692fe88191940d98952b6855d9
rcu-tasks: Wait for trc_read_check_handler() IPIs

commit 18f08e758f34e6dfe0668bee51bd2af7adacf381
rcu-tasks: Add trc_inspect_reader() checks for exiting critical section

thanks,

 - Joel
[1] Snippet of dmesg showing warning:

[ 2701.802174] WARNING: CPU: 0 PID: 11 at kernel/rcu/tasks.h:978 rcu_tasks_trace_pregp_step+0x46/0x50
[ 2701.820952] Modules linked in:
[ 2701.827014] CPU: 0 PID: 11 Comm: rcu_tasks_trace Not tainted 5.10.193-rc1+ #531
[ 2701.858299] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2701.876050] RIP: 0010:rcu_tasks_trace_pregp_step+0x46/0x50
[ 2701.907104] Code: 48 8b 04 c5 e0 56 c1 b3 80 3c 18 00 75 1c 48 c7 c6 10 37 07 b4 e8 7a fb 38 00 3b 05 a8 bc 99 01 89 c7 72 d9 5b e9 ea 56 f9 ff <0f> 0b eb e0 66 0f 1f 44 00 00 55 53 48 89 fb 48 89 77 08 48 c7 07
[ 2701.967363] RSP: 0018:ffffbd5540063e40 EFLAGS: 00010202
[ 2701.977403] RAX: ffffa426df580000 RBX: 000000000001fa40 RCX: 0000000000000000
[ 2702.007399] RDX: 000000000000000f RSI: 0000000000000000 RDI: 0000000000000003
[ 2702.070872] RBP: ffffbd5540063e60 R08: 0000000000000000 R09: ffffffffb4073710
[ 2702.104722] R10: 0000000000000001 R11: 0000000000000001 R12: ffffa426c1069e60
[ 2702.136555] R13: ffffffffb3f32ae0 R14: ffffffffb3f32af0 R15: ffffa426c1178dc0
[ 2702.183571] FS:  0000000000000000(0000) GS:ffffa426df400000(0000) knlGS:0000000000000000
[ 2702.239210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2702.326861] CR2: 0000000000402000 CR3: 00000000020e0000 CR4: 00000000000006f0
[ 2702.353000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2702.363008] smpboot: CPU 3 is now offline
[ 2702.386004] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2702.386007] Call Trace:
[ 2702.386580]  ? __warn+0x7c/0x100
[ 2702.386588]  ? rcu_tasks_trace_pregp_step+0x46/0x50
[ 2702.386725]  ? report_bug+0x99/0xc0
[ 2702.386916]  ? handle_bug+0x41/0x80
[ 2702.387021]  ? exc_invalid_op+0x13/0x60
[ 2702.387048]  ? asm_exc_invalid_op+0x12/0x20
[ 2702.387054]  ? rcu_tasks_trace_pregp_step+0x46/0x50
[ 2702.387057]  rcu_tasks_wait_gp+0x4b/0x260
[ 2702.387059]  ? schedule_timeout+0x9a/0x150
[ 2702.387062]  rcu_tasks_kthread+0xf4/0x1d0
[ 2702.387065]  ? wait_woken+0x80/0x80
[ 2702.387067]  ? rcu_barrier_tasks_trace+0xa0/0xa0
[ 2702.387071]  kthread+0x137/0x160
[ 2702.387140]  ? __kthread_bind_mask+0x60/0x60
[ 2702.387158]  ret_from_fork+0x22/0x30
