Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726979D050
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjILLqr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjILLqq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 07:46:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D427B3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 04:46:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so7078466a12.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1694519201; x=1695124001; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYqPluAProACun9byGSirN6Y7jCfizwxPx9r/p0ZgpQ=;
        b=V1ePDM9qJrzRh8TgKswM0gnnL8SDX/KLr39JVgomR2NJhaXCvwuzOkkQvsOd6gOiyt
         VuiWICswoaiODOaxQ8MYtC3bzBByK6i2eUtKZYDtgykWpeF8NnMxY/iRlrgbSbQ6si5K
         m1FO8So+ZJ5tXUjFSGJ1sg4zUEAA2MjWUaqCliuEikGM8J74GZ+U4rIuQKZ60TaOXLMU
         az9VgIXBmeUADaC6iwfs+138XCuZk9sn7U+9/cb+L6jSSauwfsCvVfz8lT6URR4OzsZI
         6qogTgD134/sIzlL9NxYym00mHkDCic6Pn0y/Tc22qimv5PLwRA0bu8Nc0434k0HsqeY
         NO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519201; x=1695124001;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYqPluAProACun9byGSirN6Y7jCfizwxPx9r/p0ZgpQ=;
        b=JFmcCtOmYXhvMZC3sktNWexRdJ82/VddH58bqX95W+HYHkoT+bJF3yu6xicH//5Sx+
         +BPRmAWxA2jUPwd/zuT0e1bHU8Vlg8nNc8AZTKeK7K4o0Phh784ellimgInv/A/BGcbG
         TY6TQV2O0g40BJtB/BjrVGdNFPN3t+UQGsKXooZjH9ly1FCpuAjo0SwO4KRDvaqdPVNq
         gAXh/66i2M5cqfJoPbnU/f9nzyj0VtvBKt+hJN7urPdnUNI+ifDNRtg3dh5HbwclDY0h
         tc6/30xX8dc6P1ilY8gKZFCiYrjLXhNT7Ff5xgBxksBG3lfYCrKz/SV69oTr70EzmmO7
         XHug==
X-Gm-Message-State: AOJu0YwOzPj5TyO2SjgfxVYv752wAhXI4q699w7XzadxG4tG2MhAfRVR
        toE92nBSvy9bmbcVj54CHOeNKZciE1h1I4iEmYubYtbQhcWOUwiXeho=
X-Google-Smtp-Source: AGHT+IHm92+9I4A7LlXoe1aDLmguowYYDZnCABarOdJ7hLwV/PkntQQLOOYNXeU27gYDV0MX2TG5Iv/xRQSgULoGaPg=
X-Received: by 2002:a05:6402:b30:b0:52c:a382:e0d5 with SMTP id
 bo16-20020a0564020b3000b0052ca382e0d5mr9936478edb.34.1694519200795; Tue, 12
 Sep 2023 04:46:40 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 12 Sep 2023 13:46:29 +0200
Message-ID: <CAMGffEmtW+95Hsmf-6sZmS76Mpdt+R6uYQKtjbLup+iX96eVfg@mail.gmail.com>
Subject: Regression with raid1 in stable 5.15.132-rc1 and 6.1.53-rc1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg and Stable folks.

We've noticed regression in raid1 due to following commits:
79dabfd00a2b ("md/raid1: hold the barrier until handle_read_error() finishes")
caeed0b9f1ce ("md/raid1: free the r1bio before waiting for blocked rdev")

