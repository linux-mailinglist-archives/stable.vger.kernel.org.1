Return-Path: <stable+bounces-232403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBMZLZcHzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7D36F2DC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97EB130C622F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDECD3009C7;
	Tue, 31 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUY01rcB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9E2FE042;
	Tue, 31 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976657; cv=none; b=DGRCiT4rKrZk/xtoF07dT2ECX4idnrrTx1gDPxfiD4mTNo0UNCyLKR6ElTS07k1CdaLjni24knaWt3lQkVEGV7mveacnQgxA6vu9hxV4Op0NIchAg9AVQQ7xWI8uwaTooJ6ycOwosaJfijbwIwNr8vTVQlTcQcPhlaPDDNtErkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976657; c=relaxed/simple;
	bh=EYSShiSVo6SLntcp+/X6iQY0ObyWc89XPWp1JKayZjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvsAMvfzGevoip76NwPPu2O07K7onxDU2Ox1qRIGOEK76CtfkMQvYnN/cwlMlNqDNQpMkwxLdsrTSYd9ANSy49bUNg40gVA91pQepdlR5Uauke8ZTnxCxSo8GCrbBj+VKse5jAsVpNxir2K5xIrcNwfJJ6qLFStKOOYjZJts4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUY01rcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC55DC19423;
	Tue, 31 Mar 2026 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976657;
	bh=EYSShiSVo6SLntcp+/X6iQY0ObyWc89XPWp1JKayZjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zUY01rcBFVgU+aYtPcv328+aG6k6uxFlfz/2cpbZ80P+ghrff9vIjbGBMAY8JAiPT
	 6ANWlDtfUlEWKKtHnSi9PmM/G6IykmAGtWHZXXILWdrezOZpo60//tgZdszO58KRHi
	 +wyZphIhGp0xSVL1R8o9GGTqLZgiuI8L0DEtyHjU=
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.18 178/309] tracing: Fix potential deadlock in cpu hotplug with osnoise
Date: Tue, 31 Mar 2026 18:21:21 +0200
Message-ID: <20260331161800.016931002@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232403-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,goodmis.org:email,efficios.com:email,zte.com.cn:email]
X-Rspamd-Queue-Id: 1EB7D36F2DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luo Haiyang <luo.haiyang@zte.com.cn>

commit 1f9885732248d22f788e4992c739a98c88ab8a55 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2073,8 +2073,8 @@ static void osnoise_hotplug_workfn(struc
 	if (!osnoise_has_registered_instances())
 		return;
 
-	guard(mutex)(&interface_lock);
 	guard(cpus_read_lock)();
+	guard(mutex)(&interface_lock);
 
 	if (!cpu_online(cpu))
 		return;
@@ -2237,11 +2237,11 @@ static ssize_t osnoise_options_write(str
 	if (running)
 		stop_per_cpu_kthreads();
 
-	mutex_lock(&interface_lock);
 	/*
 	 * avoid CPU hotplug operations that might read options.
 	 */
 	cpus_read_lock();
+	mutex_lock(&interface_lock);
 
 	retval = cnt;
 
@@ -2257,8 +2257,8 @@ static ssize_t osnoise_options_write(str
 			clear_bit(option, &osnoise_options);
 	}
 
-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();
 
 	if (running)
 		start_per_cpu_kthreads();
@@ -2345,16 +2345,16 @@ osnoise_cpus_write(struct file *filp, co
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



