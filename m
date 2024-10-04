Return-Path: <stable+bounces-80746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4BA990500
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867D01F22ED0
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF4216A39;
	Fri,  4 Oct 2024 13:56:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35169215F79;
	Fri,  4 Oct 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050188; cv=none; b=LFtk5rkaSEIzJuCEev7QnX1+zvjUBI2vxQf0sJGWOJWgOUXPMfi7U0blrvi/FbzXM7dMurvWLRbPUvSjUNN67JsnyO8lvWjVQsR7hLgk8ugdXxb+RV0xVEDp9+UCx2Zarew7jhluG1fjgo3XoszV90JHum5Ih/652B5v0IKYfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050188; c=relaxed/simple;
	bh=iJWUfcBOjvKfwKKrTHNMffbCW4LAcVM3302EPSIDozA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fa6Z8EviQXJgKs/gMYqXpxCFOvx8UHtWWEUqZKBRTPUXs7oWxlhkpHYYu8AeM64hWIY3k4UoqNQ+43PQWQ0jOGcVhSzVA0IgmqJzT9R7Hnh/41gyyxJGwkAEWQzb0gMM5niOqz1ShW5NT74hRpwvxYot5dLdvP8SL8wi6aGKads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E528CC4CED9;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio8-00000005CBW-1kGh;
	Fri, 04 Oct 2024 09:57:24 -0400
Message-ID: <20241004135724.280243457@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:57:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Wei Li <liwei391@huawei.com>
Subject: [for-linus][PATCH 8/8] tracing/hwlat: Fix a race during cpuhp processing
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Wei Li <liwei391@huawei.com>

The cpuhp online/offline processing race also exists in percpu-mode hwlat
tracer in theory, apply the fix too. That is:

    T1                       | T2
    [CPUHP_ONLINE]           | cpu_device_down()
     hwlat_hotplug_workfn()  |
                             |     cpus_write_lock()
                             |     takedown_cpu(1)
                             |     cpus_write_unlock()
    [CPUHP_OFFLINE]          |
        cpus_read_lock()     |
        start_kthread(1)     |
        cpus_read_unlock()   |

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240924094515.3561410-5-liwei391@huawei.com
Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..3bd6071441ad 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -520,6 +520,8 @@ static void hwlat_hotplug_workfn(struct work_struct *dummy)
 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
 		goto out_unlock;
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
 		goto out_unlock;
 
-- 
2.45.2



