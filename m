Return-Path: <stable+bounces-95831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF89DEC96
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEEA163A04
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88291A0AE1;
	Fri, 29 Nov 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HokwANLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871313DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910591; cv=none; b=Ojqr8V/fIo6iEZr2zFTn1pGaNhlZRd5rb5OunpOQlP2yMCqu0KHe+wBDCTs3HFO9svPzkP7qCBj/R8m1Czeju5V73efBwnUbr/UaHEWKrwuC6aF82UnDTUI5oaQDhlIN7vEfwk/gwD78JHDzN8li6JN2cPzr+vfP6bkIDkf0icQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910591; c=relaxed/simple;
	bh=8YtyfmePEXOr59HgFOzbaB3+K0xv65dnlHW0XWKiCcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgr5rLpkrjPyew0IEBhcLmD1KwEQAsGgJy+ofaviOf9yLZaxlezw8wsVqAzAZXxf/5Fwx+Zveb+bFEacejXjMhtgXhexR6ZqA3zlRMqCKnMsnEU5Zgt0dX1gxB+ZM85Yw8JfFn5W1hvWwedKmRGe+o7kXrdCMrUzM7yd/wBhdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HokwANLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5C7C4CECF;
	Fri, 29 Nov 2024 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910591;
	bh=8YtyfmePEXOr59HgFOzbaB3+K0xv65dnlHW0XWKiCcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HokwANLf1S9oecHVZPXjXntKzwxvLOY/wTQvQJK6iIP2pOsgttBkHGaUzSNwbrjhb
	 H7Ac6yUWeS/bKVdLZjbzdfK+qsRkc0Uo8s1ZF3QJcKUtb8mBWv5mQ6vKL1NtETFmoX
	 o2gisTCZce5+ToBMuZVitEf1M1jLOzrDcdDLNsTV6+i97guxlVbQgya80kDeGnzJux
	 OSZRTsEG0tbatmMi4mqTj+paUOY9JPJu2hZH2u0N0qMINBOLLellf7PRvVmb4iz78o
	 7ifhPTP0L8KlKmDEW5uq0rw+JciRr597p9LBcl+BVQQwtxwJuasbEEr4BEeL19ciet
	 7x4xJJ2j+46pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
Date: Fri, 29 Nov 2024 15:03:08 -0500
Message-ID: <20241129142000-cf79a85efd12d7db@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129060856.26060-1-hagarhem@amazon.com>
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

Note: The patch differs from the upstream commit:
---
1:  556a7c039a52c ! 1:  46084b673b37e perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
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
    +    [ Minor changes to make it work on 6.6 ]
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
| stable/linux-6.6.y        |  Success    |  Success   |

