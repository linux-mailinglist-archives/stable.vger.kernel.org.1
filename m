Return-Path: <stable+bounces-130626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168CA805B5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAFC8839FF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531F926B2CD;
	Tue,  8 Apr 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vOjBLxp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150826E142;
	Tue,  8 Apr 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114216; cv=none; b=n7ceuyq7q4PjwhixkxDJ9LjFGB1bN0AWNFsaRfrCHgkeVgXTzpeyQY6RmTakK4tTWzhWUExeN09h/RWt9845zrB9JYhF6y63chviyGyA4dyaJ81cEB7N0mPO6JHGvl8wy6Bho0bKoIOsXheMVvgE7hyF0NRRXvpSnMoiOxzeVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114216; c=relaxed/simple;
	bh=OoGYmE3Lel7SpLh96brR6VwyffgDrQ4cwAGynTqjtHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyJ7fUUkIEJRRU0fzlz6pGu/ZFKdtpipENqCMdzMcLYYY9a1rrk5JkebqXi2QZ5ZGHgCziriwjgkw7Ej05aV4U+7uNyTdmPlMfG5+gIWunNzwwi+mdfek7AdqoIormdvRXpXz4ounCgf/FoyIC4j5Pi2aE0DCgMyFcXP/YuZ3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vOjBLxp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86966C4CEE5;
	Tue,  8 Apr 2025 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114215;
	bh=OoGYmE3Lel7SpLh96brR6VwyffgDrQ4cwAGynTqjtHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOjBLxp1xhOb4f+Sm8LoPIZmdBZlis1MdEEmP7GJkzUjJMb3qek7QQyEscgZptoZE
	 8qq6mLT5NyeEOfd6IH+IxLeKaP7Jcc2ZUZFRbWNMVx3yAo9n2IHR3wDug8PqSSP34Q
	 hRt0tyJaXeXL9s/kjGu61lK4CFZuKRkE1E2/hzsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maksim Davydov <davydov-max@yandex-team.ru>,
	Ingo Molnar <mingo@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 024/499] x86/split_lock: Fix the delayed detection logic
Date: Tue,  8 Apr 2025 12:43:56 +0200
Message-ID: <20250408104851.848758872@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maksim Davydov <davydov-max@yandex-team.ru>

[ Upstream commit c929d08df8bee855528b9d15b853c892c54e1eee ]

If the warning mode with disabled mitigation mode is used, then on each
CPU where the split lock occurred detection will be disabled in order to
make progress and delayed work will be scheduled, which then will enable
detection back.

Now it turns out that all CPUs use one global delayed work structure.
This leads to the fact that if a split lock occurs on several CPUs
at the same time (within 2 jiffies), only one CPU will schedule delayed
work, but the rest will not.

The return value of schedule_delayed_work_on() would have shown this,
but it is not checked in the code.

A diagram that can help to understand the bug reproduction:

 - sld_update_msr() enables/disables SLD on both CPUs on the same core

 - schedule_delayed_work_on() internally checks WORK_STRUCT_PENDING_BIT.
   If a work has the 'pending' status, then schedule_delayed_work_on()
   will return an error code and, most importantly, the work will not
   be placed in the workqueue.

Let's say we have a multicore system on which split_lock_mitigate=0 and
a multithreaded application is running that calls splitlock in multiple
threads. Due to the fact that sld_update_msr() affects the entire core
(both CPUs), we will consider 2 CPUs from different cores. Let the 2
threads of this application schedule to CPU0 (core 0) and to CPU 2
(core 1), then:

|                                 ||                                   |
|             CPU 0 (core 0)      ||          CPU 2 (core 1)           |
|_________________________________||___________________________________|
|                                 ||                                   |
| 1) SPLIT LOCK occured           ||                                   |
|                                 ||                                   |
| 2) split_lock_warn()            ||                                   |
|                                 ||                                   |
| 3) sysctl_sld_mitigate == 0     ||                                   |
|    (work = &sl_reenable)        ||                                   |
|                                 ||                                   |
| 4) schedule_delayed_work_on()   ||                                   |
|    (reenable will be called     ||                                   |
|     after 2 jiffies on CPU 0)   ||                                   |
|                                 ||                                   |
| 5) disable SLD for core 0       ||                                   |
|                                 ||                                   |
|    -------------------------    ||                                   |
|                                 ||                                   |
|                                 || 6) SPLIT LOCK occured             |
|                                 ||                                   |
|                                 || 7) split_lock_warn()              |
|                                 ||                                   |
|                                 || 8) sysctl_sld_mitigate == 0       |
|                                 ||    (work = &sl_reenable,          |
|                                 ||     the same address as in 3) )   |
|                                 ||                                   |
|            2 jiffies            || 9) schedule_delayed_work_on()     |
|                                 ||    fials because the work is in   |
|                                 ||    the pending state since 4).    |
|                                 ||    The work wasn't placed to the  |
|                                 ||    workqueue. reenable won't be   |
|                                 ||    called on CPU 2                |
|                                 ||                                   |
|                                 || 10) disable SLD for core 0        |
|                                 ||                                   |
|                                 ||     From now on SLD will          |
|                                 ||     never be reenabled on core 1  |
|                                 ||                                   |
|    -------------------------    ||                                   |
|                                 ||                                   |
|    11) enable SLD for core 0 by ||                                   |
|        __split_lock_reenable    ||                                   |
|                                 ||                                   |

If the application threads can be scheduled to all processor cores,
then over time there will be only one core left, on which SLD will be
enabled and split lock will be able to be detected; and on all other
cores SLD will be disabled all the time.

Most likely, this bug has not been noticed for so long because
sysctl_sld_mitigate default value is 1, and in this case a semaphore
is used that does not allow 2 different cores to have SLD disabled at
the same time, that is, strictly only one work is placed in the
workqueue.

In order to fix the warning mode with disabled mitigation mode,
delayed work has to be per-CPU. Implement it.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250115131704.132609-1-davydov-max@yandex-team.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bus_lock.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 704e9241b9640..994eae8ad8609 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -192,7 +192,13 @@ static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
 }
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+/*
+ * In order for each CPU to schedule its delayed work independently of the
+ * others, delayed work struct must be per-CPU. This is not required when
+ * sysctl_sld_mitigate is enabled because of the semaphore that limits
+ * the number of simultaneously scheduled delayed works to 1.
+ */
+static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -213,7 +219,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work;
+	struct delayed_work *work = NULL;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -235,11 +241,17 @@ static void split_lock_warn(unsigned long ip)
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
 		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
 	}
 
 	cpu = get_cpu();
+
+	if (!work) {
+		work = this_cpu_ptr(&sl_reenable);
+		/* Deferred initialization of per-CPU struct */
+		if (!work->work.func)
+			INIT_DELAYED_WORK(work, __split_lock_reenable);
+	}
+
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
-- 
2.39.5




