Return-Path: <stable+bounces-71680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF0966F9D
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 08:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73085282548
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 06:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F613CFBB;
	Sat, 31 Aug 2024 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wBD2WDV0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6A210F8;
	Sat, 31 Aug 2024 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084197; cv=none; b=d+1Yh5+IpCtvFpCTYae9ENJrEm+AU8SBd3dERDZlEl0bqIl3cjqt5k5Ssjd572PyDhhGNT1b0iCoWASxK7wmYbfALXA+MkxcpwZDncpGhLa26yVRAMGNeszhfcfTQOr5nHrnhpUfhiUyQ8OKw1x+2jqgwh+uPUY260RBsJnb0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084197; c=relaxed/simple;
	bh=kDo/G94J9Yh4Kw8WUcjWlA0x8cn5cAlKy6uva5OX2YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTAli2awfzPi6+zcRVJcv/c14V7xVVdUTtPEeKqrEnU2FTthS+h1L7NwK4j/7phfmwNmH1luUdZYjeZWTShwOkHVgna2X8AgIMLCgwktJ8UCHeyPL2IR/wPNpUwMO5TFvx4bAHZQiDtLSieocKsWFuk0haZufraXK1/p1elgi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wBD2WDV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04D9C4CEC0;
	Sat, 31 Aug 2024 06:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725084197;
	bh=kDo/G94J9Yh4Kw8WUcjWlA0x8cn5cAlKy6uva5OX2YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wBD2WDV0r9NajFYcYjEVxlBslLjnaCbrfRSEHWVBPlm761KI13hgUJ8KrYfVsjate
	 zf60SxQZb++c9197BnTvgilJJ7FPRKL3eCe6AHfbWA0fWlGu35h5Z9NziNBZ4tYzMU
	 lQN0Udb5Nwl8hat2qm3DMvC7lq9hg3rnlOxJnDb4=
Date: Sat, 31 Aug 2024 08:03:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, dhowells@redhat.com,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: Patch "cifs: Fix FALLOC_FL_PUNCH_HOLE support" has been added to
 the 6.1-stable tree
Message-ID: <2024083157-anew-runner-d73d@gregkh>
References: <20240830184305.449630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830184305.449630-1-sashal@kernel.org>

On Fri, Aug 30, 2024 at 02:43:05PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     cifs: Fix FALLOC_FL_PUNCH_HOLE support
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      cifs-fix-falloc_fl_punch_hole-support.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This breaks the build on 6.1.y so I'll go drop it from there, sorry.

greg k-h

