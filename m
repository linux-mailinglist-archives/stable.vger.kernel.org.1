Return-Path: <stable+bounces-230854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OObaAW/SyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:19:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B912351053
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9ED93006135
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6D29D281;
	Sun, 29 Mar 2026 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snpAhVOS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5E22D4DC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768748; cv=none; b=IUYYVnNy+xvk1XuO1lf5hqWaa4YnaXs1t/0t+Iv7+5NxnXG1FaRbp1u8HL4/E4D0HGXCi787fsuzRtSRMwql6sb6g4QDiJJ5U0jxOKQGYw/OUwSCLZpRYiOH4LlDGrYVgqwgjP+4n5IfUFXmccbzB0WLSFFeAgWMaIkUZLCBDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768748; c=relaxed/simple;
	bh=udzKz5N/9NrXpiZUpAuPEYawJrPemkEgbcar5777UVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZvT0j+hPUmO8k0kFDUeKcsFk+pW5qtrY9U+6FPaW6vjz116EG6iufshSLfrf9U6HmurCZt3g6IciF7oURTVj2+AJeFh8FwVyOb/eZnIwwWedWP1og4lK9ulfotDWGBSSwjAJ9IqxIIe3A6EWoxneQDjk+vDMJxtg/UvIKGt1SpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snpAhVOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA09FC116C6;
	Sun, 29 Mar 2026 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774768748;
	bh=udzKz5N/9NrXpiZUpAuPEYawJrPemkEgbcar5777UVE=;
	h=Subject:To:Cc:From:Date:From;
	b=snpAhVOSEkzyOefX9/NMa0nWzBvUOEhXDxCDaXlkr0I65Q6ZMgmOFTIyjOmu7TMoc
	 Y1SsyjZ4tNT41wNVh8PlfA3FtN3tqDqlr6O/1Xz89xAFSlNt+xUzwHoMrUHl/X0htM
	 n/+J9bZl+jP6PFkDmKK1H+v737fQPNkY1S64Dj4Q=
Subject: FAILED: patch "[PATCH] tracing: Fix potential deadlock in cpu hotplug with osnoise" failed to apply to 6.6-stable tree
To: luo.haiyang@zte.com.cn,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,ran.xiaokai@zte.com.cn,rostedt@goodmis.org,yang.tao172@zte.com.cn,zhang.run@zte.com.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:18:53 +0200
Message-ID: <2026032953-garnet-dropout-ed0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230854-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,efficios.com:email,msgid.link:url,goodmis.org:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B912351053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1f9885732248d22f788e4992c739a98c88ab8a55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032953-garnet-dropout-ed0f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f9885732248d22f788e4992c739a98c88ab8a55 Mon Sep 17 00:00:00 2001
From: Luo Haiyang <luo.haiyang@zte.com.cn>
Date: Thu, 26 Mar 2026 14:19:53 +0800
Subject: [PATCH] tracing: Fix potential deadlock in cpu hotplug with osnoise

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

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index dee610e465b9..be6cf0bb3c03 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2073,8 +2073,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	if (!osnoise_has_registered_instances())
 		return;
 
-	guard(mutex)(&interface_lock);
 	guard(cpus_read_lock)();
+	guard(mutex)(&interface_lock);
 
 	if (!cpu_online(cpu))
 		return;
@@ -2237,11 +2237,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 	if (running)
 		stop_per_cpu_kthreads();
 
-	mutex_lock(&interface_lock);
 	/*
 	 * avoid CPU hotplug operations that might read options.
 	 */
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	retval = cnt;
 
@@ -2257,8 +2257,8 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 			clear_bit(option, &osnoise_options);
 	}
 
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 
 	if (running)
 		start_per_cpu_kthreads();
@@ -2345,16 +2345,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
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


