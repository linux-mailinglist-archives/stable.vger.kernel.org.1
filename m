Return-Path: <stable+bounces-124919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB54A68D8D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9951E1894EC4
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA305256C98;
	Wed, 19 Mar 2025 13:14:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064DF2571B0;
	Wed, 19 Mar 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390069; cv=none; b=gW/OLgkEkr3ZQ99Fh/1YPZnj+WJ66K+Io9qBGpkjI6lIgDiJj9sRB+kDu+JKlcizXNR/vZTzMV7e/+rBbMBDJg0HwRs2x1bNFuGkrGhXmowueShSSY/nVCIAA0d/2eobBOSG7vXOJpsL4xJ8OqCrxAqq8V3VpRTC3QxGPfQOYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390069; c=relaxed/simple;
	bh=zGMWT/v3NEfu/Nxxc0UVV03hRv2PMBqqu4MGkwowWKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WO1fy2+0WHU8Xb0WeS4SLsgFveCeGDPQTc/2/tTt95b/j51SB9cs4bpo92C0rjdjbTPM6olYVGHx5dKISpkQu4MbdzPJQs8UaT4rhaXWFRiJYDDK8+myY8RW8vwdPZwyRCZBgE8jC6qp3OvKSGCgqZeaWjHYCbMdZMnnLb5+ZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FACEFEC;
	Wed, 19 Mar 2025 06:14:35 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.85.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D884D3F673;
	Wed, 19 Mar 2025 06:14:24 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com
Cc: juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	vincent.guittot@linaro.org,
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] sched/topology: Fix EAS freq-invariance print
Date: Wed, 19 Mar 2025 13:13:24 +0000
Message-Id: <20250319131324.224228-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319131324.224228-1-christian.loehle@arm.com>
References: <20250319131324.224228-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing newline on frequency invariance check to ensure the EAS
abort reason doesn't go missing.

Fixes: fa50e2b452c6 ("sched/topology: Condition EAS enablement on FIE support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 27f14a775004..18e804b416f5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -245,7 +245,7 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 
 	if (!arch_scale_freq_invariant()) {
 		if (sched_debug()) {
-			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported",
+			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported\n",
 				cpumask_pr_args(cpu_mask));
 		}
 		return false;
-- 
2.34.1


