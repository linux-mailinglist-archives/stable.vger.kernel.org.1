Return-Path: <stable+bounces-154780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100FAE015F
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF7D5A4BF4
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73263261398;
	Thu, 19 Jun 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm5Dacpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234221CC47
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323876; cv=none; b=Ogi8OxeFcnPQVIl/GmV1UW7dUqOphZ91Ya2RzN59xvK/Z5y/B7bbe330GJjST0rl5IbKIk11SeHmTH8noEo0t+3iCdMhNtYgX8p7KpBlvjORUAyS6j09Gcfq/nn2brnwsyJmbS7XhHkmo62AHZUayfL9/+N3NXxyokWhfzQNBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323876; c=relaxed/simple;
	bh=dkit2ZYXbgVweklUWLai/ONQJjmdQOABgOry78WVfmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ju41KNW3WSt+GMkthPwDnZbY1lXRIKch/aMaMfkCoEK3crV5WliS1jtwBkp8vJI4lO7NAOvbifzUCxLGqpWK2HyCpX4zxmWfo83DhQPOd6pc47wE97tyW9S/y1TSlT8LSugkgp2dzqdZ9w4ajSOEg8jhSgCGPfwFt+g40JdMPtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm5Dacpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5AEC4CEED;
	Thu, 19 Jun 2025 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323876;
	bh=dkit2ZYXbgVweklUWLai/ONQJjmdQOABgOry78WVfmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mm5DacpaFh2I7jPz2H1IEZpnElCJMTH8iJo7eayoo5QJRbwEdCsE98U9kFDk3PTk8
	 rGKy+4AgHQtcJTae8s2dSHugD4Sm1ThxlE22RzQewC6sjm36Y5N27DdQ7P6PJw0qPk
	 pq4oAf1OizyBg9QlacWg2vCZ3ocSMLn3HmtKG/1E9w/Sq1R8uPnXUPvxlr0pXusxYL
	 e0mJldBdTypnx6ABDy6Hj3wC+tjxsm7p4IzdwM+xUupM8lHQJpMw+h3MGtfRNATYe1
	 T3pJ5oLpX2FiWdS7q3/L7z+U9adxmN5sj0bB7+iYJrJzVbTuvmo5UvP2ERpkDxR8+i
	 EEtIMIPQxMHDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 04/16] x86/alternatives: Introduce int3_emulate_jcc()
Date: Thu, 19 Jun 2025 05:04:34 -0400
Message-Id: <20250618171326-7e04c16dfa905279@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-4-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: db7adcfd1cec4e95155e37bc066fddab302c6340

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 75c066485bcb)
5.15.y | Present (different SHA1: f4ba357b0739)

Note: The patch differs from the upstream commit:
---
1:  db7adcfd1cec4 ! 1:  fd965993ed457 x86/alternatives: Introduce int3_emulate_jcc()
    @@ Metadata
      ## Commit message ##
         x86/alternatives: Introduce int3_emulate_jcc()
     
    +    commit db7adcfd1cec4e95155e37bc066fddab302c6340 upstream.
    +
         Move the kprobe Jcc emulation into int3_emulate_jcc() so it can be
         used by more code -- specifically static_call() will need this.
     
    @@ Commit message
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
         Link: https://lore.kernel.org/r/20230123210607.057678245@infradead.org
    +    Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/include/asm/text-patching.h ##
     @@ arch/x86/include/asm/text-patching.h: void int3_emulate_ret(struct pt_regs *regs)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

