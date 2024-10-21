Return-Path: <stable+bounces-87044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0599A608D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C674D2826D8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B91D1727;
	Mon, 21 Oct 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OpGqmR86"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B61953B9
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504030; cv=none; b=UvF8UFAgKWj6XoSGpwaSpg0JBGPyYnh86/yspJWcVUKRWw6EqpQRCwhIp2CHtCGFNkMxYnr+JTuaZYO3INwbJWFGeNcQ89FOmlCJyi8XcCp6r0cejJYrocc04FXhm9QQAdggZjLhmzkP2AiaduTxzb/xMuunnC8xNb3LldRE6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504030; c=relaxed/simple;
	bh=sjAgj7Ldoi4HQVJl14e9VHuw9NyEq7WxkBbfCnmFLJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKTeWQxNazpm2sU/iiITw3c4cAbEfSrEmZwEM4TlMow1cSeTDwwKkQVJlKm0ovni5dlEZn05MINtysqr451MScfLyPiplKAU/hQxTUDWXS7S+XUkaahtuD9Z067uIEq04irTIFisIeWoQ4Kwc3d0pOED6c+R8u4QBIuqg9QDtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OpGqmR86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B62C4CEC3;
	Mon, 21 Oct 2024 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729504029;
	bh=sjAgj7Ldoi4HQVJl14e9VHuw9NyEq7WxkBbfCnmFLJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpGqmR86TaiIh4uqgWMQsAXEjMpRzK8Bo7hbLb/NplpXeljKfNnmiee6u4G7Dzb7G
	 OPSG0RRSfMmfhpo+BVYGBfTqAQbg+orSrsiJ3xnWjqgaYeH8Wa73dCwYnNDEHd0FcC
	 heeYWg9s7lc7UnA7drQo+Xh4E1b852VtKV5jpst4=
Date: Mon, 21 Oct 2024 11:47:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: chrisl@kernel.org, stable@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>, Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <oliver.sang@intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 6.11.y v2 0/3] Yu Zhao's memory fix backport
Message-ID: <2024102139-hangnail-thimble-38d4@gregkh>
References: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
 <3d7865c0-f269-413f-bb9d-54f46acbe489@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7865c0-f269-413f-bb9d-54f46acbe489@suse.cz>

On Fri, Oct 18, 2024 at 11:59:50PM +0200, Vlastimil Babka wrote:
> On 10/18/24 7:27 PM, chrisl@kernel.org wrote:
> > A few commits from Yu Zhao have been merged into 6.12.
> > They need to be backported to 6.11.
> 
> But aside from adding the s-o-b, you still didn't say why?
> 
> > - c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
> 
> Especially for this one.
> 
> > - 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
> > - e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")
> 
> And those are marked already, but actually Kent wanted to hold off in
> response to your v1, due to suspecting them to cause problems?

Ok, I'm going to drop these from my review queue for now.  Please, when
you all work it out, resend if they are still deemed necessary for
6.11.y or any other stable tree.

thanks,

greg k-h

