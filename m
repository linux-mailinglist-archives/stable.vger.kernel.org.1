Return-Path: <stable+bounces-164927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE7B13AB2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123BD7A8022
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF026561C;
	Mon, 28 Jul 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVW8O4F9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0B2580E2
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706744; cv=none; b=cUo1ncH61s8BYkjqxwdb6AH6sid/Hf93pKkRHjJ1WZsLAwk+qF+vNAgnXz9PK82yzo7SV6hZVrPR6KwR92JKarURv0vRJUJkwD8wvGfeFErUaFzkE3Vq0lvhkZSfkQi97Rdj79Pj5fbmpcHMrOokFfpRTI7n8CK65Dum7G7zPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706744; c=relaxed/simple;
	bh=axnLcJv7gS849Q/0zj20cDmXUEH+It1Fgq5ya2DOavY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeoZp1r1Fi4XmMENMPrOX2hDG3slgEmLm97Ix/QvBqn39FX/A6RRQFKcD1eunPBC7soAeUURvdt/AoVl/uMaQDWJPPYYrRDXQHRb3Cs/7oyGWXcaK1qc+KiFD8DIW1rPbbvOpSXJj4whqsytJe8UL4+Y+inIrIfWk9Hub6vUkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVW8O4F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385D0C4CEE7;
	Mon, 28 Jul 2025 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706743;
	bh=axnLcJv7gS849Q/0zj20cDmXUEH+It1Fgq5ya2DOavY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVW8O4F9AvhDXh10ycjnimDEC0HS+ErcNH5f+GzLjzmZ+ugHHNzScZZt19A9WGZAk
	 8PPjRfX+Qwluhk6Koj5yPidYJPtlaYHgKYsWku81nx+Md8m24+qaqyXu0R21NJ8k3b
	 J1PGw3jhm1wU0YkKM2kmYxiOSC7YZk61O+Ln4e4dwUVRPV+0baKynxk4lVbr321hnZ
	 KJ5QEG1WU0jMl1tmMmqdzKLgpMOSUMJN3HQoIMwZYyO79b2bTrBXB1ozOOZn7QBME1
	 609Z1Kw7Qg0ltTC9XWdOMacCfINxOEYBsNXAKPQTiIg4wtMPt/pVL6njXjMTJs+ZRt
	 5yVR1m3vkKG1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenridong@huaweicloud.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/5] sched/core: Remove ifdeffery for saved_state
Date: Mon, 28 Jul 2025 08:45:41 -0400
Message-Id: <1753684394-c86c76a8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728025444.34009-2-chenridong@huaweicloud.com>
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

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: fbaa6a181a4b1886cbf4214abdf9a2df68471510

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Ridong <chenridong@huaweicloud.com>
Commit author: Elliot Berman <quic_eberman@quicinc.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  fbaa6a181a4b ! 1:  b72e2a437525 sched/core: Remove ifdeffery for saved_state
    @@ Metadata
      ## Commit message ##
         sched/core: Remove ifdeffery for saved_state
     
    +    [ Upstream commit fbaa6a181a4b1886cbf4214abdf9a2df68471510 ]
    +
         In preparation for freezer to also use saved_state, remove the
         CONFIG_PREEMPT_RT compilation guard around saved_state.
     
    @@ Commit message
         Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
    +    Signed-off-by: Chen Ridong <chenridong@huawei.com>
     
      ## include/linux/sched.h ##
     @@ include/linux/sched.h: struct task_struct {
    @@ kernel/sched/core.c: int __task_state_match(struct task_struct *p, unsigned int
      int task_state_match(struct task_struct *p, unsigned int state)
      {
     -#ifdef CONFIG_PREEMPT_RT
    + 	int match;
    + 
      	/*
    - 	 * Serialize against current_save_and_set_rtlock_wait_state() and
    - 	 * current_restore_rtlock_saved_state().
    - 	 */
    - 	guard(raw_spinlock_irq)(&p->pi_lock);
    +@@ kernel/sched/core.c: int task_state_match(struct task_struct *p, unsigned int state)
    + 	raw_spin_unlock_irq(&p->pi_lock);
    + 
    + 	return match;
    +-#else
    +-	return __task_state_match(p, state);
     -#endif
    - 	return __task_state_match(p, state);
      }
      
    + /*
     @@ kernel/sched/core.c: bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
      
      	*success = !!(match = __task_state_match(p, state));

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Failed     |

