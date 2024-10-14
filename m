Return-Path: <stable+bounces-84853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3699D265
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D25BB266C7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ACC15D5C5;
	Mon, 14 Oct 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvfF9un9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7F1798C;
	Mon, 14 Oct 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919445; cv=none; b=jWcXs/oh25j689HXdHan8RZzteNBycQ+ILQaYhOtsUSiJ6pdTWj69YXwd/AIIRifRzYZQGX4zBHRgUJkXEwJ5oTeAJ6nVkAUpv416BXTuVsjBBChCr9jkpaYb5xLzvkdYcL6ofodHHUJBzaDmdurZcZ7Hj8/D+gWuegj7CfFexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919445; c=relaxed/simple;
	bh=V9Dl9YkAhafRguG2ZY6ck758MJoTjMjekqc/wv8GBAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2YHxvknp2f0wqDGpcC9bK52jNb/SIO46WKbNk16cyD8IE0r0M81qKuFfrPu0O0M6DfZfppzIH/j5uUcAXqCJ6JkXv7FFEeCGrO3fuuQno4ZKBPibRjPDsQfwYk4qxJxNwz1JC0CP8nLpBk2GVn2/xzy+GXhnUD9zTK5B9TFLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvfF9un9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95519C4CEC7;
	Mon, 14 Oct 2024 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919445;
	bh=V9Dl9YkAhafRguG2ZY6ck758MJoTjMjekqc/wv8GBAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvfF9un9ezsJV99u9HwCQ+xPJbdgBJaIZzXF9dzspHvZnoYXcBL99PRVnnq/5icGG
	 sYTuWmCdmdScae+j3zNEAIPBLqKzbMbvZAr/VSXaF+WZSRG6u/p53u3htkwF2X9KrP
	 0mjaNmhHV80Rxb/rqCwMLg/WVjvW25vmqTdD5+ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Wei Li <liwei391@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 610/798] tracing/hwlat: Fix a race during cpuhp processing
Date: Mon, 14 Oct 2024 16:19:24 +0200
Message-ID: <20241014141241.983163415@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Li <liwei391@huawei.com>

commit 2a13ca2e8abb12ee43ada8a107dadca83f140937 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_hwlat.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -520,6 +520,8 @@ static void hwlat_hotplug_workfn(struct
 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
 		goto out_unlock;
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
 		goto out_unlock;
 



