Return-Path: <stable+bounces-95836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90009DEC9A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED1B28204D
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83DC1A2C21;
	Fri, 29 Nov 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYUlLyS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896713DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910602; cv=none; b=ukZZcCnJHtEBzGKIr0sQAM9Y1IsE6ghVFCx2wcCpudF4+RYFvRu2C1YKewmc9KdL80s2QXPoiejpT7JYpaoB1aAlleDotMfwt4klTZ4eudtxgkYZVfAkYbchrROZ/PglfXn/CDd6zh6R4y0QTEXXnNprDbDzzpb0xvsZtnPESBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910602; c=relaxed/simple;
	bh=hQoCZOfiKKGU4a8ngvsHH+SKw713wUaoPD9e+sMHwWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiTDCi4vY8Jnnwe1ewTqQw7nOFswxpx6psPMJeoPyit90I1vCPUzpMU6YC3nOWPQXvA8Xafprj5ZHUK+NsCNK5wnuKdRopwyE9MdZP9ECumHU27eCxA1wzfGl9GcVk19Q77a/OadJ98ap7vTFUR6GLUZq5F4qQQGqF10tNHrU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYUlLyS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED90C4CECF;
	Fri, 29 Nov 2024 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910601;
	bh=hQoCZOfiKKGU4a8ngvsHH+SKw713wUaoPD9e+sMHwWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYUlLyS14lvUrdp6pq1nyhgrsltA/52wPzYT+cTCli5276vi9VTPC+VYqRrB+Yy+D
	 mdwovhd6IOpJ00BDJnDLiDZN5GqhzsiDJCxAHRvPIKRczAzP1EQxaNAv0TIpaS/fa3
	 4q3HrDU7lHrSu/th2v+pMVaKo6YF9o4lNziIk27Fab9QEkni1h07bvdB9PzclBBote
	 kWgCcrTrqJNSe4nM/MVOpfA/6aR8PzrzNLC8GjuzpQC6/3udAHaacsKxeBuswSYO0I
	 ySvKt++uZNt+1iWqetWHLSIH0yILgFPfLv602U4b+8DxHQnYrLNkXpTPUQTIXxrBxy
	 WnzzYJgDmq4vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
Date: Fri, 29 Nov 2024 15:03:20 -0500
Message-ID: <20241129140614-af295bd2976d3ea8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129060856.26060-2-hagarhem@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 556a7c039a52c21da33eaae9269984a1ef59189b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan <hagarhem@amazon.com>
Commit author: Kan Liang <kan.liang@linux.intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  556a7c039a52c ! 1:  39f65e280d338 perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
    @@ Metadata
      ## Commit message ##
         perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
     
    +    [ Upstream commit 556a7c039a52c21da33eaae9269984a1ef59189b ]
    +
         The below error is observed on Ice Lake VM.
     
         $ perf stat
    @@ Commit message
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
         Link: https://lkml.kernel.org/r/20240708193336.1192217-2-kan.liang@linux.intel.com
    +    [ Minor changes to make it work on 6.1 ]
    +    Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
     
      ## arch/x86/events/intel/core.c ##
    -@@ arch/x86/events/intel/core.c: exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
    - 	return x86_pmu.version >= 2 ? attr->mode : 0;
    +@@ arch/x86/events/intel/core.c: default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
    + 	return attr->mode;
      }
      
     +static umode_t
    @@ arch/x86/events/intel/core.c: exra_is_visible(struct kobject *kobj, struct attri
      
      static struct attribute_group group_events_mem = {
     @@ arch/x86/events/intel/core.c: static umode_t hybrid_format_is_visible(struct kobject *kobj,
    - 	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
    + 	return (cpu >= 0) && (pmu->cpu_type & pmu_attr->pmu_type) ? attr->mode : 0;
      }
      
     +static umode_t hybrid_td_is_visible(struct kobject *kobj,
    @@ arch/x86/events/intel/core.c: static umode_t hybrid_format_is_visible(struct kob
     +
     +
     +	/* Only the big core supports perf metrics */
    -+	if (pmu->pmu_type == hybrid_big)
    ++	if (pmu->cpu_type == hybrid_big)
     +		return pmu->intel_cap.perf_metrics ? attr->mode : 0;
     +
     +	return attr->mode;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

