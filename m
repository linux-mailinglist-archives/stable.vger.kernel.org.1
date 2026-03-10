Return-Path: <stable+bounces-223892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFB+IMT8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0B24A1EF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C4C8305FD66
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0B346E7A;
	Tue, 10 Mar 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBb888os"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A25382391;
	Tue, 10 Mar 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140792; cv=none; b=Qe0Y+dtPnxepqmMk0DJARummiJsFBb93g5lJ0zGuYpHjH6FRoiBELbENH1rQGnRCpA6s2qm7odUj275QF/gbux+ez9cpHuSpOJLpTHKRg/XPK9UUnLfO5STuQR/6YuNqpLdc62rwRWkgm4eBaGHM2yNxib8Um6pbDg8ak623vM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140792; c=relaxed/simple;
	bh=LfhtLSkoQIXUMb0faskn0qzBv6pkLsH+d48xyDJI2cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBKppyutyjkJm6keqvr9wpt4F668y50bwAftCpi5WIecL/ZAgICiNOsM4KyL7m6SNwRM73ZWqAYoO4wc0M1w6vfHvge9Lq47YXT/Qo2uf8y2G2nbZlRImeiIVOdcrz4xBgFe3YJ+bKYfzVgxmkII7L2p0LnCk2KM4rWeiLnUT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBb888os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8D4C2BCAF;
	Tue, 10 Mar 2026 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140792;
	bh=LfhtLSkoQIXUMb0faskn0qzBv6pkLsH+d48xyDJI2cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBb888os6AWHLve2J6tynYCRUgK8DkIclzqx9JtYeWpeEo7piD6N1hwBEuKgN+suv
	 4vsab9AXX+iBWX0r1VB2Wj71HGavQR1pDBLrzzixDvIcYBhuXcVK+O5w1R+QC89uqB
	 xKQMNLzQYTKtJO3RgmslzIl8A2ecjJPIHdi3L+enh3Sn0O69hFqxSVfkT4QevFoam2
	 MDweRYd3lZjzE2IppeoLu73roE9vz5MLfqq05Lbw3ZKE2YWYfc+u344zJLSnzkqVG7
	 B87LKTUjlqGcR0itvP9ZNR/4na5Hvh/iaYnnqvzRND3ZBXRDd34g0Z2+Nfa18cgOM0
	 halAMzkvcGUMA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wang Tao <wangtao554@huawei.com>,
	Zhang Qiao <zhangqiao22@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 028/311] sched/eevdf: Update se->vprot in reweight_entity()
Date: Tue, 10 Mar 2026 07:01:15 -0400
Message-ID: <4fd89e66b5f25c191e24f59764c7d7f15420e1e5.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FE0B24A1EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223892-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email,huawei.com:email,amperecomputing.com:email]
X-Rspamd-Action: no action

From: Wang Tao <wangtao554@huawei.com>

[ Upstream commit ff38424030f98976150e42ca35f4b00e6ab8fa23 ]

In the EEVDF framework with Run-to-Parity protection, `se->vprot` is an
independent variable defining the virtual protection timestamp.

When `reweight_entity()` is called (e.g., via nice/renice), it performs
the following actions to preserve Lag consistency:
 1. Scales `se->vlag` based on the new weight.
 2. Calls `place_entity()`, which recalculates `se->vruntime` based on
    the new weight and scaled lag.

However, the current implementation fails to update `se->vprot`, leading
to mismatches between the task's actual runtime and its expected duration.

Fixes: 63304558ba5d ("sched/eevdf: Curb wakeup-preemption")
Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Wang Tao <wangtao554@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260120123113.3518950-1-wangtao554@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f66d4f0540ea..c8a6dac54e220 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3816,6 +3816,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr = cfs_rq->curr == se;
+	bool rel_vprot = false;
+	u64 vprot;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
@@ -3823,6 +3825,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		update_entity_lag(cfs_rq, se);
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
+		if (curr && protect_slice(se)) {
+			vprot = se->vprot - se->vruntime;
+			rel_vprot = true;
+		}
+
 		cfs_rq->nr_queued--;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
@@ -3838,6 +3845,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	if (se->rel_deadline)
 		se->deadline = div_s64(se->deadline * se->load.weight, weight);
 
+	if (rel_vprot)
+		vprot = div_s64(vprot * se->load.weight, weight);
+
 	update_load_set(&se->load, weight);
 
 	do {
@@ -3849,6 +3859,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		place_entity(cfs_rq, se, 0);
+		if (rel_vprot)
+			se->vprot = se->vruntime + vprot;
 		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
-- 
2.51.0


