Return-Path: <stable+bounces-211327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO0cNC7jcmkyrAAAu9opvQ
	(envelope-from <stable+bounces-211327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 03:55:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7D36FDCB
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 03:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F88300F17F
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C932D42A;
	Fri, 23 Jan 2026 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="aXGnUCeP"
X-Original-To: stable@vger.kernel.org
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5413319610
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136935; cv=none; b=TgXqi7yzKIBBYp/fMvcH+DWVA6jt42vDNed6xZ9R9DtoDyJsih7UgYLbc0ACYpIXWRbuahasnrVukCnXPKE4VAwfYyRKuu3eR7j73zDf+gyhVVE+Rur+UaBk6rgda3hXmyg5TLTz6SqQbOOLb3cqyPCScPrWlehsfVK0+DcxmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136935; c=relaxed/simple;
	bh=sFB4cvqbcJv5bB4obUEpve8OrWbmWGd2leraogpiNwI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TSsE8SBeIC6PtnjRoUwEMAjjJf9o7XqkpuwOo+YddJqYZr3ORCVedu5vzU6FbJ+jMhcuhMHJaGGGHl2LbLmuXpNhykaBN/aGcxNTqLHvCHcyXLqj3vWFnS0Mbohlai1ja84wzYL2furEdO4CDmV6mZ1Rqdu7BB/bC637GDMa2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=aXGnUCeP; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1769136907;
	bh=1AZraIqFNxsoX+AOKd5m0LmUccWPz+Izq8FztWWyJiw=;
	h=From:Subject:Date:Message-Id;
	b=aXGnUCePk+LHQsTgWcKpUssAwD0F+xgEOUejpuwnAAxzQBrFK/NidgdK8sGeZwpBt
	 NuqBu2b3iL2Py643uhqWqctcVTpNFJG2LlMMwLMRG2xWmtC3/1DBIbGamwiSAW6Md3
	 U5xE+IJWoGrr0vNfcXlIkSwpEx0V8gZXsg3SH2U4=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([183.241.245.115])
	by sina.cn (10.54.253.32) with ESMTP
	id 6972E26E00005606; Fri, 23 Jan 2026 10:52:33 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 2138004456614
X-SMAIL-UIID: 23DEF36AA4864D2B85F8B6ABD419775A-20260123-105233-1
From: Chen Yu <xnguchen@sina.cn>
To: qiang.zhang@linux.dev,
	tj@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12.y] sched_ext: Fix possible deadlock in the deferred_irq_workfn()
Date: Fri, 23 Jan 2026 10:52:25 +0800
Message-Id: <20260123025225.2132-1-xnguchen@sina.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211327-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xnguchen@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[sina.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE7D36FDCB
X-Rspamd-Action: no action

From: Zqiang <qiang.zhang@linux.dev>

[ Upstream commit a257e974210320ede524f340ffe16bf4bf0dda1e ]

For PREEMPT_RT=y kernels, the deferred_irq_workfn() is executed in
the per-cpu irq_work/* task context and not disable-irq, if the rq
returned by container_of() is current CPU's rq, the following scenarios
may occur:

lock(&rq->__lock);
<Interrupt>
  lock(&rq->__lock);

This commit use IRQ_WORK_INIT_HARD() to replace init_irq_work() to
initialize rq->scx.deferred_irq_work, make the deferred_irq_workfn()
is always invoked in hard-irq context.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Chen Yu <xnguchen@sina.cn>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9f03255ec910..7e79f39c7bcf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6044,7 +6044,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
-		init_irq_work(&rq->scx.deferred_irq_work, deferred_irq_workfn);
+		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
-- 
2.17.1


