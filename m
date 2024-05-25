Return-Path: <stable+bounces-46125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E14F8CEE92
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 12:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E141F215A3
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DB2C1B9;
	Sat, 25 May 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cI4yI/WM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9B381C2;
	Sat, 25 May 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716633767; cv=none; b=mvyl7ooYSKZV2A1sc4vcVVH8hXw+A77nwM3p6EIR6Kt/ep5WH6yFgs/mSX1tvpUCOhN8XfViOY2jFqKY50dthok/kBcvgB2Z3TMuWF+cagKr6afEgq5XWz8y3in65L6f+4ZROq2wQbco/SCyBDwtZ7PVVXULlLrzWZCB+YaNcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716633767; c=relaxed/simple;
	bh=Y8zEXzQ5nmw3UNBUpfXBQWgtBX8Z0W5nrj5k5XBj9wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDpewtLLYTyVI3Tu98eAtY7W4qOceL32lOXEXF125kQxAv8toUiewB+vYE1ND095Fk5roU36VPu2u7ONC84jfNOaXIc4/8j+KtF85Tvi7AQ1MD6TTcyC7R6nB7GXiQJiplhj8dRYdsKfaXnV2JsROEBY1GsOsiWnwG6q+B0Rfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cI4yI/WM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A7AC2BD11;
	Sat, 25 May 2024 10:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716633766;
	bh=Y8zEXzQ5nmw3UNBUpfXBQWgtBX8Z0W5nrj5k5XBj9wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cI4yI/WMt0buznjd0rCgeyEAGHyYbTbAA/ZSrSxG6nqsZLUHAxXW/iSeFLiFhvWv8
	 SaqiN8ktzlSo/ceE61xFb9P6kfhZz++51r+CcROjdOhrxnLOTcLMG3hnbbf3wLIfJ5
	 RZhvTq68gbPSJzsSFHCxg8P4ATQrjSEpVk7D1BoE=
Date: Sat, 25 May 2024 12:42:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.15 0/2] Revert the patchset for fix
 CVE-2024-26865
Message-ID: <2024052526-reference-boney-1c67@gregkh>
References: <20240506030554.3168143-1-shaozhengchao@huawei.com>
 <2024052355-doze-implicate-236d@gregkh>
 <92bc4c96-9aaa-056c-e59a-4396d19a9f58@huawei.com>
 <2024052511-aflutter-outsider-4917@gregkh>
 <9940d719-ee96-341d-93e6-ffd04b6fddba@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9940d719-ee96-341d-93e6-ffd04b6fddba@huawei.com>

On Sat, May 25, 2024 at 06:21:08PM +0800, shaozhengchao wrote:
> 
> 
> On 2024/5/25 17:42, Greg KH wrote:
> > On Sat, May 25, 2024 at 05:33:00PM +0800, shaozhengchao wrote:
> > > 
> > > 
> > > On 2024/5/23 19:34, Greg KH wrote:
> > > > On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
> > > > > There's no "pernet" variable in the struct hashinfo. The "pernet" variable
> > > > > is introduced from v6.1-rc1. Revert pre-patch and post-patch.
> > > > 
> > > > I do not understand, why are these reverts needed?
> > > > 
> > > > How does the code currently build if there is no variable here?
> > > > 
> > > > confused,
> > > > 
> > > > greg k-h
> > > Hi greg:
> > >    If only the first patch is merged, compilation will fail.
> > > There's no "pernet" variable in the struct hashinfo.
> > 
> > But both patches are merged together here.  Does the released kernel
> > versions fail to build somehow?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Work well, as I know.

Ok, then why send these reverts?  Are they needed, or are they not
needed?  And if needed, why?

still confused,

greg k-h

