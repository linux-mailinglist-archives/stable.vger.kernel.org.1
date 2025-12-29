Return-Path: <stable+bounces-203648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A53CE736B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74102300A344
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BAF2C1589;
	Mon, 29 Dec 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ffGYVsL/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42729265CA4
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022229; cv=none; b=Gomb4ihlNGatWBHPSfUsjC1PW80cD/YzFXYSAmtafedbf42ebNaSiDdz7ilPDX9gCmJrPkNTgxLzn2sutVb8zUBCZhE2Acuzcyjsdu6vP/oSz3SmHS31OghhfJBrM82neB2wT4c54qkASYc56BvYDi3vMNV6WR6xU+qaJ5H5Clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022229; c=relaxed/simple;
	bh=Yajy6GRVlgvNn6kFaVrQYJ05LBOU4RGb7zLSQjq/fiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exVkysAOp8vzfxh6zBAco5jHh8D+g4uOvxp9u1LOsnxzEZ8feFqK2mZa3pCiIVfjicq/euPaRgMxJ1+KYuHQeXjXQ0fHKYW0c3/a+EXPN8O2K17utzmBytO2OvFqhBSEQM6gOLDZU3nIlLaAJfI+yVf9l3ENG/cA9YBE3ZEarSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ffGYVsL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6809EC4CEF7;
	Mon, 29 Dec 2025 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767022228;
	bh=Yajy6GRVlgvNn6kFaVrQYJ05LBOU4RGb7zLSQjq/fiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffGYVsL/yOAEcte7SI6tg9kOD/S6qiPfj6zoOi3OfjwW2iWmrk27m6cDthBxFgWgC
	 leyhNFwWHgvK6OTyoUmvYY52t9+Qg78BHg12s2iiIq1hvIPwOTfFIeQvcpeJPdlWU8
	 fIAGMdZorjosl0T4n2PqL+egu8yXkHMmSvs00H+Y=
Date: Mon, 29 Dec 2025 16:30:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: tip@tenbrinkmeijs.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: fix min_wait wakeups for
 SQPOLL" failed to apply to 6.12-stable tree
Message-ID: <2025122920-dwindling-feminize-ba8a@gregkh>
References: <2025122915-sensually-wasting-f5f8@gregkh>
 <91bb9ee4-0ea5-4e15-a2fd-8a4634c4ed34@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bb9ee4-0ea5-4e15-a2fd-8a4634c4ed34@kernel.dk>

On Mon, Dec 29, 2025 at 08:10:42AM -0700, Jens Axboe wrote:
> On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.12-stable.

Applied, thanks.

greg k-h

