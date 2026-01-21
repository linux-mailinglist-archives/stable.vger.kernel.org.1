Return-Path: <stable+bounces-211030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNvSOc82cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:27:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB965D37B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC6553ABCA2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F2358D0F;
	Wed, 21 Jan 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOxUrOWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F53A7E12;
	Wed, 21 Jan 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020199; cv=none; b=YoNlSRnrt6f83xb1ajfFjfm6sMdZcO4BCpNuepnr0Dc2M9aLyfyqNDx+NBq37fWbvmbTraL6jJNfT5ULsXjY9DtTqDJLZGSAzzWea8fiGe78LeXmbayfJahIYtTknfgnrR0urmrPkqDBSuLMGTrhgRlwvmRtWo789qlgzH/nWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020199; c=relaxed/simple;
	bh=0zwP8Y4yP9zZvxjfuG9/arxkqB3IMRx9wK3tRvqOB3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL2gJTi1pAz7qfLO1F+X8nQS2o1elS9zVcLOtbyLvq2zUh0FKkQNrnpV/9YXHQdOSpR4teBIjn+Br6M64v/RtwFdM4kXPkQLGYcoZgRcA4Sx9fCCZvKIYm/5sYiOpPFZf/lPLO7q8EyoMw6iF/FjM+zrtqUEJpEU29W+Py0dvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOxUrOWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD211C4CEF1;
	Wed, 21 Jan 2026 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020199;
	bh=0zwP8Y4yP9zZvxjfuG9/arxkqB3IMRx9wK3tRvqOB3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOxUrOWoLCcL4lz0Umj8bsOpVTsgZo/LWfU50rG6gbrXMe34WEO9mNVjv/QPzLHbA
	 U/g4gWtkv3ZVrsHx8EKTp0XvIz4lBmdlxVVxfg4vvaRZxm8askXvbzX/0KkJa7lpAC
	 UMx7hXFaLfnUWoAQ38IJMfGwFqKkmhgWJIBzMJOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 088/198] sched: Deadline has dynamic priority
Date: Wed, 21 Jan 2026 19:15:16 +0100
Message-ID: <20260121181421.725093197@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211030-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6EB965D37B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit e008ec6c7904ed99d3b2cb634b6545b008a99288 ]

While FIFO/RR have static priority, DEADLINE is a dynamic priority
scheme. Notably it has static priority -1. Do not assume the priority
doesn't change for deadline tasks just because the static priority
doesn't change.

This ensures DL always sees {DE,EN}QUEUE_MOVE where appropriate.

Fixes: ff77e4685359 ("sched/rt: Fix PI handling vs. sched_setscheduler()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20260114130528.GB831285@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/syscalls.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb47d294e2c5a..e460c22de8ad4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7383,7 +7383,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	trace_sched_pi_setprio(p, pi_task);
 	oldprio = p->prio;
 
-	if (oldprio == prio)
+	if (oldprio == prio && !dl_prio(prio))
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index bf360a6fbb800..6805a63d47af7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -688,7 +688,7 @@ int __sched_setscheduler(struct task_struct *p,
 		 * itself.
 		 */
 		newprio = rt_effective_prio(p, newprio);
-		if (newprio == oldprio)
+		if (newprio == oldprio && !dl_prio(newprio))
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
-- 
2.51.0




