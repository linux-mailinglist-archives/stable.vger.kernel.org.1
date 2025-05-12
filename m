Return-Path: <stable+bounces-143271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38AAB38C0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5FE1891356
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FBA294A18;
	Mon, 12 May 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSqpaExD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9D2949FD
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056154; cv=none; b=Ciu0FG7pdjdKTLI5l6CFjiz6U7MxMqyOa4a80Sm0VjHAQsSneYvJd28zFEq8LhFytO0rVUehpQDlhZIcDF1voB0S8Gt5V3MrLdyPCA24gj97Z1rHxApKDPRvYbaYYf+oFm8pIByntsYKL+7FFMkx/C4wjQijjUtLf2gwQNZ4oHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056154; c=relaxed/simple;
	bh=b/H8477FYtiDl3aXXObibNNXnWxL9n2u2S9P7jXa/IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXRgDa4YKwaadw3FKEEEbrgeE/cHjytCKRCCZ/Cz6cA24Q08qZHtons46kbH66SFYetwLDd0q7GeAUoZ/DzfuhOcbUjr2pQa+FS8LNZqEyFwgPXgBlDkp3KFpJqLVi2L94+JfFEil8hkVysUjuBgx1hzhgeg5B/NZkj5CqNRVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSqpaExD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAA8C4CEE7;
	Mon, 12 May 2025 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747056153;
	bh=b/H8477FYtiDl3aXXObibNNXnWxL9n2u2S9P7jXa/IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSqpaExDo9RCFF2oo6AhM+wTRxh/9R0BL8Th5xYPrlpHYrFUfxK+Nn5bhbfiWcenN
	 Ub77dIarpe5+WlQdK0aiwqE1TQQW/IeHVWIIlFZ+0UjYDaL0Hw8xJds5dffM9GFA+2
	 no6KGU1A6PoRPyHE5fsbrkorXM2vrPw6osllsWVs=
Date: Mon, 12 May 2025 15:22:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Subject: Re: Patch "memblock: Accept allocated memory before use in
 memblock_double_array()" has been added to the 6.6-stable tree
Message-ID: <2025051217-dispersal-trustful-906e@gregkh>
References: <2025051242-predefine-census-81af@gregkh>
 <9339fb64-a62a-fdb7-5686-dd9b2a4cdf0d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9339fb64-a62a-fdb7-5686-dd9b2a4cdf0d@amd.com>

On Mon, May 12, 2025 at 08:15:22AM -0500, Tom Lendacky wrote:
> On 5/12/25 05:34, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     memblock: Accept allocated memory before use in memblock_double_array()
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      memblock-accept-allocated-memory-before-use-in-memblock_double_array.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> The 6.6 version of the patch needs a fixup. As mentioned in the patch
> description, any release before v6.12 needs to have the accept_memory()
> call changed from:
> 
> 	accept_memory(addr, new_alloc_size);
> 
> to
> 
> 	accept_memory(addr, addr + new_alloc_size);
> 
> Do you need for me to send a v6.6 specific patch?

Yes please, I'll go drop this one now.

thanks.

greg k-h

