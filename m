Return-Path: <stable+bounces-173600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D867B35E2B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A921BA7E8C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D6338F2B;
	Tue, 26 Aug 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0S4HpN3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FD338F36;
	Tue, 26 Aug 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208670; cv=none; b=G7DOrlGiFqw1iR37SJc4vVNbOFGPmcYsV/+Q8K4HC/gKhYgzSg9h+ND1xS2Q65AT7lHSLDf4AQ3wEsByeqw0kn+t3cuMz8h9wBVha16MsjoMINbVkib/FMhPDqzIztCMKYN4d1BK6vLLP+hh1YNNHkvQpB1em7foehn4Hk58wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208670; c=relaxed/simple;
	bh=wUIvI7r/C/FTiGtXOfZyGuC2DGiVu9RpvXv0p+ogJmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6Ex5uaSUNYUDz4AgEwO2SoJxhf4YNVo410NDTmNqI1myJD5pfOXJYZp+DKAbBoOXoqP4mldYvcqQr/Fns9TQi24O6Uufgu7f/FqRNC2IPmeagf8Rg/hXM9P6XbYM4GFoVniRP1mFrUZCHtGq4YD2vMHy3z0+HDziVUgZvyC1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0S4HpN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE8C4CEF4;
	Tue, 26 Aug 2025 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756208670;
	bh=wUIvI7r/C/FTiGtXOfZyGuC2DGiVu9RpvXv0p+ogJmE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f0S4HpN3EuAVCDuFCVf9mC8nOZuUDAZaEJDENE42sThSDMZ2/aV/Dt4drP3uHPYBk
	 m7vAimFzPatB8AEBj90cK5qpvpws4wBj2GpUxUN7eDCOGkYMgMWxhPPgjwISmkTVah
	 U/dcJ5hZiRiDuQTYSzD0cvWqq/XjVhek5o+RY0o65H28t+cNSmCI25/u77LjqqL4Za
	 smWK5pOKSkNTtCupvksyY7Ws3zMarmKLfvEa4G+Hz8QMconH3mIya4GpilNIULEj3m
	 OCJYqHTJFvATIGPAvhBtc4TbPaO5JGzFW46JZNflweVUOaqeWjO+sxr8demTAtfC2t
	 NPBMmC0F3lpYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2310DCE0C4D; Tue, 26 Aug 2025 04:44:30 -0700 (PDT)
Date: Tue, 26 Aug 2025 04:44:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	stable@vger.kernel.org,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: Re: [PATCH RESEND] locking/spinlock/debug: Fix data-race in
 do_raw_write_lock
Message-ID: <7325588b-189c-4825-a87f-5494b1230d7a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250826102731.52507-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826102731.52507-1-alexander.sverdlin@siemens.com>

On Tue, Aug 26, 2025 at 12:27:27PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> KCSAN reports:
> 
> BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock
> 
> write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
>  do_raw_write_lock+0x120/0x204
>  _raw_write_lock_irq
>  do_exit
>  call_usermodehelper_exec_async
>  ret_from_fork
> 
> read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
>  do_raw_write_lock+0x88/0x204
>  _raw_write_lock_irq
>  do_exit
>  call_usermodehelper_exec_async
>  ret_from_fork
> 
> value changed: 0xffffffff -> 0x00000001
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111
> 
> Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
> adressed most of these races, but seems to be not consistent/not complete.
> 
> >From do_raw_write_lock() only debug_write_lock_after() part has been
> converted to WRITE_ONCE(), but not debug_write_lock_before() part.
> Do it now.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
> Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> There are still some inconsistencies remaining IMO:
> - lock->magic is sometimes accessed with READ_ONCE() even though it's only
> being plain-written;
> - debug_spin_unlock() and debug_write_unlock() both do WRITE_ONCE() on
> lock->owner and lock->owner_cpu, but examine them with plain read accesses.
> 
>  kernel/locking/spinlock_debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
> index 87b03d2e41dbb..2338b3adfb55f 100644
> --- a/kernel/locking/spinlock_debug.c
> +++ b/kernel/locking/spinlock_debug.c
> @@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
>  static inline void debug_write_lock_before(rwlock_t *lock)
>  {
>  	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
> -	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
> -	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
> +	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
> +	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
>  							lock, "cpu recursion");
>  }
>  
> -- 
> 2.47.1
> 

