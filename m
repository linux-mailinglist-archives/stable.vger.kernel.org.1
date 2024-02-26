Return-Path: <stable+bounces-23705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2897867697
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635061F2A962
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3B128368;
	Mon, 26 Feb 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8KVLF6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C479128363
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954258; cv=none; b=T4HXqC3Z8D32HtHXKk3W6mq6vhAY9vFFtzfsWzKckhQipUWRiVgx2/Ybvr6VkllnFa5RsbZ8AN+9L0AjpBTrWSbvR8GP4WRMJXAsrHS0yY74wQpuA/obaay57gMx9d4qFNkVvdoyXcdyoJNFEBMgBV4toyYt/+9nSgwcbHRoOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954258; c=relaxed/simple;
	bh=jDfbE6gCqWwrkJPLg8gu2NVYbKL/GYabzPsGANsdhGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0K/zoiPwR6WWvDAa8G/8ZmvR4mMaBX6UFktnNH26bWv+6UsmduzYoTLLese+keAdipHkO4OKL6HdVRTXJWQhRRDCNo9jAt1pveQMjyfoQuSit6wHqM+yZ8bquaWRnofBQKLjswwdOySrGZCbLrVFSmqOQgF5ckdXdz7Ps2H7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8KVLF6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1399C433F1;
	Mon, 26 Feb 2024 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708954258;
	bh=jDfbE6gCqWwrkJPLg8gu2NVYbKL/GYabzPsGANsdhGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8KVLF6MXxSqwkV18HH5/Li4qW49zUODdKfWap96tYqZafPdZV1KjXRKT22BXdXhV
	 L25Xs6viGVHa2Jvo71B9nH7SKCUg4bCiEceLXOpkVLfdA+1OttY1ENQxY1mt5xM5jl
	 Lh1Q6Zu+kPEYujXnJn5nsjwUH1oPy32s89P1ihIo=
Date: Mon, 26 Feb 2024 14:30:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2 0/7] 5.4 backport of recent mds improvement patches
Message-ID: <2024022603-speculate-staple-4f54@gregkh>
References: <20240226122237.198921-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226122237.198921-1-nik.borisov@suse.com>

On Mon, Feb 26, 2024 at 02:22:30PM +0200, Nikolay Borisov wrote:
> Here's the recently merged mds improvement patches adapted to latest stable tree.
> I've only compile tested them, but since I have also done similar backports for
> older kernels I'm sure they should work.
> The main difference is in the definition of the CLEAR_CPU_BUFFERS macro since
> 5.4 doesn't contains the alternative relocation handling logic hence the verw
> instruction is moved out of the alternative definition and instead we have a jump which
> skips the verw instruction there. That way the relocation will be handled by the
> toolchain rather than the kernel.
> 
> Since I don't know if I will have time to work on the other branches this patchset
> can be used as basis for the rest of the stable kernels. The main difference would be
> which bit is used for CLEAR_CPU_BUFFERS. For kernel 6.6 the 2nd patch can be used verbatim
> from upstrem (unlike this modified version) since the alternative relocation
> did land in v6.5. However, even if used as-is from this patchset it's not a problem.

As mentioned on IRC, I can't take these now, without the newer branches
fixed first, otherwise someone could upgrade and have a regression.

So I'll hold off on these until we backports for all of the other stable
trees as well.

thanks,

greg k-h

