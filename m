Return-Path: <stable+bounces-55971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF53C91A96D
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B181C2100E
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9744B196C9C;
	Thu, 27 Jun 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/nNxa54"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F8195FEF;
	Thu, 27 Jun 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499365; cv=none; b=HEmnVwms/tPiaDPcrUThhBa46rMjry/+teh69a7DpDFq6rPR/XWmj1YEChFCgzyPsLbFgtxs4p4nGt38KUVFFchJeyq81hqWPtsb0Y2sLDTKXpqlKatQvYJk0OnTcQ//Zd+2X71JksLSw8pDvTW4hnzHAHWqgC/7HWMiNmd9eRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499365; c=relaxed/simple;
	bh=kxhoLkUXq44hWnlZZqxS5nqxVuFwyn9Q/6yADeybFNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Btlnqil+26ssedGfu3rFlDDd5ZOJnKUwlLYIqx3C5IzqF9EGeHnIYMnUgagXZdZ2mInuFKtif5TTKIWBiYCpECoYuNfE+Ssp8O1OJq5s85RS3ETnDNm3P8HPgBAZJs/PzszZr6A5z5DQjiLZAmpfQEtgFVsqtVm4H+Ivqlk4KO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/nNxa54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217AAC2BBFC;
	Thu, 27 Jun 2024 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719499364;
	bh=kxhoLkUXq44hWnlZZqxS5nqxVuFwyn9Q/6yADeybFNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/nNxa54xbCYzFF5V9lUz2JOdOcueYxQWV7PAs8lxhCQbf6z3jMRnnp/NM8bMujdR
	 11mJp6Vd7xLjiaLvtOrLzpl7GK+72J7aiXlEdIyv+6QCsy2pnzOQoictibN573nYIY
	 nJz/qkWft7Tx7mudtp10fCJUuEOAE0T9og4lZoy4RhUVVefecMQGp8R22LtSbFArpc
	 UB8EjyxgdrhgTZshA4vsjllLrt2Fp62zeXQ+6dFAKn1FqzhfZmqKJEPw5jieHWxRO9
	 kc2y2Y9eI6AP8D1OL7xAUg2CFfNFLc5DMl3xUNsicoMEG8G8AuPH8Rn8Add2C29/Si
	 GgCR65LTQNzow==
Date: Thu, 27 Jun 2024 17:40:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: memblock: replace dereferences of memblock_region.nid
 with API calls" has been added to the 5.4-stable tree
Message-ID: <Zn15zDM2kjbPOepD@kernel.org>
References: <20240626190708.2059584-1-sashal@kernel.org>
 <Zn0Q_DKvcVF8P5f-@kernel.org>
 <Zn1zXiis-yqRB2VO@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1zXiis-yqRB2VO@sashalap>

On Thu, Jun 27, 2024 at 10:12:46AM -0400, Sasha Levin wrote:
> On Thu, Jun 27, 2024 at 10:13:00AM +0300, Mike Rapoport wrote:
> > Hi Sasha,
> > 
> > On Wed, Jun 26, 2024 at 03:07:08PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     mm: memblock: replace dereferences of memblock_region.nid with API calls
> > > 
> > > to the 5.4-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      mm-memblock-replace-dereferences-of-memblock_region..patch
> > > and it can be found in the queue-5.4 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > 
> > > commit dd8d9169375a725cadd5e3635342a6e2d483cf4c
> > > Author: Mike Rapoport <rppt@kernel.org>
> > > Date:   Wed Jun 3 15:56:53 2020 -0700
> > > 
> > >     mm: memblock: replace dereferences of memblock_region.nid with API calls
> > > 
> > >     Stable-dep-of: 3ac36aa73073 ("x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()")
> > 
> > The commit 3ac36aa73073 shouldn't be backported to 5.4 or anything before
> > 6.8 for that matter, I don't see a need to bring this in as well.
> 
> Sadly there was no fixes tag :(
> 
> Should this be reverted from 5.4 and older, or is it ok for it to be
> there?

It should be reverted from 5.4 and earlier please
 
> -- 
> Thanks,
> Sasha

-- 
Sincerely yours,
Mike.

