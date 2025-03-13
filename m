Return-Path: <stable+bounces-124246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E6A5EF1F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A361890B34
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5E264F83;
	Thu, 13 Mar 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/hHWkYs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591E264A7B
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856925; cv=none; b=IFFZ6KjMOt+kQ4MSWCCvUrpBb7dBRxA/M4MVtR1OKlubhHDlIx6C3EF+sCTNcJmC9nfgShughxf+oElm5EyFakchXgZ92O2IdklxMDgJ6f+cSTmgbRb2bPDMAzvvpBTjqDYOYdqmeAHYUSahaJEk4AB2vRhzWg21o2RGLOBxpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856925; c=relaxed/simple;
	bh=NRFBjR41wQOjkdyTP9fpuFfOQcI5Bw4NDqre8KU5IN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJaVw2HiR/gha5uaOqLtqC5+/6YqnjbkFGlF9z/AXm7RMZruvT8321gg1WVaZaThG+yMJtWmLHsQ3UTBsNC4HugZpUlgQWeoCalU1qukUDyeIci+cALiBXuRw6N96Zw4Tv62aWQKts9jRngI8c8dNg3K7qzL8lC85qvotIYa4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/hHWkYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D4AC4CEDD;
	Thu, 13 Mar 2025 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856925;
	bh=NRFBjR41wQOjkdyTP9fpuFfOQcI5Bw4NDqre8KU5IN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/hHWkYsE8UamYtZ8Zh4AySi1F7gEVOlIgCOEV4lyYwezsqolGHjzcAhFb7F2tbKT
	 tHy3MQSQs/GV3IODtriyaULaacjqpf5ITxpWxmX7NNA2QegmiWBxtgj4V70Ua+sn+Q
	 19FPrQgylv0sSNPTCytVPALu1JhTLbVzEscU8J1s1VLJW6VmuxJiebzTp0bQySpoL3
	 J8mUkR2zrqZ894pl9b0TEBTKbiywi8tmaUbqsB8SGSLSw0oc0BOyrnG9qtqKYAMrih
	 DWQRNEYfsykowYvm+5KUUFN52n5kMg7IkIjRWfoVWuLqG554UejpUWaCnIpBRLajwb
	 AP7QIh+WgPZxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/1] hrtimer: Use and report correct timerslack values for realtime tasks
Date: Thu, 13 Mar 2025 05:08:43 -0400
Message-Id: <20250312233302-2946e29efda0cecc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311134931.290856-1-felix.moessbauer@siemens.com>
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

The upstream commit SHA1 provided is correct: ed4fb6d7ef68111bb539283561953e5c6e9a6e38

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ed4fb6d7ef681 ! 1:  8ec8728ce513f hrtimer: Use and report correct timerslack values for realtime tasks
    @@ Metadata
      ## Commit message ##
         hrtimer: Use and report correct timerslack values for realtime tasks
     
    +    commit ed4fb6d7ef68111bb539283561953e5c6e9a6e38 upstream.
    +
         The timerslack_ns setting is used to specify how much the hardware
         timers should be delayed, to potentially dispatch multiple timers in a
         single interrupt. This is a performance optimization. Timers of
    @@ fs/select.c: u64 select_estimate_accuracy(struct timespec64 *tv)
      }
      
     
    - ## kernel/sched/syscalls.c ##
    -@@ kernel/sched/syscalls.c: static void __setscheduler_params(struct task_struct *p,
    + ## kernel/sched/core.c ##
    +@@ kernel/sched/core.c: static void __setscheduler_params(struct task_struct *p,
      	else if (fair_policy(policy))
      		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

