Return-Path: <stable+bounces-227987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bk8JsI/wWlnRwQAu9opvQ
	(envelope-from <stable+bounces-227987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F002F2E57
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B3F304B03B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027E3A9627;
	Mon, 23 Mar 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpOPkRHl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463537C90E
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271962; cv=none; b=eTnUfns5bBsRRftzdAjmQvsf5tcXRam5FbgNHGAFaZo0zyXNJQeqpA+7q55eN/lRSvk8pUq7sbREeJR+GZXQg5+ZKuo7Zj7EhmmJpuj73/BZCkBeJ6RMhpC1aVZ3Z/n2CCvgYNGuzY1hDHXkbjLCn4h9FJ7Zb0llLHN1xYrAVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271962; c=relaxed/simple;
	bh=hPKGfAkWLXDhzKqGxA1lJKtSOKpLgFTEu4HCd/Ei7IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXNn3gsmkpEdzKewV2DormNesMJhydQaQ/KddBHKIaFEP0qwCGEqz8ag6IPF7Q/WZFPSRt53ALtXZHD3hLzIBrOPKlBH2eINUx8Wue7YEck8HBkhg6th5i5NFP9oHjOADK4CBdUQOkCxdXeQyquhjgj2Mf7KeFoJNWDf9eQYRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpOPkRHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7523C4CEF7;
	Mon, 23 Mar 2026 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774271962;
	bh=hPKGfAkWLXDhzKqGxA1lJKtSOKpLgFTEu4HCd/Ei7IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpOPkRHl7jUICCiKKaw0XF85qqgnPtUzoGoBWdIGqZ/c8HgZmXc24jpfpvoBo0eFZ
	 uZTdlyiT3VbtwVyv/TT/6RQqB0w41qMtXeZDkWlg4wwPFEtvd8hrqDj3FjI/hkZ+je
	 wqqE2ESWtf2g0tm+N300wId5yfrTf1DdEomRiYay82+l99wtPlu5ZmDn0CHaxe6mmj
	 H0MWqutG9gz72VBPCt8N0x6KmGo/2OdMqcboN5GxnGAKDYw9YbzloBDJnDAvV+S5bz
	 xnRrJGiqWXwqgDod0+QUwxVRwJhXYVdcfcgJFtfob3no9P+EDXchClz4I77H0wbCc6
	 9QxbrVaWX8aQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] perf/x86/intel: Add missing branch counters constraint apply
Date: Mon, 23 Mar 2026 09:19:20 -0400
Message-ID: <20260323131920.1715214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032304-energetic-angular-3ccf@gregkh>
References: <2026032304-energetic-angular-3ccf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227987-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: C7F002F2E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 1d07bbd7ea36ea0b8dfa8068dbe67eb3a32d9590 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4a57a9948c745..ddde2f1d0bd29 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4031,6 +4031,17 @@ static u64 intel_pmu_freq_start_period(struct perf_event *event)
 	return start;
 }
 
+static inline int intel_set_branch_counter_constr(struct perf_event *event,
+						  int *num)
+{
+	if (branch_sample_call_stack(event))
+		return -EINVAL;
+	if (branch_sample_counters(event))
+		(*num)++;
+
+	return 0;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4090,17 +4101,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		 * group, which requires the extra space to store the counters.
 		 */
 		leader = event->group_leader;
-		if (branch_sample_call_stack(leader))
+		if (intel_set_branch_counter_constr(leader, &num))
 			return -EINVAL;
-		if (branch_sample_counters(leader))
-			num++;
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
-			if (branch_sample_counters(sibling))
-				num++;
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))
-- 
2.51.0


