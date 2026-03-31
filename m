Return-Path: <stable+bounces-231655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF4FBd/9y2nqNAYAu9opvQ
	(envelope-from <stable+bounces-231655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C336DA83
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 400EB306383D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81113E3C5C;
	Tue, 31 Mar 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c7+64l6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C333F38A;
	Tue, 31 Mar 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974726; cv=none; b=Ko966qF6+nV11V93fAWtSjBkNmpvWgkEbslK5UzQhjkvHUKn0C5elp2d1Cli8zUEmtrUEF2A2tkgH64FDPthQd7V1UirZNiwi3pll690gcuN0ljnc0JmWpH6+POjKx2lBQGVTeeHbQTvbkOPt2seN5Esi/aGbM/nxjsDQotKU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974726; c=relaxed/simple;
	bh=uLpMAzypNcTxDAyHMZbCOVNFpXu+wb3qp3E65n1jlZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR7LPy9Kdu73UGgGmipouuz80PJfvhrIDJpNPetJND0ol3JJLzmQfbNnnrJY/8zWfk/XS5b8JEiIWfy0RgFicE24+pxTxmarMyWjAuJxEzvION6V2/Axws4q4iPcWXlnBPX91KeIdD57/2w4zrVCZZQBwvFp99IXV8Xk5sW6et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c7+64l6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33789C19424;
	Tue, 31 Mar 2026 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974726;
	bh=uLpMAzypNcTxDAyHMZbCOVNFpXu+wb3qp3E65n1jlZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7+64l6d+IDyhrxALqnXKtUWLlrUOtvDdb4uZjR2KqUvT88k8F7MPj5iu2yV3/fTH
	 6P5W40+MdIoVW/TuP0zl1YZzeWMDVaO8ljkiAGxkiPU9IDBjQMJ7B5O+WbjUCRDBsp
	 U+cKZtpvOBIkor9gQBiwbaour1PMWmMLmKeFuvRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Rosenberg <olrose55@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 006/342] perf: Make sure to use pmu_ctx->pmu for groups
Date: Tue, 31 Mar 2026 18:17:19 +0200
Message-ID: <20260331161759.146315861@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,infradead.org,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-231655-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E2C336DA83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 4b9ce671960627b2505b3f64742544ae9801df97 ]

Oliver reported that x86_pmu_del() ended up doing an out-of-bound memory access
when group_sched_in() fails and needs to roll back.

This *should* be handled by the transaction callbacks, but he found that when
the group leader is a software event, the transaction handlers of the wrong PMU
are used. Despite the move_group case in perf_event_open() and group_sched_in()
using pmu_ctx->pmu.

Turns out, inherit uses event->pmu to clone the events, effectively undoing the
move_group case for all inherited contexts. Fix this by also making inherit use
pmu_ctx->pmu, ensuring all inherited counters end up in the same pmu context.

Similarly, __perf_event_read() should use equally use pmu_ctx->pmu for the
group case.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Reported-by: Oliver Rosenberg <olrose55@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://patch.msgid.link/20260309133713.GB606826@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84a79e977580e..39b35f280845b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4672,7 +4672,7 @@ static void __perf_event_read(void *info)
 	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-	struct pmu *pmu = event->pmu;
+	struct pmu *pmu;
 
 	/*
 	 * If this is a task context, we need to check whether it is
@@ -4684,7 +4684,7 @@ static void __perf_event_read(void *info)
 	if (ctx->task && cpuctx->task_ctx != ctx)
 		return;
 
-	raw_spin_lock(&ctx->lock);
+	guard(raw_spinlock)(&ctx->lock);
 	ctx_time_update_event(ctx, event);
 
 	perf_event_update_time(event);
@@ -4692,25 +4692,22 @@ static void __perf_event_read(void *info)
 		perf_event_update_sibling_time(event);
 
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
-		goto unlock;
+		return;
 
 	if (!data->group) {
-		pmu->read(event);
+		perf_pmu_read(event);
 		data->ret = 0;
-		goto unlock;
+		return;
 	}
 
+	pmu = event->pmu_ctx->pmu;
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
 
-	pmu->read(event);
-
+	perf_pmu_read(event);
 	for_each_sibling_event(sub, event)
 		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
-
-unlock:
-	raw_spin_unlock(&ctx->lock);
 }
 
 static inline u64 perf_event_count(struct perf_event *event, bool self)
@@ -14461,7 +14458,7 @@ inherit_event(struct perf_event *parent_event,
 	get_ctx(child_ctx);
 	child_event->ctx = child_ctx;
 
-	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
+	pmu_ctx = find_get_pmu_context(parent_event->pmu_ctx->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
-- 
2.51.0




