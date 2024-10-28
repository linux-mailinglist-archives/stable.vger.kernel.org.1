Return-Path: <stable+bounces-88275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0C9B24BF
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E001C2074B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39B18CBF1;
	Mon, 28 Oct 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="13y3FBF7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AA2629D;
	Mon, 28 Oct 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095033; cv=none; b=LQVjZrjMDM8fDA6ZU9AJc5GuWIaaC/EBDINtz7+/NSF9CMNQQ4jbz842RxomVTjEdjegN5ny8hzTsXoxSspXHJy/9T14di1Uw4hiZL7k5Hmvr023bNnb11lATpJ17UWFFz+8xVgG0enbS40/XURY1Q9GA5it82QdJTga6YIKkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095033; c=relaxed/simple;
	bh=iDU+3Lwy0SJCIlt0kJd1ek0NVKOX821di5e563+qVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ3IevaQNwrzkT2Bn7HttmCIaaFMs/AeH9hHjYOxlYUHJ3zvjPYU6LCnqwoW+hCRJEebR4UJXSt8o0J7N7nF6JSSCZTIfn+twTdJY/haA2NZ0Em5qwkntNajDEl918lT0R+2QoWU+z2UEeVP/bLa0WaH16Lk63z6FuSxh8Wmwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=13y3FBF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8523CC4CEC3;
	Mon, 28 Oct 2024 05:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730095032;
	bh=iDU+3Lwy0SJCIlt0kJd1ek0NVKOX821di5e563+qVa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=13y3FBF78s7OYxj3JqcruZmfFlWvEzsxGIEYyPrRyeO/8Fh9AzmGIZwgr9aOnAZI7
	 +yxLKnPEzJM59pEoCYY7rmFDnFUczsG1iBr8BOs9A2PVx6QjYzSnBZLIzBGhx8dcqf
	 ywZk2RQx6ffkhKStJVRlEORBgkcd6TDg/YegXhx4=
Date: Mon, 28 Oct 2024 06:57:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: Patch "xhci: dbgtty: use kfifo from tty_port struct" has been
 added to the 6.11-stable tree
Message-ID: <2024102839-eskimo-lunacy-550f@gregkh>
References: <20241022174538.2837492-1-sashal@kernel.org>
 <435a97c3-57da-4e18-a054-506433b0062a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435a97c3-57da-4e18-a054-506433b0062a@kernel.org>

On Wed, Oct 23, 2024 at 08:24:22AM +0200, Jiri Slaby wrote:
> On 22. 10. 24, 19:45, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      xhci: dbgtty: use kfifo from tty_port struct
> 
> This is a cleanup, not needed in stable.

Is needed as a prerequisite for a later patch in the series.

thanks,

greg k-h

