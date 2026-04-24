Return-Path: <stable+bounces-241034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFJRAkLW62lISAAAu9opvQ
	(envelope-from <stable+bounces-241034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:44:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FE246342A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EC96301223F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75113FE35F;
	Fri, 24 Apr 2026 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewKkUAf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD83FD14E;
	Fri, 24 Apr 2026 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063463; cv=none; b=fpu6bvtzbwkKle371r/Mnidh/DjuBKhNBZrSHp5qoRIUDfHXrPomSYMM0Mk4p03C7ZGXTx4vEwGk4hOAM6OkHTSbtBpkoOVCLbqZlZBKlav6amy7NKAzGP/PXNO6XB46lc8tcs92lNYurzq6N6ZprXhqqu72vqaloD+QMNefvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063463; c=relaxed/simple;
	bh=BqAdOCk1D5oAloLZseRfFomUyN6bCfzFNQZ2SgsjhEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSGpBEQhuyDanj+fG4p+D8u1B9i4BygP360lxwUvE0Nq7ngjYaUVtVxZcOcxs5v2FvUcwrPlESaurxX0rMk31yMQSyN9MseD2PksuAzQykp+8bn0r4Bcrkb56fa7WqijUc/A04aS3wEBEBVA3f8BD2ipQAxJeD4qnIN2xkVzZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewKkUAf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF824C19425;
	Fri, 24 Apr 2026 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063463;
	bh=BqAdOCk1D5oAloLZseRfFomUyN6bCfzFNQZ2SgsjhEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewKkUAf3IHrJNAL27VGyLyuWXOcrND32jt49Lcg1Z1QC/uDBnVYyHBUlgMX+TKVkY
	 wwID+LFuVdAzWMWv7RqDkz/57oaZ/EaDWK6Ktwj8lV13nHlOcX8JLalbfh//GIV/W6
	 +QI7CDjzo4fDLWpWvYVNUPpUsfDv34MkDobmA4gBPj4GTdGzlVEH0O7mtPcUsSjBym
	 EMLB0ihNEb/DvtfmHXdCzoWau/fAPW5kVDbysafpZ9uM6SJ8tJkerJqVCqTvpZWW2A
	 RFQXZUkoZQH8qOYJWA06llkypxmSm2fmepCUodHVnJhbctVZsrCj7ZNrdOdb4wUnO3
	 XP1op+NqjGsBg==
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
Subject: [PATCH 03/13] sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()
Date: Fri, 24 Apr 2026 10:44:08 -1000
Message-ID: <20260424204418.3809733-4-tj@kernel.org>
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
X-Rspamd-Queue-Id: C3FE246342A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241034-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

bypass_lb_cpu() transfers tasks between per-CPU bypass DSQs without
migrating them - task_cpu() only updates when the donee later consumes the
task via move_remote_task_to_local_dsq(). If the LB timer fires again before
consumption and the new DSQ becomes a donor, @p is still on the previous CPU
and task_rq(@p) != donor_rq. @p can't be moved without its own rq locked.

Skip such tasks.

Fixes: 95d1df610cdc ("sched_ext: Implement load balancer for bypass mode")
Cc: stable@vger.kernel.org # v6.19+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 89170a0e5779..62b4139a4cc8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5002,6 +5002,15 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 		if (cpumask_empty(donee_mask))
 			break;
 
+		/*
+		 * If an earlier pass placed @p on @donor_dsq from a different
+		 * CPU and the donee hasn't consumed it yet, @p is still on the
+		 * previous CPU and task_rq(@p) != @donor_rq. @p can't be moved
+		 * without its rq locked. Skip.
+		 */
+		if (task_rq(p) != donor_rq)
+			continue;
+
 		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
 		if (donee >= nr_cpu_ids)
 			continue;
-- 
2.53.0


