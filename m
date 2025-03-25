Return-Path: <stable+bounces-126037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3EA6F460
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131EB3B2597
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F1255E51;
	Tue, 25 Mar 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgE2UmEX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159C19F111
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902699; cv=none; b=mLvAb5vE4Ok0v3C0xCyXJhu/N/avv0KvZl9TSghvV01yK0hsXWFts4CUmoSbTe0QGy86z/n3YIPRniDeNTOQeFVkgPw/S/h/o91jev4A+65ExA6alL+kICtUamAqpts6nF+1L0nPqNfNFAlIn++3h94rUj2RfQ9KX5qMXZEYptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902699; c=relaxed/simple;
	bh=XaefwPIkKUk6voIKxH1RLDBZohuJJHpLRYXQQ9Tvw+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCzd+jLV91P1HlTtY6Pboe0i7oogwBLV0TPEiFIS2krj2rwQrsegUj5VxI9SQtIYuJnczJYezJFYmZaADdcx8aRMPgV53OjS3Gt1FnW/oHWF/qnCTV6uvbdvrgl7Bq9vfKJm6SD9TSujlE8GbuCPlv+MKxxAv8h8rnRWEl89zsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgE2UmEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E25C4CEEE;
	Tue, 25 Mar 2025 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902696;
	bh=XaefwPIkKUk6voIKxH1RLDBZohuJJHpLRYXQQ9Tvw+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgE2UmEXo6ONKvqbqgXIcII45iFd+hWVmowS/Q0MzDg5RIz3DItNOBNTgfkdq9RgQ
	 L42ZDRQZQ+ta/MnyNHZ3EKbcMMoFY+EmBRL+D+gDuzAEa/Az260uaHkOsYk/URwk4i
	 jbHRrB1HrbI+ap3oOa4WvwAmyPh1rxf09FfO0KJqqs9BmbTwXdiV8lM791+R/5TCaJ
	 fgmvhGqMJdzqAd4a8XrRGvvw3WXtDqcClFy7Dt4gRMmhqcEvcsh8TRELLy4kES0vTg
	 +zib8/yf7iXsfA0aoPzRQppHHy942h2FbgUCJ3t/RrdHIxKCxF9IjFTSOoU88Ed0m8
	 DdM+q9P+fsT3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
Date: Tue, 25 Mar 2025 07:38:14 -0400
Message-Id: <20250324210755-fb95f7e2f28e4205@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324114156.31212-1-hagarhem@amazon.com>
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

The upstream commit SHA1 provided is correct: 76f970ce51c80f625eb6ddbb24e9cb51b977b598

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Dietmar Eggemann<dietmar.eggemann@arm.com>

Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  76f970ce51c80 ! 1:  1382b2427fdda Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
    @@ Metadata
      ## Commit message ##
         Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
     
    +    commit 76f970ce51c80f625eb6ddbb24e9cb51b977b598 upstream.
    +
         This reverts commit eff6c8ce8d4d7faef75f66614dd20bb50595d261.
     
         Hazem reported a 30% drop in UnixBench spawn test with commit
    @@ Commit message
         Tested-by: Hagar Hemdan <hagarhem@amazon.com>
         Cc: Linus Torvalds <torvalds@linux-foundation.org>
         Link: https://lore.kernel.org/r/20250314151345.275739-1-dietmar.eggemann@arm.com
    +    Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: void sched_release_group(struct task_group *tg)
    @@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk, bool for_auto
     -
      	update_rq_clock(rq);
      
    - 	running = task_current_donor(rq, tsk);
    + 	running = task_current(rq, tsk);
     @@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk, bool for_autogroup)
      	if (running)
      		put_prev_task(rq, tsk);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

