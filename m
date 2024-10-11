Return-Path: <stable+bounces-83450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA2999A4F9
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A921F2262F
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3821644E;
	Fri, 11 Oct 2024 13:26:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02C20CCE6
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653218; cv=none; b=GFCX5rULzMYdRs/6VFj9V1qoJqwo/iILsw9vCavA8Kjaa2nTUlMhXxzgB3qQDxcAF5CnG/mDpQHbAUOwE3Np1vMsSzwcmiDRkwetXwzT6ZBTVqRDFEkFwXuHhltgLk6CGm9Iel6859VXHG74N9fN1C3n6NbmSbxcOExaGa0qzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653218; c=relaxed/simple;
	bh=TKxnXDkGhATn0FqIrpUz5udTcw+K0UUOvMulDmQ8L8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4Ny9a9rmTb+nE5NS/usb/u48rfgrcv1no+o51DFIxlx/S6zBvcMPtWwlJBQ8R2sqrHnzupvtqyM3/8v5xakG4ZWGwo34eiutFe/cwJLo7nMSziYuxO2neu0c91FjE9iNqIBltqdGAGfYdADV64N4+YFvtHc8nHDUBUTEotb2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F1B3DA7;
	Fri, 11 Oct 2024 06:27:25 -0700 (PDT)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.129.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EADF43F64C;
	Fri, 11 Oct 2024 06:26:53 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-eng@arm.com
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Chritian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC PATCH v2] sched/fair: Fix integer underflow
Date: Fri, 11 Oct 2024 15:26:12 +0200
Message-Id: <20241011132617.1331268-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011132617.1331268-1-pierre.gondois@arm.com>
References: <20241011132617.1331268-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
(local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.

Use lsub_positive() instead of max_t().

Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")
cc: stable@vger.kernel.org
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..6d9124499f52 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * idle CPUs.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0,
-					       (local->idle_cpus - busiest->idle_cpus));
+			env->imbalance = local->idle_cpus;
+			lsub_positive(&env->imbalance, busiest->idle_cpus);
 		}
 
 #ifdef CONFIG_NUMA
-- 
2.25.1


