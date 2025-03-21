Return-Path: <stable+bounces-125741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA85A6B81E
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 10:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F8946154C
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6321F4C9B;
	Fri, 21 Mar 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QYxXqkUU"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB251F1531;
	Fri, 21 Mar 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550808; cv=none; b=I57nvYrd2lMWq8pyNkvKJMlChzpRYJUmZiXMNrHUbzD2cPuJLntyvtCXFSkOtcJ0uuzEEXMmBQCM41Rdig25e3yAtOTyifim1n/dQv6zd/5Me3UAvpbiuBJ3i3FqTOPk+yoxml7dnskQQvI2Rtkx+fB+X7UwGyTz65rh/En9HxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550808; c=relaxed/simple;
	bh=XKNZ6wUbfUUJwumVzJVxuP6qyuUd5Q1xxGKx66EOtdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZgQjRfmUv+yfV6E5wWgk2IUlGjClZ6p6WVRHYVygZEi6cyaxLiuwKz/IGLMf0XFXLzT9bkTn5q7ebn/8dRSpa9Ya9eoM7Crrpzn8N3bGWyMP6/b7wfk/xdBtdoPGm4DZgFQvA3zciOPUhbxvtXZofTV3u019fMOkdiMAT87VTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QYxXqkUU; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=++OTN
	zdXkTPaGKYdvu87lvAPQjNiOrcVxjsUv7eK/2E=; b=QYxXqkUUMShENiM3sOe6M
	ctiOn7U4cFxhQ7Vz8M15MMp+BDDMYjH1zsENBhJUNefIgrC6KSD80fu0Y2EP3rxq
	8Lhhj7DRQ8IFiSI5HihS5zXz/7MkvNcg2ImIUpYhtf7qsuLD5Cz0bAYDZoj3VlIS
	9zuNm8Bl7Qc6zd8RonXnSY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnz3L1Nt1nzZiaAw--.17933S4;
	Fri, 21 Mar 2025 17:52:54 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	vishalc@linux.ibm.com,
	bristot@redhat.com
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn
Subject: [PATCH V2] tracing/osnoise: Fix possible recursive locking for cpus_read_lock()
Date: Fri, 21 Mar 2025 09:52:49 +0000
Message-Id: <20250321095249.2739397-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz3L1Nt1nzZiaAw--.17933S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4xWw1ftryUCr1kWr17Wrg_yoW8uF45p3
	93tFyxtr4Uuryqvw1UZw18Gry8X3y5XFWUt34vqw1fAwnruw47XrWjga4Fq345ury5ZFWj
	9a4jkrWjvw4DXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqAEXTGfdMFyzYgAAs1

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Lockdep reports this deadlock log:

osnoise: could not start sampling thread
============================================
WARNING: possible recursive locking detected
--------------------------------------------
       CPU0
       ----
  lock(cpu_hotplug_lock);
  lock(cpu_hotplug_lock);

 Call Trace:
  <TASK>
  print_deadlock_bug+0x282/0x3c0
  __lock_acquire+0x1610/0x29a0
  lock_acquire+0xcb/0x2d0
  cpus_read_lock+0x49/0x120
  stop_per_cpu_kthreads+0x7/0x60
  start_kthread+0x103/0x120
  osnoise_hotplug_workfn+0x5e/0x90
  process_one_work+0x44f/0xb30
  worker_thread+0x33e/0x5e0
  kthread+0x206/0x3b0
  ret_from_fork+0x31/0x50
  ret_from_fork_asm+0x11/0x20
  </TASK>

This is the deadlock scenario:
osnoise_hotplug_workfn()
  guard(cpus_read_lock)();      // first lock call
  start_kthread(cpu)
    if (IS_ERR(kthread)) {
      stop_per_cpu_kthreads(); {
        cpus_read_lock();      // second lock call. Cause the AA deadlock
      }
    }

It is not necessary to call stop_per_cpu_kthreads() which stops osnoise
kthread for every other CPUs in the system if a failure occurs during
hotplug of a certain CPU.
For start_per_cpu_kthreads(), if the start_kthread() call fails,
this function calls stop_per_cpu_kthreads() to handle the error.
Therefore, similarly, there is no need to call stop_per_cpu_kthreads()
again within start_kthread().
So just remove stop_per_cpu_kthreads() from start_kthread to solve this issue.

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/trace/trace_osnoise.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 647516a73fa2..e732c9e37e14 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2006,7 +2006,6 @@ static int start_kthread(unsigned int cpu)
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		stop_per_cpu_kthreads();
 		return -ENOMEM;
 	}
 
-- 
2.17.1



