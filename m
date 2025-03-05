Return-Path: <stable+bounces-120675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B71A507D1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01110189378D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8531C6FF6;
	Wed,  5 Mar 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYdHzR03"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721714B075;
	Wed,  5 Mar 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197647; cv=none; b=ogynMNc4Lh+tD84UuC8ZDjATP3c9j7LslFSC5epmEDWOIkB9g2/vI4mDlK40DOZ2oskEsPoSYVw9AuxUpJEnRDuqcbeXoHG1Qd+cUWVxemH18go8CTVK1a4dzikAGwD0ySbMWuuWbgKYe3fILwrU1jQbfcGaNCtqCWZVFApnLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197647; c=relaxed/simple;
	bh=pYYeP4YiEM1Khn3C3VdjPDEtX3PrABdQl/qoQckF968=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5lehzXJetjk+KVgr5JjmufFQtoH+dWOqLsNbvcP4Dmdfjw5JUFWRTAh+KORWZrIfr8LWHbuINhZ5hNW02/z+sPNIIPUF06geiAkmKGeOXcpj71QWgxxagp48JkfxePmrZSPSEJnPRWnWaKWw3Rm5hMbv1MhPWQqAetgHynRPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYdHzR03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEF7C4CED1;
	Wed,  5 Mar 2025 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197647;
	bh=pYYeP4YiEM1Khn3C3VdjPDEtX3PrABdQl/qoQckF968=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYdHzR03e3ISgc3tuKmKOc3qxjTZGL25ilAqkZj7eezBShXZXwYtJRIuskTGlM/mO
	 ZjIOp+VjAqEmcAVbc6W/d7NwwqQULqj0rCLNcmo2bSJ/jv7CIysFjWDLgZg0eNBzMW
	 0dRls7k9mL0kdvLIODh6Gt2MtUJdbA98EfGoHFlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 052/142] perf/core: Order the PMU list to fix warning about unordered pmu_ctx_list
Date: Wed,  5 Mar 2025 18:47:51 +0100
Message-ID: <20250305174502.428609184@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luo Gengkun <luogengkun@huaweicloud.com>

[ Upstream commit 2016066c66192a99d9e0ebf433789c490a6785a2 ]

Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
perf_event_swap_task_ctx_data(). vmcore shows that two lists have the same
perf_event_pmu_context, but not in the same order.

The problem is that the order of pmu_ctx_list for the parent is impacted by
the time when an event/PMU is added. While the order for a child is
impacted by the event order in the pinned_groups and flexible_groups. So
the order of pmu_ctx_list in the parent and child may be different.

To fix this problem, insert the perf_event_pmu_context to its proper place
after iteration of the pmu_ctx_list.

The follow testcase can trigger above warning:

 # perf record -e cycles --call-graph lbr -- taskset -c 3 ./a.out &
 # perf stat -e cpu-clock,cs -p xxx // xxx is the pid of a.out

 test.c

 void main() {
        int count = 0;
        pid_t pid;

        printf("%d running\n", getpid());
        sleep(30);
        printf("running\n");

        pid = fork();
        if (pid == -1) {
                printf("fork error\n");
                return;
        }
        if (pid == 0) {
                while (1) {
                        count++;
                }
        } else {
                while (1) {
                        count++;
                }
        }
 }

The testcase first opens an LBR event, so it will allocate task_ctx_data,
and then open tracepoint and software events, so the parent context will
have 3 different perf_event_pmu_contexts. On inheritance, child ctx will
insert the perf_event_pmu_context in another order and the warning will
trigger.

[ mingo: Tidied up the changelog. ]

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250122073356.1824736-1-luogengkun@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d6458ea675e9..18f0a3aa6d7c6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4842,7 +4842,7 @@ static struct perf_event_pmu_context *
 find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
-	struct perf_event_pmu_context *new = NULL, *epc;
+	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
@@ -4899,12 +4899,19 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 			atomic_inc(&epc->refcount);
 			goto found_epc;
 		}
+		/* Make sure the pmu_ctx_list is sorted by PMU type: */
+		if (!pos && epc->pmu->type > pmu->type)
+			pos = epc;
 	}
 
 	epc = new;
 	new = NULL;
 
-	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	if (!pos)
+		list_add_tail(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	else
+		list_add(&epc->pmu_ctx_entry, pos->pmu_ctx_entry.prev);
+
 	epc->ctx = ctx;
 
 found_epc:
-- 
2.39.5




