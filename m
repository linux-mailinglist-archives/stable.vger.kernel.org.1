Return-Path: <stable+bounces-111198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B2AA22207
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FF11625ED
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F81DF73A;
	Wed, 29 Jan 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHC8ySmy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC501DF254
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169244; cv=none; b=Nb2vF8qxm/h8U82+0ZBmw1Xw3zJ6ulzaKXF0slyTsDlNWWHJLWXnD+yTizLlkO4Y1wA+rsBw4Q4LzoC9C+QVaxoW7hhQJgOyvX21D31R9vLaLOhTAdItht8buERHYKeBM4l2JYt5u9Fs9TZEZlZ3aFSZV6NGJJjx1hkL2wdHGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169244; c=relaxed/simple;
	bh=9toNwxstXNg73OIaCrphY6RXecNJsqaZF9tKg1sUURM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yhi7jyqUVQCLIHkJk24E4Q6thBmBLfW5L84SETMySRE1hpJbfpB0RmLHznGyU7TT6OcLaguORbKx73njMWGL6UzP9y75SoyjkoQVccPFcLANCo5RMltlsEoa8/ry1pOhC3pLMZUsb+vQQeiM/8383OgOzr+qYHDILJlmQdypOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHC8ySmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A9C4CED1;
	Wed, 29 Jan 2025 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169244;
	bh=9toNwxstXNg73OIaCrphY6RXecNJsqaZF9tKg1sUURM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHC8ySmy++TFEycDALaD0Mqh6NBLt4VuyHpzzubr8Fq52ESdNGa+jvMyecHrNi8Ss
	 GyUHHnpTI0qnbEkR4doOFOAUpY9IEJCHX0f+KunUNKe8IKSYw6sZvWDHwNaOym0U9O
	 QBzjg/arSCxo0dcrkGPRrAaMPOK3dxjeBU60OCxa/ZQFSXtuaSvVAZaqeOOMeFN2D0
	 s8sQh0MfAPOz56m+/+eBhiPPOHaZ+JHrdf0Iqb9NIb1KGMQZYrVVKo2Fh9eXTtD95Y
	 RVuApgJSV2/39Gf1K0brhVTh4bdSCNMUtJuBTuHH6rFHN15N19VG7P7t/5VbT9Jo4w
	 iX2EzdO39pBBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
Date: Wed, 29 Jan 2025 11:47:22 -0500
Message-Id: <20250129113903-c29608a883c75428@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129153226.818485-1-florian.bezdeka@siemens.com>
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

The upstream commit SHA1 provided is correct: 6675ce20046d149e1e1ffe7e9577947dee17aad5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Bezdeka<florian.bezdeka@siemens.com>
Commit author: K Prateek Nayak<kprateek.nayak@amd.com>


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Present (different SHA1: 6aeef0214de7)
6.6.y | Present (different SHA1: 3dd65ffa2df6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6675ce20046d1 ! 1:  c2bdd4c44f80e softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
    @@ Metadata
      ## Commit message ##
         softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
     
    +    commit 6675ce20046d149e1e1ffe7e9577947dee17aad5 upstream.
    +
         do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
         WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
         Since do_softirq_post_smp_call_flush() is called with preempt disabled,
    @@ Commit message
         Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Link: https://lore.kernel.org/r/20241119054432.6405-2-kprateek.nayak@amd.com
    +    Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
    +    Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
     
      ## kernel/softirq.c ##
     @@ kernel/softirq.c: static inline void invoke_softirq(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

