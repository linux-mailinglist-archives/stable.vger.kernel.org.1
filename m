Return-Path: <stable+bounces-233506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK6JLiKy1GkkwgcAu9opvQ
	(envelope-from <stable+bounces-233506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:28:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B85E3AAC80
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29625303B4D6
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499113939C8;
	Tue,  7 Apr 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1q6LP+W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ca0FfV2y"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6B393DF2;
	Tue,  7 Apr 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546893; cv=none; b=VpDW60Z963T2h9A3rnPhP23LpB5LJEt4k4Om8JWHrRzvo49VD+8by6ayizFQmpYZsXNVanVHzcFFg/1v/6fcbgYjfnfTo02No7nLgHgyNzmysomHkXQZ29DVoUFtsIyqSqLzsxk3PSBtqyQF42Zhoi6+D0cdFbNMNCojSLpkX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546893; c=relaxed/simple;
	bh=gtpgsne8Yo/fg6x38+D58h5z9npkwHtGxRXDAuAHi4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m7N6ojKc0zoZkVZGsjTr02p6EsB4qZIPr+WfaSAIVp4zTqRgg/xRPPb2NcP+8zYStnFBL1tJUOjeH60TQsdt8g/JphP8sANeplve926HjjRdXM7oItqi90nuQ3Z8knO5mvXPKZvfE6wE+b+dSwOonk0ZbhG22xnU9Qd23TRumag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1q6LP+W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ca0FfV2y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 07 Apr 2026 07:28:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775546890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6McT4XkR9SN6jcbAPDGciPBdzpUTrkn/L7fDkMvCPo=;
	b=J1q6LP+WWsHe+0Y+0B9fwIfdBU2XSqt2qxs6Y10Ao9iWzFwgTsov1YfHAn+cHmK2hzJBJv
	HEh0pfAHPQVHnlyKOhf4Zd8I59tOC+iNOJcV/qbuypw3M/ox7wgi+V86AaE9xoLGUl+au4
	tS+HXSGF/5PTCupRCT0X9H3LOwc5PigMixFXwagOgtSJM++2pmgRiLVqDgc3iaHteUpj+s
	hfZeaKteRk4Djyhzcb8mDC0+2yY3YUq1YbOesiRK+V72iUL5/pJtMitZe7KOgljiKts8UJ
	3HWlpd/G2B6kbtwzipzRWZDtjvvdVK7hYEwV2NweM7s4XYUgEsAV8kYRdlbN+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775546890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6McT4XkR9SN6jcbAPDGciPBdzpUTrkn/L7fDkMvCPo=;
	b=ca0FfV2yyXHfyt36j0EPJTf+O9QMkJpiYWb4JgY3YU6UMV8SUy2dCYqiIOmoZSIyeWY1r0
	fDpDCciF88qh4ZDQ==
From: "tip-bot2 for Joseph Salisbury" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Use u64 for bandwidth ratio calculations
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260403210014.2713404-1-joseph.salisbury@oracle.com>
References: <20260403210014.2713404-1-joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177554688890.226963.17414444257275011729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233506-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7B85E3AAC80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c6e80201e057dfb7253385e60bf541121bf5dc33
Gitweb:        https://git.kernel.org/tip/c6e80201e057dfb7253385e60bf541121bf=
5dc33
Author:        Joseph Salisbury <joseph.salisbury@oracle.com>
AuthorDate:    Fri, 03 Apr 2026 17:00:14 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 07 Apr 2026 09:23:52 +02:00

sched: Use u64 for bandwidth ratio calculations

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
Link: https://patch.msgid.link/20260403210014.2713404-1-joseph.salisbury@orac=
le.com
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/rt.c    | 2 +-
 kernel/sched/sched.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c15c986..49cd5d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4735,7 +4735,7 @@ void sched_post_fork(struct task_struct *p)
 	scx_post_fork(p);
 }
=20
-unsigned long to_ratio(u64 period, u64 runtime)
+u64 to_ratio(u64 period, u64 runtime)
 {
 	if (runtime =3D=3D RUNTIME_INF)
 		return BW_UNIT;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4e5f195..a48e867 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2666,7 +2666,7 @@ static int tg_rt_schedulable(struct task_group *tg, voi=
d *data)
 {
 	struct rt_schedulable_data *d =3D data;
 	struct task_group *child;
-	unsigned long total, sum =3D 0;
+	u64 total, sum =3D 0;
 	u64 period, runtime;
=20
 	period =3D ktime_to_ns(tg->rt_bandwidth.rt_period);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9594355..c955841 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2907,7 +2907,7 @@ extern void init_cfs_throttle_work(struct task_struct *=
p);
 #define MAX_BW_BITS		(64 - BW_SHIFT)
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
=20
-extern unsigned long to_ratio(u64 period, u64 runtime);
+extern u64 to_ratio(u64 period, u64 runtime);
=20
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);

