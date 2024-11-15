Return-Path: <stable+bounces-93565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22669CF178
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 17:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2831F23F44
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9271CEAD6;
	Fri, 15 Nov 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ql2urm/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906551E4A6
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688081; cv=none; b=Vh7w7GfmIu15Q1UTBxhvxKmF9QEAgiu3hn3zGeGp5ma0gqJwjYsAqMRCEDxeIV5wTuzjPG4vlNqDViajoMZHq/qrkVa/nCdoOePmpgj814D48iXZxbsOde9tkhN/jb6gB2osKB3/qK64oiq6joVlA4LbA6rFg5T1PSeCSGw+HNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688081; c=relaxed/simple;
	bh=PcuSRQQ074UZnU+y/DNuvUguEy9/xZJ5DC9JC1ARJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suiM/vt2DX4nFZYIYDdMzP2pvVvssoq2USspT6WLiVf0w0ZJvN+6ghvvoBOlkjtina3qIBeooMLim590m12LD0DzxXbpAbAfooEFxL9KvBmTGUIxwCZvmoKVNsM1kgtb6HFKxajM+PUtOBounl7vfL68VjpyshUAdmVpD8U/Elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ql2urm/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78004C4CECF;
	Fri, 15 Nov 2024 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731688081;
	bh=PcuSRQQ074UZnU+y/DNuvUguEy9/xZJ5DC9JC1ARJyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ql2urm/i31gyaLmJwDcnPqFTTIfFnsnBcunfAzPu/nzQ/cZCUnZkxx3lgHW9WPYQ1
	 DveLMq2tXyq1KaNjrESz8zoA8u60OusHJNzNYiR37BWZ54SUZHKsyYmWzEEZ9qlbBB
	 dYOD8+uMFmGOCHSt36v/NH0/5arep9m0SPJMHRrQ=
Date: Fri, 15 Nov 2024 17:27:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: mmc: core: add devm_mmc_alloc_host (5.10.y)
Message-ID: <2024111517-explain-monthly-6fbb@gregkh>
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

We used to detect them, something seems to have gone wrong...

