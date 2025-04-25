Return-Path: <stable+bounces-136673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B253A9C0DD
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B48B3A3354
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A21B6D11;
	Fri, 25 Apr 2025 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbcYDF7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D117A2EE
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569462; cv=none; b=Fbg/oitzQCYDQUUKsf0FGgYf2PDxdXIDJ8gI4LRJ2PXqyZ8xxRmj94/NPDtUlS0UQ6bas5mspLNdaMpC3orP12tz0djmAmFGifLLgtNzA9+gkpHQHidGZDjDb+DdxR5ZqelBQjfLBLcdRZAmeq5BIuxRgtz3sO8lXvFuN6/kYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569462; c=relaxed/simple;
	bh=tM27B+Xrczr8abINeS292PeAmez9y1vh8GpGXdU6MGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLXCHQkD9BJ8cpVrGBcWGWPtQ5f2geXlQxfReavHr0I3oKjWYz3M8ZL8+xb2RoFAn9SrJo7kB3nYTuAaJlwTwRy/1S7o3BynmUR0jyXo+39/tEoUFrJCja03xnvpZ7k5+ZvJDuLw4UoQRC5cLl/SHAZP533U2gGJV43IngfEj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbcYDF7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A3C4CEE4;
	Fri, 25 Apr 2025 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745569461;
	bh=tM27B+Xrczr8abINeS292PeAmez9y1vh8GpGXdU6MGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbcYDF7IjO7gFqbiyb6XEdENMvYtfk+vrYA90EvZmupvNevoA5cw5tn5wBswKhvm5
	 FNAWdrGRPlfNzE03FuatVkohHYzGitBn8FZ3UiTsE+IEihnLCdFDQUftAKKwyA7Va2
	 5j6AzjeIfpXtZ0FllVv/vKGhfzi6nCjcM/RZCmao=
Date: Fri, 25 Apr 2025 10:24:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling
 reserved channels
Message-ID: <2025042542-cusp-sesame-000b@gregkh>
References: <2025042315-tamer-gaffe-8de0@gregkh>
 <20250424060854.50783-1-hgohil@mvista.com>
 <2025042527-livestock-client-3c04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042527-livestock-client-3c04@gregkh>

On Fri, Apr 25, 2025 at 10:10:58AM +0200, Greg KH wrote:
> On Thu, Apr 24, 2025 at 06:08:54AM +0000, Hardik Gohil wrote:
> > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Like paRAM slots, channels could be used by other cores and in this case
> > we need to make sure that the driver do not alter these channels.
> > 
> > Handle the generic dma-channel-mask property to mark channels in a bitmap
> > which can not be used by Linux and convert the legacy rsv_chans if it is
> > provided by platform_data.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Link: https://lore.kernel.org/r/20191025073056.25450-4-peter.ujfalusi@ti.com
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Hardik Gohil <hgohil@mvista.com>
> > ---
> > The patch [dmaengine: ti: edma: Add some null pointer checks to the edma_probe] fix for CVE-2024-26771                                   needs to be backported to v5.4.y kernel.
> 
> No upstream git commit id?
> 
> Please fix and resend the whole series as a new versioned set of
> patches.

Actually, given all of the recent problems here, I recommend taking some
time off, and work with some more experienced kernel developers in your
company first, to get the experience needed in order to properly submit
kernel changes.  I'd like to see at least one other mvista.com
developer, who has such experience, sign off on your backports as well
to get someone else to catch basic problems like this before the
community is forced to do so.

thanks,

greg k-h

