Return-Path: <stable+bounces-200654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E6ACB2481
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F71E301D325
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3744303CAF;
	Wed, 10 Dec 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gjs8m2jk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01762FF16C;
	Wed, 10 Dec 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352140; cv=none; b=nwHRXilbql8SYl8FCTUA3XWkczLxyfgMFo/24ylWFtcHYnCD02iuqyDcQ9Y/gQJArDMWm5gGJStUVsB9Aomw1rp9gJm2SVMWIozho66BjhyEQes/rZOeoxbRsqjb6JlbWqXLmtB+2cFTerT08fLj7YKfnDFGefAvPrwmrfqyTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352140; c=relaxed/simple;
	bh=w3J+lvelb6Bkn/bv7QxQ+9r1agNo4xIcVeKghHjC2r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERkq0ks4dl/nmlsWKKW87m/WVgia+XIj5tsaLhu8cb1B9eCOHX6c4Q8nmXOV2cPC3xuh7Wsb5I0dyYshyXaPWrzuD9VE7koyM3LEmDU/svoYJ5YLO10wn9iu3X/7D/yqxv20d/J1E/KRbtxjWYfvbyiRz98R+GQScNe4RXpyMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gjs8m2jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2822C4CEF1;
	Wed, 10 Dec 2025 07:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765352140;
	bh=w3J+lvelb6Bkn/bv7QxQ+9r1agNo4xIcVeKghHjC2r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjs8m2jkI6eXLjESzTnOTR6iKZC740v2tDughtzIkmdBrzGtqQhrwSpms8MlOfwOQ
	 1qrQaXGeXGNYTH21uvOBM/YeoOSDLRTSvbZ17faW+YfV/v31ac08qY11QEjqA2j2Od
	 HdLBRQSZAU7JBgCDr1pTuXcnoIoG1D+/zWnhW7NM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 47/60] sched_ext: Use IRQ_WORK_INIT_HARD() to initialize rq->scx.kick_cpus_irq_work
Date: Wed, 10 Dec 2025 16:30:17 +0900
Message-ID: <20251210072949.035868693@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
References: <20251210072947.850479903@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zqiang <qiang.zhang@linux.dev>

[ Upstream commit 36c6f3c03d104faf1aa90922f2310549c175420f ]

For PREEMPT_RT kernels, the kick_cpus_irq_workfn() be invoked in
the per-cpu irq_work/* task context and there is no rcu-read critical
section to protect. this commit therefore use IRQ_WORK_INIT_HARD() to
initialize the per-cpu rq->scx.kick_cpus_irq_work in the
init_sched_ext_class().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 16a7ae9b29ae4..9592579db949d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5378,7 +5378,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
-		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
+		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
 			cpu_rq(cpu)->scx.flags |= SCX_RQ_ONLINE;
-- 
2.51.0




