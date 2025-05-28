Return-Path: <stable+bounces-147973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C8AC6CBA
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814237A468E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9735288C9B;
	Wed, 28 May 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVZ1X7ne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A601C683;
	Wed, 28 May 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445642; cv=none; b=UvhKj5s1YXTKohf+HeAVlLLjcRiLvtvvWpll4cOq/oyTLoVaS7qj6MFwtOVcE4t2oz6bIgs0DCN1bxlyC7Cnj2yYwy1sdn8ZB/4qSt+XJgAQ6gT9sXFZHnTo0/O72kr8AoENrAbJke4l6B7jUWMI7wocnJ1xdnMt214yEZSu9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445642; c=relaxed/simple;
	bh=IKr9+MA+9okWN9C27pDp8r5LvWkD4PL2yqXr+lVANRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5UjZa2QoUrqMJ6MT0TOAcLluJhOxXz/AvtqDHl2ofcJNLNDdjkRhyK7x374b1kyp7dcodzdUO9BMwkuqY4hehqq2KtvDleoVlNX2n0+WOChykhvSY5RHbHLqfQZhZOPzQjAsG2fTgy4nhCkQ6gBj1DFPb6B4P561sFS3OXjdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVZ1X7ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A02C4CEEE;
	Wed, 28 May 2025 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748445642;
	bh=IKr9+MA+9okWN9C27pDp8r5LvWkD4PL2yqXr+lVANRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVZ1X7nezOONOzxwXJ4Jdfc2Yk0JQun9rCt2edmcL3rVjPxz0hnrI9pG+xnIcvYO8
	 ss8dHII66vsCm/5VO8XIs726R2SJaoL5Ooz8dju4OPMiJLSMAK8628jH5x60B1EMyb
	 30uVeteOTPKJYkS8s35y2yXFr9fi/oHe8MvFm0R/LyZffSZzrXcDruJagkh1ipnkaZ
	 C8KGf1wcG/dgeUPUDV4dunSNmj8Ks+Bdpp2YbPDnWX5BNeqdcOvcrBo6TltutzdSOS
	 azYusE9XfQo6S4DMfRXPwbGD6jvjgq2vODUC06z6noP3Recru20KnxlLYnYgCfljIk
	 Ux1UzdRi8o8Mg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uKIaD-000000002xI-1Lic;
	Wed, 28 May 2025 17:20:46 +0200
Date: Wed, 28 May 2025 17:20:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Nicolas Escande <nico.escande@gmail.com>,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix ring-buffer corruption
Message-ID: <aDcpzTI-Bjry144Z@hovoldconsulting.com>
References: <20250321095219.19369-1-johan+linaro@kernel.org>
 <aC8-mUinxA6y688X@pilgrim>
 <aDRR5oYBU0Z-DaWr@hovoldconsulting.com>
 <aDRli6uIbnuQK3nN@pilgrim>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDRli6uIbnuQK3nN@pilgrim>

On Mon, May 26, 2025 at 02:58:51PM +0200, Remi Pommarel wrote:
> On Mon, May 26, 2025 at 01:35:02PM +0200, Johan Hovold wrote:
> > On Thu, May 22, 2025 at 05:11:21PM +0200, Remi Pommarel wrote:

> > > Why not move the dma_rmb() in ath12k_hal_srng_access_begin() as below,
> > > that would look to me as a good place to do it.

> > We only need the read barrier for dest rings so the barrier would go in
> > the else branch, but I prefer keeping it in the caller so that it is
> > more obvious when it is needed and so that we can skip the barrier when
> > the ring is empty (e.g. as done above).
> 
> Thanks for taking time to clarify this.
> 
> Yes I messed up doing the patch by hand sorry, internally I test with
> the dma_rmb() in the else part. I tend to prefer having it in
> ath12k_hal_srng_access_begin() as caller does not have to take care of
> the barrier itself. Which for me seems a little bit risky if further
> refactoring (or adding other ring processing) is done in the future;
> the barrier could easily be forgotten don't you think ?

Yeah, that would be the argument for putting in the helper. Big hammer
vs adding it where needed after reviewing the code.

There actually is a new ring being added for 6.16-rc1 I noticed after I
posted the latest series. That would require a follow-up fix with the
barrier-in-caller approach.

> > > dma_rmb() acting also as a compiler barrier why the need for both
> > > READ_ONCE() ?
> > 
> > Yeah, I was being overly cautious here and it should be fine with plain
> > accesses when reading the descriptor after the barrier, but the memory
> > model seems to require READ_ONCE() when fetching the head pointer.
> > Currently, hp_addr is marked as volatile so READ_ONCE() could be
> > dropped for that reason, but I'd rather keep it here explicitly (e.g. in
> > case someone decides to drop the volatile).
> 
> Yes actually after more thinking, the READ_ONCE for fetching hp does make
> sense and is also in the patch I am currently testing.
> 
> Also for source rings don't we need a dma_wmb()/WRITE_ONCE before
> modifying the tail pointer (see ath12k_hal_srng_access_end()) for quite
> the same reason (updates of the descriptor have to be visible before
> write to tail pointer) ?

Yep, the source rings need explicit barriers for the LMAC case, but
there are further issues here too.

And that may also suggest adding the barriers in the start/end helpers
for consistency (i.e. use the big hammer).

I'll try to find some more time to fix the remaining bits next week.

Johan

