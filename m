Return-Path: <stable+bounces-227925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDzjN5sEwWlUPgQAu9opvQ
	(envelope-from <stable+bounces-227925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:15:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 444842EED07
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62C943004223
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89F38642E;
	Mon, 23 Mar 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8q765sJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0D3859D8
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256906; cv=none; b=rM4FS1q7wg1BWOO0ElLZom6XbbXYjC/OaPbo47Q7lb8+Apr8t5kCRu3+3jjuUK4I4bcv3yjVFjoICkklYuczgsKj7xELIMtwlLQBfnGUYFtOK9My9P/gUuydxi3XLplKyIw8hcT4ukHkLp6BQS3VP2rQOLGxQ0Et9lQU2/G9xv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256906; c=relaxed/simple;
	bh=7IZJjcTctwv1tLno3Y1Yj+9M/JWOtQwg7J+K9ZZUN5Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aU6MKuT03J9gnJvUG4BkwPG+ocAzqMLDYkd+W0VMnZzTFo7Mmmy+mNTnahdsi04EoVwwa3R0aoh2igiOjZV+5IUR1YJZ9NCapKV0Qb7fCEnyr5V/mJ1EsDGN6e9IcZqPvAq7URdyy9DN/I4kh+RgSmAHRHzhYJO6kIbfiqdYno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8q765sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23ABC4CEF7;
	Mon, 23 Mar 2026 09:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774256906;
	bh=7IZJjcTctwv1tLno3Y1Yj+9M/JWOtQwg7J+K9ZZUN5Q=;
	h=Subject:To:Cc:From:Date:From;
	b=a8q765sJHeis4/WvWVD9k/yYBV1FT918Ufr7lKfZUA8teNMmdOB0hVRv+JZuClYI9
	 mpR1pr4IcEqIWEs1zVx2WE6XK1+xTkAh3/nf62R4DMmQ6auJDUnYQrs3qX4cwjHkuj
	 xG9HcQDnrYLjQKqZuKN0EEOBsaqnFhKAeGr2W+e0=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Add missing branch counters constraint apply" failed to apply to 6.12-stable tree
To: dapeng1.mi@linux.intel.com,peterz@infradead.org,xudong.hao@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Mar 2026 10:08:04 +0100
Message-ID: <2026032304-energetic-angular-3ccf@gregkh>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227925-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received,100.90.174.1:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,msgid.link:url,gregkh:email,infradead.org:email]
X-Rspamd-Queue-Id: 444842EED07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1d07bbd7ea36ea0b8dfa8068dbe67eb3a32d9590
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032304-energetic-angular-3ccf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d07bbd7ea36ea0b8dfa8068dbe67eb3a32d9590 Mon Sep 17 00:00:00 2001
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
Date: Sat, 28 Feb 2026 13:33:20 +0800
Subject: [PATCH] perf/x86/intel: Add missing branch counters constraint apply

When running the command:
'perf record -e "{instructions,instructions:p}" -j any,counter sleep 1',
a "shift-out-of-bounds" warning is reported on CWF.

  UBSAN: shift-out-of-bounds in /kbuild/src/consumer/arch/x86/events/intel/lbr.c:970:15
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

cnt = (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;

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
Link: https://patch.msgid.link/20260228053320.140406-2-dapeng1.mi@linux.intel.com
Cc: stable@vger.kernel.org

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cf3a4fe06ff2..36c68210d4d2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
 		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
 }
 
+static inline int intel_set_branch_counter_constr(struct perf_event *event,
+						  int *num)
+{
+	if (branch_sample_call_stack(event))
+		return -EINVAL;
+	if (branch_sample_counters(event)) {
+		(*num)++;
+		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
+	}
+
+	return 0;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4698,21 +4711,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		 * group, which requires the extra space to store the counters.
 		 */
 		leader = event->group_leader;
-		if (branch_sample_call_stack(leader))
+		if (intel_set_branch_counter_constr(leader, &num))
 			return -EINVAL;
-		if (branch_sample_counters(leader)) {
-			num++;
-			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
-		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
 		for_each_sibling_event(sibling, leader) {
-			if (branch_sample_call_stack(sibling))
+			if (intel_set_branch_counter_constr(sibling, &num))
+				return -EINVAL;
+		}
+
+		/* event isn't installed as a sibling yet. */
+		if (event != leader) {
+			if (intel_set_branch_counter_constr(event, &num))
 				return -EINVAL;
-			if (branch_sample_counters(sibling)) {
-				num++;
-				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
-			}
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))


