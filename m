Return-Path: <stable+bounces-131969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3DA82A7C
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 17:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5571189CD81
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D02265CC5;
	Wed,  9 Apr 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="elsCI4RL"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E669D2B;
	Wed,  9 Apr 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212437; cv=none; b=tbQh3Dfb6CIoK01Po6NwTRp0iQTt+3M4Tff6H/l4BTdYPIrWfMjebxdAp1E7xEtoqenVsZHshgcDUN9wZNT4yHMuGW7ttcAVoONVY0vrL2KWbiR1hY/8I43IGGTjNVj2p6PSsunyx0PHynmk5dRofraxB7xQCk5xzxKF+SreQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212437; c=relaxed/simple;
	bh=qbv5VX98vIcIPOUSeR4TxxKkhB/UgpxzgMbNDUt70To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0V/suLaxdKs9dSo/DRQCePDMgOLtGf8eYHjknyLccM5j1+46gMHkWqugM1RkYYaRRmvyJlzlmPQhcY7XAO9fT9P9oCWeig0j5IrY49CM+XdpYPFrmrBYqrLcvxOUzQ/4tJcvDeGnMulj9Ck0mFibwGb1/gFkALCw4u/HJDDffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=elsCI4RL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wbzNcKaI2Ju+NUurCd+43BqDXaBMvMUrjcEfBIbcm6c=; b=elsCI4RLVTbXJh8m6jf0fPfoZB
	YWu/Wj9wFWmML48QzkNpHnYgD3fXpjA8vnc54ftkdU+DpTaS6kfXY1sAPZxiLc2Rp62zxKwDWlwP+
	edtCHwAy8x3yz6AfLhI64+2FnKYbwiFP+1jeHbBIWBTDq5l0Xil0cv/XLy6GeiwWfYo/LruUln3hk
	hYOOMxXIkKhcRvxMsoAScZsy0j7FJBERghBSBDrwNGP2KtrnUa6iN8rlmffRYQd+UamqlpsQ/pV5F
	MRbjWWUc2TeMH+GHIhGA6zbSCZugfXYbBNUiLVkvynJR2mbctO6B9tl7USrPw2JGuDBV/aVcpDPP7
	NbpbArNA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2XKR-00000008dy8-3x7H;
	Wed, 09 Apr 2025 15:27:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D8A83003FA; Wed,  9 Apr 2025 17:27:03 +0200 (CEST)
Date: Wed, 9 Apr 2025 17:27:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Pat Cody <pat@patcody.io>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, patcody@meta.com,
	kernel-team@meta.com, stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250409152703.GL9833@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
 <20250402180734.GX5880@noisy.programming.kicks-ass.net>
 <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>

On Wed, Apr 09, 2025 at 10:29:43AM -0400, Rik van Riel wrote:
> On Wed, 2025-04-02 at 20:07 +0200, Peter Zijlstra wrote:
> > 
> > Anyway, seeing how your min_vruntime is weird, let me ask you to try
> > the
> > below; it removes the old min_vruntime and instead tracks zero
> > vruntime
> > as the 'current' avg_vruntime. We don't need the monotinicity filter,
> > all we really need is something 'near' all the other vruntimes in
> > order
> > to compute this relative key so we can preserve order across the
> > wrap.
> > 
> > This *should* get us near minimal sized keys. If you can still
> > reproduce, you should probably add something like that patch I send
> > you
> > privately earlier, that checks the overflows.
> 
> Our trouble workload still makes the scheduler crash
> with this patch.
> 
> I'll go put the debugging patch on our kernel.
> 
> Should I try to get debugging data with this patch
> part of the mix, or with the debugging patch just
> on top of what's in 6.13 already?

Whatever is more convenient I suppose.

If you can dump the full tree that would be useful. Typically the
se::{vruntime,weight} and cfs_rq::{zero_vruntime,avg_vruntime,avg_load}
such that we can do full manual validation of the numbers.

