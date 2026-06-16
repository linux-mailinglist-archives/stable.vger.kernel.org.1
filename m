Return-Path: <stable+bounces-264204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pq+GIaZxMWrejQUAu9opvQ
	(envelope-from <stable+bounces-264204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:54:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF76917DA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=0iKmFrnp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264204-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264204-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8BA630B2ED9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5744E05B;
	Tue, 16 Jun 2026 15:44:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B344DB64;
	Tue, 16 Jun 2026 15:44:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624680; cv=none; b=sTkLquWLUccKeqjQOvStJsvEpbdXBBUdlbukjP4rkBOtHQv4QqXZbyCN0EhnlYw/ol//LvF7wWKDBZKXVBGeQXipDoI416I3hk5mgdxLmw72gqFI+lEuEsG0luRsb9S/wUL8n4rj1Z8VVNrVw5q1wXEg6PCl8RM0zMbS77Mr0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624680; c=relaxed/simple;
	bh=Rj1rGyKaJaPulcT77Pc25CaFw/pT1ELkLv3xQtNYsfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl7KQaQxlGNdnWg8PFGAkpU+ASgc2237WP/QZObmw5axd+Xc+CyAczzgA3vGJwZtYyPDas8PYX1Rw8hOYvAVUJJdkbCH2tv61JkRf/7elsi/899dt6FQ2hlkwNbgD0M/nBzTfakYfKi71TyhFcDTdmFM2vp3OLiTLbFUvRX8ulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iKmFrnp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA041F00A3A;
	Tue, 16 Jun 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624677;
	bh=Y0uM1WZEKbQp6Hnu1avnx00eT0Zl+36JABH2TXRFq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0iKmFrnpehcG4xaQfJxBTsaBMhuVIgTHb+vrB09988aTJnpD3RdAjqFI1PPXLnWKV
	 eGTVL9znfzF1dBJ42Khf9TBQM9KiwP6L9hHMa5XUqlqTMynhqMUf3nHG5mvdccYkEM
	 G9tV4X9dmWRR7iqHyLzqXelHW5EEFcKAqF0omPWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 7.0 373/378] debugobjects: Dont call fill_pool() in early boot hardirq context
Date: Tue, 16 Jun 2026 20:30:04 +0530
Message-ID: <20260616145129.735460566@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264204-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bigeasy@linutronix.de,m:tglx@linutronix.de,m:longman@redhat.com,m:tglx@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BEF76917DA

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 0d046ae106255cba5eb83b23f78ee93f3620247d upstream.

When booting a debug PREEMPT_RT kernel on an ARM64 system, a "inconsistent
{HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage" lockdep warning message was
reported to the console.

During early boot, interrupts are enabled before the scheduler is
enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts can
fire and in the hard interrupt context handler attempt to fill the pool

This can lead to a deadlock when the interrupt occurred when the interrupt
hits a region which holds a lock that is required to be taken in the
allocation path.

Add a new can_fill_pool() helper and reorder the exception rule and forbid
this scenario by excluding allocations from hard interrupt context.

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260605173038.495075-1-longman@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/debugobjects.c |   46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_b
 #endif
 }
 
+static inline bool can_fill_pool(void)
+{
+	/*
+	 * On !RT enabled kernels there are no restrictions and spinlock_t and
+	 * raw_spinlock_t are the same types.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return true;
+
+	/*
+	 * On RT enabled kernels, the task must not be blocked on a lock as
+	 * that could corrupt the PI state when blocking on a lock in the
+	 * allocation path.
+	 */
+	if (debug_objects_is_pi_blocked_on())
+		return false;
+
+	/*
+	 * On RT enabled kernels the pool refill should happen in preemptible
+	 * context.
+	 */
+	if (preemptible())
+		return true;
+
+	/*
+	 * Though during system boot before scheduling is set up, preemption is
+	 * disabled and the pool can get exhausted. Before scheduling is active
+	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
+	 * and if interrupted then hard interrupt context might run into a lock
+	 * inversion. So exclude hard interrupt context from allocations before
+	 * scheduling is active.
+	 */
+	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -734,18 +769,11 @@ static void debug_objects_fill_pool(void
 	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
+	if (can_fill_pool()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-		 * the preemptible() condition above.
+		 * the preemptible() condition in can_fill_pool().
 		 */
 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);



