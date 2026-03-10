Return-Path: <stable+bounces-224422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEJNEZ4CsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5B24B293
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D8DA3264598
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EAD3876A7;
	Tue, 10 Mar 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXFsZFlL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB652FFDF7;
	Tue, 10 Mar 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142155; cv=none; b=VQgWeFuXmPUR6hctBZC1q36+g7JP2YCufNhq1v6+djdKfC3OkUWmcCh2PYnFBw9JIAan4yB++eIJPP1Wdn3hQiXz6Oc82uJdBrZZVKSTM+xl4V7UXSyQIT/gsPtuuqOi11Hy0s9RhI0SirDg9Tk/BjZPahADcPRkWLNTjDbe6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142155; c=relaxed/simple;
	bh=vFCkomxdJaZSXeq6qagrIaS9wVggtX/V8K/7PT3j1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUfnWtZKplvkUhl/kkrq5osWxC+QZU8KWMxSDHl5hSp9dfM0RQwUFQ2bhN6qOJNzWbiJxtcHnfYW8NlFMtiHtC8ha/czxgD32YGDSggIci+u0nfQWDYnfk/2Z9sLBRRdVTo32+d1sEThKen1DJ6flpk5xqvkGYUII3w/DS8/P9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXFsZFlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C8C2BC86;
	Tue, 10 Mar 2026 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142155;
	bh=vFCkomxdJaZSXeq6qagrIaS9wVggtX/V8K/7PT3j1Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXFsZFlLg2HqhXYU2gMPaZrUaAIXKjSgXKGUlkj0ZhhgPQWxm3gQhBUhvbB9aSGlf
	 OzxxZITC8ZpWYVErSyRjzk7glOoPKXAiCnH2mhui5LSU6/odEoNsKJ62rdKXHyS2GE
	 4x2JF+zFVr424v1gmlkP8tp9/BnpzaIt8gZhdtNyqgwuf3DkdswY6ahkqt8NlZCwsz
	 OBE+fJW1SoKYOSooh7DE2qwtNOYz5O6l6OhIMrgFXFmBAIREfUQIb4wEcEgB8Q9Otf
	 Kw3PhWykGSvnYYft5ISrXdyLmhqf1VGYGr3B5GO5lE85uHMhhmg44QXTXCfsCIVvV+
	 fCCPdo/gmcqng==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Carlos Santa <carlos.santa@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 243/314] drm/xe: Do not preempt fence signaling CS instructions
Date: Tue, 10 Mar 2026 07:18:22 -0400
Message-ID: <d02a803174d3a027f7f82b5d8fbc9304f3b90d7c.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCE5B24B293
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224422-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit cdc8a1e11f4d5b480ec750e28010c357185b95a6 ]

If a batch buffer is complete, it makes little sense to preempt the
fence signaling instructions in the ring, as the largest portion of the
work (the batch buffer) is already done and fence signaling consists of
only a few instructions. If these instructions are preempted, the GuC
would need to perform a context switch just to signal the fence, which
is costly and delays fence signaling. Avoid this scenario by disabling
preemption immediately after the BB start instruction and re-enabling it
after executing the fence signaling instructions.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patch.msgid.link/20260115004546.58060-1-matthew.brost@intel.com
(cherry picked from commit 2bcbf2dcde0c839a73af664a3c77d4e77d58a3eb)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_ring_ops.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index d71837773d6c6..e0082b55e2162 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -265,6 +265,9 @@ static void __emit_job_gen12_simple(struct xe_sched_job *job, struct xe_lrc *lrc
 
 	i = emit_bb_start(batch_addr, ppgtt_flag, dw, i);
 
+	/* Don't preempt fence signaling */
+	dw[i++] = MI_ARB_ON_OFF | MI_ARB_DISABLE;
+
 	if (job->user_fence.used) {
 		i = emit_flush_dw(dw, i);
 		i = emit_store_imm_ppgtt_posted(job->user_fence.addr,
@@ -328,6 +331,9 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
 
 	i = emit_bb_start(batch_addr, ppgtt_flag, dw, i);
 
+	/* Don't preempt fence signaling */
+	dw[i++] = MI_ARB_ON_OFF | MI_ARB_DISABLE;
+
 	if (job->user_fence.used) {
 		i = emit_flush_dw(dw, i);
 		i = emit_store_imm_ppgtt_posted(job->user_fence.addr,
@@ -377,6 +383,9 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
 
 	i = emit_bb_start(batch_addr, ppgtt_flag, dw, i);
 
+	/* Don't preempt fence signaling */
+	dw[i++] = MI_ARB_ON_OFF | MI_ARB_DISABLE;
+
 	i = emit_render_cache_flush(job, dw, i);
 
 	if (job->user_fence.used)
-- 
2.51.0


