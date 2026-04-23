Return-Path: <stable+bounces-240399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HqdlO0d16Wn0aAIAu9opvQ
	(envelope-from <stable+bounces-240399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:26:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7844C1D1
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE3D302E795
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663CC388E7A;
	Thu, 23 Apr 2026 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrUJxbhW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA7219303
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907588; cv=none; b=Y1BmTc1EmFCU3jeWaSdgWe/T3ORK7n18Q4N4L7RLjHf7G3f8MfyV755A8ozQxx8XqPVEqZGbwqdrlzfVxEiHhiM3CvX3r8sbeXoKf5iJV5+dRo5pYCfnY2eIHPpwlWCt9zefgZWKw4janKaIV1Ir128O+K21/5t9lKI9BgbaqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907588; c=relaxed/simple;
	bh=38ygI611/cZr81uZTau/J3OdOllPwcSbiwlV4VAuy1A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QMlq1HmzYB3CJ/niIUS6xLcnIkGg0yd1ulV06H6EnAGpg1N4Y0TwlwUT/RAi+RtCuvT7ytS1aEl5lQqo+PJ2GJdaDlPwTVvBqPNFmmRa83uq/gXFySSqri8rlW3gryJwctNTQegCQ5WqCG2gwoUe8A8Kbm3S5cYgr6qBlCVCRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrUJxbhW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so57234525ad.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776907586; x=1777512386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a1iYRsPBV1u1X550LvvoKYrPaq03SnhZdHv11Z08TPk=;
        b=ZrUJxbhWbqmRLdbS+P4tWNAJs7SV3xM4Os8VUVJBK9COsa9bKCSQdK470EYuKSup6w
         W40ll69+NmHR/YtBLOMBX9hdEU+IA1lbEXX3AB+OBmym0aRYJpfMeIV+D79OW6TCqzcz
         0tPReOjlyLAmXO0glERdaYbLa/cfUsjN3hSr7j0nDQHuOmLr6Uc4n8abKZW3pESHPp+z
         D9mj25ZJTqn9LflwpzSBTZZIpqGrnjaMJRjPLLctueoWxWs+Nr57pd+O9N3kJ9H4NEVV
         xbpGcKQm+QpowmdNoCqpW1h3CKzbjAcRKYjCEJ+13nw0CKVrjJiAGYRr+UbHcezuuA0U
         vRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776907586; x=1777512386;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1iYRsPBV1u1X550LvvoKYrPaq03SnhZdHv11Z08TPk=;
        b=C4l3HFkyMYRYxtd2oEqpNs4SFDJp4g94aUfKbcW0mJfzz7YqSrM3FpuIMBVEy8RBaQ
         /MW6+I/PSu6l61IJuLQnGBtjQpcSXJ7/1mENDCi5I8dIke3uTFaaWypEh35wZ0w0Zb7D
         DL7JiblqFnRR5AiVM3x5/+3pqdS99p1tMfFWDKDA78U+qSgNBVmr3J0EWkYTeS5TV3hI
         FAcQSEbYSh/ds7tof/0eGO1wsPBczZgr3lYxgtwVQFe4adoDu5Xw4SKAcUq4e9VjcVWU
         ByFfRCeDg1zn/ctx2p+pVs8YohGupf0hACrIKZdCirCpMmycforhQfd2C6Zi5SXAIlJB
         iIiQ==
X-Gm-Message-State: AOJu0Yy4qyGagwOfcj0n5VdJBkYmunGz4uB2RNcz6GPvI5UV+IPvGl4j
	sxsWSqTH19eYc+Z5DN61ZbNczrdpZZf/2phxgnNCuBHBKFNw4Uh2+MtaRSZqxl87wTyYMbd4o7P
	CpE/5TZoXTqTDt+J8uzju8czjLI6plHY738etEh8R61TPOtOV0BdlS99vW0NAFnWQfnuTO7KeXx
	frcul7a3KVy8yPqir8GoOaBm+NpmtHfb4FFeSlfYgH
X-Received: from plbjw21.prod.google.com ([2002:a17:903:2795:b0:2b2:5616:36aa])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f645:b0:2ae:5163:c2aa
 with SMTP id d9443c01a7336-2b5f9f519e5mr247784565ad.20.1776907585932; Wed, 22
 Apr 2026 18:26:25 -0700 (PDT)
Date: Thu, 23 Apr 2026 01:26:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423012619.980559-1-jstultz@google.com>
Subject: [PATCH 6.18] sched/debug: Fix avg_vruntime() usage
From: John Stultz <jstultz@google.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, K Prateek Nayak <kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240399-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linaro.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 41C7844C1D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Zijlstra <peterz@infradead.org>

commit e08d007f9d813616ce7093600bc4fdb9c9d81d89 upstream.

John reported that stress-ng-yield could make his machine unhappy and
managed to bisect it to commit b3d99f43c72b ("sched/fair: Fix
zero_vruntime tracking").

The commit in question changes avg_vruntime() from a function that is
a pure reader, to a function that updates variables. This turns an
unlocked sched/debug usage of this function from a minor mistake into
a data corruptor.

Fixes: af4cf40470c2 ("sched/fair: Add cfs_rq::avg_vruntime")
Fixes: b3d99f43c72b ("sched/fair: Fix zero_vruntime tracking")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20260401132355.196370805@infradead.org
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 93f009e1076d8..3504ec9bd7307 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -798,6 +798,7 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
 	s64 left_vruntime = -1, zero_vruntime, right_vruntime = -1, left_deadline = -1, spread;
+	u64 avruntime;
 	struct sched_entity *last, *first, *root;
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
@@ -821,6 +822,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	if (last)
 		right_vruntime = last->vruntime;
 	zero_vruntime = cfs_rq->zero_vruntime;
+	avruntime = avg_vruntime(cfs_rq);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_deadline",
@@ -830,7 +832,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "zero_vruntime",
 			SPLIT_NS(zero_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "avg_vruntime",
-			SPLIT_NS(avg_vruntime(cfs_rq)));
+			SPLIT_NS(avruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "right_vruntime",
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
-- 
2.54.0.rc2.533.g4f5dca5207-goog


