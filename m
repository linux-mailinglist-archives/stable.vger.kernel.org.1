Return-Path: <stable+bounces-45578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6758CC3E2
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE91B1C22D4D
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832A24B2A;
	Wed, 22 May 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFoHTvvF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3884F883;
	Wed, 22 May 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390730; cv=none; b=lx4g6J0eAZCreYOtmxFzakvr+y3g6w7eetqOfXQoFqqMFFlWNhDHPc6P1sP1ktRSaMQHbv7ut2gRazJ5VT98iPLKw+AtMIcZpSWpWMxqtmTBByTKBp89HANaBBU6aFNttQ7JSl97Oco0MyjuFf4H3F4H9XaQEl8r0hhcyVZ7FLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390730; c=relaxed/simple;
	bh=YFJnJyDwtPC7OdnMBtp3lNZatMd5ed+t5HUSZsapbic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrHBPe+t0LIoaoPD0bpcQ2sWqckrIHgCCaRfgSPJWWMNvx2tC4baAlNrqWbqfiq1WGYX6/GWwc+bn3JIs3ndzqWXaH20Ps0jCiixlovK4GI+5qd1P5hxCuklHvvPQo3VfCkEqTCMVLThnA8ieobe69K9eWKQdQJdCAF7uX90UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFoHTvvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB987C2BBFC;
	Wed, 22 May 2024 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716390730;
	bh=YFJnJyDwtPC7OdnMBtp3lNZatMd5ed+t5HUSZsapbic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFoHTvvFv+aM22hunXSt154tj7Ue7KKqYb7zdX1lEOPo/0nMo6M+9U5g7eTj+vMHu
	 DQB/yju4wrNHAwl4HP5jEIS6RfiZFH3axpJAyY1JPEsf7XXCEXwhKayZs07kmqFE9I
	 He1ylWf1VTPC1jCqpY+yNTAe2NkSoAhwUJhmuhO4=
Date: Wed, 22 May 2024 17:12:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Grandperrin <paul.grandperrin@gmail.com>
Cc: rankincj@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [BUG] Linux 6.8.10 NPE
Message-ID: <2024052249-cryptic-anthem-5bd2@gregkh>
References: <A8DQDS.ZXN0FMYZ3DIM1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8DQDS.ZXN0FMYZ3DIM1@gmail.com>

On Sun, May 19, 2024 at 01:28:58PM +0200, Paul Grandperrin wrote:
> > I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
> dmesg log. I have no idea what triggered it, and especially since I
> have not even mounted any NFS filesystems?!
> 
> Hi all,
> I have the exact same bug. I'm using the NixOS kernel but as soon as it was
> updated to 6.8.10 my server has gone in a crash-reboot-loop.
> 
> The server is hosting an NFS deamon and it crashes about 10 seconds after
> the tty login prompt is displayed.
> 
> Dowgrading to 6.8.9 fixes the issue.

Any chance you all can use 'git bisect' to track down the offending
commit?

thanks,

greg k-h

