Return-Path: <stable+bounces-130163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A55FA8032A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300FE442084
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297D22257E;
	Tue,  8 Apr 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5ZmiKDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82035A94A;
	Tue,  8 Apr 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112985; cv=none; b=jbXTQAPWxntGrwxORGiPmXNZNcAFzEzEx5tJR/x7JD+q6j2mavCm8bz+1cxQxBiXeEtpMYlzMEYj2BxfOXapAK+ictmnhbJDpYxitJtf3g3rpi3QG3KgcE3jYpFT1E8MAIt70ZZ9kSx93GukacTS+U9iL7krHkuag1mQDnF953c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112985; c=relaxed/simple;
	bh=SeGNlcl2lW7xkWil2CebA/3fAxQzhuAuogYJ+cVgWYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq93oG95R+cI3l2b/RXHBCgzJkjKXmw5UIavyysJuK7cIpynJF+mpQywIqtFSxLyzTuKq3Jtjy82EozJOlVQXCegqnkGx8+psLReQB3+WxkrZ3CXQE8TanZzwWk9EE49HPOxrF/0hK7BSocnwsrq0Bu+OhS9bRFPBCiXKYdGylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5ZmiKDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14211C4CEE5;
	Tue,  8 Apr 2025 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112985;
	bh=SeGNlcl2lW7xkWil2CebA/3fAxQzhuAuogYJ+cVgWYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5ZmiKDR6tgsZY4YQTHRHV8uIUIjGChQ/tpj5OyTa4UxG0UmHWeiwAbzBPrQkBotG
	 wzGJk6TfoE8ICyeI45zM26vQtaPXoY1Sls9CcGfhx9hPr+997SkyqLblkyjFooi00S
	 xASDs4aVr8jsk0Iwc4i2v4ysaTehRDie/if0fXVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 271/279] tracing/osnoise: Fix possible recursive locking for cpus_read_lock()
Date: Tue,  8 Apr 2025 12:50:54 +0200
Message-ID: <20250408104833.709603192@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

commit 7e6b3fcc9c5294aeafed0dbe1a09a1bc899bd0f2 upstream.

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

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250321095249.2739397-1-ranxiaokai627@163.com
Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1560,7 +1560,6 @@ static int start_kthread(unsigned int cp
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		stop_per_cpu_kthreads();
 		return -ENOMEM;
 	}
 



