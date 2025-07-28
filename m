Return-Path: <stable+bounces-165014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471DCB143A6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 22:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC233AF3F3
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F3233701;
	Mon, 28 Jul 2025 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XB8Hyc0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042B215798;
	Mon, 28 Jul 2025 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736334; cv=none; b=ER1sUCqs/As3E68cZpM1rvBVNq1gju04TA4+14zAHIfQ2brToTlmOYmuGi/2Wf8qBFfivw4mHG/8fKtYOPuWteIJhkRcf+DFSryInAkY3viTo/UYnfmFOHvO0Ctir8NpXoQ2L4NASljlDauDiql/dWCNHphn09vcBJGfIuJyrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736334; c=relaxed/simple;
	bh=PLzM4UumP/OoUpTWArSfsoC66j4BCJQV+EkLiWusGss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FUghaRAmNmLAHBqn3y3OcXz/LskgON3gGPcBsxAeXE/YWiX6eZz0Tkx9ZpXkk4oMHMpkhMxhkUUwze2QgA+g95w+EHuMNLbCPxLm1Po4uBaaX+eYuST9DZX0X7N3m2D+ZzI93yYFTcagGLXGh+2fG5cm8fVmSeJNO77A8UNu40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XB8Hyc0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F5EC4CEE7;
	Mon, 28 Jul 2025 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753736333;
	bh=PLzM4UumP/OoUpTWArSfsoC66j4BCJQV+EkLiWusGss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XB8Hyc0josg3kRfBL/TAuWzvNjY4I1quwAvLgSXlghfiz0tZuhh551krkBpbBuI+s
	 dQuM50o4a0+3LX4tHYGVjw3wdt8yw1BprjUVKWYIw8kf9+kHN7KunShyFnoFOwc5oP
	 7ahl52fn6VDbtxAc+yE1YmQUP6NW1oORT1YDStek=
Date: Mon, 28 Jul 2025 13:58:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
Message-Id: <20250728135852.1441a6fd58f7171ac2a3dedd@linux-foundation.org>
In-Reply-To: <20250728175355.2282375-1-surenb@google.com>
References: <20250728175355.2282375-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 10:53:55 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> By inducing delays in the right places, Jann Horn created a reproducer
> for a hard to hit UAF issue that became possible after VMAs were allowed
> to be recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.
> 
> Race description is borrowed from Jann's discovery report:
> lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> it can be recycled by another process. vma_start_read() then
> increments the vma->vm_refcnt (if it is in an acceptable range), and
> if this succeeds, vma_start_read() can return a recycled VMA.
> 
> In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> will then detect the mismatching ->vm_mm pointer and drop the VMA
> through vma_end_read(), which calls vma_refcount_put().
> vma_refcount_put() drops the refcount and then calls rcuwait_wake_up()
> using a copy of vma->vm_mm. This is wrong: It implicitly assumes that
> the caller is keeping the VMA's mm alive, but in this scenario the caller
> has no relation to the VMA's mm, so the rcuwait_wake_up() can cause UAF.
> 
> The diagram depicting the race:
> T1         T2         T3
> ==         ==         ==
> lock_vma_under_rcu
>   mas_walk
>           <VMA gets removed from mm>
>                       mmap
>                         <the same VMA is reallocated>
>   vma_start_read
>     __refcount_inc_not_zero_limited_acquire
>                       munmap
>                         __vma_enter_locked
>                           refcount_add_not_zero
>   vma_end_read
>     vma_refcount_put
>       __refcount_dec_and_test
>                           rcuwait_wait_event
>                             <finish operation>
>       rcuwait_wake_up [UAF]
> 
> Note that rcuwait_wait_event() in T3 does not block because refcount
> was already dropped by T1. At this point T3 can exit and free the mm
> causing UAF in T1.
> To avoid this we move vma->vm_mm verification into vma_start_read() and
> grab vma->vm_mm to stabilize it before vma_refcount_put() operation.

Thanks, I'll add this to mm-unstable with a plan to include it in the
second batch of MM-updates->Linus next week.

> Cc: <stable@vger.kernel.org>

The patch won't apply to 6.15 so I expect the -stable maintainers will
be asking you for a backportable version.


