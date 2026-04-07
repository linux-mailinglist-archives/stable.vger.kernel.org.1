Return-Path: <stable+bounces-233611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC81Bz0a1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CA63B0650
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81B48300DF6F
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2033ADB0;
	Tue,  7 Apr 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b8U9/Bqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662532ED3A
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573560; cv=none; b=FtlzqxJXsgTuHRwzRCZ1IGy6BMNuiSnRTxMXMuVODz5XRJrxcUxYkeYi35z9KTDNQeq7P1pSYBVH0TD0eg2ckre22cs81OvIBtmZvIJK7SmctjtsKE77s9KBfXRKx/vtwNnF5XsbYQ6JXvg/KT9NVQkx4e8/ZVIf2sDGjDgpbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573560; c=relaxed/simple;
	bh=GxXMA5GUiSnBk2S4R5Pb9RScypTF8ohJcYHPpJdJ6Ws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lDwuQ68VjKKxoEVwhHu2KHpuTriRpn2Fdv+FsktJWMQ1gnlCf1jSgTo+X/5A9emThtpnSybQ1ytTzD6BCRsUrqgI5lkDitElcmbrnZejSuIE4G1Mz0WPBR+aDjeG0yW5dUHmOtLeEHATwCXx4qk3QJWsG/s6+BU2sU/82pDrgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8U9/Bqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F20C116C6;
	Tue,  7 Apr 2026 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573560;
	bh=GxXMA5GUiSnBk2S4R5Pb9RScypTF8ohJcYHPpJdJ6Ws=;
	h=Subject:To:Cc:From:Date:From;
	b=b8U9/BqzmtcdQsmOua+PEAbbF2d4cRSpBgQ54Ly83wJtjBy9tDqjezIxZzlp1q39Y
	 7NA97uX5sB2K+iI5cAaMhl0NExe8aB49g3OmSEv+unxSzf7xiki6HXmE6PJmfty/Vk
	 5sV+KfDLDuNmJFR8y03dH0M8MVToNCCgrZsls3Xs=
Subject: FAILED: patch "[PATCH] workqueue: Fix false positive stall reports" failed to apply to 6.1-stable tree
To: song@kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:52:37 +0200
Message-ID: <2026040737-filler-glue-cef2@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233611-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 83CA63B0650
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c7f27a8ab9f2f43570f0725256597a0d7abe2c5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040737-filler-glue-cef2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7f27a8ab9f2f43570f0725256597a0d7abe2c5b Mon Sep 17 00:00:00 2001
From: Song Liu <song@kernel.org>
Date: Sat, 21 Mar 2026 20:30:45 -0700
Subject: [PATCH] workqueue: Fix false positive stall reports

On weakly ordered architectures (e.g., arm64), the lockless check in
wq_watchdog_timer_fn() can observe a reordering between the worklist
insertion and the last_progress_ts update. Specifically, the watchdog
can see a non-empty worklist (from a list_add) while reading a stale
last_progress_ts value, causing a false positive stall report.

This was confirmed by reading pool->last_progress_ts again after holding
pool->lock in wq_watchdog_timer_fn():

  workqueue watchdog: pool 7 false positive detected!
    lockless_ts=4784580465 locked_ts=4785033728
    diff=453263ms worklist_empty=0

To avoid slowing down the hot path (queue_work, etc.), recheck
last_progress_ts with pool->lock held. This will eliminate the false
positive with minimal overhead.

Remove two extra empty lines in wq_watchdog_timer_fn() as we are on it.

Fixes: 82607adcf9cd ("workqueue: implement lockup detector")
Cc: stable@vger.kernel.org # v4.5+
Assisted-by: claude-code:claude-opus-4-6
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b77119d71641..ff97b705f25e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7699,8 +7699,28 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		else
 			ts = touched;
 
-		/* did we stall? */
+		/*
+		 * Did we stall?
+		 *
+		 * Do a lockless check first. On weakly ordered
+		 * architectures, the lockless check can observe a
+		 * reordering between worklist insert_work() and
+		 * last_progress_ts update from __queue_work(). Since
+		 * __queue_work() is a much hotter path than the timer
+		 * function, we handle false positive here by reading
+		 * last_progress_ts again with pool->lock held.
+		 */
 		if (time_after(now, ts + thresh)) {
+			scoped_guard(raw_spinlock_irqsave, &pool->lock) {
+				pool_ts = pool->last_progress_ts;
+				if (time_after(pool_ts, touched))
+					ts = pool_ts;
+				else
+					ts = touched;
+			}
+			if (!time_after(now, ts + thresh))
+				continue;
+
 			lockup_detected = true;
 			stall_time = jiffies_to_msecs(now - pool_ts) / 1000;
 			max_stall_time = max(max_stall_time, stall_time);
@@ -7712,8 +7732,6 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n", stall_time);
 		}
-
-
 	}
 
 	if (lockup_detected)


