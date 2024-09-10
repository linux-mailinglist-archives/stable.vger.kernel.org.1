Return-Path: <stable+bounces-74122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854F972AD6
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EA5B20517
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797517C9EB;
	Tue, 10 Sep 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcszCMuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19852F71;
	Tue, 10 Sep 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953533; cv=none; b=jCuvavoESZnFHHDapUi4N+SLClhjNs035Zh0fWv88Q+cqRTv4PtefJgw28RWCd41JrMglSU1CA3neVcmv7J1JMSl0s7E1Euw1g5Wl5lyJ8JMj0SyGE6YTYmrYDtTThMHxnGqlgYHuyudEGkwyMpNX5fGnXX0pHH//IvQgIZbWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953533; c=relaxed/simple;
	bh=Wt3I8iEDKPg35JSenun0Nk2iBIDnFaPNA3lYXP3Yk4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozynRAhacyxkmVIWsp0vNB+w1DdZy/Ojb2rIyPvg+K9S2nFXE4/UQesVYZUe74BzZnTL3bVBqRnSC4JyL8cXymbF8FpG3WlAVCL12NVEB5W+UTNbzkDjN4M8NTkAmTjYrBvkATc477tkGsR4NJYSJxRTZKUcwfPUk7pqC40AYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcszCMuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A4C4CEC3;
	Tue, 10 Sep 2024 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725953533;
	bh=Wt3I8iEDKPg35JSenun0Nk2iBIDnFaPNA3lYXP3Yk4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcszCMuZNY9rpBWYCUlpAx6I7oXcWxHhUQfGs4FOETXF3tyEjS8aQXwrT1pZFCcEU
	 LhhUwaaWo+my1Lf8s57xE0KDl498Qzn3WzAmGpip6FtQGnRPZN5ry0i6ja1U0phOTU
	 7Vv4Z65RInrd9LnCJ6L/4HTNUhxM7ipbuJK9+QW8=
Date: Tue, 10 Sep 2024 09:32:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, parri.andrea@gmail.com,
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
Message-ID: <2024091002-caution-tinderbox-a847@gregkh>
References: <10F34E3A3BFBC534+20240909025701.1101397-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10F34E3A3BFBC534+20240909025701.1101397-1-wangyuli@uniontech.com>

On Mon, Sep 09, 2024 at 10:57:01AM +0800, WangYuli wrote:
> From: Andrea Parri <parri.andrea@gmail.com>
> 
> [ Upstream commit d6cfd1770f20392d7009ae1fdb04733794514fa9 ]
> 
> The membarrier system call requires a full memory barrier after storing
> to rq->curr, before going back to user-space.  The barrier is only
> needed when switching between processes: the barrier is implied by
> mmdrop() when switching from kernel to userspace, and it's not needed
> when switching from userspace to kernel.
> 
> Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
> primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
> architecture, to insert the required barrier.
> 
> Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Link: https://lore.kernel.org/r/20240131144936.29190-2-parri.andrea@gmail.com
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  MAINTAINERS                         |  2 +-
>  arch/riscv/Kconfig                  |  1 +
>  arch/riscv/include/asm/membarrier.h | 31 +++++++++++++++++++++++++++++
>  arch/riscv/mm/context.c             |  2 ++
>  kernel/sched/core.c                 |  5 +++--
>  5 files changed, 38 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/asm/membarrier.h

Now queued up, thanks.

greg k-h

