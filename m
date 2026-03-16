Return-Path: <stable+bounces-225516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIEwE9vTt2n0VgEAu9opvQ
	(envelope-from <stable+bounces-225516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:56:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C36129781A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 791A2302C363
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203038CFF7;
	Mon, 16 Mar 2026 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPuHdiYc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+vULJ7CI"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA126059D;
	Mon, 16 Mar 2026 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654632; cv=none; b=AB9lLXPWIXRtJrBdeKqasyLqVwhJCKt344nLLJ1TWDxD1jHWWvexdG4Y5qQt23nJk0v2tj83xO5o+zAySmBcQv9fk2sTpS5dT34zOOtdf06YCFwQhg6DdcDyktWyg35xwqR91sz2BywiICbah/BslNjFsJeXTEaGbx/VXOf0MzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654632; c=relaxed/simple;
	bh=uDyTtBGwtJb80gdIRZbp19hIW1JH8eZXq7ROZNEji4M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rYoEkLxfiznhUKZXbXPxMWhjpsTnUM+j+DIF+ORfyzo3IMB+t2sOZsOtWYQo/Vf9X9bQQiNaUJVnOaBD9Ad/rcCWs/Is6RAXspd07mPcZpqqUuGbez1JhJjlsrnHy5Pr+PHyDTDPR1ZRLk1yi2M5eBTgUvY0BTXFd1YHoS0UhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPuHdiYc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+vULJ7CI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Mar 2026 09:50:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773654629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2YvYjAY1hUa3GyWY5vwbEGMxuuCofYMaBF5F6CteM=;
	b=aPuHdiYcrSx5MwpoHPKz0sCkHeWjglBFdHOb8z2w+kPhFFO4q0f2BqQSTB1gsG42n4wxva
	mpQRCbALWTqYd4Lp3QXSYjOm/bFOxJcUm/s60l1E1hPOYp/4MhXsHXMm5qUDQDOIA21oq9
	Z6QHCF8ZXF+IIAIFdOOjW3qJwroiHw4SMJl/cOSoi9OH7I9UW8G1mFS43QoOJglvdmKWeq
	Hf56l4qx2V8Yew2Vti+sGgezSOnhqp5jvrzGVM3h+kjHyYb3r/NcZaBDlGsofUlCJDYJq2
	dxCM3C4x6xJZIf2ndlmNVtWzaQUwP3DCmNkpNIIcwVwoA0aU2lqeWyKMr0IO0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773654629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2YvYjAY1hUa3GyWY5vwbEGMxuuCofYMaBF5F6CteM=;
	b=+vULJ7CIcPYDq58rwrld+q/NvAshaBHAbuHkRkIIXp1TIvcur4SfdZQwrQUeDJmU21RBKh
	DdRtDS9gWCbjSPCg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Add missing branch counters
 constraint apply
Cc: Xudong Hao <xudong.hao@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
References: <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177365462848.1647592.121327259632805795.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url,vger.kernel.org:replyto,infradead.org:email]
X-Rspamd-Queue-Id: 0C36129781A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1d07bbd7ea36ea0b8dfa8068dbe67eb3a32d9590
Gitweb:        https://git.kernel.org/tip/1d07bbd7ea36ea0b8dfa8068dbe67eb3a32=
d9590
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Sat, 28 Feb 2026 13:33:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Mar 2026 11:29:16 +01:00

perf/x86/intel: Add missing branch counters constraint apply

When running the command:
'perf record -e "{instructions,instructions:p}" -j any,counter sleep 1',
a "shift-out-of-bounds" warning is reported on CWF.

  UBSAN: shift-out-of-bounds in /kbuild/src/consumer/arch/x86/events/intel/lb=
r.c:970:15
  shift exponent 64 is too large for 64-bit type 'long long unsigned int'
  ......
  intel_pmu_lbr_counters_reorder.isra.0.cold+0x2a/0xa7
  intel_pmu_lbr_save_brstack+0xc0/0x4c0
  setup_arch_pebs_sample_data+0x114b/0x2400

The warning occurs because the second "instructions:p" event, which
involves branch counters sampling, is incorrectly programmed to fixed
counter 0 instead of the general-purpose (GP) counters 0-3 that support
branch counters sampling. Currently only GP counters 0-3 support branch
counters sampling on CWF, any event involving branch counters sampling
should be programed on GP counters 0-3. Since the counter index of fixed
counter 0 is 32, it leads to the "src" value in below code is right
shifted 64 bits and trigger the "shift-out-of-bounds" warning.

cnt =3D (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;

The root cause is the loss of the branch counters constraint for the
new event in the branch counters sampling event group. Since it isn't
yet part of the sibling list. This results in the second
"instructions:p" event being programmed on fixed counter 0 incorrectly
instead of the appropriate GP counters 0-3.

To address this, we apply the missing branch counters constraint for
the last event in the group. Additionally, we introduce a new function,
`intel_set_branch_counter_constr()`, to apply the branch counters
constraint and avoid code duplication.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Reported-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260228053320.140406-2-dapeng1.mi@linux.intel=
.com
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cf3a4fe..36c6821 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(str=
uct perf_event *event,
 		event->hw.dyn_constraint &=3D hybrid(event->pmu, acr_cause_mask64);
 }
=20
+static inline int intel_set_branch_counter_constr(struct perf_event *event,
+						  int *num)
+{
+	if (branch_sample_call_stack(event))
+		return -EINVAL;
+	if (branch_sample_counters(event)) {
+		(*num)++;
+		event->hw.dyn_constraint &=3D x86_pmu.lbr_counters;
+	}
+
+	return 0;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret =3D x86_pmu_hw_config(event);
@@ -4698,21 +4711,19 @@ static int intel_pmu_hw_config(struct perf_event *eve=
nt)
 		 * group, which requires the extra space to store the counters.
 		 */
 		leader =3D event->group_leader;
-		if (branch_sample_call_stack(leader))
+		if (intel_set_branch_counter_constr(leader, &num))
 			return -EINVAL;
-		if (branch_sample_counters(leader)) {
-			num++;
-			leader->hw.dyn_constraint &=3D x86_pmu.lbr_counters;
-		}
 		leader->hw.flags |=3D PERF_X86_EVENT_BRANCH_COUNTERS;
=20
 		for_each_sibling_event(sibling, leader) {
-			if (branch_sample_call_stack(sibling))
+			if (intel_set_branch_counter_constr(sibling, &num))
+				return -EINVAL;
+		}
+
+		/* event isn't installed as a sibling yet. */
+		if (event !=3D leader) {
+			if (intel_set_branch_counter_constr(event, &num))
 				return -EINVAL;
-			if (branch_sample_counters(sibling)) {
-				num++;
-				sibling->hw.dyn_constraint &=3D x86_pmu.lbr_counters;
-			}
 		}
=20
 		if (num > fls(x86_pmu.lbr_counters))

