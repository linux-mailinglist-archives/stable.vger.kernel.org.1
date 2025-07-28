Return-Path: <stable+bounces-164874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F9B13355
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D00165B97
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 03:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5621EA7C4;
	Mon, 28 Jul 2025 03:08:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F31F4606
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672132; cv=none; b=fz3b2dhGUR2DTDII2ANHG+bZuk1ijQf4dKoxHJX/vks1HdlLCs7NbUGCotb9leg+DFJ3P/lHdBXrfN7y832bDP6+n/MCLYA3YcNpy2UVAndL9OGTeqL19I9y1pf+w9/CWt146/BaMf0FcFHfuIgvmWOskvShWUsNaRT8MSrHXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672132; c=relaxed/simple;
	bh=LHBmeIa19IMKeKIlGR/byR16EyOel+tFxkosgb9hiVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFmB4/0Dcy/AbQkf+SdfPGBHaifRYNPJfILKfJwao6YJxjClt4NbUCLav6ggQt17ac75UQi1TLCbiujIglRB5+wNwsi2XTc/EHkU4UEd0oMe5JSKKpHAU2pVLGzrEnSCZ3NMF5P/HKtfi2VMdgBeUVFT4wszDDOuE8KL8UsF/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br3N16yGVzYQv46
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A505E1A102B
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:48 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCXExS56YZokj7rBg--.58859S3;
	Mon, 28 Jul 2025 11:08:48 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	pavel@ucw.cz
Cc: stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH 6.6 1/5] sched/core: Remove ifdeffery for saved_state
Date: Mon, 28 Jul 2025 02:54:40 +0000
Message-Id: <20250728025444.34009-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728025444.34009-1-chenridong@huaweicloud.com>
References: <2025072421-deviate-skintight-bbd5@gregkh>
 <20250728025444.34009-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExS56YZokj7rBg--.58859S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW8Zw1UJFy5JFyUJFyxXwb_yoW5JF4xpa
	sYgrWxGayUGr1Iqry7A3yDCF9xGwnrXw1UGrZY93y0yFy5t3yFqr1vg343JrWrWrZIkFya
	qrsFvr4Skw4jq3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6
	pB-UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Elliot Berman <quic_eberman@quicinc.com>

[ Upstream commit fbaa6a181a4b1886cbf4214abdf9a2df68471510 ]

In preparation for freezer to also use saved_state, remove the
CONFIG_PREEMPT_RT compilation guard around saved_state.

On the arm64 platform I tested which did not have CONFIG_PREEMPT_RT,
there was no statistically significant deviation by applying this patch.

Test methodology:

perf bench sched message -g 40 -l 40

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/sched.h |  2 --
 kernel/sched/core.c   | 10 ++--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 393c300347de..cb38eee732fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -753,10 +753,8 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
-#ifdef CONFIG_PREEMPT_RT
 	/* saved state for "spinlock sleepers" */
 	unsigned int			saved_state;
-#endif
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 760a6c3781cb..ab6550fadecd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2238,17 +2238,15 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 	if (READ_ONCE(p->__state) & state)
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT
 	if (READ_ONCE(p->saved_state) & state)
 		return -1;
-#endif
+
 	return 0;
 }
 
 static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
-#ifdef CONFIG_PREEMPT_RT
 	int match;
 
 	/*
@@ -2260,9 +2258,6 @@ int task_state_match(struct task_struct *p, unsigned int state)
 	raw_spin_unlock_irq(&p->pi_lock);
 
 	return match;
-#else
-	return __task_state_match(p, state);
-#endif
 }
 
 /*
@@ -4059,7 +4054,6 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	*success = !!(match = __task_state_match(p, state));
 
-#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Saved state preserves the task state across blocking on
 	 * an RT lock.  If the state matches, set p::saved_state to
@@ -4075,7 +4069,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 */
 	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-#endif
+
 	return match > 0;
 }
 
-- 
2.34.1


