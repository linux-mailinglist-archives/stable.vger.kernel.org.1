Return-Path: <stable+bounces-246378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKhLJCxsA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:06:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59504526C50
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 845D53067400
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE133D51A;
	Tue, 12 May 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/BBvbgo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4923EDE55;
	Tue, 12 May 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609072; cv=none; b=BFsYekuefTe015aLz3OssWe0cx98ED6276YSPl1ZstSJLNcKLRTTu/j+9LzZfLVRoixYfAKKV1p11Vna2V/koaM6IoNgnJmqkzAvV7K5/RW2JSZUm2sGrHcx+Hm20jom6ndRWceqEqs023zZRECm9I5C5ajImuwJbqGr8xNxAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609072; c=relaxed/simple;
	bh=YVFX2J7Max5X+qXLUQXPQw+JPh+5VFQaLflGodOuwsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of9ODIzsPvczB0nTMvasTA2KjneLk8nQZoLSbDxnQHxTb8/DzeuVK2NHPBkdMTv8Pj1BXMqa3buMpIvv0SQ3qu2RoulotTNYHWQ9mVSRDQfRQgV/k/r3Iy/iswgZ1Ib4gYusuTdlAWBHc9jaOYlJO5H4iibNN+Ay5IutDSv2nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/BBvbgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFF4C2BCB0;
	Tue, 12 May 2026 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609071;
	bh=YVFX2J7Max5X+qXLUQXPQw+JPh+5VFQaLflGodOuwsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/BBvbgoLDA1n+PviDTx03Z24xVC0bVg0SBaBsyy+ygfXXs2N4Peld+Q0huO9S7cj
	 z4T5rX1z1Ig4YX8WKaDIw4Y8n37tw4GazE4h2Mo9Bsk/Ww1gUHj/+0uWn62jPRazow
	 /OXbgm2reXtorAqNZDuXmb3+3in12eO1//6CX03c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 7.0 053/307] sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters
Date: Tue, 12 May 2026 19:37:28 +0200
Message-ID: <20260512173941.242946370@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 59504526C50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246378-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 80afd4c84bc8f5e80145ce35279f5ce53f6043db upstream.

scx_group_set_{weight,idle,bandwidth}() cache scx_root before acquiring
scx_cgroup_ops_rwsem, so the pointer can be stale by the time the op runs.
If the loaded scheduler is disabled and freed (via RCU work) and another is
enabled between the naked load and the rwsem acquire, the reader sees
scx_cgroup_enabled=true (the new scheduler's) but dereferences the freed one
- UAF on SCX_HAS_OP(sch, ...) / SCX_CALL_OP(sch, ...).

scx_cgroup_enabled is toggled only under scx_cgroup_ops_rwsem write
(scx_cgroup_{init,exit}), so reading scx_root inside the rwsem read section
correlates @sch with the enabled snapshot.

Fixes: a5bd6ba30b33 ("sched_ext: Use cgroup_lock/unlock() to synchronize against cgroup operations")
Cc: stable@vger.kernel.org # v6.18+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3430,9 +3430,10 @@ void scx_cgroup_cancel_attach(struct cgr
 
 void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
 	    tg->scx.weight != weight)
@@ -3446,9 +3447,10 @@ void scx_group_set_weight(struct task_gr
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
@@ -3463,9 +3465,10 @@ void scx_group_set_idle(struct task_grou
 void scx_group_set_bandwidth(struct task_group *tg,
 			     u64 period_us, u64 quota_us, u64 burst_us)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
 	    (tg->scx.bw_period_us != period_us ||



