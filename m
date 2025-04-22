Return-Path: <stable+bounces-135036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF4A95E6F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF283ABAC3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54226199E8D;
	Tue, 22 Apr 2025 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scLCtOwE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DD22B8BF
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303920; cv=none; b=Brah2Mp9/HcJoBvoDsjU9R2vPccJZy/XBY83xnIQrGZmSiUKN/uwxqHBBbz7YTU9km1FZzzCiNZqVxgU9AaoKxT9Izyv+LMdW4mKvCi1zPb2PdC1RrTN/tU+BlyTzASSjltWO2hs8xbC4EdM0SXo5EPQbBiMDuAdyJRjoZdWsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303920; c=relaxed/simple;
	bh=HbrnzTeJMZmm3jewc/DX0NbXr1rlX5TeRtQFbqRqRQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6Y2LP8crXaAF3o1pPVnpX7Rwk/9XO0yse1lMr132KhoqqPcuzgHPiOOnwW/Sf3OWiTW6/+tOnPtc1qdYMb6jG/+5YRQk1/IcBO1LNqCAtZRdkBjAHDeyiDpkPqrDuds8YE/+escAV1LsFedNsLVd3dAocS34NSBdNdaYSmI+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scLCtOwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264EBC4CEE9;
	Tue, 22 Apr 2025 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303919;
	bh=HbrnzTeJMZmm3jewc/DX0NbXr1rlX5TeRtQFbqRqRQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scLCtOwE00ZBzG2daIIgNuRJan0xfiksE8G50GgOOGrM/n2XqHr3oKsWIjXMR9aAl
	 iBas2shU+5MrBNZOFfkoSZxPiLJz8gmUioIieM+GXAgygzHvYgjBicXkkCPc/2Eo2D
	 WGBDQ/21LXxH4NfJXw/jBJy/wSt93sU7ZU7x2CKc=
Date: Tue, 22 Apr 2025 08:38:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: fix accept multishot
 handling" failed to apply to 6.6-stable tree
Message-ID: <2025042230-doornail-unmoving-7f6a@gregkh>
References: <2025041711-juniper-slapstick-265c@gregkh>
 <43f57b54-7f43-4a1a-ab3d-15bfeefceebb@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f57b54-7f43-4a1a-ab3d-15bfeefceebb@kernel.dk>

On Thu, Apr 17, 2025 at 12:40:15PM -0600, Jens Axboe wrote:
> On 4/17/25 4:46 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> This one applies to both 6.1-stable and 6.6-stable, can you queue
> it up for both? Thanks!

Now applied, thanks.

greg k-h

