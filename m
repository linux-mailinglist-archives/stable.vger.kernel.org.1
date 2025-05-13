Return-Path: <stable+bounces-144241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE88EAB5CBB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D58119E8629
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D912BF3FE;
	Tue, 13 May 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coNa/h6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272472BEC3F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162191; cv=none; b=N1uK7pODquTaL6CNfyp7QUVYlJR1AHxFieGDM5+jZi2sgjFlAaESNt1ASpvHIX+6OrqlzvCngGmxHiwB77Ax+gKKPH8auwHptwgjeD2EgKIIuWySw07Ib1pNaZUSLa2rK+3fTtj73TjU9kVfSta5tvmiJnN6dst/6vusnPcyWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162191; c=relaxed/simple;
	bh=74xxrAsBphp9yVP5IfWidn5tDyDIbxScyTVksbQj2FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVzWkTGM/okqFHhiwGLrquCXCxxlxwckMyOw00hRhVU0GABBNSMKVgHIow/hFY0JYUgaxi4kBlpNrdCvyh38MZKbA26ZcLQL3Sg9L161nG8yveKEMVjKfQw/XxBsSUctzz1dvwqqtb7++tm0SHbvUkaWN17wYAT2J2Y19fql8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coNa/h6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95368C4CEE4;
	Tue, 13 May 2025 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162191;
	bh=74xxrAsBphp9yVP5IfWidn5tDyDIbxScyTVksbQj2FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coNa/h6/r+KOiFxND/ExYet66im2VVe9T4bSTEcdgxUJOpWxiQfkLyIC35mBaul/q
	 6PImJLZmmcrJQypHhs1uVGkO9qdkF4SUmZMlXYzZ/eOBwZ8rCQFC7Gq3j4Cs4ceaQD
	 EOrx5B95PwSDFw9Dka9Raa4QL8N/69dp0wqACt/pe1CdSjd2LlhF5o3XQBVa+zxvzG
	 EGE9Z4kxZ8ReYehz4f9tUdWuJWGsSgRN7Ed1piwUaS6UAXl2VMC85xdOqdGk/DX/Zw
	 ZFO51astB3C5lYNn6gytTVCYgX6sWj6PgxXgw4anN3Gpj+MX7Q0uGeVlq+6c6zoq8I
	 EpBBPSKR7/fBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
Date: Tue, 13 May 2025 14:49:47 -0400
Message-Id: <20250513104906-ef676fa035b23f5d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513060430.378468-1-lizy04@hust.edu.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 53dac345395c0d2493cbc2f4c85fe38aef5b63f5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Frederic Weisbecker<frederic@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: e456a88bddae)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  53dac345395c0 ! 1:  80e6b55d26f94 hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
    @@ Metadata
      ## Commit message ##
         hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
     
    +    [ Upstream commit 53dac345395c0d2493cbc2f4c85fe38aef5b63f5 ]
    +
         hrtimers are migrated away from the dying CPU to any online target at
         the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
         handling tasks involved in the CPU hotplug forward progress.
    @@ Commit message
         Link: https://lore.kernel.org/all/20250117232433.24027-1-frederic@kernel.org
         Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
     
    - ## include/linux/hrtimer_defs.h ##
    -@@ include/linux/hrtimer_defs.h: struct hrtimer_cpu_base {
    +    Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
    +
    + ## include/linux/hrtimer.h ##
    +@@ include/linux/hrtimer.h: struct hrtimer_cpu_base {
      	ktime_t				softirq_expires_next;
      	struct hrtimer			*softirq_next_timer;
      	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
     +	call_single_data_t		csd;
      } ____cacheline_aligned;
      
    - 
    + static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
     
      ## kernel/time/hrtimer.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

