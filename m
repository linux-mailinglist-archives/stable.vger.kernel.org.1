Return-Path: <stable+bounces-27103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE7875588
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEE81F21288
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9E130E23;
	Thu,  7 Mar 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jQuClfT0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B2130E59
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833833; cv=none; b=Yf0KAPu/B/jcieDuT7HiZBZthDC0yARxlcR0s0Tejrhq9oq/vMboDusM6iVAEgWyzj4P9+lGOQ1i+0TAV3PJ4yOgYlamtiKcAKEBRTa466/QLFU23eXv3cUcbMRO2FaMK8ZoJO1lryy1rosdZbbesHFhpMVZ9qLkMXXSYL/0tEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833833; c=relaxed/simple;
	bh=byT1iF0h6fFWAxChGy6K8iEsUtI5d3G/xLow/JKCdtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOOgT6o+4L5nlEILn9FWNUoPyBfBqcA+ysFm9TUeqdxaeOjc5eGS1gBlQgDE9rerAiojrlWw3h7oa8ul3uAbEgmvpr9L714p+ZoG/iebLQCOfRKvFC8zXQUT/zseO7oWXTKBmnNkHdGHkfMA1IPnlHgsq2qalNN1sY/W9VNEYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jQuClfT0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NPs98xlVVTa3YlCxRGPmviXZfgFIjWV0d+v/yaWn6jE=; b=jQuClfT01z46wVfJgHlWq+1YpV
	boZ3q4Wmx1ILsEF9mAZ0wUmIi9rtViWB83RhQLnw2pvyoW449i45GYibZeEXIKpphEZkcUDwMcu03
	okA6qE4Q4bWkdJOfQ0f/Mo+h3KZMjmYWSNckSw3ZWBCtFnH+CRtAXZFXP10wwWWVYFChOXTqaNkLm
	phuMNsloEr+T8O87s4oDuanySmQDBcSdut8MHwk0DFFM0aHEqOCmZWHPx/IudnPOagcszMT9nyDEJ
	ZF020O8x2P6G99K1J+YEK+K3p748XEyTK4tXSnSCmqJUYrBNpWj1zXrOhAiayEGbNqngU8Kv5Dylt
	JnBmpxBg==;
Received: from 179-125-71-231-dinamico.pombonet.net.br ([179.125.71.231] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1riHsw-007Mr8-RY; Thu, 07 Mar 2024 18:50:27 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel-dev@igalia.com
Subject: [PATCH 4.19,5.4,5.10,5.15] perf/core: Fix reentry problem in perf_output_read_group()
Date: Thu,  7 Mar 2024 14:50:15 -0300
Message-Id: <20240307175015.1972330-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

This race may also lead to observed behavior like RCU stalls, hang tasks,
OOM. Likely due to list corruption or a similar root cause.

---
 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4e5a73c7db12..e79cd0fd1d2b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7119,9 +7119,16 @@ static void perf_output_read_group(struct perf_output_handle *handle,
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
@@ -7157,6 +7164,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
+
+	local_irq_restore(flags);
 }
 
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
-- 
2.34.1


