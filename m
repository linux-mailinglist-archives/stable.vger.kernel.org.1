Return-Path: <stable+bounces-249261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMTIDPn8CmqA+wQAu9opvQ
	(envelope-from <stable+bounces-249261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:50:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B156BF55
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67B413018D47
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD73F6C4C;
	Mon, 18 May 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND0E+zry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6E3E6DE4
	for <stable@vger.kernel.org>; Mon, 18 May 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104907; cv=none; b=IDi5a4hACTYCLqxqNHM3qRaiS/eajN96uVmfJsxt7VrveJDZ2MoxqzCRbII16WQ6eHR0q6/mqZSi6juG64b7AujW4aa4VRJTSjm4sYtCMQUwOUg8DK0sBI8DB9T/jDnaDK/n7aZ6OdRo5YY4u9mjer47R21FXiXSQMnZZnFvh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104907; c=relaxed/simple;
	bh=cTCWTFviCDAZ311FSdj9ulxiVG8gs0Bxn7kbhVx2FlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc37/vjN9CHil2Ke6aogTwgGGnDfeeF5TliqS0HlhdfxSVQFklB2/TB6us6zxtOr6i+pyEUwM2MSLIY/JLJOR+Da7nmzexRkiw/DhT6OyFmd6DGE+QMjCVgfy49GNChndrtiJLFJdA/OL/HABkir7IpBwysygh+3Qkc7YUfB4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND0E+zry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19859C2BCB7;
	Mon, 18 May 2026 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104907;
	bh=cTCWTFviCDAZ311FSdj9ulxiVG8gs0Bxn7kbhVx2FlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ND0E+zryIFyeBHnxVQdk9p6tAU9kAogAkdKwuaS8zg5JwyW2DD/gG0Na5ezQuGV65
	 FwozTvldTJI4+iZSd+auCaOaR6KxRHo6vXzZTQfeQ7sqUNdZtASHicodvjTGUn7uvD
	 6d2mOEHgQg4HNAz23sR63szTTkeunVzLpaC/gFZwCG3qjj5R7rIBYgFFxWAAnuNrL9
	 9dWCw+YAWEqOCIiNOgbBIW9DVPfzWvdqaJR6Wi+41IHFjMo3DPRAzcu7Sfhhr8v2i5
	 XD6Ohvf6zncdp8NCygz463OeRCc/BZPT0G2pF+0SANwoQ43NgrLoiORaRLO67xwAeA
	 WcxWDRGvIr0Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Chris Mason <clm@meta.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Pass held rq to SCX_CALL_OP() for core_sched_before
Date: Mon, 18 May 2026 07:48:25 -0400
Message-ID: <20260518114825.789656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051216-garage-angles-0119@gregkh>
References: <2026051216-garage-angles-0119@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE1B156BF55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249261-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 4155fb489fa175ec74eedde7d02219cf2fe74303 ]

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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ adapted call to use stable's single `sch`/`SCX_KF_REST` mask and `scx_rq_bypassing(task_rq(a))` signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 177bbf31116d0..29d3663fe4dcf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2522,7 +2522,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	if (SCX_HAS_OP(sch, core_sched_before) &&
 	    !scx_rq_bypassing(task_rq(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, core_sched_before,
-					      NULL,
+					      task_rq(a),
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
 	else
-- 
2.53.0


