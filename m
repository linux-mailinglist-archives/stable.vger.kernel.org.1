Return-Path: <stable+bounces-94011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3CF9D27FB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55119B2EDD7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F861CDA39;
	Tue, 19 Nov 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2f0AXcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774711CCB23;
	Tue, 19 Nov 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025716; cv=none; b=kO9py50+t/p30+FG708LwCKSL+pwtW6jzdm3HyCqM1EPRhtSe02aWqADPztjciUsQ01jL9Bt/j28MG0mf8NF4bGdqyOtH5fuEyVveWDzitQ5ULhJqpglIz50PR8GTfos2Ijq5MrcW3CsgHV4G8H9wqrXQi801mBKzewTnotL9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025716; c=relaxed/simple;
	bh=Q+RHmcNHjNmW4oV/4STiDLZbbvONXbLU+a9emUh0paE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmsxgHJgxdX0dSgkXTFIr/cN2m/oY+JGSLg8a75nDJSq+sTjHagN0Oq96OISS0uJqmdP/nRm3lySql10Iq1yFYBGdsD3ChjHCxTtZVIdn0q9M6xJ0HJMZN/xnz6N9+xgmamHfaMa6vl2eVDJjDo/UwbvO1eLiSSWN/k92jvJKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H2f0AXcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8934C4CECF;
	Tue, 19 Nov 2024 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732025716;
	bh=Q+RHmcNHjNmW4oV/4STiDLZbbvONXbLU+a9emUh0paE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2f0AXcfzYj8VqayMjV8ZMiuTONB3JBlDMJZQOs0FX2m/toSoxaxoRl1Ls/5KgFXK
	 dEeL+mwPr61X711GRet0tcQLrMbQcbz0PftNqIDJk0qYUXco/WQspC7tZJkMNBUbyL
	 z/3aa2WC2i8QeQWMtM0iqGJe1abpco4zr48eU5jI=
Date: Tue, 19 Nov 2024 15:14:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.6.y 0/5] fix error handling in mmap_region() and
 refactor (hotfixes)
Message-ID: <2024111921-snuff-onlooker-f95a@gregkh>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
 <2024111932-fondue-preorder-0c6f@gregkh>
 <7189585f-d6a8-4335-a78c-547ce468fe0b@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7189585f-d6a8-4335-a78c-547ce468fe0b@lucifer.local>

On Tue, Nov 19, 2024 at 01:24:33PM +0000, Lorenzo Stoakes wrote:
> On Tue, Nov 19, 2024 at 02:16:52PM +0100, Greg KH wrote:
> > On Fri, Nov 15, 2024 at 12:41:53PM +0000, Lorenzo Stoakes wrote:
> > > Critical fixes for mmap_region(), backported to 6.6.y.
> >
> > Did I miss the 6.11.y and 6.1.y versions of this series somewhere?
> >
> > thanks,
> >
> > greg k-h
> 
> 5.10.y - https://lore.kernel.org/linux-mm/cover.1731670097.git.lorenzo.stoakes@oracle.com/
> 5.15.y - https://lore.kernel.org/linux-mm/cover.1731667436.git.lorenzo.stoakes@oracle.com/
>  6.1.y - https://lore.kernel.org/linux-mm/cover.1731946386.git.lorenzo.stoakes@oracle.com/
>  6.6.y - https://lore.kernel.org/linux-mm/cover.1731672733.git.lorenzo.stoakes@oracle.com/
> 
> I didn't backport to 6.11.y as we are about to move to 6.12, but I can if
> you need that.

True, 6.11.y is only going to be around for another few weeks, just
wanted to make sure I hadn't missed this.  I'll go queue all of these up
now, thanks for the backports!

greg k-h

