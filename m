Return-Path: <stable+bounces-231262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJv5G7LDymmL/wUAu9opvQ
	(envelope-from <stable+bounces-231262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:40:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F435FD55
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E6FC302D10B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375182FD7D3;
	Mon, 30 Mar 2026 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2AqdBS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D73939BC
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895863; cv=none; b=oBykRb8bVFepVpxv3n4StFh7EuF6Mkx9sQI7p+MYx1+/UW/RULT5oIYJ7jkJbKuv1tZ/wWtgKeuGQRNM1XKNP6OSvwlRMfrPFCt00AO+Wnhs5T3PKLu0H7rOXUMTFvDcX0u7FQo0S6zSlamzX9ZEa2O4Wgu2Sl9a80LNGRiF2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895863; c=relaxed/simple;
	bh=RJkQrMB7pQepheHQ0DQOJsBYT6CADPChA0Jy5HCWB8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfZFiEq7LipR1Z2ELX+yemus5xII3zXeGEUuD1JCVCPR/v4rH5gSg6JRQLoL54ztWzuLfQvxmepThsXWvp6BCCA+vQt8MP/R6jHLK6o492yXTOmLw07tLgo/7i01EgRX+0kiUEnuRQO6QIH0O5OFtmuNdIlumLpNMIxEnSxJWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2AqdBS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0ACC4CEF7;
	Mon, 30 Mar 2026 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774895862;
	bh=RJkQrMB7pQepheHQ0DQOJsBYT6CADPChA0Jy5HCWB8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2AqdBS9vSH6aOLfJH8MgKYIQUFXcTeBNBA+Y5uApjLuxU2YnI08xKh8OyDkacIqP
	 e/X9oFiC2xOAdvJaM7x07+5LLiXcEw3JpRAo01K6ROMY0ZkVEeadXdNIqkvIZdBv64
	 g8FaWVdjWo1lzeyS2nZ5rtQvIdJ3LFTwIsDSqt7OSlmStQAvk5VD6zFs84pJmaRWIy
	 GXOGoHQIkQ2emJP1GYWBf3prjxtpTbvVYTn2Vh013n4ToaMf8cjtBeeezVDo9gaC3G
	 h+5jwfZgMcwIF75FrT0Nh9GTNmWxLjPUM94NgFMm/Y4qZkiYqsU33ue7+B0kIdoMG5
	 F6zHwV22J+0hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luo Haiyang <luo.haiyang@zte.com.cn>,
	mathieu.desnoyers@efficios.com,
	zhang.run@zte.com.cn,
	yang.tao172@zte.com.cn,
	ran.xiaokai@zte.com.cn,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing: Fix potential deadlock in cpu hotplug with osnoise
Date: Mon, 30 Mar 2026 14:37:39 -0400
Message-ID: <20260330183739.934195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032953-disinfect-spinning-5c06@gregkh>
References: <2026032953-disinfect-spinning-5c06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231262-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:email]
X-Rspamd-Queue-Id: B33F435FD55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luo Haiyang <luo.haiyang@zte.com.cn>

[ Upstream commit 1f9885732248d22f788e4992c739a98c88ab8a55 ]

The following sequence may leads deadlock in cpu hotplug:

    task1        task2        task3
    -----        -----        -----

 mutex_lock(&interface_lock)

            [CPU GOING OFFLINE]

            cpus_write_lock();
            osnoise_cpu_die();
              kthread_stop(task3);
                wait_for_completion();

                      osnoise_sleep();
                        mutex_lock(&interface_lock);

 cpus_read_lock();

 [DEAD LOCK]

Fix by swap the order of cpus_read_lock() and mutex_lock(&interface_lock).

Cc: stable@vger.kernel.org
Cc: <mathieu.desnoyers@efficios.com>
Cc: <zhang.run@zte.com.cn>
Cc: <yang.tao172@zte.com.cn>
Cc: <ran.xiaokai@zte.com.cn>
Fixes: bce29ac9ce0bb ("trace: Add osnoise tracer")
Link: https://patch.msgid.link/20260326141953414bVSj33dAYktqp9Oiyizq8@zte.com.cn
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ adapted guard() macros to lock/unlock calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_osnoise.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e5929cb3840f4..676d9a3e65cde 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1809,8 +1809,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	if (!osnoise_has_registered_instances())
 		goto out_unlock_trace;
 
-	mutex_lock(&interface_lock);
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	if (!cpu_online(cpu))
 		goto out_unlock;
@@ -1820,8 +1820,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	start_kthread(cpu);
 
 out_unlock:
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 out_unlock_trace:
 	mutex_unlock(&trace_types_lock);
 }
@@ -1950,16 +1950,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (running)
 		stop_per_cpu_kthreads();
 
-	mutex_lock(&interface_lock);
 	/*
 	 * osnoise_cpumask is read by CPU hotplug operations.
 	 */
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
 
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 
 	if (running)
 		start_per_cpu_kthreads();
-- 
2.53.0


