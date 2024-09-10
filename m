Return-Path: <stable+bounces-75629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20C97368C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7661C248D0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3838190052;
	Tue, 10 Sep 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mu2OqBie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74394190047;
	Tue, 10 Sep 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969486; cv=none; b=amOnEzlmFJxZO6WKhvDg7YJ+3qV0KL3uWjfBfYk29wXCXnGMZz9SEORAZP4LCtGV/qfGiJ7Y45e+eJF81oxNqb9+oWQY0gUWhxVdECFpTsMRY4AnGJmWbozC82R+Pd6IyPv02RVMWwRrt2m6zBw0g9ZtvYRBY+KVgTozSBhlntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969486; c=relaxed/simple;
	bh=nxm8JGXvA/juyus1Lqfvbv0TjjsNRb50mc0VwIYbggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+A01WsdQqmH5PK8lQj/280NC2FMh4mq+ahGBIpekE4p2zDIiE08vVUVoyFhFLZYRzEWqETo7/Fm/9HKXVA6PNMgiCu4So4oR2Mg/Y/99HHZJPtNvsgrgCz0NSXyul4HbF88AGt9sOqJltLZdrrD05Gngpz85BiosKBOGb9tNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mu2OqBie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5333EC4CEC3;
	Tue, 10 Sep 2024 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725969486;
	bh=nxm8JGXvA/juyus1Lqfvbv0TjjsNRb50mc0VwIYbggw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu2OqBieA010YaJZ9trrWESWcM/unoYGySmVYRZRA7J39DWUTONOtc9N39UmXL0yB
	 vCAY7mKuYmRZjgvwXYk2LEt3H/ksZbWWk4bCXHM2ugkZyQGEnrfm74j17OO3ykiB2b
	 Bsn2siY0eFKHQGUu7VqqaaOXq1idIhXoL64/GUZg=
Date: Tue, 10 Sep 2024 13:58:02 +0200
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
Message-ID: <2024091037-errant-countdown-4928@gregkh>
References: <10F34E3A3BFBC534+20240909025701.1101397-1-wangyuli@uniontech.com>
 <2024091002-caution-tinderbox-a847@gregkh>
 <364e0e33-68ad-4f0c-86f1-f6a95def9a30@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364e0e33-68ad-4f0c-86f1-f6a95def9a30@ghiti.fr>

On Tue, Sep 10, 2024 at 01:31:04PM +0200, Alexandre Ghiti wrote:
> Hi Greg,
> 
> On 10/09/2024 09:32, Greg KH wrote:
> > On Mon, Sep 09, 2024 at 10:57:01AM +0800, WangYuli wrote:
> > > From: Andrea Parri <parri.andrea@gmail.com>
> > > 
> > > [ Upstream commit d6cfd1770f20392d7009ae1fdb04733794514fa9 ]
> > > 
> > > The membarrier system call requires a full memory barrier after storing
> > > to rq->curr, before going back to user-space.  The barrier is only
> > > needed when switching between processes: the barrier is implied by
> > > mmdrop() when switching from kernel to userspace, and it's not needed
> > > when switching from userspace to kernel.
> > > 
> > > Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
> > > primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
> > > architecture, to insert the required barrier.
> > > 
> > > Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
> > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Link: https://lore.kernel.org/r/20240131144936.29190-2-parri.andrea@gmail.com
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > Signed-off-by: WangYuli <wangyuli@uniontech.com>
> > > ---
> > >   MAINTAINERS                         |  2 +-
> > >   arch/riscv/Kconfig                  |  1 +
> > >   arch/riscv/include/asm/membarrier.h | 31 +++++++++++++++++++++++++++++
> > >   arch/riscv/mm/context.c             |  2 ++
> > >   kernel/sched/core.c                 |  5 +++--
> > >   5 files changed, 38 insertions(+), 3 deletions(-)
> > >   create mode 100644 arch/riscv/include/asm/membarrier.h
> > Now queued up, thanks.
> 
> 
> The original patch was merged in 6.9 and the Fixes tag points to a commit
> introduced in v4.15. So IIUC, this patch should have been backported
> "automatically" to the releases < 6.9 right? As stated in the documentation
> (process/stable-kernel-rules.html):
> 
> "Note, such tagging is unnecessary if the stable team can derive the
> appropriate versions from Fixes: tags."
> 
> Or did we miss something?

Yes, you didn't tag cc: stable at all in this commit, which is why we
did not see it.  The documentation says that :)

thanks,

greg k-h

