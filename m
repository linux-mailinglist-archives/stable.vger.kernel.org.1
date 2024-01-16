Return-Path: <stable+bounces-11352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831582F323
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214F6284AFB
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BC1CAA6;
	Tue, 16 Jan 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JtuVsKQb"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555A1CAA4
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426005; cv=none; b=Q687hJ9qvlkbkldnzs2s24m9T4Ph8sywWcVQRDF+vuDR6/GHDLrVt2vFR3uKcLpw/0gKs5WYGrVpTcyQNtyUNbbE3ivbvfCFF1c8oA1xmPMMfYKPa15pstc0/l6UysYwTNzFN93gWVh1IAPlUSr+4eeNGcBUH9eVHUlg2y8rsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426005; c=relaxed/simple;
	bh=n3CxErObWVyCEWf6Zj2uRJ++qYhSqbR99XV/ZIU7bYk=;
	h=Date:DKIM-Signature:X-Report-Abuse:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Migadu-Flow; b=ms+riAAU9WChgKOyodRI0X5gv5yF9xt+4rPrRegJyOh4GNiSXvjQvdXO/dLFcFlxLSMAnnJZsqSt5K9UWoryulMxCIApzZ1onzE7VJClJ1tKv/VUwRsqoY8k1i4BWFSLQUtd46AAqqJNaEmHf61QyNfaAKHeeiEGhKW4++eGHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JtuVsKQb; arc=none smtp.client-ip=91.218.175.186
Date: Tue, 16 Jan 2024 12:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705426001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYQOp5qWW+BTXICBx99IGxd3eUV7OrPFcLzK9xg4HmI=;
	b=JtuVsKQb5+P9Aw/7LAS1/hfyNhVPQ74eqiQt6KJNq+0eQ6XR37leyfSOTK4clnYhuqRXHB
	ZN8nArCMTC9jMWVG+A67otLpGTFet700/2fYJCxw3i3N5B3W3Aj0zuBZgz/QhXYqYMqyi8
	4s7We7y0QWc1AoHSDB29KZ2twcEDSNs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2ve257m37wusszvzkr254hp62nvxecmdcnybmft5ebl6n7hesj@yelqgrderuay>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <2024011614-modify-primer-65dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011614-modify-primer-65dd@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 16, 2024 at 03:13:08PM +0100, Greg KH wrote:
> On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > myself; I'll be doing backports and sending pull requests after stuff
> > has been tested by my CI.
> 
> Now done:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=9bf1f8f1ca9ae53cf3bc8781e4efdb6ebaee70db
> 
> We will ignore it for any "Fixes:" tags, or AUTOSEL, but if you
> explicitly add a "cc: stable@" in the signed-off-by area, we will pick
> that up.

Would it work for your process to ignore cc: stable@ as well?

I want a tag that I can have tooling grep for later that means "this
patch should be backported later, after seeing sufficient testing", and
cc: stable@ has that meaning in current usage.

Or if you'd like that to be reserved for yourself we could think of a
new one.

> 
> > Thanks, and let me know if there's any other workflow things I should
> > know about
> 
> This is going to cause you more work, but less for us, so thanks!

per our conversation on IRC I'm going to write some simple tooling for
grepping through the git log for patches that may want to be backported
and haven't yet made it to a stable tree.

Also, Sasha, is there any reason your autosel tool couldn't be made
available for others to use that way?

Yes, it's more work for myself, but I have strong opinions that I as the
person who knows the code ought to be picking the patches to backport,
and doing the backports and resolving merge conflicts when necessary;
but collaborating on tooling would be _fantastic_.

