Return-Path: <stable+bounces-237077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NMbK2Ug3WneaAkAu9opvQ
	(envelope-from <stable+bounces-237077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:57:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D33F0522
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92D09309BB2A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A29130C359;
	Mon, 13 Apr 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vTHJSYpM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C1307AC7;
	Mon, 13 Apr 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098528; cv=none; b=kQ2v7EY5wz/ytjVNmTHUKXK04me6TplzsoA50JSQ/YsYj5LBXhpsIJEOai9tdy7l8NvqgTCKhwumXYg07pdovI3ehE3viRhdWKNp9r146mE3HuIutpFL7//0pal9OhYL07UH8LrCtS2BID0Mgc8xaPQypGXiQpI90h2sekch/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098528; c=relaxed/simple;
	bh=fykuKx+Utz7rd7t7CZmQwqw2MnLMEQObMNXsR6jcyTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfDMuXBRYKzxgMWnaJym2E/L0/i1HB2b73A7alOnOkZU65e5VQqIbnBivIWh2+9dx0Ku3w7fXfjaLFVBQaWRSU9h4XZh52g9iRWx9xqP88rf2MCoPXNrb0N3FQL/NEMMWxYyHYmbUf0JZbTwF+3HvyKRcFTylUYAWR9iTaBOXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vTHJSYpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F679C2BCAF;
	Mon, 13 Apr 2026 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098527;
	bh=fykuKx+Utz7rd7t7CZmQwqw2MnLMEQObMNXsR6jcyTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vTHJSYpM6vI/7jxCOHJyuTcdSjsNBVOqejm+OUxBENAMiQ+5fFcIfF/vPuXDmCv4e
	 8Fy+k5+E1iZGt07SjWIfOLXw3xM1NSHrw1vQJdpz+TqLTS5Kk6jY3y7I7Zl9fbZ0yv
	 uOPkVQTqlW4KhB9dx4xhKCgJjY+BSYh6bAviQSbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	mathieu.desnoyers@efficios.com,
	zhang.run@zte.com.cn,
	yang.tao172@zte.com.cn,
	ran.xiaokai@zte.com.cn,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Luo Haiyang <luo.haiyang@zte.com.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 560/570] tracing: Fix potential deadlock in cpu hotplug with osnoise
Date: Mon, 13 Apr 2026 18:01:31 +0200
Message-ID: <20260413155851.449717833@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237077-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,efficios.com:email,zte.com.cn:email]
X-Rspamd-Queue-Id: 958D33F0522
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1620,8 +1620,8 @@ static void osnoise_hotplug_workfn(struc
 	if (!osnoise_busy)
 		goto out_unlock_trace;
 
-	mutex_lock(&interface_lock);
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	if (!cpu_online(cpu))
 		goto out_unlock;
@@ -1634,8 +1634,8 @@ static void osnoise_hotplug_workfn(struc
 	start_kthread(cpu);
 
 out_unlock:
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 out_unlock_trace:
 	mutex_unlock(&trace_types_lock);
 }
@@ -1772,16 +1772,16 @@ osnoise_cpus_write(struct file *filp, co
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



