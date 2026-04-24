Return-Path: <stable+bounces-241038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HvmzKtPW62luSAAAu9opvQ
	(envelope-from <stable+bounces-241038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 206544634DE
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A194D306D86D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A843FFAC2;
	Fri, 24 Apr 2026 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDpGhsiM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764823FBEDF;
	Fri, 24 Apr 2026 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063470; cv=none; b=c1GLmWsHehVMNHRCEY4wSehsfm9fnSkcmqy+Zk1rMsVywnctTfWUcIMuWZl5JFXOnf91ahB6xNly8mbd7MGiwJkWfC1BXm9X3MZs1XDnaYqxmS+CynyOYlxFleYC3HtBDkAiFnfjylRF+9KDf/TlJYFC1/0Qi5eP+cfiVoBU5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063470; c=relaxed/simple;
	bh=ub2HjRnRhsO82hYhvfuT5DCGaDAB9eGtDiAAH82Q+Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSrzanpTTSWAIfKIDTF7mSNPEJjrCRTm+fBgR2IZ+XF8HDHTZ9SJ+4sBqDRjDmoW0sjXA/ozPDckv+drRRBnrzPpunoyU7I63wUKK+mTt11G6twW/8wN+mGYkVo6vPH2AcQvYLQeKfnjT0cHbjspnK2BGPQhGijO+nwSYT4+uzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDpGhsiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E27CC2BCB0;
	Fri, 24 Apr 2026 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063470;
	bh=ub2HjRnRhsO82hYhvfuT5DCGaDAB9eGtDiAAH82Q+Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDpGhsiMDn/iOj6hijnFRPowFzarzfWDE/rx67TyK4R9l3yykMkHcksomGxoBNx6s
	 iRpQxixVhUWtSmBpBk4IkZ/zYee92LjHnACXDHEWf6f4xCm6nd7DY0/Rf/zzIgzvzU
	 WZMITIUnWnKhT1CsPJDYIROLZlA/G6RJCAJP5noDkWt1FHVC3kB6jiHoN2G/w3aKuF
	 O9dytaURBaCRMq0mXoe4aWjGbjw4+XzmaydMjm2U8KZsQ9T1+inN5Ux5hYDElrc3RN
	 bCINJfMZ49NSd3S80nqrw2ADk0upNM/Kl8OYUNVrvNcoDmcYVz+K6OAjPdrxxtp294
	 o0pYQsVDUKcEA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 10/13] sched_ext: Pass held rq to SCX_CALL_OP() for core_sched_before
Date: Fri, 24 Apr 2026 10:44:15 -1000
Message-ID: <20260424204418.3809733-11-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 206544634DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241038-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

scx_prio_less() runs from core-sched's pick_next_task() path with rq
locked but invokes ops.core_sched_before() with NULL locked_rq, leaving
scx_locked_rq_state NULL. If the BPF callback calls a kfunc that
re-acquires rq based on scx_locked_rq() - e.g. scx_bpf_cpuperf_set(cpu)
- it re-acquires the already-held rq.

Pass task_rq(a).

Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 90008be04c7c..da188af21b3d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3198,7 +3198,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
 	    !scx_bypassing(sch_a, task_cpu(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch_a, core_sched_before,
-					      NULL,
+					      task_rq(a),
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
 	else
-- 
2.53.0


