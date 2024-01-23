Return-Path: <stable+bounces-13110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D3837A8B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B13D28FBAD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554112F592;
	Tue, 23 Jan 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IH8EsA6R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739412CDB0;
	Tue, 23 Jan 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968991; cv=none; b=qQ5yOi5JJHXfEIF4fG6n3/JkDEIIyQQ64dvh0+CfHBKEI4nUe4ev72V4Tz8ZdUf8ELDL48sg6gwMYEyvnS1i8EAXMMKvnpXOE+OyFExmwppTjLEZ5qSrUQUWSc6eASehtqS7Zk9r+HkRRWoku+5frZ/wUfG1UYO1KSw+0+sZ/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968991; c=relaxed/simple;
	bh=bEQYW3E4Z75j0picskT0J6xiUmDIuM+vSTB1HVwj+Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQpGg5S0MwHhkb9gYl8sm73jeLvt6ziKl6iLIP+MjI7V2qUx1ctaroLptH/q6Ye5XtynwseWLM5f2PxfbF+wTf94hrIogcafJ9HHrO1LPB1cho13BD1Lcu/9/tvuCpAlfpJFVTNZ6C6bEcnfYSipEGHAfekICAQQzIn7i+dQb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IH8EsA6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546FEC43390;
	Tue, 23 Jan 2024 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968991;
	bh=bEQYW3E4Z75j0picskT0J6xiUmDIuM+vSTB1HVwj+Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IH8EsA6RckI+ovda6hrAPRIxn/2zSIDMo7ZL56Av5g/o46dkrHqs4l622srLm26VS
	 dXWs/a43hj8aDl4945eclj1A0W9E/hC8aqSob4ul69birEj7Jhrzcj+c6vFudulKJu
	 /CTHBPVEBd4F8NgkomB35JiYSxmxG27c/LZfFR0w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 5.4 146/194] tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug
Date: Mon, 22 Jan 2024 15:57:56 -0800
Message-ID: <20240122235725.496781835@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09 upstream.

When offlining and onlining CPUs the overall reported idle and iowait
times as reported by /proc/stat jump backward and forward:

cpu  132 0 176 225249 47 6 6 21 0 0
cpu0 80 0 115 112575 33 3 4 18 0 0
cpu1 52 0 60 112673 13 3 1 2 0 0

cpu  133 0 177 226681 47 6 6 21 0 0
cpu0 80 0 116 113387 33 3 4 18 0 0

cpu  133 0 178 114431 33 6 6 21 0 0 <---- jump backward
cpu0 80 0 116 114247 33 3 4 18 0 0
cpu1 52 0 61 183 0 3 1 2 0 0        <---- idle + iowait start with 0

cpu  133 0 178 228956 47 6 6 21 0 0 <---- jump forward
cpu0 81 0 117 114929 33 3 4 18 0 0

Reason for this is that get_idle_time() in fs/proc/stat.c has different
sources for both values depending on if a CPU is online or offline:

- if a CPU is online the values may be taken from its per cpu
  tick_cpu_sched structure

- if a CPU is offline the values are taken from its per cpu cpustat
  structure

The problem is that the per cpu tick_cpu_sched structure is set to zero on
CPU offline. See tick_cancel_sched_timer() in kernel/time/tick-sched.c.

Therefore when a CPU is brought offline and online afterwards both its idle
and iowait sleeptime will be zero, causing a jump backward in total system
idle and iowait sleeptime. In a similar way if a CPU is then brought
offline again the total idle and iowait sleeptimes will jump forward.

It looks like this behavior was introduced with commit 4b0c0f294f60
("tick: Cleanup NOHZ per cpu data on cpu down").

This was only noticed now on s390, since we switched to generic idle time
reporting with commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time()
and corresponding code").

Fix this by preserving the values of idle_sleeptime and iowait_sleeptime
members of the per-cpu tick_sched structure on CPU hotplug.

Fixes: 4b0c0f294f60 ("tick: Cleanup NOHZ per cpu data on cpu down")
Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240115163555.1004144-1-hca@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/tick-sched.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1397,13 +1397,18 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
 
+	idle_sleeptime = ts->idle_sleeptime;
+	iowait_sleeptime = ts->iowait_sleeptime;
 	memset(ts, 0, sizeof(*ts));
+	ts->idle_sleeptime = idle_sleeptime;
+	ts->iowait_sleeptime = iowait_sleeptime;
 }
 #endif
 



