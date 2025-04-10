Return-Path: <stable+bounces-132124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6EA846D8
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E25D3B1909
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864928CF5F;
	Thu, 10 Apr 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="oLu2Qefl"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F23204F80
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296285; cv=none; b=fLqKPhstsRWPgvSg4OeL40KBLY9bgLeYlFogih9ChqeslpnkMNb8b4JIPFbGr3WGxKBToVd4QD01k5DK3lr3VpxL6Nr/OhyFgvWYJXueqMXc32QK/YsOT27BnH9oqc+swK7/2USPJINhvZ5Gem8T9IL0k07TSZ5YwefqMpQMJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296285; c=relaxed/simple;
	bh=FofydQ0MqcUu4QUKuNWAbs4463NgNMQkYNYWs2GXYpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7W4ElGhBC0pYp+kty3diIXgPnDDyuqJaB3BtiXNY5TqUrqrtje2HVJamYJ3hKr8DIYJjjM+XlzMkPQcI7iSZfm0Eo2InngL1ISm5S1XS3RwJwN0tpHiA4v6RQea/cSCrlRKUvP/WYLMlIZp9YFf192vhpMPbdO+aAnoI7PtIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=oLu2Qefl; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:471f:0:640:4191:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5FFBD6098C;
	Thu, 10 Apr 2025 17:43:25 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown [2a02:6bf:8011:f00:b4e7:8a36:c937:5b33])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id DhgIQB0FcOs0-8VjmymBb;
	Thu, 10 Apr 2025 17:43:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1744296204;
	bh=RtmbY1O4gA6c7i1Ndxbg5C95RljS2ohwn8hEdg8s/Fk=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=oLu2QeflYWoU3yDnQkLy0nlzl6w0TGUttjzqc43F0I+5Uz/v1XmBjmsKh1z5KSMHU
	 uAPFGAWjYQ3KwP09g13kGbdlWxztaMHvjwF48V82HRWyMnCyu2YrR0/4E4S/2LYmoV
	 EYPB/eD/NA/w5pFUa0JenOzT4bRj+w+BXaQNN7ek=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: stable@vger.kernel.org
Cc: davydov-max@yandex-team.ru,
	Ingo Molnar <mingo@kernel.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6.1.y] x86/split_lock: Fix the delayed detection logic
Date: Thu, 10 Apr 2025 17:43:09 +0300
Message-Id: <20250410144309.93864-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c929d08df8bee855528b9d15b853c892c54e1eee upstream.

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
---
 arch/x86/kernel/cpu/intel.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b91f3d72bcdd..2c43a1423b09 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1204,7 +1204,13 @@ static void __split_lock_reenable(struct work_struct *work)
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
@@ -1225,7 +1231,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work;
+	struct delayed_work *work = NULL;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -1247,11 +1253,17 @@ static void split_lock_warn(unsigned long ip)
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
2.34.1


