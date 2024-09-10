Return-Path: <stable+bounces-75650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215F973892
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8570BB25FC1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EE18FDDF;
	Tue, 10 Sep 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvNI427V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38993137772;
	Tue, 10 Sep 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974729; cv=none; b=t0KjJL5dOOf7LbZhiHv++2MAQRft6OIx2cd+JFp0LZqlX1ySp404J50OWarGcwEZUrGkyM2n9RMbRcdJD0UXUCA+Pg8OO11Xdco9nw7b91pJV88RUG4P/OQL1Uv9e3Lu6PPIrlVXTLbrgBue/5MKwHGSw6/mZzrg2bgfDTq6apo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974729; c=relaxed/simple;
	bh=iErFQRjvVaeRZZjjypJjPsqKtrbs1/0tXgyfPY3kmLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX8VHPyW+PXYn35+SG+npiFjBl4CCgebZAOb0M+2Z3g8dRljeLTxNTzQQsJKyoqK0UOEtqplTxRMH6G+uQfNhS9NujwhPHjLs90o6lAyGX6R6fTjP65pL41HvbtISHvgTwuzc5LjsyjnbwjfoDSMVFpvQ+M1E3nzFmQi5nzf6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvNI427V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11685C4CEC3;
	Tue, 10 Sep 2024 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725974728;
	bh=iErFQRjvVaeRZZjjypJjPsqKtrbs1/0tXgyfPY3kmLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvNI427V24MmWNO6p4R/aCPouxzmHYkcslJu44OJmlY074/gMUvEcJBgc+8unpqmo
	 34Kabs2y6x+Vjsr883Q2aXbocI5JwTMoZrh90gNKM2+5gftHxV8NRsYCKcxeDQUyJK
	 s0rfVlfTKn/PNMLuMk5eske1c5fS5DPZUSDYE9+Y=
Date: Tue, 10 Sep 2024 15:25:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: WangYuli <wangyuli@uniontech.com>, stable@vger.kernel.org,
	sashal@kernel.org, parri.andrea@gmail.com,
	mathieu.desnoyers@efficios.com, palmer@rivosinc.com,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
	ndesaulniers@google.com, trix@redhat.com,
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
	paulmck@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	brauner@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 6.6] membarrier: riscv: Add full memory barrier in
 switch_mm()
Message-ID: <2024091056-bogus-whoops-4bde@gregkh>
References: <10F34E3A3BFBC534+20240909025701.1101397-1-wangyuli@uniontech.com>
 <2024091002-caution-tinderbox-a847@gregkh>
 <364e0e33-68ad-4f0c-86f1-f6a95def9a30@ghiti.fr>
 <2024091037-errant-countdown-4928@gregkh>
 <5d486ff8-2ab5-4ed5-a1da-c2817927b3a2@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d486ff8-2ab5-4ed5-a1da-c2817927b3a2@ghiti.fr>

On Tue, Sep 10, 2024 at 02:35:06PM +0200, Alexandre Ghiti wrote:
> 
> On 10/09/2024 13:58, Greg KH wrote:
> > On Tue, Sep 10, 2024 at 01:31:04PM +0200, Alexandre Ghiti wrote:
> > > Hi Greg,
> > > 
> > > On 10/09/2024 09:32, Greg KH wrote:
> > > > On Mon, Sep 09, 2024 at 10:57:01AM +0800, WangYuli wrote:
> > > > > From: Andrea Parri <parri.andrea@gmail.com>
> > > > > 
> > > > > [ Upstream commit d6cfd1770f20392d7009ae1fdb04733794514fa9 ]
> > > > > 
> > > > > The membarrier system call requires a full memory barrier after storing
> > > > > to rq->curr, before going back to user-space.  The barrier is only
> > > > > needed when switching between processes: the barrier is implied by
> > > > > mmdrop() when switching from kernel to userspace, and it's not needed
> > > > > when switching from userspace to kernel.
> > > > > 
> > > > > Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
> > > > > primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
> > > > > architecture, to insert the required barrier.
> > > > > 
> > > > > Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
> > > > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > > > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > Link: https://lore.kernel.org/r/20240131144936.29190-2-parri.andrea@gmail.com
> > > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > Signed-off-by: WangYuli <wangyuli@uniontech.com>
> > > > > ---
> > > > >    MAINTAINERS                         |  2 +-
> > > > >    arch/riscv/Kconfig                  |  1 +
> > > > >    arch/riscv/include/asm/membarrier.h | 31 +++++++++++++++++++++++++++++
> > > > >    arch/riscv/mm/context.c             |  2 ++
> > > > >    kernel/sched/core.c                 |  5 +++--
> > > > >    5 files changed, 38 insertions(+), 3 deletions(-)
> > > > >    create mode 100644 arch/riscv/include/asm/membarrier.h
> > > > Now queued up, thanks.
> > > 
> > > The original patch was merged in 6.9 and the Fixes tag points to a commit
> > > introduced in v4.15. So IIUC, this patch should have been backported
> > > "automatically" to the releases < 6.9 right? As stated in the documentation
> > > (process/stable-kernel-rules.html):
> > > 
> > > "Note, such tagging is unnecessary if the stable team can derive the
> > > appropriate versions from Fixes: tags."
> > > 
> > > Or did we miss something?
> > Yes, you didn't tag cc: stable at all in this commit, which is why we
> > did not see it.  The documentation says that :)
> 
> 
> Ok, some patches seem to make it to stable without the cc: stable tag (like
> the one below for example), so I thought it was not necessary.

Yes, they do, because many maintainers and developers don't follow the
normal rules, so we sweep the tree when we have a chance and do a "best
effort" backport at times.

But again, it is NOT guaranteed that this will happen, and even if it
does, you will NOT get emails saying the attempt-at-backporting fails,
if it fails, as obviously the developers involved weren't explicitly
asking for it to be backported.

So in short, just properly tag things for stable, and all will be fine.

thanks,

greg k-h

