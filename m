Return-Path: <stable+bounces-23881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D48868D1C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A90B25AF8
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F2137C4D;
	Tue, 27 Feb 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+QMY6L0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6C137C39
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029043; cv=none; b=ssQCAf4RGoppng0qInlHHblMFTleyqdjyxQJ9Dh9u/+0CAqlQQ64qOfJKrEqzK+xX/asWs5tVm9gb2+hIqQAi+oCoo/y0uiCqVUMohXp+awZ04F/K1VCm+V/8VUIcvf+YFTVCMhi6P6Z/kRJy+fYDjkwSlvXlG+WyvhEHLEW2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029043; c=relaxed/simple;
	bh=q3erbvsmmb9t7jj3nRRHpcZ9XI9cZ5BveC6dDaYsw6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQgrTnU46EwYRtZ6S9cNUSOCW1dVp73Zz5ZEv4MLz9wVzpmKehkBgZLXUlOl2PsO2DLDHVMJgfk7ZTcxtxul6dKdIm6K/aQP/7x3amYXSGgqXrORoAjrzTupI7HRTxrhcu5d4qt8OwWS9+UzG6Y3BTRNcqA8Xrvpts8tGN2fTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+QMY6L0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C3DC43390;
	Tue, 27 Feb 2024 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709029043;
	bh=q3erbvsmmb9t7jj3nRRHpcZ9XI9cZ5BveC6dDaYsw6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+QMY6L0TsNOVVjgJgSceehSOsP6ZiP+kEaQ25V67gnpjbrFrZM/p4TDByS99U636
	 0fMDIQ+bSE1VgzepkAxaIWOFfRsIRgnIV8Sjxie9eo/YZKNd6NrP+oiw5Cp2pMjNT6
	 xQa3EZ/i4GZP6SnacyV8npBSoIyy7afRKDKIwk8A=
Date: Tue, 27 Feb 2024 11:17:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Message-ID: <2024022714-reaffirm-spendable-4cb3@gregkh>
References: <2024022622-agony-salvaging-5082@gregkh>
 <20240227022654.3442054-1-chengming.zhou@linux.dev>
 <2024022743-rented-trembling-7797@gregkh>
 <95333296-d656-4982-bec0-aee2d54ba254@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95333296-d656-4982-bec0-aee2d54ba254@linux.dev>

On Tue, Feb 27, 2024 at 05:04:19PM +0800, Chengming Zhou wrote:
> On 2024/2/27 16:54, Greg KH wrote:
> > On Tue, Feb 27, 2024 at 02:26:54AM +0000, chengming.zhou@linux.dev wrote:
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> We have to invalidate any duplicate entry even when !zswap_enabled since
> >> zswap can be disabled anytime.  If the folio store success before, then
> >> got dirtied again but zswap disabled, we won't invalidate the old
> >> duplicate entry in the zswap_store().  So later lru writeback may
> >> overwrite the new data in swapfile.
> >>
> >> Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
> >> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Nhat Pham <nphamcs@gmail.com>
> >> Cc: Yosry Ahmed <yosryahmed@google.com>
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> (cherry picked from commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1)
> > 
> > What tree is this for?
> 
> Ah, for linux-6.7.y. I forgot to use your command line to send patch...

Thanks, both now queued up.

greg k-h

