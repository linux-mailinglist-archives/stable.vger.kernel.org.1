Return-Path: <stable+bounces-76184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2F979C34
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A13728371C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C313A863;
	Mon, 16 Sep 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VvKQXXlL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641828175F
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472679; cv=none; b=A79zh6Hw1FoBLhcwX4yF5kLbTEvzehq276uqljg7+QDztHWLfolruLFaZl5E/UzKiAQOjtvGhS7gRDSaxHzGkVf9ACTcgJoZxPTjnTgWUa6K4xM5tai5s/2l/VG4pCHF0Qqa8W6WLwt3r7jFDRBUn89G+cKSW41ZjX4ZR25vfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472679; c=relaxed/simple;
	bh=oB7UHUCX/iL0sTTNiK4Gi1C2rm4DtyQptJOpgMJHeY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIX3XSxwkBJjJG8tOfG8z3IOTMe4EkxhEVuZAzzzdORuaKY3WxbBscdR71PxEhNGbYmnN+0VMwbKSwtrGGqTvYvFotXkxN9YYaPOh/Lz3QMk0YLUSqbIBkGGwlz4MZgSDWvAtVpmPBzDyu0ikneoSSGwF07t+4No7k6nN/CE8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvKQXXlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9816C4CECD;
	Mon, 16 Sep 2024 07:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726472679;
	bh=oB7UHUCX/iL0sTTNiK4Gi1C2rm4DtyQptJOpgMJHeY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvKQXXlL1jlzBlJYbjaa8Jf2dWTAOYr8WzTOXiQ7YYbcFGN3mxuPaNxgYhgmrGBOj
	 Mnf2cr+4WO8yxub6yXj8xFHcPY2yr/l9vpmseaymP7BSzFVJE3FMOB5sRRKvp6dFwG
	 ZtR1oAc3s1PYexQWZFa6TmFRg8h3laK7adL1ksqc=
Date: Mon, 16 Sep 2024 09:44:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: stable@vger.kernel.org, Xingyu Jin <xingyuj@google.com>,
	John Stultz <jstultz@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 5.10.y] dma-buf: heaps: Fix off-by-one in CMA heap fault
 handler
Message-ID: <2024091614-headcount-headstone-b2f4@gregkh>
References: <20240916043441.323792-1-tjmercier@google.com>
 <2024091643-proved-financial-0bb5@gregkh>
 <CABdmKX1_zvT=EDGr0-hPmrbyf97JrzUB_Rw40JT9au6v4zaMUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX1_zvT=EDGr0-hPmrbyf97JrzUB_Rw40JT9au6v4zaMUw@mail.gmail.com>

On Mon, Sep 16, 2024 at 12:38:26AM -0700, T.J. Mercier wrote:
> On Mon, Sep 16, 2024 at 12:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Sep 16, 2024 at 04:34:41AM +0000, T.J. Mercier wrote:
> > > commit ea5ff5d351b520524019f7ff7f9ce418de2dad87 upstream.
> > >
> > > Until VM_DONTEXPAND was added in commit 1c1914d6e8c6 ("dma-buf: heaps:
> > > Don't track CMA dma-buf pages under RssFile") it was possible to obtain
> > > a mapping larger than the buffer size via mremap and bypass the overflow
> > > check in dma_buf_mmap_internal. When using such a mapping to attempt to
> > > fault past the end of the buffer, the CMA heap fault handler also checks
> > > the fault offset against the buffer size, but gets the boundary wrong by
> > > 1. Fix the boundary check so that we don't read off the end of the pages
> > > array and insert an arbitrary page in the mapping.
> > >
> > > Reported-by: Xingyu Jin <xingyuj@google.com>
> > > Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
> >
> > This commit is in 5.11, so why:
> >
> > > Cc: stable@vger.kernel.org # Applicable >= 5.10. Needs adjustments only for 5.10.
> >
> > does this say 5.10?
> >
> > thanks,
> >
> > greg k-h
> 
> a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the
> cma_heap implementation") moved the code from this heap-helpers.c file
> to cma_heap.c in 5.11, which is the only place it lives upstream now.
> The bug still exists in the original location in this heap-helpers.c
> file on 5.10.

Ah, then that was the wrong Fixes: tag :(

thanks, I'll go queue this up now.

greg k-h