Kernel crash during io tests like below:
Sep 11 23:03:15 ps401a-901 kernel: [  449.007040] RIP:
0010:call_bio_endio+0x1a/0x60 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.007147] Code: 00 5b e9 d9 79
b3 f0 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 18 48 8b
5f 30 a8 01 75 04 c6 43 1a 0a 48 8b 53 08 <48> 8b 82 40 02 00 00 48 8b
40 50 48 8b 40 60 a8 80 74 12 48 8b 47
Sep 11 23:03:15 ps401a-901 kernel: [  449.007347] RSP:
0018:ffffb3300f627b90 EFLAGS: 00010202
Sep 11 23:03:15 ps401a-901 kernel: [  449.007448] RAX:
0000000000000025 RBX: ffff8d2cab013210 RCX: 0000000000000000
Sep 11 23:03:15 ps401a-901 kernel: [  449.007582] RDX:
00000001ab000000 RSI: ffff8d2cab013210 RDI: ffff8cfdb1e1d100
Sep 11 23:03:15 ps401a-901 kernel: [  449.007688] RBP:
ffff8d34c2ee2800 R08: 000000000000c0d4 R09: 0000000000073f2c
Sep 11 23:03:15 ps401a-901 kernel: [  449.007795] R10:
0000000000073f34 R11: ffff8cfdb1e1d100 R12: ffff8d2cab013200
Sep 11 23:03:15 ps401a-901 kernel: [  449.007901] R13:
0000000000000000 R14: 0000000000000000 R15: ffff8d34c2ee2800
Sep 11 23:03:15 ps401a-901 kernel: [  449.008011] FS:
0000000000000000(0000) GS:ffff8d3487c40000(0000)
knlGS:0000000000000000
Sep 11 23:03:15 ps401a-901 kernel: [  449.008146] CS:  0010 DS: 0000
ES: 0000 CR0: 0000000080050033
Sep 11 23:03:15 ps401a-901 kernel: [  449.008248] CR2:
00000001ab000240 CR3: 000000038360a000 CR4: 00000000000406e0
Sep 11 23:03:15 ps401a-901 kernel: [  449.008355] Call Trace:
Sep 11 23:03:15 ps401a-901 kernel: [  449.008448]  <TASK>
Sep 11 23:03:15 ps401a-901 kernel: [  449.008539]  ? __die_body+0x1a/0x60
Sep 11 23:03:15 ps401a-901 kernel: [  449.008638]  ? page_fault_oops+0x136/0x2a0
Sep 11 23:03:15 ps401a-901 kernel: [  449.008754]  ? exc_page_fault+0x5f/0x110
Sep 11 23:03:15 ps401a-901 kernel: [  449.008853]  ?
asm_exc_page_fault+0x22/0x30
Sep 11 23:03:15 ps401a-901 kernel: [  449.008955]  ?
call_bio_endio+0x1a/0x60 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.009055]
raid_end_bio_io+0x28/0x90 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.009158]
raid1_end_write_request+0x10b/0x340 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.009263]  submit_bio_checks+0x84/0x450
Sep 11 23:03:15 ps401a-901 kernel: [  449.009364]  ? __wake_up_common+0x77/0x140
Sep 11 23:03:15 ps401a-901 kernel: [  449.009463]  __submit_bio+0x106/0x190
Sep 11 23:03:15 ps401a-901 kernel: [  449.009560]  ? __queue_work+0x136/0x3b0
Sep 11 23:03:15 ps401a-901 kernel: [  449.009659]  submit_bio_noacct+0x268/0x2c0
Sep 11 23:03:15 ps401a-901 kernel: [  449.009758]
flush_bio_list+0x60/0x100 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.009859]
flush_pending_writes+0x71/0xb0 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.009976]  raid1d+0xa6/0x1280 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.010076]  ? psi_task_switch+0xde/0x200
Sep 11 23:03:15 ps401a-901 kernel: [  449.010175]  ? __switch_to_asm+0x3a/0x60
Sep 11 23:03:15 ps401a-901 kernel: [  449.010274]  ?
finish_task_switch+0x7d/0x280
Sep 11 23:03:15 ps401a-901 kernel: [  449.010373]  ?
try_to_del_timer_sync+0x4d/0x80
Sep 11 23:03:15 ps401a-901 kernel: [  449.010475]  ?
md_thread+0x137/0x170 [md_mod]
Sep 11 23:03:15 ps401a-901 kernel: [  449.010586]  ?
process_checks+0x4c0/0x4c0 [raid1]
Sep 11 23:03:15 ps401a-901 kernel: [  449.010688]
md_thread+0x137/0x170 [md_mod]

Reverting both patches locally I can no longer reproduce the crash.

Please drop both patches from all the stable queues.

Thx!
Jnipu Wang @ IONOS cloud
