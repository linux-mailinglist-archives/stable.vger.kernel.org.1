Return-Path: <stable+bounces-231620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WItMDFb6y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:46:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9A36D1A1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A892306E521
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8194218B4;
	Tue, 31 Mar 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTIt28XG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7C2EE262;
	Tue, 31 Mar 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974641; cv=none; b=dsKSB9mD7r3QD1RIf+CkWRMuupIBpdf3CvzuYoksoc2DQPJIDm2NIxBeYzIfZO4VNHQp1zlyhoBRU5vgpbhWBz+0965LNTwZRrdE2nlP/X3+I5OYt5uVLGvg57oen8EisHuOit4908/SPK/VjaPz00BeulSIxK2Qvzu2YufJtF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974641; c=relaxed/simple;
	bh=vVMj8CVdvSN7a3BLZq2/Jog7kakqNEOI2TR04uAUo68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfLGTHkxuh3D5gLMm+JWXJqoJgOaFg/7CzkCPjNLohn67IS9zGL86hykD/muwLDuVB0xZfB6PxRdlsJutcf8g1Kyspn+yye1m7LCR+/KQp+YeHLYn370Dj4P7OLqHDN3xjPAk7zFDOov6CnhKAF4+mCJPfoGxR7Bu1OXcro+bkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTIt28XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD6BC19424;
	Tue, 31 Mar 2026 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974641;
	bh=vVMj8CVdvSN7a3BLZq2/Jog7kakqNEOI2TR04uAUo68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTIt28XGogHeqVYJb4o+6uvSNmJPHRXMgSAfng6wrt/8NZhxkDZ4E6Myzj7MzS7wc
	 5EeKPLXmFqVFcPVyZjWY2wkUO3HfxEz7bOEN6BIbrln+WuoMRMFdPCe1FMCbJVTrdw
	 4J7jJFZ/ExTvKB847z+sKM226rI4QyWOWK1tfnKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 146/175] tracing: Switch trace_osnoise.c code over to use guard() and __free()
Date: Tue, 31 Mar 2026 18:22:10 +0200
Message-ID: <20260331161735.150638764@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231620-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,infradead.org:email,goodmis.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 48F9A36D1A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 930d2b32c0af6895ba4c6ca6404e7f7b6dc214ed ]

The osnoise_hotplug_workfn() grabs two mutexes and cpu_read_lock(). It has
various gotos to handle unlocking them. Switch them over to guard() and
let the compiler worry about it.

The osnoise_cpus_read() has a temporary mask_str allocated and there's
some gotos to make sure it gets freed on error paths. Switch that over to
__free() to let the compiler worry about it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241225222931.517329690@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 1f9885732248 ("tracing: Fix potential deadlock in cpu hotplug with osnoise")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c |   40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2099,26 +2099,21 @@ static void osnoise_hotplug_workfn(struc
 {
 	unsigned int cpu = smp_processor_id();
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (!osnoise_has_registered_instances())
-		goto out_unlock_trace;
+		return;
 
-	mutex_lock(&interface_lock);
-	cpus_read_lock();
+	guard(mutex)(&interface_lock);
+	guard(cpus_read_lock)();
 
 	if (!cpu_online(cpu))
-		goto out_unlock;
+		return;
+
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
-		goto out_unlock;
+		return;
 
 	start_kthread(cpu);
-
-out_unlock:
-	cpus_read_unlock();
-	mutex_unlock(&interface_lock);
-out_unlock_trace:
-	mutex_unlock(&trace_types_lock);
 }
 
 static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
@@ -2316,31 +2311,22 @@ static ssize_t
 osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
 		  loff_t *ppos)
 {
-	char *mask_str;
+	char *mask_str __free(kfree) = NULL;
 	int len;
 
-	mutex_lock(&interface_lock);
+	guard(mutex)(&interface_lock);
 
 	len = snprintf(NULL, 0, "%*pbl\n", cpumask_pr_args(&osnoise_cpumask)) + 1;
 	mask_str = kmalloc(len, GFP_KERNEL);
-	if (!mask_str) {
-		count = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!mask_str)
+		return -ENOMEM;
 
 	len = snprintf(mask_str, len, "%*pbl\n", cpumask_pr_args(&osnoise_cpumask));
-	if (len >= count) {
-		count = -EINVAL;
-		goto out_free;
-	}
+	if (len >= count)
+		return -EINVAL;
 
 	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
 
-out_free:
-	kfree(mask_str);
-out_unlock:
-	mutex_unlock(&interface_lock);
-
 	return count;
 }
 



