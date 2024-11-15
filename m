Return-Path: <stable+bounces-93085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6E29CD694
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9568E1F2274B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0B175D5F;
	Fri, 15 Nov 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GArVcg6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6480B
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648814; cv=none; b=sm7ebjqh24lYpcIyICZlBwl+swyNo5aYwjDh3tQzXnwH2XxtT+Paa+PZChTX9IjjHv8B/4V7E44WKadqtVo7IadbcPmP7Qp6aaCnwwpNZZT2CJgiYT8RVi77G3ch4JNyvYw9crQ4gEK38mQBmZ+0+PncA9w1fVezs7Wb99HP6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648814; c=relaxed/simple;
	bh=mp8Q3eksKFiS3yQwb1JtaC2S1E0fjkFuiaZDpvI8GgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwAy5hgzql8Q1GNTok+FuNpKLUBE/auy3kgcZdiTIVPP8WHHbqd9Htby8AZIZKdNx2UlMaADMzhzxOs1SFj/Eq8mk1E6cUcXfGHkevT5yjeSZMM6LRGC8GIUjuU08PpszXtU5NfXwG8vVddiDnLfbfCG9xQruzyQX/SqGQ24+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GArVcg6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66031C4CECF;
	Fri, 15 Nov 2024 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731648814;
	bh=mp8Q3eksKFiS3yQwb1JtaC2S1E0fjkFuiaZDpvI8GgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GArVcg6Pu3fGi15Rl0wbDlAcDjkZdhpJDQKp6uGRowkfQC2WX1lzOl53X0ggRt3G2
	 aE8ZAJwS3EeoCWvheXKf8sc8EFHE07dq9sJL/QwVMg2cl+7r7/UK1vlYR2dWRkRSE9
	 uvoOMt/3aUbDLi9ZmPbIYk5VBxpseAu5b7KM9WBs=
Date: Fri, 15 Nov 2024 06:33:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, kirill.shutemov@linux.intel.com,
	nphamcs@gmail.com, richard.weiyang@gmail.com, ryan.roberts@arm.com,
	shakeel.butt@linux.dev, shy828301@gmail.com, stable@vger.kernel.org,
	usamaarif642@gmail.com, wangkefeng.wang@huawei.com,
	willy@infradead.org, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] mm/thp: fix deferred split unqueue naming
 and locking" failed to apply to 6.6-stable tree
Message-ID: <2024111547-pod-carrot-54fc@gregkh>
References: <2024111106-employer-bulgur-4f6d@gregkh>
 <bcd65dea-5dfe-7d55-68bb-4a7031ebaccf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd65dea-5dfe-7d55-68bb-4a7031ebaccf@google.com>

On Wed, Nov 13, 2024 at 12:59:53AM -0800, Hugh Dickins wrote:
> On Mon, 11 Nov 2024, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x f8f931bba0f92052cf842b7e30917b1afcc77d5a
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111106-employer-bulgur-4f6d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Thanks for trying this: as expected, the v6.11 port was easy,
> but earlier releases not.
> 
> I've probably spent more effort on this v6.6 version than it deserves,
> and folks may not even like the result: though I am fairly satisfied
> with it by now, and testing has shown no problems.
> 
> If I do go on to do v6.1 and earlier (not immediately), I won't approach
> them in this way, but just do minimal patches to fix mem_cgroup_move_charge
> and mem_cgroup_swapout (mem_cgroup_migrate was safe until v6.7).
> 
> There's a tarball attached, containing the series of six backports needed
> (three clean, three differing slightly from the originals).  But let me
> put inline below a squash of those six, so it's easier for all on Cc to
> see what it amounts to without extracting the tarball.  Based on v6.6.60,
> no conflict with v6.6.61-rc1

Thanks for this!  I accidentally commited this one "big patch" to the
queue, but then realized the tarball was what I wanted, so went back and
applied from there directly.  Sorry for any confusing emails sent out
about that.

greg k-h

