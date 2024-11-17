Return-Path: <stable+bounces-93736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACFC9D0614
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301202824A1
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA61DBB32;
	Sun, 17 Nov 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WYiI1RpD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9A84A3E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877974; cv=none; b=Yuutodx6NS32pHLxP4Vjy6hgPrB9tZgFBNmCu1b4f0wNpQAHiJQE5y0rpZbhV2ktw8Ln2m1OSiau6oPnVWx4Yqy4qRp6zexjkJcyHjGzNKjgMUesNodLPaCdcufP1QF0t/iySzIpcDXRHRUn/bBLTnWD6XtejNJW4pcMvvLkq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877974; c=relaxed/simple;
	bh=C+cZF2RxNAu60g36P/APkOT9U5pm7QjuaYsdM1F3FP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYhfxdRgg9OTqM+Qqq1ZxxztxLagg9ucDb4kFsmPxF5/NKwFKdJ4msXUrRt9L2LNaB/jPy8jzhqg/a8HXdr3i8H/6W0VT6xgsb/8mOd3zx2QYC6zxfIvVcpUrSdJvaFGJnHy69kqcYJTqw2uObImfhkQ3Q+JbQmi+qp/TcVSHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WYiI1RpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9169DC4CECD;
	Sun, 17 Nov 2024 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731877974;
	bh=C+cZF2RxNAu60g36P/APkOT9U5pm7QjuaYsdM1F3FP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYiI1RpDuwrNGlmYJZr8aXDkziCvwmFcL7eYUEvZ8p/lXNy9Cb/Lh+6dV7llFEjj5
	 IpEW+VvDiR7m08X9OWuV00HwAjq0g2H7EJzm7ji5A1nRd/wgfo4vl3uXUiMb/f0EvW
	 lidVZsLJFQId+qbF+/sS6ETjX39X3LHvu7g2akvk=
Date: Sun, 17 Nov 2024 22:12:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: mmc: core: add devm_mmc_alloc_host (5.10.y)
Message-ID: <2024111711-decrease-unwrapped-04c9@gregkh>
References: <b5016bde-5d0a-428d-9136-cbbc15f2d70f@stanley.mountain>
 <1729ae61-ca8a-4230-9ec2-493041761f91@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729ae61-ca8a-4230-9ec2-493041761f91@oracle.com>

On Fri, Nov 15, 2024 at 09:35:28PM +0530, Harshit Mogalapalli wrote:
> Hi Sasha,
> 
> On 15/11/24 19:59, Dan Carpenter wrote:
> > Hi Sasha,
> > 
> > The 5.10.y kernel backported commit 80df83c2c57e ("mmc: core:
> > add devm_mmc_alloc_host") but not the fix for it.
> > 
> > 71d04535e853 ("mmc: core: fix return value check in devm_mmc_alloc_host()")
> > 
> > The 6.6.y kernel was released with both commits so it's not affected and none
> > of the other stable trees include the buggy commit so they're not affected
> > either.  Only 5.10.y needs to be fixed.
> > 
> 
> How come we have a commit in 5.10.y and 6.6.y and not in 6.1.y and 5.15.y --
> May be we should detect those.

This was added because it was a dependancy, that's how things got out of
sync...

