Return-Path: <stable+bounces-92216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD629C5134
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C094B24F99
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146520DD6B;
	Tue, 12 Nov 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8rKWcj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD420DD49
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400765; cv=none; b=Fdl4/IPhi4jU5FwV4ShENfbdNgc//nwZZwEiMYICL5PqifN3t/85EyNApIOCZK5iRm8E5zH1YJncvBH1LzZ/2M9qA3Vcg7yuEE7yQN527DeznAOric3rI636jHASoADYbPEojoQfbxN396PN+zCt+igJGolfyo6Q7PuXnk2iBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400765; c=relaxed/simple;
	bh=CKlyLnDd1rTNSj5rM4FRn2vc13t369MrtZ+mBDYw83k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0dzPjxEPwYVFpYto3koRg9xokaKeS779O1gzCsQrmo6X/82lEP71lhyWu2qqGkBxnaBVpOFmOdqahF1lQ/ya4AmKl0NxpTEdYbHAVWuHtZb01tlrOBXujQV77BC1H2MdP0T6CeoLF2dOpWJ+/BHYPjLIRiaB8WUKzbxGSnQSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8rKWcj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E75CC4CED4;
	Tue, 12 Nov 2024 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731400764;
	bh=CKlyLnDd1rTNSj5rM4FRn2vc13t369MrtZ+mBDYw83k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z8rKWcj/2zX2IHuzPgOsK5IFQg3CwWoBB+K3bOBDjmOCxb3NEskmpMqvR1XBdaVzO
	 RWu+S1QYDbyzDRZlPP8bdP1xVj/5O/mwilgeDGwMuGLLgY4i8g6WyVLqR3MRHlSNfu
	 4kA4RfTZSoIPAXMkwBDDTxH5VmxyNHutHAbJfsvk=
Date: Tue, 12 Nov 2024 09:39:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, Maximilian Heyne <mheyne@amazon.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.1] io_uring: fix possible deadlock in
 io_register_iowq_max_workers()
Message-ID: <2024111200-glimpse-refill-3204@gregkh>
References: <20241112083006.19917-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112083006.19917-1-hagarhem@amazon.com>

On Tue, Nov 12, 2024 at 08:30:06AM +0000, Hagar Hemdan wrote:
> commit 73254a297c2dd094abec7c9efee32455ae875bdf upstream.
> 
> The io_register_iowq_max_workers() function calls io_put_sq_data(),
> which acquires the sqd->lock without releasing the uring_lock.
> Similar to the commit 009ad9f0c6ee ("io_uring: drop ctx->uring_lock
> before acquiring sqd->lock"), this can lead to a potential deadlock
> situation.
> 
> To resolve this issue, the uring_lock is released before calling
> io_put_sq_data(), and then it is re-acquired after the function call.
> 
> This change ensures that the locks are acquired in the correct
> order, preventing the possibility of a deadlock.
> 
> Suggested-by: Maximilian Heyne <mheyne@amazon.de>
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> Link: https://lore.kernel.org/r/20240604130527.3597-1-hagarhem@amazon.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [Hagar: Modified to apply on v6.1]
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> ---
>  io_uring/io_uring.c | 5 +++++
>  1 file changed, 5 insertions(+)

What about 6.6.y?  We can't just take patches for older branches and not
newer ones, you know this :)

thanks,

greg k-h

