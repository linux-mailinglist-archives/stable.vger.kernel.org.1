Return-Path: <stable+bounces-86788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D519A388B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7352B21563
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481718755C;
	Fri, 18 Oct 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUZsKT0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C737E101
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240223; cv=none; b=hRl5OKtgfz37Wk4cPuGMhrdT1c6qN3ATu0fL7F5sEQjwWKByQaWnqPrIFx6Wbwv60ZqW0RJA2ibIwqyk0oQJdKy6ODTWnCU7wJZmbGbLXXia6HFZFKN84jE0x0rxrJrh3FY4Yphx6UAagSU/fJoz+xKNqcFmRiNuiMmO1M15m9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240223; c=relaxed/simple;
	bh=Fcj01Z2tyroDi/45Vr40n2B4cZ3d+x4XG0wdWWESwe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCuoqXd0KkONtbVd/EFNcrjSQTnOc5imTaARLqlzr9NqyVqZ0Quz5tizkhs48xbLMYteXAYsu2SR0NzmKtm9TSL3499HaA1PdMbO9ES/u5ZAV6KlJCZPNbGU/GZmJtj/J+DXX65AewfL8DuzIf3qgR5y7zy3t82ayIQOY4dv8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUZsKT0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23ACC4CEC3;
	Fri, 18 Oct 2024 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729240223;
	bh=Fcj01Z2tyroDi/45Vr40n2B4cZ3d+x4XG0wdWWESwe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUZsKT0UMddRoakxvyvXpYTTnANb8QI4tLsKKEV8+arT9D624tbWwUKfS7izTyKGk
	 X030IOw07NhVdnPjrFTxBgVksmyGMu6052WMLVbYxaD1NnzXRKrj2vx8/LYm5wOyw4
	 jSJhFdagC1LmDjVz+A/ldncL/FfHam4FIaUYBFNE=
Date: Fri, 18 Oct 2024 10:30:20 +0200
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
Subject: Re: [PATCH 6.11.y 0/3] : Yu Zhao's memory fix backport
Message-ID: <2024101824-exonerate-unpopular-f367@gregkh>
References: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
 <2024101856-avoid-unsorted-fc33@gregkh>
 <3b8915df-2327-4054-ab68-0521f9c1bb74@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8915df-2327-4054-ab68-0521f9c1bb74@suse.cz>

On Fri, Oct 18, 2024 at 10:18:19AM +0200, Vlastimil Babka wrote:
> On 10/18/24 07:58, Greg KH wrote:
> > On Thu, Oct 17, 2024 at 02:58:01PM -0700, chrisl@kernel.org wrote:
> >> A few commits from Yu Zhao have been merged into 6.12.
> >> They need to be backported to 6.11.
> > 
> > Why?
> > 
> >> - c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
> >> - 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
> >> - e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")
> > 
> > For mm changes, we need an explicit ack from the mm maintainers to take
> > patches into the stable tree.  Why were these not tagged with the normal
> > "cc: stable@" tag in the first place?
> 
> The two codetags commit actually were tagged.

Ah, I missed that, I only looked at the first one and stopped there.

> c2a967f6ab0ec seems to me an
> unrelated performance optimization, could make sense in a LTS kernel but is
> there a lot of benefit expected for the lifetime of 6.11?

I can't take any of these as they aren't properly signed-off so I'll
wait for a resubmit to consider any of these (but patch 1 better have
some justification and ack from the mm developers that we can take
it...)

thanks,

greg k-h

