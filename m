Return-Path: <stable+bounces-231231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oICVJuKHymn09gUAu9opvQ
	(envelope-from <stable+bounces-231231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:25:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA335CC6C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F9F3048577
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0D3A6B9E;
	Mon, 30 Mar 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj7yf0tv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE4383C79
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880290; cv=none; b=hfJqdo8dlg+bENWDc/FonjD1CCudGO6qzOJnHvrKQAKkF2wEuNGPCEA6xTW8mBQC+2XF9/j6QX5OnetP9erCyKBSaLdQf2HI9SjlnIvEkLzlaiFEzpuHJluJ44J9AWtbyoVlgfU52xpR5VSvEgzLCeplc1BNVrgc0pUrIBoXUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880290; c=relaxed/simple;
	bh=yMLL4eZ1IZjR31caId07J3j0PwrZ1v8ccxXM5nCH8+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMYEtEez5GUnkGT2ZdkFVpD3RbYdxi6IElWxpiP5aSF4zDu7EnGNhWk4lpLRRvTCiChkq4fjpRLg9+81fsY5NpaqBGMXSk2lHzOYaxA3kVY3Yk6BJ0E3C946S0wt4VVJ1y80KHS/co3Jrw6NJWeDBmjKDjU00GiKKlfsDl3Nj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj7yf0tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43521C19423;
	Mon, 30 Mar 2026 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880290;
	bh=yMLL4eZ1IZjR31caId07J3j0PwrZ1v8ccxXM5nCH8+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jj7yf0tvrgUFkv8XRehpW3emfe/5qym9tpAhK0AB5E3pgAnVDSc6Kk+7ivJ4qUwMb
	 QKBAIo2OSZkOBd/9KEeS/f+uCpqyAWYJxwl7r3KPo9HCsIXujDWDp25OZBqvhHzipN
	 nfKlTXiygZ72DySFtV/1teOKUQ0g2dk8fBWAT6t8udarwXH8dTkkvTMVBjmKyuWGdw
	 ORK8abFU0ldCkzS/PQDr2cp9ZGi6BZLbEPqQC+gZwMN8CGGCnrLZVyndpcdEU/z/4H
	 bAgSVbbbpFFJfGZCMAdbbVueAsPSccMhR48pFbuhu3/FfWwUfuFIeoskFxXM8qRJWR
	 cvK/JCchV5vpQ==
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
Subject: [PATCH 6.12.y 2/2] tracing: Fix potential deadlock in cpu hotplug with osnoise
Date: Mon, 30 Mar 2026 10:18:06 -0400
Message-ID: <20260330141806.817242-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330141806.817242-1-sashal@kernel.org>
References: <2026032952-shredding-snorkel-3530@gregkh>
 <20260330141806.817242-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231231-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5DA335CC6C
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 412ca1efa956e..7d96be13367f3 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2104,8 +2104,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	if (!osnoise_has_registered_instances())
 		return;
 
-	guard(mutex)(&interface_lock);
 	guard(cpus_read_lock)();
+	guard(mutex)(&interface_lock);
 
 	if (!cpu_online(cpu))
 		return;
@@ -2268,11 +2268,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 	if (running)
 		stop_per_cpu_kthreads();
 
-	mutex_lock(&interface_lock);
 	/*
 	 * avoid CPU hotplug operations that might read options.
 	 */
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	retval = cnt;
 
@@ -2288,8 +2288,8 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 			clear_bit(option, &osnoise_options);
 	}
 
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 
 	if (running)
 		start_per_cpu_kthreads();
@@ -2375,16 +2375,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
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


