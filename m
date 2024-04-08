Return-Path: <stable+bounces-37626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B655D89C673
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37310B2BB9A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5637F470;
	Mon,  8 Apr 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vp10MOs3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28F7E0FF;
	Mon,  8 Apr 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584785; cv=none; b=kP4Er9tPX0aVvelI7LyQx2J8VyuoISnd3LIM8xz55ZfXdZFaGeybxpYx0EbSuh6MkUiQsoiNZjzngILKYwSSNtcoW1yqtWKKvEgkGyFoaUt8IR9l4L3N8O6bddcvYIeIgaiH+4JKQV7jTdI+RlrqdcqhmO0U6bAylJsVBpshm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584785; c=relaxed/simple;
	bh=UVWZXM5vGhM0RTB9BV24TkwWi4En8rbrS9ieM+E8VKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGzxT5XaQUqiJh9fAQdj3mRI7ygttLSrJ7+sCWDXIPduefA1E61+MsLhC3aMlU+pR4826mH83i5anXtOKyBtgQEErH6RhqLESz7t8oBL5EJjJRYIs707MjIUBs56Q5u7XzR2dMecPbe38DdGOBEUx+6uyBZduGOtHbLKWybCXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vp10MOs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C91C43399;
	Mon,  8 Apr 2024 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584785;
	bh=UVWZXM5vGhM0RTB9BV24TkwWi4En8rbrS9ieM+E8VKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vp10MOs3BKfc4QWdaREEK+IOkqnGWd+bGLvVUPNPapxHjT0fOJceQiaFC9OYnz2Fx
	 bFnTMvHdRtHs3XiFAzJLh3PYbmQGNu8PkuGhE05H9z5mbPUeJ8WDIgGeueMg5jO445
	 LEua8uXFd7zCtBjMohAdepyoJDTuinilgiK8zr3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Jihong <yangjihong1@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 557/690] perf/core: Fix reentry problem in perf_output_read_group()
Date: Mon,  8 Apr 2024 14:57:03 +0200
Message-ID: <20240408125419.799173871@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Jihong <yangjihong1@huawei.com>

commit 6b959ba22d34ca793ffdb15b5715457c78e38b1a upstream.

perf_output_read_group may respond to IPI request of other cores and invoke
__perf_install_in_context function. As a result, hwc configuration is modified.
causing inconsistency and unexpected consequences.

Interrupts are not disabled when perf_output_read_group reads PMU counter.
In this case, IPI request may be received from other cores.
As a result, PMU configuration is modified and an error occurs when
reading PMU counter:

		     CPU0                                         CPU1
						      __se_sys_perf_event_open
							perf_install_in_context
  perf_output_read_group                                  smp_call_function_single
    for_each_sibling_event(sub, leader) {                   generic_exec_single
      if ((sub != event) &&                                   remote_function
	  (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
  <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
  __perf_install_in_context
    ctx_resched
      event_sched_out
	armpmu_del
	  ...
	  hwc->idx = -1; // event->hwc.idx is set to -1
  ...
  <exit IPI>
	      sub->pmu->read(sub);
		armpmu_read
		  armv8pmu_read_counter
		    armv8pmu_read_hw_counter
		      int idx = event->hw.idx; // idx = -1
		      u64 val = armv8pmu_read_evcntr(idx);
			u32 counter = ARMV8_IDX_TO_COUNTER(idx); // invalid counter = 30
			read_pmevcntrn(counter) // undefined instruction

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220902082918.179248-1-yangjihong1@huawei.com
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7119,9 +7119,16 @@ static void perf_output_read_group(struc
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
+	unsigned long flags;
 	u64 values[6];
 	int n = 0;
 
+	/*
+	 * Disabling interrupts avoids all counter scheduling
+	 * (context switches, timer based rotation and IPIs).
+	 */
+	local_irq_save(flags);
+
 	values[n++] = 1 + leader->nr_siblings;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -7157,6 +7164,8 @@ static void perf_output_read_group(struc
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
+
+	local_irq_restore(flags);
 }
 
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\



