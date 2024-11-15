Return-Path: <stable+bounces-93079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EB9CD682
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00726281FA2
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795371632E4;
	Fri, 15 Nov 2024 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOl5+z/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4612F26
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647537; cv=none; b=Bo0t69SIdAGjMrPNH9bnVyOmVxIOCLtnyqY8LOzjlfXaybmk6+01JtfRuXvWyk7H5GOcQBWXyhVG2BnZc8vtrWe3+NIDdUJHaIE5c4le4l3AklEdwwmAEm1SHvNRNZeX+dmkb2mdBh0ZEeLdVoq77/0XbUfBPiMDaOWbYLfMqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647537; c=relaxed/simple;
	bh=Pyh6bxGuZ5BU/+B6al9gbNw5ar/BdJLgCZEA2mgQtkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5tYzRXG8wMPyMBcoMs5T+/+lWIyaoZPdLWhn55aEGqryIIsAlOyz9R/rVTHfFVTT571QAL9PiJEIgUE8Vu+OGjKSA/l/o8kPjPaRoQZ8aFJ8y+kHhTWswtYEJhAjqU20iVLrCJen4UcOnidZ2WkFJ25g8L/s18rmyEl5CB6uCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOl5+z/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55209C4CECF;
	Fri, 15 Nov 2024 05:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731647536;
	bh=Pyh6bxGuZ5BU/+B6al9gbNw5ar/BdJLgCZEA2mgQtkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOl5+z/MBoQFXqooINYva7arR2VvWQ2zNgvErypL3N5UY3wMGK+0teti0hF/j4R9z
	 UD4i1TdLpTH/nIZLKGTOahDStg5NzhmzPBkrm5oHImVv+u1ogcN4/vGTQFEbaGpBPb
	 7tXA4e0hFcWVzrWrA39XELG1DVnEtkwQRXo7rAHk=
Date: Fri, 15 Nov 2024 06:12:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hagar Hemdan <hagarhem@amazon.com>, stable@vger.kernel.org,
	Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH 6.1] io_uring: fix possible deadlock in
 io_register_iowq_max_workers()
Message-ID: <2024111508-june-badge-f5bc@gregkh>
References: <20241112083006.19917-1-hagarhem@amazon.com>
 <2024111200-glimpse-refill-3204@gregkh>
 <2f03db3f-b6cb-466f-8ab0-0ce73d31e46a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f03db3f-b6cb-466f-8ab0-0ce73d31e46a@kernel.dk>

On Tue, Nov 12, 2024 at 07:56:45AM -0700, Jens Axboe wrote:
> On 11/12/24 1:39 AM, Greg KH wrote:
> > On Tue, Nov 12, 2024 at 08:30:06AM +0000, Hagar Hemdan wrote:
> >> commit 73254a297c2dd094abec7c9efee32455ae875bdf upstream.
> >>
> >> The io_register_iowq_max_workers() function calls io_put_sq_data(),
> >> which acquires the sqd->lock without releasing the uring_lock.
> >> Similar to the commit 009ad9f0c6ee ("io_uring: drop ctx->uring_lock
> >> before acquiring sqd->lock"), this can lead to a potential deadlock
> >> situation.
> >>
> >> To resolve this issue, the uring_lock is released before calling
> >> io_put_sq_data(), and then it is re-acquired after the function call.
> >>
> >> This change ensures that the locks are acquired in the correct
> >> order, preventing the possibility of a deadlock.
> >>
> >> Suggested-by: Maximilian Heyne <mheyne@amazon.de>
> >> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> >> Link: https://lore.kernel.org/r/20240604130527.3597-1-hagarhem@amazon.com
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> [Hagar: Modified to apply on v6.1]
> >> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> >> ---
> >>  io_uring/io_uring.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> > 
> > What about 6.6.y?  We can't just take patches for older branches and not
> > newer ones, you know this :)
> 
> Hagar, thanks for doing the other ones too. Greg, they look fine to me.

Thanks, all now queued up.

greg k-h

