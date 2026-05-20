Return-Path: <stable+bounces-252001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKK8H/n9DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:31:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BA5966DE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769BB386F350
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712283F4DF4;
	Wed, 20 May 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LRViFI2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862A3F44F7;
	Wed, 20 May 2026 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299486; cv=none; b=S+yX72ykDGfaKaXqc6aCduESOKVlIYiJQ2iG5va2ExCp1ET94lDdI3Je+0I6P17jNKfilMAMSebm2eqTKrDzTVr4oxlY0HxO+Xhz2ZvwH6tR2e9YedHnm1dNIuAJh+CEz0RDtDXqGohfnW9OE+UPnVJNJ6ctwPFkbR/sSQWNJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299486; c=relaxed/simple;
	bh=Msikoipmi+PvgcN0Y7bxLYAlc/yxBZ0b/Sb6YTz1HRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibukTN4zvrxVeCKYNhdee7W4BEsOe/LE24uv1VGRt5Wt/Df1HeW8xtXCFtMbQzI9Y/nV50keHRPKgQ6MV5Se1M4fISrc61MwXnPIQId/O4ifLK2WpE4RGqbq6wdgCsxjIR8vMk/jrue5AaRnj90SBNZ/cP51J6EzL44bh6kLQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LRViFI2j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493651F000E9;
	Wed, 20 May 2026 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299484;
	bh=IWl13lOK7Y6PkYy8+kn4wVgfyFg/vta59YlBaidXFYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRViFI2jiE/lxQ1mup1gcn9+eMe8C9DeADsCaaqgsQ/4rw/Z0ndINVouicmFTSsJX
	 jWkTc+VDqkmhmsrwhYD23yKENWH9e1LuZqwdH7SNJ7x3xIdGUOX+L5sQUrtKFVYM+2
	 JNIxHtA7yqF1g1ASDThLS5h3i4FbSsktPoj1N+RA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zicheng Qu <quzicheng@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	Hui Tang <tanghui20@huawei.com>,
	Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH 6.18 789/957] sched/fair: Clear rel_deadline when initializing forked entities
Date: Wed, 20 May 2026 18:21:12 +0200
Message-ID: <20260520162151.674770057@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252001-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: DB1BA5966DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zicheng Qu <quzicheng@huawei.com>

[ Upstream commit 3da56dc063cd77b9c0b40add930767fab4e389f3 ]

A yield-triggered crash can happen when a newly forked sched_entity
enters the fair class with se->rel_deadline unexpectedly set.

The failing sequence is:

  1. A task is forked while se->rel_deadline is still set.
  2. __sched_fork() initializes vruntime, vlag and other sched_entity
     state, but does not clear rel_deadline.
  3. On the first enqueue, enqueue_entity() calls place_entity().
  4. Because se->rel_deadline is set, place_entity() treats se->deadline
     as a relative deadline and converts it to an absolute deadline by
     adding the current vruntime.
  5. However, the forked entity's deadline is not a valid inherited
     relative deadline for this new scheduling instance, so the conversion
     produces an abnormally large deadline.
  6. If the task later calls sched_yield(), yield_task_fair() advances
     se->vruntime to se->deadline.
  7. The inflated vruntime is then used by the following enqueue path,
     where the vruntime-derived key can overflow when multiplied by the
     entity weight.
  8. This corrupts cfs_rq->sum_w_vruntime, breaks EEVDF eligibility
     calculation, and can eventually make all entities appear ineligible.
     pick_next_entity() may then return NULL unexpectedly, leading to a
     later NULL dereference.

A captured trace shows the effect clearly. Before yield, the entity's
vruntime was around:

  9834017729983308

After yield_task_fair() executed:

  se->vruntime = se->deadline

the vruntime jumped to:

  19668035460670230

and the deadline was later advanced further to:

  19668035463470230

This shows that the deadline had already become abnormally large before
yield_task_fair() copied it into vruntime.

rel_deadline is only meaningful when se->deadline really carries a
relative deadline that still needs to be placed against vruntime. A
freshly forked sched_entity should not inherit or retain this state.
Clear se->rel_deadline in __sched_fork(), together with the other
sched_entity runtime state, so that the first enqueue does not interpret
the new entity's deadline as a stale relative deadline.

Fixes: 82e9d0456e06 ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
Analyzed-by: Hui Tang <tanghui20@huawei.com>
Analyzed-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260424071113.1199600-1-quzicheng@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 522d4bad56ad1..b42a65a79b701 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4453,6 +4453,7 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
+	p->se.rel_deadline		= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	/* A delayed task cannot be in clone(). */
-- 
2.53.0




