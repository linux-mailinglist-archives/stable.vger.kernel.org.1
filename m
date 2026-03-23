Return-Path: <stable+bounces-228922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CxCLzpYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:11:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1B2F5F0E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E7C03026BFB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BD3AF647;
	Mon, 23 Mar 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A+fJbs/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694323EA97;
	Mon, 23 Mar 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277496; cv=none; b=lf8ZM9ZIpVHJMTG3Ptz2DIrCdSFHt8oSiDJZ/GGRFB+ea6PX6kY57h+1+CxVYYKyIg2b1OMJS6d5DkW1CjWiksqiVv8bjKv3hIv4N6k0DlYNt19jr6TRm2IhI3nkiQu51RIJi+4DWeDw1ucwChe2Nic0dPs3WZTJVaEsc4E0lfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277496; c=relaxed/simple;
	bh=5+vjtCXBqyvn6Q8TtJcxdve9UIaKLQOS+PLMP2EXONo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHFn1mTolDY+hcjhDauaLxU3vm/AZzQVK1l0A+vrk9CWfu197wQYFDXrgB9xZ08WOfnOcrmuFq174Yqax7fr8pSGgyflHXN8HspEsLO3ZauV2EwtfEoGl+Cc7uX01N6v21cYke2VMTsK7S1FnFFNwHtP2BGUaVDKCVOxxrsrWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A+fJbs/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB56C4CEF7;
	Mon, 23 Mar 2026 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277495;
	bh=5+vjtCXBqyvn6Q8TtJcxdve9UIaKLQOS+PLMP2EXONo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+fJbs/auiiAkmNofdLEy8y372mNM6kgToHSZOWhSykpF+0ZgocH1N+HX3X4V0S0g
	 uKmzQB3R9KFWCz29VWPfnvLMbGzDR5M+HakN8GaTtvhWrmqJFxX3+1eqYxagdk44tB
	 P7uqXbL2fsBnU4GKeL3fQsQbyWvQnoPfFPH8+8jU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 460/460] perf/x86/intel: Add missing branch counters constraint apply
Date: Mon, 23 Mar 2026 14:47:36 +0100
Message-ID: <20260323134537.878213120@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228922-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E0D1B2F5F0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4031,6 +4031,17 @@ end:
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
@@ -4090,17 +4101,19 @@ static int intel_pmu_hw_config(struct pe
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



