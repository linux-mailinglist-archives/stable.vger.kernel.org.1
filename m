Return-Path: <stable+bounces-231276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCPZDCLmymloBAYAu9opvQ
	(envelope-from <stable+bounces-231276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:07:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C3E361435
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FC913018417
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA539D6CE;
	Mon, 30 Mar 2026 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7mpSTkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67D39B964
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904860; cv=none; b=PX4RdXan21ec5IIivMidytTgozZ1F39CqhzTEKo9F/juiff995ObERXu36zE8n8tppRW8AO9fxwb1mcx218XcVZmLdIHGvbLpzZQ6QQLbDMpFKegFV+/fx3W7FoWpyN4sf8vjmex+BhoiBzxrHjh4QVIPqiOjdliURuCifzuhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904860; c=relaxed/simple;
	bh=s/OCvbvYWO04qQ9nXf19LG8CveRke/ugB6HZYecF71U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCVRdJldLHdFghkZEpWRNG76h2QKxvl4LTlD6CdNIRdiYOWDYIvx13yW1uWWsTY0tIPIZuXHcld9AdhWg7epcgAV1iUN7+jQIMVkGUvJhdXTbkAJvIACY4206rJIP2ybPWtI7B3yiJb7a3Ku4LrqIpPMkwuts8BJIbViqan/a5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7mpSTkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69EC4CEF7;
	Mon, 30 Mar 2026 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774904860;
	bh=s/OCvbvYWO04qQ9nXf19LG8CveRke/ugB6HZYecF71U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7mpSTkcmVL8LqVy3Akb7vQCwZxD4QPkZAHwMGDmwiaQHos0CP6XQnOk9nXNmp3M1
	 VE1d7ugUuEK+t0uhdBi24dw7LqNRyov2YnBAj2lWNOgHLBxEFDAm6e3mS508/Xsdh3
	 Zf8+w7begAVNX2nbWw6KdYE9i35mAsdMaVm69Vh6QB3J65h2xEEeT5MZAbgZljMCBA
	 QT6fDzjpxgUSJ1Y86Vm2DyVRahf67CrpdL61P5QGcC9hQpdcj2nZ6b6u9ynpaNnIqu
	 cHePsC3TsAljCGkeonfXfAYmeNN4p4Phe6eTQmBnnMaRSJ6z0jN6SqVisjM8Fay4+7
	 9B+E9XqaVk+Qw==
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
Subject: [PATCH 5.15.y] tracing: Fix potential deadlock in cpu hotplug with osnoise
Date: Mon, 30 Mar 2026 17:07:37 -0400
Message-ID: <20260330210737.1213194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032954-repossess-ascension-613b@gregkh>
References: <2026032954-repossess-ascension-613b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231276-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84C3E361435
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
index 5959b1d4ee459..66061e77cc514 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1620,8 +1620,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	if (!osnoise_busy)
 		goto out_unlock_trace;
 
-	mutex_lock(&interface_lock);
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	if (!cpu_online(cpu))
 		goto out_unlock;
@@ -1634,8 +1634,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	start_kthread(cpu);
 
 out_unlock:
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 out_unlock_trace:
 	mutex_unlock(&trace_types_lock);
 }
@@ -1772,16 +1772,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (running)
 		osnoise_tracer_stop(tr);
 
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
 		osnoise_tracer_start(tr);
-- 
2.53.0


