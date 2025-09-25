Return-Path: <stable+bounces-181723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83955B9F99E
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 15:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889C77BDE8A
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0326A0DB;
	Thu, 25 Sep 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="TX3iNa0C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE982641E3
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807198; cv=none; b=d+FnYeWNh4REUzSTtKQjf47Lj3qkDag9AFvo5XCR3I6G1gO28qcdpWKCLk415cnt+AbY+w6amz0/83ZEScK3rXFkDPwL/6dwn08Fu4BW/g7gt3nl0VDrKDek3wkDrMEgx7s+LDEcp3kdfRLGMh1+VyrQrTK1WK74W1Bl7HK1O+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807198; c=relaxed/simple;
	bh=pbPVkYQ8kmks8NtRvetGTvntXfeiJxnGT7gjqdzx04Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VPIgO47k4Fjfpc2uAj6yYlc9lA8J0dj1wDTW8SH/5J2TzOY9smqfHv7UOYgnNgw5zNy4eykV0RyO5LRu4h2XGBHLIKtOMA9pZufS+as9W8L6mlBpXzxN4/f1OJEDYRIyFBqvNr7zNf9uNiJEsob5dq1JkgCsxCTXFcHdkQ3jShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=TX3iNa0C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso8520395e9.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1758807194; x=1759411994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6p46HOBWWfro5hj7gcC0pHFM8QTS0713LJWgGrHP3oI=;
        b=TX3iNa0C3JKcOCGMDGyYR0uLVP7ye/8I3uHUOFb3O4GLSXuppIxq5Sr4q64Bqb+i8I
         6fosxqYBW221azP7+rXWe5+0Ze8LfjDznVCBMwxFMRjNNeNx9tFK9x5qQ05lSkNMIJqm
         FdpGTCS/KtJd9H0kFG2uIzkN/+EstUUgt/gwek/zkFVrNKl7aNjEkjwtWREoLYc0DrjL
         HFZP4ClLEwDGBUcq9acPibR9DCBF+J6P4/MQje59bhLUFFt8UD9wNIYGpK8RS7PIYVqe
         VmdyCbszrWh4bcqUo1i6PiMN6adrcA3dGKZCpBULMQzM5ZwL0FVtMsY8q3unTxXpAV58
         vZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807194; x=1759411994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p46HOBWWfro5hj7gcC0pHFM8QTS0713LJWgGrHP3oI=;
        b=TB0pBbNrHW4V1yBtmcZXxW4EzjRbZ6rNn3XIItwOQkF9H5QYtmK4kEkZmOkeMJSlRx
         5VkS/SYvpI2hImBTVI/Qw5J2oW16aumje8y201AGdpBXPfMAldJ76+4NKK5RmIizq3Hj
         1oiQPZNL7Ax2PPaIsSHg48QYpqmdsSW/T2VbKbEZ1fWLekweObzi1PxBD7n4wMOVcox/
         5odm0TufxFTIfFVcC9C7yE9Hp0s70ya2dbmOlIHqMhYzJBC2GdAd+UJcSxk0nh7SFiHy
         jGcXyejVL/dM1TFWiMZhSDG68rp2BuUiBJbq+2/DZ4TpZuDhyhCxJfs55SCXzIymoV4Z
         stTw==
X-Forwarded-Encrypted: i=1; AJvYcCVNGeO1GIr7T57eM49V5Btbee2poOKYvXElOWC7h0GeEoKucPARkpSHQ17DoNsHdfPi9c/9tyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydnqn2yN9gXJM8ert9UhMGuEDuKW4zlwzOB6nT82ZfnQmefbof
	ZYEmLXU8wqNvCWgGmw9uyGmjvp5MBIDmeVYVql66eiGCE/opxW3PVAt/oaxOgfVlpN4=
