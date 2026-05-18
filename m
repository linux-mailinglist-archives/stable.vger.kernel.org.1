Return-Path: <stable+bounces-249176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJVQBEaHCmpl2wQAu9opvQ
	(envelope-from <stable+bounces-249176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:28:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99E5656A3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AFDE300B3CA
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074F3803D8;
	Mon, 18 May 2026 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhfJ6jBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B90212542
	for <stable@vger.kernel.org>; Mon, 18 May 2026 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074883; cv=none; b=ouCZtut4/mPlHi/l0mGtoA7TNJlzU0W3tB8u8SoMCJ8LDQlrgBF0YrOWFvkNTyG2EQ0ETASIUFyBrvMyws3xWZ+gILH2sxDdoMj7HdZRF1CkP5idDULmyr51XkARHRjWfEgH6sPOc2c0NQuUGlRErTriJ2ZHQizAxEv+7xBsvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074883; c=relaxed/simple;
	bh=Y6AiHMzld19Y9qjM11PpsRRCeLlcbQ0okP0i7rLUQRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXmQmB23KNkXk11ArRekx8sqculvKKXmYfbiFWsFE4TRSo789+y+63fATbuAkqZQNmsnOgNldUTyAR8RQo0zle3yg+CFpMhz143lh+4b/2ICZfy9GTcoYB8qcN5yTwNHUJo330jp9YqsY3zhFDrUN7yWbVDRWg8I6zb/q6yFPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhfJ6jBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889ACC2BCB0;
	Mon, 18 May 2026 03:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779074883;
	bh=Y6AiHMzld19Y9qjM11PpsRRCeLlcbQ0okP0i7rLUQRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhfJ6jBpo2uAs50jeHI8mLBhT+vkaRtFgMpwkmFUO7H8yNXPGt1VSGkIvLxl2A4nw
	 x3z5Yk06/LcE0sFcM+wV4J070oVx/m461aGUszfHnuzs18vf31hoLujOLygMXDCcQ2
	 hqOqCe6PI+LMS/oxHY1T1tvG/gOnA/mw3kMP2K+3LKk/h/pfoYyXYTymdC++QA5t5g
	 5oTyEabQ4vPm6Ts4tV6AskY3bjMQhcHK8ZqnYFcLNZxUzTjn826l5a9FKOnGHEi0Pq
	 mLo4lGZdDjb+SB5/9yfcU1MFAkw0/IZ0RCDtSf7phuePol4Mqt6jvD60SWVgcArbIq
	 fE8LOfPGR+vxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Chris Mason <clm@meta.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Guard scx_dsq_move() against NULL kit->dsq after failed iter_new
Date: Sun, 17 May 2026 23:28:00 -0400
Message-ID: <20260518032800.587649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051201-visibly-fossil-2e59@gregkh>
References: <2026051201-visibly-fossil-2e59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C99E5656A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249176-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 4fda9f0e7c950da4fe03cedeb2ac818edf5d03e9 ]

bpf_iter_scx_dsq_new() clears kit->dsq on failure and
bpf_iter_scx_dsq_{next,destroy}() guard against that. scx_dsq_move() doesn't -
it dereferences kit->dsq immediately, so a BPF program that calls
scx_bpf_dsq_move[_vtime]() after a failed iter_new oopses the kernel.

Return false if kit->dsq is NULL.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ dropped the `struct scx_sched *sch` declaration and `sch = src_dsq->sched` line ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 25df16aed142a..f24579675cf32 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6346,6 +6346,14 @@ static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
+	/*
+	 * The verifier considers an iterator slot initialized on any
+	 * KF_ITER_NEW return, so a BPF program may legally reach here after
+	 * bpf_iter_scx_dsq_new() failed and left @kit->dsq NULL.
+	 */
+	if (unlikely(!src_dsq))
+		return false;
+
 	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
 		return false;
 
-- 
2.53.0


