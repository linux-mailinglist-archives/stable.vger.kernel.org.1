Return-Path: <stable+bounces-242308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKBZL+iI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:05:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB814ABE13
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 787F5300C391
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD739B96A;
	Fri,  1 May 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wd9M+9JH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42239B488
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633456; cv=none; b=GtN739+uqzogZl3okEchGJtTLspPrl2j14iyKi4Um+o0ytDApj7+SohPtEtI0ief7jG9yHX3fhjY2eb2HNHtHzxyWPnzL2MMexobA/Gm5lpO7pAbSTQgcWVP7ZDd0IjiATAzwPTMWNFbEthyErhMToOYQLZtn+b/nVXpPFWb6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633456; c=relaxed/simple;
	bh=zzcmP6NlsR0l5z0Keg5IKgVFt/WrwpV4xmdCsr997Vk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wc6Rpdz/33pxgO1XdciQb05rhBhxkAKmN2uyrMOYT3owaK1COYH8SHaP3w8WfT/z9AlRe+CI4EY8t2rukimGbEWobtm+wXAR3XWJHWnvQ+lVglNbYTIkif44eRywjAvpKVG1NeCFt47xgRwF4eeITc9WcZJuIF/nNQ+kNer0+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wd9M+9JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D34C2BCB4;
	Fri,  1 May 2026 11:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633455;
	bh=zzcmP6NlsR0l5z0Keg5IKgVFt/WrwpV4xmdCsr997Vk=;
	h=Subject:To:Cc:From:Date:From;
	b=Wd9M+9JHrYc+MgO6FKeh4Y/S6uUC6+r9utEm1WzUYpCBU2rlC5h09ZwPFKJlmHSZr
	 t0n9OflEbcnFSRApw3/HFMZtJFEp6kipFG3dDZpZWTLwd0fERJEBfjvD8jbd4/fFDN
	 E7JXa0EkIhlojDIAr2UqkLTwrslkc1oIzx2oQi+o=
Subject: FAILED: patch "[PATCH] sched: Use u64 for bandwidth ratio calculations" failed to apply to 5.10-stable tree
To: joseph.salisbury@oracle.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:04:01 +0200
Message-ID: <2026050101-glamorous-absurd-e506@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EAB814ABE13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242308-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,oracle.com:email,infradead.org:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c6e80201e057dfb7253385e60bf541121bf5dc33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050101-glamorous-absurd-e506@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


