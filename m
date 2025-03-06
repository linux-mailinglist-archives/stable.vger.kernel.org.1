Return-Path: <stable+bounces-121310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66464A5563F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA9174A5F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAEF26E15F;
	Thu,  6 Mar 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4TeXLaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E857263F5F
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288288; cv=none; b=RYYeIH7+KzNp69UPM/Y/w1LLvZw7PLY6RNM7ZuCxqyyAtQ99dDV6BAhXmBYOsTKZhgGtNT3JgAhEZJM929A+W0/LYIzg9XcBFF0cMUnE0JHqgZLnZn2o6VI/Ssf7+sUsoyqyyRs5Kj4CwlPByliupH9od1En3NsyCZXd8TIJqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288288; c=relaxed/simple;
	bh=cI19g59zyjQNbQHKCze+vRIX3+lT5Hk8Jn7byx1lzHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUY2Arc74GsDYLiXwemOV/jhH3OvFMNt9Z/LEX+SyHBazliD6z7bT3438NyJipk0+kVxjEfPZTobcbWcDTbjmXzUOlbBxqywzINlAyYtVYrt0wxfPGm3pZQMcEf3g8PeEYdGeL41kAPn+KGxOE7kGK8Sy0btacoWj4unr4YN2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4TeXLaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA60EC4CEE0;
	Thu,  6 Mar 2025 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288288;
	bh=cI19g59zyjQNbQHKCze+vRIX3+lT5Hk8Jn7byx1lzHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4TeXLaXX+8Lts1YQfaN7jS8yYQ5km2Lm9inr4OPeXw2+/Bfc8nJ4ErYsJWYF0Jny
	 tSREWVT/3dvqXVZjlhe5UKGbOpwimDQvTYm25ek4sOgi6016aS6S01QGW5YdkfYauB
	 nFOlZZ3lJnGPDlqdEhLSvpAKxJL+cG9utJKwIUqh4GSw6IsuJC54lftF7lbH4DckUe
	 Gmaw7BeUvhzzrKttE5vf2bdativPQ/0JbukMqmKvROD1Ny7KCpCeC9GnASIjzC8oqJ
	 leM4900zSNsMqus7lplRLNsSiRAFp3eDbeWlXbDU8pJ5wgoyZTpuWVrtGvxUgnTytL
	 1Znyt75poyIqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	simon@swine.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] uprobes: Fix race in uprobe_free_utask
Date: Thu,  6 Mar 2025 14:11:26 -0500
Message-Id: <20250306114857-f0c76c629381a812@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <u27rnbdpxnayssubw557qxf2rrf6p22cmwkg43skziesvpj7bq@ig5nmblcelrr>
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
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: b583ef82b671c9a752fbe3e95bd4c1c51eab764d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Christian Simon<simon@swine.de>
Commit author: Jiri Olsa<jolsa@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b583ef82b671c ! 1:  b3a3f2344d131 uprobes: Fix race in uprobe_free_utask
    @@
      ## Metadata ##
    -Author: Jiri Olsa <jolsa@kernel.org>
    +Author: Christian Simon <simon@swine.de>
     
      ## Commit message ##
         uprobes: Fix race in uprobe_free_utask
     
    +    commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d upstream.
    +
    +    Christian Simon verified the regression exists in v6.12.17 as per method
    +    below and backported the mainline fix to the older version of
    +    uprobe_free_utask. After that change I can no longer reproduce
    +    the race with this method within 1h, while before it would show the
    +    panic under a minute.
    +
         Max Makarov reported kernel panic [1] in perf user callchain code.
     
         The reason for that is the race between uprobe_free_utask and bpf
    @@ Commit message
     
         Fixes: cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe")
         Reported-by: Max Makarov <maxpain@linux.com>
    +    (cherry picked from commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d)
         Signed-off-by: Jiri Olsa <jolsa@kernel.org>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Acked-by: Oleg Nesterov <oleg@redhat.com>
         Acked-by: Andrii Nakryiko <andrii@kernel.org>
         Link: https://lore.kernel.org/r/20250109141440.2692173-1-jolsa@kernel.org
    +    [Christian Simon: Rebased for 6.12.y, due to mainline change https://lore.kernel.org/all/20240929144239.GA9475@redhat.com/]
    +    Signed-off-by: Christian Simon <simon@swine.de>
     
      ## kernel/events/uprobes.c ##
     @@ kernel/events/uprobes.c: void uprobe_free_utask(struct task_struct *t)
    @@ kernel/events/uprobes.c: void uprobe_free_utask(struct task_struct *t)
      		return;
      
     +	t->utask = NULL;
    - 	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
    + 	if (utask->active_uprobe)
    + 		put_uprobe(utask->active_uprobe);
      
    - 	timer_delete_sync(&utask->ri_timer);
     @@ kernel/events/uprobes.c: void uprobe_free_utask(struct task_struct *t)
    - 		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
      
    + 	xol_free_insn_slot(t);
      	kfree(utask);
     -	t->utask = NULL;
      }
      
    - #define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */
    + /*
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

