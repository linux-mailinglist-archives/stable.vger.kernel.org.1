Return-Path: <stable+bounces-154759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DF0AE0115
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417917AE3CE
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A3279331;
	Thu, 19 Jun 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVfg5jYq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C9278767
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323765; cv=none; b=XKJYlgLD6qd6UWptg88hL0ufZ5Sn5Qxd1M3yzsY3w2axhyO4VlJkgNHEkjUBxQOPShQeKfsVljUTAktEs6aJt1aKZX5Sd6fzz94SZhtApFDgnGudQs0pQKFBRXySRPsws1WX1XwfQh7fLyIa8sHcKtlflp/C8Fm0kCllyMcx3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323765; c=relaxed/simple;
	bh=QPV7eyz6w4i7r5vwUbwCkHrr60xHJcMeQMKtAEtL77c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvjhSyTqj/beogzVjhBkE45OcczyMGHQLchfMrRtE+vq4eQZP354H/xziWf6exI96fUGNxdgg6N0bItnUl+IjNC+0809rIEYfiJ8Y+GDiG4RAA4Fs+QAJt+OEk/fQUjG9FdYjh1/VkAyQvLK10Y1uY4E8IgSK1vazBbLE7sEI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVfg5jYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C3C4CEEA;
	Thu, 19 Jun 2025 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323764;
	bh=QPV7eyz6w4i7r5vwUbwCkHrr60xHJcMeQMKtAEtL77c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVfg5jYqtYQWbE3ADhj5UX99LBe5qRgjClDRgdX5avtMsHEYd0E/d6f/zs3e/fbSB
	 7YwX5D4xLCD7EdxKcsrtsRQN4RkvF9BtvU0EOjRCtpiUNpIBcU/5GxsnJt20H9jnIK
	 wOJKV9grCFSn+KFgO+RdJeWDR1uYccbQayYK919kbvwt7tdD+WkkCtU1oAU2VOloY/
	 xcIby7PIlfYKFOC+uDjA7HwapTGhs2rlEIMB7KN1azqlt9Rnz/wxJ+4QsePvRjfKKy
	 //+ueKqj7waLHtV0kn0pDbSPMP76jVyxh75fjHUp1fGIhf93kRwaFiDAWI6//vML0b
	 +uK//UwYRu2nA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] posix-cpu-timers: fix race between handle_posix_cpu_timers()" failed to apply to 5.4-stable tree
Date: Thu, 19 Jun 2025 05:02:42 -0400
Message-Id: <20250618112251-e884ef1d31b4675d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617172613.GA19542@redhat.com>
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

The upstream commit SHA1 provided is correct: f90fff1e152dedf52b932240ebbd670d83330eca

Status in newer kernel trees:
6.15.y | Present (different SHA1: d65f6c68f7b1)
6.12.y | Present (different SHA1: 18a3e65f32ed)
6.6.y | Present (different SHA1: 8db5813e9ad7)
6.1.y | Present (different SHA1: 61fa08967f27)
5.15.y | Present (different SHA1: f6e90a3258e0)
5.10.y | Present (different SHA1: 1c179c7c3b82)

Note: The patch differs from the upstream commit:
---
1:  f90fff1e152de ! 1:  933e5cbcf266c posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()
    @@ Metadata
     Author: Oleg Nesterov <oleg@redhat.com>
     
      ## Commit message ##
    -    posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()
    +    FAILED: patch "[PATCH] posix-cpu-timers: fix race between handle_posix_cpu_timers()" failed to apply to 5.4-stable tree
    +
    +    On 06/17, gregkh@linuxfoundation.org wrote:
    +    >
    +    > The patch below does not apply to the 5.4-stable tree.
    +
    +    Please see the attached patch for 5.4.y
    +
    +    Oleg.
    +
    +    From a3dbb5447bc9a8f9c04ffa5381b0a0bd77b1bdd5 Mon Sep 17 00:00:00 2001
    +    From: Oleg Nesterov <oleg@redhat.com>
    +    Date: Tue, 17 Jun 2025 19:15:50 +0200
    +    Subject: [PATCH 5.4.y] posix-cpu-timers: fix race between
    +     handle_posix_cpu_timers() and posix_cpu_timer_del()
    +    MIME-Version: 1.0
    +    Content-Type: text/plain; charset=UTF-8
    +    Content-Transfer-Encoding: 8bit
    +
    +    commit f90fff1e152dedf52b932240ebbd670d83330eca upstream.
     
         If an exiting non-autoreaping task has already passed exit_notify() and
         calls handle_posix_cpu_timers() from IRQ, it can be reaped by its parent
    @@ kernel/time/posix-cpu-timers.c: void run_posix_cpu_timers(void)
     +		return;
     +
      	/*
    - 	 * If the actual expiry is deferred to task work context and the
    - 	 * work is already scheduled there is no point to do anything here.
    + 	 * The fast path checks that there are no expired thread or thread
    + 	 * group timers.  If that's so, just return.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

