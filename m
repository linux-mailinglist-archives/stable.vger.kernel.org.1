Return-Path: <stable+bounces-86750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB999A358F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBDA284A14
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE1E17DFEB;
	Fri, 18 Oct 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gNjS8PEs"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6420E30E
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233552; cv=none; b=FYlBGCFVHqSWrSRreXBU6E/B1s2Km5/+OPr/J2RU/2RTzPsXAUJjwVLccwX9ODr5zb0Kfp0q30YHHYl6zWSbPObUEtO1+rjI4vokULmyjHlkHljUl4sl/eQawgYgEnNIpwTuxlCUs3vYgUaxooLJ3aWp+VvDvq9/qf8zI7wI27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233552; c=relaxed/simple;
	bh=wpcLuO5tYuIlgzsR02I/trFAkkzQL/Pz6HMUG2AWyQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QysyHTGZd8TT+/+NZcjiNc9dAK2gxTHQNDth1sIwBWn7IEYYLg8wodbBONXfwKDC2LT/60lChM2chCbJUuC9y4tS+ANNAPcO6tUEDM4VU9BwmXB1nGcK8s5zWHZhL7oeQleKyDOuc0a4Dh0clmDfQLBVy1i02G1YbWvQha9KO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gNjS8PEs; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Oct 2024 02:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729233547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxTWwJUr2UrghmbNCpGhcUMRYZvIYOKkeTMeZ6wCbWQ=;
	b=gNjS8PEs66vToi4dEFYbqCc7203aLPkGXNGAwBsZw473CisBSFVFUpJnwWQX9SvaN4oRWB
	Oe4hBEW5UqzPVkY9mjqsVd0dVV76UxV7h3VWnU1ck8U3lPTOlEPOCttBqYXK+yxUW2/oNi
	pZwaDztkCNqMhjH1e7ozpFrt33+uJt8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: chrisl@kernel.org, stable@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 6.11.y 0/3] : Yu Zhao's memory fix backport
Message-ID: <uldnkkrbjugod2uvmx6sckxibie2hjjnv4mhlikpvnlkkvoqhf@3oeyqgkttveb>
References: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
 <2024101856-avoid-unsorted-fc33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101856-avoid-unsorted-fc33@gregkh>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 18, 2024 at 07:58:41AM +0200, Greg KH wrote:
> On Thu, Oct 17, 2024 at 02:58:01PM -0700, chrisl@kernel.org wrote:
> > A few commits from Yu Zhao have been merged into 6.12.
> > They need to be backported to 6.11.
> 
> Why?
> 
> > - c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
> > - 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
> > - e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")
> 
> For mm changes, we need an explicit ack from the mm maintainers to take
> patches into the stable tree.  Why were these not tagged with the normal
> "cc: stable@" tag in the first place?

I've got a possible regression in memory allocation profiling, and page
splitting would be a likely culprit, so we should probably hold off on
backporting until I bisect.

