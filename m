Return-Path: <stable+bounces-242307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGD3N+aI9GnFCAIAu9opvQ
	(envelope-from <stable+bounces-242307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:05:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC54ABE0C
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FDF7300A598
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCE39B496;
	Fri,  1 May 2026 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tddYg/9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8839B971
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633453; cv=none; b=K2/EpJUCOmujQoYd2gum2RzqyMcRl5TNWxah3cUYTC9D1noFXJPbZioRP0nUWdolRsSRxLk9sT2AGCyDsFgodiAzb/o5za7fg0dA5fQGASgj+1+kr9xC1uk0hFAKajfkIBef2fK2ikvdXKoKiGHfDnL0MZsbQU1VS+caj2FG+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633453; c=relaxed/simple;
	bh=FnQfc3aCs1nYdh63mf0LUwt4RRfYzwmXkNMxlHNUrTs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bcjZ8IIK5zTjlUfa9qxdDGoCQdMqp/fyL/DMKXXoFtyJHZ6kKc/KInfeWCU1WCgSZY44jIEbtfZfOr2mqPxxF4X/MwtvToVQhYlHtF/Bmg9CEZyc1OOeFBwlMnBbezvF6pGia5U3zdOxFMAvH9iJrkcvaZ7IDFeJvvIbn41V72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tddYg/9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEFEC2BCB7;
	Fri,  1 May 2026 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633452;
	bh=FnQfc3aCs1nYdh63mf0LUwt4RRfYzwmXkNMxlHNUrTs=;
	h=Subject:To:Cc:From:Date:From;
	b=tddYg/9rACheLZulXk8CyCJ6hGL/3SlujCnxVnrT1CuwfXOUWRsbCAhphwT7n3ret
	 4PeUXxffl+y/HEqKPJttsuBZ1/IomQBONJ3F/qUkzHJpy3/sqxRuJF3+zk/bvuQunI
	 gInfVy2pVxOyMFYNHrF8ccmDWnm8KZGAOGfZ82E4=
Subject: FAILED: patch "[PATCH] sched: Use u64 for bandwidth ratio calculations" failed to apply to 6.1-stable tree
To: joseph.salisbury@oracle.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:04:00 +0200
Message-ID: <2026050100-bonded-fled-538b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6BC54ABE0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242307-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,gregkh:email,msgid.link:url,infradead.org:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c6e80201e057dfb7253385e60bf541121bf5dc33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-bonded-fled-538b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6e80201e057dfb7253385e60bf541121bf5dc33 Mon Sep 17 00:00:00 2001
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Date: Fri, 3 Apr 2026 17:00:14 -0400
Subject: [PATCH] sched: Use u64 for bandwidth ratio calculations

to_ratio() computes BW_SHIFT-scaled bandwidth ratios from u64 period and
runtime values, but it returns unsigned long.  tg_rt_schedulable() also
stores the current group limit and the accumulated child sum in unsigned
long.

On 32-bit builds, large bandwidth ratios can be truncated and the RT
group sum can wrap when enough siblings are present.  That can let an
overcommitted RT hierarchy pass the schedulability check, and it also
narrows the helper result for other callers.

Return u64 from to_ratio() and use u64 for the RT group totals so
bandwidth ratios are preserved and compared at full width on both 32-bit
and 64-bit builds.

Fixes: b40b2e8eb521 ("sched: rt: multi level group constraints")
Assisted-by: Codex:GPT-5
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260403210014.2713404-1-joseph.salisbury@oracle.com

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c15c9865299e..49cd5d217161 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4735,7 +4735,7 @@ void sched_post_fork(struct task_struct *p)
 	scx_post_fork(p);
 }
 
-unsigned long to_ratio(u64 period, u64 runtime)
+u64 to_ratio(u64 period, u64 runtime)
 {
 	if (runtime == RUNTIME_INF)
 		return BW_UNIT;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4e5f1957b91b..a48e86794913 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2666,7 +2666,7 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 {
 	struct rt_schedulable_data *d = data;
 	struct task_group *child;
-	unsigned long total, sum = 0;
+	u64 total, sum = 0;
 	u64 period, runtime;
 
 	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9594355a3681..c95584191d58 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2907,7 +2907,7 @@ extern void init_cfs_throttle_work(struct task_struct *p);
 #define MAX_BW_BITS		(64 - BW_SHIFT)
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
 
-extern unsigned long to_ratio(u64 period, u64 runtime);
+extern u64 to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);


