Return-Path: <stable+bounces-212410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEQSG9oxemlr4gEAu9opvQ
	(envelope-from <stable+bounces-212410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:57:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB01A4C97
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEC0030445B3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16FB2F25EF;
	Wed, 28 Jan 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWdBBx23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACF288C22;
	Wed, 28 Jan 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615424; cv=none; b=dDLdm1VbiW6REWXqI2pEpDOgDOGImN4QuAIXu63im3N9jrR9Kt6/1nA5Sx4fD+OaYPGrnG9LKmpY+spMlA8kcpiOQAr6oJv97wA03d6ztfeLo3EkGbEfoTjLd8bltbIFPCcuNqx7/Q9dOf6eTJEjUpaqVaXro8byrIsVMwi47s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615424; c=relaxed/simple;
	bh=OA8TuQYIQ7XBj8Ad3PQFjcSol22+Ko0ATrdPLDJZNwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2hTMDJOIHOYeMiU6FK34pGdNM8Q4UxhenfHsvEbicYYFheg7rwF6vTlLHjJe9hHKMsnR61gQD5Lugrp9mLwUQpFtVQJ8/qiV7mP3tM+ZjUj4XmPWuzAS8fHJXT+HwuyHu0YqoP+SX2xksuuTieamYyhbPy7MqyiUIJQAulwjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWdBBx23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BE7C4CEF1;
	Wed, 28 Jan 2026 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615424;
	bh=OA8TuQYIQ7XBj8Ad3PQFjcSol22+Ko0ATrdPLDJZNwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWdBBx23dH2ivjgUbte9dhC8FpimQEU/2jVPgE5CESunVZ2XS7G8XIvedVdV8ERdp
	 o5rvlIvt90NkEsbJg4noOuJvFKfS5IXEIh0L3AiSdeySw20OWgjVkJZHySIKwBj+PW
	 W1fSTuGSeTZw3j5Ergt//5DKQE3DoAKUub5Cq55w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Chen Yu <xnguchen@sina.cn>
Subject: [PATCH 6.12 157/169] sched_ext: Fix possible deadlock in the deferred_irq_workfn()
Date: Wed, 28 Jan 2026 16:24:00 +0100
Message-ID: <20260128145339.663065960@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212410-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.dev,kernel.org,sina.cn];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CCB01A4C97
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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



