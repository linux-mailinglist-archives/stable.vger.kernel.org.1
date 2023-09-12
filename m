Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C415279D302
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjILN5v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjILN5u (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168E10CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50098cc8967so9121972e87.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527064; x=1695131864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hcVh0aPGq4dcGpyOu6En2Lcn4oiY1UZquxveT2lc9Q=;
        b=XEkJGq+oEjm+YrrIPro4meEuO89A4/KnRhRjFUh6w8UblHojwKzbIPK0Uy5y3Quqcf
         tECpcj6biNa4qvGyocImw8fwJyPtNqhmHoQ8XGjjyqlkLlVUM8MwmLEpCyVIOYQTGVMH
         i8hzHRg9ICr+CZrvTNh/mUDkn2FPknJYrB/IrmN9CAlhg4v2SIDbd9IIXu2k6erEWCFK
         8hQYHHhx/LcfyV6BwfFNwMEMaeVgeaiDty+CKgeIeSHBNdBaG1Iwj1v/eHDLy+kGUkpI
         PI57NcrJ23aNUB0qb2QYJeAJjk1JDoydOtfEC2OyJf22IZTreWheNcRHj2EbOxO2W5R7
         Hniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527064; x=1695131864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hcVh0aPGq4dcGpyOu6En2Lcn4oiY1UZquxveT2lc9Q=;
        b=d14vI0Ct7+wSv8EyO8UPRqSaTojGsOnKfVHyGcBdpcDCnhmNYIJ0g+sR1Wrs2Bbx1r
         YcB5jUYD3RUNr/4gQocEVaOe9PqAQEaIRFWyazlWDyLeDso1HvQRooT8+iDrNtCbcFKQ
         MjhiGNSB0MBCguElTwxelmZy9BumUvh66V5DRRMlB/0haxsOXUIW4QEUamFuNb/CFLVj
         jDNsU8LnTqrqpGV+BaSJCd0xU4Ubn8N2owKolemXcJ5kYdJJMwb0K9f2ppMlujFx2aRm
         Abvk/3eaG6EenG7qDpHwfrjNCv/z6mPwiK5Sc6F/AhoqnnTE6GczIeIsWtECPARFCr+x
         oK2g==
X-Gm-Message-State: AOJu0YxwBje1T0H3zXWGIQOiQShlzk1KX9eZ0gITmIM7zVwEsvWaET0h
        YLlLIBOiYCK10GM3u8qp/vt+XSalK5E=
X-Google-Smtp-Source: AGHT+IES0K7PhxsrGtuRyhYVgVnpZb/Z3kg8gTRGdNwgVsJX0eNgaLfVrtfinakL07D7WAjUc6cuug==
X-Received: by 2002:a05:6512:32af:b0:500:bd75:77cf with SMTP id q15-20020a05651232af00b00500bd7577cfmr11378319lfe.17.1694527064075;
        Tue, 12 Sep 2023 06:57:44 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:43 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        syzbot+c74fea926a78b8a91042@syzkaller.appspotmail.com
Subject: [PATCH 6/6] io_uring: Don't set affinity on a dying sqpoll thread
Date:   Tue, 12 Sep 2023 14:57:08 +0100
Message-ID: <0aed50c3249c232d28eac664a086539660507c3d.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694486400.git.asml.silence@gmail.com>
References: <cover.1694486400.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ upstream commit bd6fc5da4c51107e1e0cec4a3a07963d1dae2c84 ]

Syzbot reported a null-ptr-deref of sqd->thread inside
io_sqpoll_wq_cpu_affinity.  It turns out the sqd->thread can go away
from under us during io_uring_register, in case the process gets a
fatal signal during io_uring_register.

It is not particularly hard to hit the race, and while I am not sure
this is the exact case hit by syzbot, it solves it.  Finally, checking
->thread is enough to close the race because we locked sqd while
"parking" the thread, thus preventing it from going away.

I reproduced it fairly consistently with a program that does:

int main(void) {
  ...
  io_uring_queue_init(RING_LEN, &ring1, IORING_SETUP_SQPOLL);
  while (1) {
    io_uring_register_iowq_aff(ring, 1, &mask);
  }
}

Executed in a loop with timeout to trigger SIGTERM:
  while true; do timeout 1 /a.out ; done

This will hit the following BUG() in very few attempts.

BUG: kernel NULL pointer dereference, address: 00000000000007a8
PGD 800000010e949067 P4D 800000010e949067 PUD 10e46e067 PMD 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 15715 Comm: dead-sqpoll Not tainted 6.5.0-rc7-next-20230825-g193296236fa0-dirty #23
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
RIP: 0010:io_sqpoll_wq_cpu_affinity+0x27/0x70
Code: 90 90 90 0f 1f 44 00 00 55 53 48 8b 9f 98 03 00 00 48 85 db 74 4f
48 89 df 48 89 f5 e8 e2 f8 ff ff 48 8b 43 38 48 85 c0 74 22 <48> 8b b8
a8 07 00 00 48 89 ee e8 ba b1 00 00 48 89 df 89 c5 e8 70
RSP: 0018:ffffb04040ea7e70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff93c010749e40 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffa7653331 RDI: 00000000ffffffff
RBP: ffffb04040ea7eb8 R08: 0000000000000000 R09: c0000000ffffdfff
R10: ffff93c01141b600 R11: ffffb04040ea7d18 R12: ffff93c00ea74840
R13: 0000000000000011 R14: 0000000000000000 R15: ffff93c00ea74800
FS:  00007fb7c276ab80(0000) GS:ffff93c36f200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000007a8 CR3: 0000000111634003 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die_body+0x1a/0x60
 ? page_fault_oops+0x154/0x440
 ? do_user_addr_fault+0x174/0x7b0
 ? exc_page_fault+0x63/0x140
 ? asm_exc_page_fault+0x22/0x30
 ? io_sqpoll_wq_cpu_affinity+0x27/0x70
 __io_register_iowq_aff+0x2b/0x60
 __io_uring_register+0x614/0xa70
 __x64_sys_io_uring_register+0xaa/0x1a0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7fb7c226fec9
Code: 2e 00 b8 ca 00 00 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 97 7f 2d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe2c0674f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb7c226fec9
RDX: 00007ffe2c067530 RSI: 0000000000000011 RDI: 0000000000000003
RBP: 00007ffe2c0675d0 R08: 00007ffe2c067550 R09: 00007ffe2c067550
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2c067750 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 00000000000007a8
---[ end trace 0000000000000000 ]---

Reported-by: syzbot+c74fea926a78b8a91042@syzkaller.appspotmail.com
Fixes: ebdfefc09c6d ("io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://lore.kernel.org/r/87v8cybuo6.fsf@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/sqpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 2949959cbe60..7b6facf529b8 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -432,7 +432,9 @@ __cold int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx,
 
 	if (sqd) {
 		io_sq_thread_park(sqd);
-		ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
+		/* Don't set affinity for a dying thread */
+		if (sqd->thread)
+			ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
 		io_sq_thread_unpark(sqd);
 	}
 
-- 
2.41.0

