Return-Path: <stable+bounces-245636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE8MNAU9A2po2AEAu9opvQ
	(envelope-from <stable+bounces-245636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:45:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B0E522D5F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC763310D0D0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92CD37DAA5;
	Tue, 12 May 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VLSgaoBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C833395AF5
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593853; cv=none; b=LqDYBj/DSZ0iFWJ65GV+1s/79nPpv/7iCsXzwDfddLEqsaX9OUCr++WC+2iSQmpbot4AD9OUj0dri3du0PhklJuC5sSMhgNzlT1iTiJ1vdpcEn652LK/ghEz3vKAvgwqILGXK4UBKA1IlaED9z48fzgqiqdcwNPXksX1Z3G5Rhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593853; c=relaxed/simple;
	bh=BqXm+j3vBpen4tjD49wOw0PlMdOTw5J8qgTjMY1zTuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d6xIzXyUF+/altdf5KA1OVpu15L5DECMN2e9MQy/j1NJyyvSxKsGq4WYGPYzOGdCW45+ifATvjjb+QVj4r2fMUBqkheFnx6bHXFv//QIfORNL0jeFsJ3Q/rGT211nPtKHObyelKGNXY+9u+rj9rFssaQlLLtA6EX1Q3+qYq2FUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VLSgaoBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9270C2BCB0;
	Tue, 12 May 2026 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593853;
	bh=BqXm+j3vBpen4tjD49wOw0PlMdOTw5J8qgTjMY1zTuU=;
	h=Subject:To:Cc:From:Date:From;
	b=VLSgaoBa8EzMCmV6cGP1HBadqMeWtJ4NyczKLBIhURQDYBj4gdKcDqN4QTJjRGgJD
	 fStI01hnDNddfdsqwhBgVv3UXYVLvprHnAI3efsvA+POxeix6xQUtCaN+RFl4HtPIP
	 dab1fLwT4L/8rH/XxkGJctmp3wbzmruoSy743LLM=
Subject: FAILED: patch "[PATCH] clockevents: Add missing resets of the next_event_forced flag" failed to apply to 7.0-stable tree
To: tglx@kernel.org,dnaim@cachyos.org,i.r.e.c.c.a.k.u.n+kernel.org@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:50:58 +0200
Message-ID: <2026051258-schedule-parcel-c95c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37B0E522D5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245636-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,cachyos.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,kernelorg];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email,cachyos.org:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 4096fd0e8eaea13ebe5206700b33f49635ae18e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051258-schedule-parcel-c95c@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4096fd0e8eaea13ebe5206700b33f49635ae18e5 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Tue, 14 Apr 2026 22:55:01 +0200
Subject: [PATCH] clockevents: Add missing resets of the next_event_forced flag

The prevention mechanism against timer interrupt starvation missed to reset
the next_event_forced flag in a couple of places:

    - When the clock event state changes. That can cause the flag to be
      stale over a shutdown/startup sequence

    - When a non-forced event is armed, which then prevents rearming before
      that event. If that event is far out in the future this will cause
      missed timer interrupts.

    - In the suspend wakeup handler.

That led to stalls which have been reported by several people.

Add the missing resets, which fixes the problems for the reporters.

Fixes: d6e152d905bd ("clockevents: Prevent timer interrupt starvation")
Reported-by: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
Reported-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com
Link: https://patch.msgid.link/87340xfeje.ffs@tglx

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index b4d730604972..5e22697b098d 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -94,6 +94,9 @@ static int __clockevents_switch_state(struct clock_event_device *dev,
 	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
+	/* On state transitions clear the forced flag unconditionally */
+	dev->next_event_forced = 0;
+
 	/* Transition with new state-specific callbacks */
 	switch (state) {
 	case CLOCK_EVT_STATE_DETACHED:
@@ -366,8 +369,10 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires, b
 	if (delta > (int64_t)dev->min_delta_ns) {
 		delta = min(delta, (int64_t) dev->max_delta_ns);
 		cycles = ((u64)delta * dev->mult) >> dev->shift;
-		if (!dev->set_next_event((unsigned long) cycles, dev))
+		if (!dev->set_next_event((unsigned long) cycles, dev)) {
+			dev->next_event_forced = 0;
 			return 0;
+		}
 	}
 
 	if (dev->next_event_forced)
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 7e57fa31ee26..115e0bf01276 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -108,6 +108,7 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
 
 static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
 {
+	wd->next_event_forced = 0;
 	/*
 	 * If we woke up early and the tick was reprogrammed in the
 	 * meantime then this may be spurious but harmless.


