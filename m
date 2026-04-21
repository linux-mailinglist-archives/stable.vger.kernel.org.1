Return-Path: <stable+bounces-240041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCYUOjkZ52nT3wEAu9opvQ
	(envelope-from <stable+bounces-240041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF2436F2C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58D8300F12D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92237F748;
	Tue, 21 Apr 2026 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ/ZaMHD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A435F61A;
	Tue, 21 Apr 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752783; cv=none; b=tf/luoN7LH/DVBB4kTM+vqeJTHaH1SonJSTvdi5eh3iAeg7G/tXcYpOK1ShBJ7wkIipWhvZ6QuPy1UdH58BJe4K+++fGc3zsRK/vfWheGr4Mr4E9flMyRJu/tF1ReM4NTpP9N6w80tucwVD/uwMFqXYrPTaq1URR5sz1Po1YbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752783; c=relaxed/simple;
	bh=7GmAiJXRTK/Ukg9RCeU+C9XLvBUClVbfahskbfvf6mU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IzbWY9y3Tjr4QIQG9574vrqhja5sdqirzRLTljz9IoifHeoxGUCI5jMHnc/7aHxBUyxzP9jUGvDnMwOf2HW2BTDBfulBJY9ggENzYfNubt8DWAGBQ/Mcpc4iSkFS9xcdTHMPtgxYttS7fCj6CjsJGF0dlZV+3wu1CtW5hP0I26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ/ZaMHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8B3C2BCB0;
	Tue, 21 Apr 2026 06:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776752783;
	bh=7GmAiJXRTK/Ukg9RCeU+C9XLvBUClVbfahskbfvf6mU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NJ/ZaMHDBOwnABjGVYItfsTNB0sJdMvxqV3WS1LyX0BY22mDWv+h15YJAk5L02f3q
	 Qu/DzxaUxv8xynjDkSlef86xmVeWu4dGMIRqO6zubkt0gpsSCE8u87AXP7rcuwv5w6
	 h5GnScbAL+sUQvbtngDoXXq58TzK9CZqz01YKnOpWRLlSovUZoXuOF+1QjvUa5GYx8
	 Y2aGxWqDpBk2yuFykjnSdVOyhHrIQ8zVrBsq/Vhg3+q6edAvWFfLLzbA9IXcNpNJjK
	 /Vls9bZPixENiM09GoAZVboqnGmtO/n9eo3dLbOcexsETPUc+Low0ZOQDFwMjrxAT2
	 0rmxfR8an0ORw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>, Borislav Petkov <bp@alien8.de>, Sasha
 Levin <sashal@kernel.org>, fweisbec@gmail.com, mingo@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH stable backport] clockevents: Add missing resets of the
 next_event_forced flag
In-Reply-To: <87pl3ten5y.ffs@tglx>
References: <20260420131539.986432-1-sashal@kernel.org>
 <20260420131539.986432-78-sashal@kernel.org> <87pl3ten5y.ffs@tglx>
Date: Tue, 21 Apr 2026 08:26:19 +0200
Message-ID: <87jyu0de2c.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wbinvd.org,alien8.de,kernel.org,gmail.com,linux-foundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240041-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cachyos.org:email]
X-Rspamd-Queue-Id: 6CEF2436F2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 4096fd0e8eaea13ebe5206700b33f49635ae18e5 upstream.

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

---
 kernel/time/clockevents.c    |    7 ++++++-
 kernel/time/tick-broadcast.c |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -94,6 +94,9 @@ static int __clockevents_switch_state(st
 	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
+	/* On state transitions clear the forced flag unconditionally */
+	dev->next_event_forced = 0;
+
 	/* Transition with new state-specific callbacks */
 	switch (state) {
 	case CLOCK_EVT_STATE_DETACHED:
@@ -332,8 +335,10 @@ int clockevents_program_event(struct clo
 	if (delta > (int64_t)dev->min_delta_ns) {
 		delta = min(delta, (int64_t) dev->max_delta_ns);
 		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
-		if (!dev->set_next_event((unsigned long) clc, dev))
+		if (!dev->set_next_event((unsigned long) clc, dev)) {
+			dev->next_event_forced = 0;
 			return 0;
+		}
 	}
 
 	if (dev->next_event_forced)
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -108,6 +108,7 @@ static struct clock_event_device *tick_g
 
 static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
 {
+	wd->next_event_forced = 0;
 	/*
 	 * If we woke up early and the tick was reprogrammed in the
 	 * meantime then this may be spurious but harmless.