X-Gm-Gg: ASbGncvtgyBFUytEwxCL2LA1o9jVZyfiUX+frM3klLE4z1dRv0ZCOf9Twvd1gYzJia4
	75h96aRbOPjZzf1NFgTJhzQw/iV3eDjzvTRRVV6iRl0AodEV/ICBNbxuIhNAbgiXrH4N0vlwOe3
	dShqk39ktxDFopc9VKMHcDlPW3kSgFPbaZnubP24/Js0xsMGYQuabpRmD5vya9anzIcf1DnFW9H
	bzfeWhKyCHtVhvVK9jz3ZIOSxDDo968Q9AQj1zCDJRVmnzax2B2xgMeEBLUz4RCvvmC4PZQI2fJ
	XAoa62k0Dxd+cYtPMwudMtM18SOndcmRBUqOiV8da/JLldfG7ynjYTL1iVK62VnMRIyCJC20kTh
	4ZWyTGXlR0Q3MXgoQ0hpGcuw1
X-Google-Smtp-Source: AGHT+IHxdCA3FiTt5asuefF8cFaSyXMaVpmg/nyWOHiE4Nd1JK8crLR4Luw93rXuD8Y4STbkN+crjQ==
X-Received: by 2002:a05:6000:40c8:b0:3ee:23a7:5df0 with SMTP id ffacd0b85a97d-40e4a42f416mr3556892f8f.54.1758807193926;
        Thu, 25 Sep 2025 06:33:13 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:28e0:840::15:427])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf701dsm33591135e9.24.2025.09.25.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:33:13 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	Oleg Nesterov <oleg@redhat.com>,
	John Stultz <jstultz@google.com>,
	Chris Arges <carges@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks"
Date: Thu, 25 Sep 2025 14:33:10 +0100
Message-Id: <20250925133310.1843863-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

This reverts commit b7ca5743a2604156d6083b88cefacef983f3a3a6.

If we dequeue a task (task B) that was sched delayed then that task is
definitely no longer on the rq and not tracked in the rbtree.
Unfortunately, task_on_rq_queued(B) will still return true because
dequeue_task() doesn't update p->on_rq.

This inconsistency can lead to tasks (task A) spinning indefinitely in
wait_task_inactive(), e.g. when delivering a fatal signal to a thread
group, because it thinks the task B is still queued (it's not) and waits
forever for it to unschedule.

          Task A                                    Task B

  arch_do_signal_or_restart()
    get_signal()
      do_coredump()
        coredump_wait()
	  zap_threads()                     arch_do_signal_or_restart()
          wait_task_inactive() <-- SPIN       get_signal()
	                                        do_group_exit()
						  do_exit()
						    coredump_task_exit()
						      schedule() <--- never comes back

Not only will task A spin forever in wait_task_inactive(), but task B
will also trigger RCU stalls:

  INFO: rcu_tasks detected stalls on tasks:
  00000000a973a4d8: .. nvcsw: 2/2 holdout: 1 idle_cpu: -1/79
  task:ffmpeg          state:I stack:0     pid:665601 tgid:665155 ppid:668691 task_flags:0x400448 flags:0x00004006
  Call Trace:
   <TASK>
   __schedule+0x4fb/0xbf0
   ? srso_return_thunk+0x5/0x5f
   schedule+0x27/0xf0
   do_exit+0xdd/0xaa0
   ? __pfx_futex_wake_mark+0x10/0x10
   do_group_exit+0x30/0x80
   get_signal+0x81e/0x860
   ? srso_return_thunk+0x5/0x5f
   ? futex_wake+0x177/0x1a0
   arch_do_signal_or_restart+0x2e/0x1f0
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? __x64_sys_futex+0x10c/0x1d0
   syscall_exit_to_user_mode+0xa5/0x130
   do_syscall_64+0x57/0x110
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f22d05b0f16
  RSP: 002b:00007f2265761cf0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
  RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00007f22d05b0f16
  RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00005629e320d97c
  RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
  R10: 0000000000000000 R11: 0000000000000246 R12: 00005629e320d928
  R13: 0000000000000000 R14: 0000000000000001 R15: 00005629e320d97c
   </TASK>

Fixes: b7ca5743a260 ("sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: Chris Arges <carges@cloudflare.com>
Cc: stable@vger.kernel.org # v6.12
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/sched/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..2dfc3977920d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2293,12 +2293,6 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * just go back and repeat.
 		 */
 		rq = task_rq_lock(p, &rf);
-		/*
-		 * If task is sched_delayed, force dequeue it, to avoid always
-		 * hitting the tick timeout in the queued case
-		 */
-		if (p->se.sched_delayed)
-			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		trace_sched_wait_task(p);
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
-- 
2.34.1


