Return-Path: <stable+bounces-48301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0018FE756
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059FEB24C4A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18299195F27;
	Thu,  6 Jun 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jzItJAA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB613C826;
	Thu,  6 Jun 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679597; cv=none; b=U+TqzHEcL9Y0IaZuM1HtUtasl6Sa0rI/tr1uEyYp/4YYaSBIWPfKGfyViOBz8GHCx8TynDiMaVh4hOyNoeKrAmpR2tLyQSJBjY7Yrhc+JL+0M5kSC2xWJn5hBTdTATBOJ9ngLoEJ1gsvUpYbJlNb/Z3e70uRvIb73TAVtqoK3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679597; c=relaxed/simple;
	bh=R/1LF7rPeOtGgAmg31Fkr01LM5Ni5L50WWnz5ezlb98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5PC0h1ySnbafM6NcpBlQ7gTnpWf/AH+j87f+FgXu2UoRm2pkhsbMnfXkos3HyApAhjMVqeKeVnuRbVabRF7JZeiENvx0xY1KmDcZJXepeeZyX03Ho8r/Us54zXUOtDdAYShZIKWtglaRp+UTysxrl/1XS57nPzyFsfHSDclB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jzItJAA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A58C2BD10;
	Thu,  6 Jun 2024 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717679597;
	bh=R/1LF7rPeOtGgAmg31Fkr01LM5Ni5L50WWnz5ezlb98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzItJAA+X0ugFeqzgKjpS9hPSsgmagQFhpUedcXw+no2uyCxX+urM/PU8ICVEGBr4
	 qh9d+1jnT7XG5K5KhrxocwaJsBjGeOTIBHmngnw3nFon3zEj1sNMUXmbC+5fmVONhQ
	 3ya8dX6JphoQy6GwtrNDIxdE3W4kKD3OFyBr8oaA=
Date: Thu, 6 Jun 2024 15:13:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: Patch "arm64: fpsimd: Bring cond_yield asm macro in line with
 new rules" has been added to the 6.6-stable tree
Message-ID: <2024060653-enlarging-imprecise-2831@gregkh>
References: <20240605231152.3112791-1-sashal@kernel.org>
 <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>

On Thu, Jun 06, 2024 at 02:42:09PM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Jun 2024 at 01:11, Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     arm64: fpsimd: Bring cond_yield asm macro in line with new rules
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      arm64-fpsimd-bring-cond_yield-asm-macro-in-line-with.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> 
> NAK
> 
> None of these changes belong in v6.6 - please drop all of them.

Odd, yeah, we add some stuff, then the patch, and then the revert of it,
but not then these.  I'll go drop them all, thanks for the review!

greg k-h

