Return-Path: <stable+bounces-47631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFF8D33EE
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D2D1C23522
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CF17A902;
	Wed, 29 May 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2E7PjElq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B516ABEB;
	Wed, 29 May 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976933; cv=none; b=Q3j2lMNTCtnDlFYmIPVqIXKSRxV7flbpITscvJhgUnENAHDrEHa2zngvDQ1GK/KS1xGtHRBlEbqIzReVMewvtJIO+zkGhyGbezIGMgLohJGZGlQxiSYc0QLGI1GW4Umqr6qVMKhrniVk0OXi3zOuE8N4tlMdmadMLx8jF8SJixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976933; c=relaxed/simple;
	bh=DuDw8/yBB2AZVr6AgtJgvvzrp1U7IhFhr0g5CR4Yv7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kABdbw2L+raZVQx6H1hZZ8rKXIJOhxBdVD+hODo3pAdQxjtuwU35XuCiCQtR6z0hmH8lALnLphIVEizZtXGMjsd8cM0ud2bO0tYmRgf8bb5kHBonYI+F76ZwzvZ7tYR2g6Ftc0YXp+G1bgC9+Nr0+fhmjFaYvQ+1F4c7+MIkt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2E7PjElq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166C8C2BD10;
	Wed, 29 May 2024 10:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716976932;
	bh=DuDw8/yBB2AZVr6AgtJgvvzrp1U7IhFhr0g5CR4Yv7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2E7PjElqMLhAHLpr0fXD0T9cfdBQ9L+26TbC5AJP5nV1rdOsiwWlw9BlAzqeB7JDj
	 sXh/85kGFYl0nF6YCVzySxIvl4eSKl7tGf3P4IB344mOE9fKXft9tWFbxAh8vh1XEX
	 MkVoWWlYd6MVahGOhFq0X2c9gGuI+gbra25un6fo=
Date: Wed, 29 May 2024 12:02:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.15 0/2] Revert the patchset for fix
 CVE-2024-26865
Message-ID: <2024052936-yelp-panhandle-6a62@gregkh>
References: <20240506030554.3168143-1-shaozhengchao@huawei.com>
 <2024052355-doze-implicate-236d@gregkh>
 <92bc4c96-9aaa-056c-e59a-4396d19a9f58@huawei.com>
 <2024052511-aflutter-outsider-4917@gregkh>
 <9940d719-ee96-341d-93e6-ffd04b6fddba@huawei.com>
 <2024052526-reference-boney-1c67@gregkh>
 <7430832a-d5ca-da76-6e41-e17ba5b5f190@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7430832a-d5ca-da76-6e41-e17ba5b5f190@huawei.com>

On Wed, May 29, 2024 at 03:59:31PM +0800, shaozhengchao wrote:
> 
> 
> On 2024/5/25 18:42, Greg KH wrote:
> > On Sat, May 25, 2024 at 06:21:08PM +0800, shaozhengchao wrote:
> > > 
> > > 
> > > On 2024/5/25 17:42, Greg KH wrote:
> > > > On Sat, May 25, 2024 at 05:33:00PM +0800, shaozhengchao wrote:
> > > > > 
> > > > > 
> > > > > On 2024/5/23 19:34, Greg KH wrote:
> > > > > > On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
> > > > > > > There's no "pernet" variable in the struct hashinfo. The "pernet" variable
> > > > > > > is introduced from v6.1-rc1. Revert pre-patch and post-patch.
> > > > > > 
> > > > > > I do not understand, why are these reverts needed?
> > > > > > 
> > > > > > How does the code currently build if there is no variable here?
> > > > > > 
> > > > > > confused,
> > > > > > 
> > > > > > greg k-h
> > > > > Hi greg:
> > > > >     If only the first patch is merged, compilation will fail.
> > > > > There's no "pernet" variable in the struct hashinfo.
> > > > 
> > > > But both patches are merged together here.  Does the released kernel
> > > > versions fail to build somehow?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > Work well, as I know.
> > 
> > Ok, then why send these reverts?  Are they needed, or are they not
> > needed?  And if needed, why?
> > 
> > still confused,
> > 
> > greg k-h
> > 
> Hi greg:
>   If the patchset is merged together, and the compilation is normal. I'm
> just concerned that some people only put in one of the patchset and forget
> to put in both of them, which will be a problem.

That's not our responsibility at all.  There is a reason we do releases,
not just individual commits.  We test and release changes all at the
same time, and so, you should just take them all please.  Otherwise you
are on your own and usually end up with a broken system.

good luck!

greg k-h

