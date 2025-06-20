Return-Path: <stable+bounces-154871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A8AAE12AF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 06:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622EE1BC2FF4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C96E5336D;
	Fri, 20 Jun 2025 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcfZ9dg1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D381F0996;
	Fri, 20 Jun 2025 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395388; cv=none; b=WqYpEi3ONDw/74GKPpOHLaLulnJEO02VR4rY0+ICLUQfwzBYRnyLCcDa9G+xCxKsV3RenPckLfKsxRNhtmBsZsZtz5wyNFf/CeeryRlNkSw4Q1bOXumiXZOgrK9OCHBet/1XFnu4mkWmLr27I9ZL9amcgz1n01/5WpDP6KXgxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395388; c=relaxed/simple;
	bh=45n5wMn3ILNwxkmHzBPfoOF18K2bjR0KD6crYqs+TJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEEDasZFTZqVQ0ZNRA4EGGIv/7UuZp87gGl3e4AfsNcR/bUTLnGPzAgRu1FFIn7QjM3i/MotXg2Nh2LbiIgCwx50EpDFgDhaIILLkicUEWCQMFp6043PRlr54IHh8Vv4lCt9TbWpBHkvH1u+2CaeUeSnPmYfIIMt7L6RBpK4R40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcfZ9dg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A747C4CEED;
	Fri, 20 Jun 2025 04:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750395387;
	bh=45n5wMn3ILNwxkmHzBPfoOF18K2bjR0KD6crYqs+TJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcfZ9dg12mRE2aQzD7q3o9Tx6WYj0bbmkDoig9sJgsQ/O6GshmAqdYDXUgkXvuLAE
	 FVikDMoa1h1iPGu0IMrAWKdUyYHiLz/6ZyKrXa5mPo8yZY6p3teqS4HQ5fYuAcFSor
	 AOy8qMVRoYuP+cXMV3Ru3fVTh89+/ts/2QOaGHgY=
Date: Fri, 20 Jun 2025 06:56:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: asmadeus@codewreck.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	security@kernel.org, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <2025062007-ravishing-overcrowd-7342@gregkh>
References: <20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org>

On Fri, Jun 20, 2025 at 06:22:03AM +0900, Dominique Martinet via B4 Relay wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> A buffer overflow vulnerability exists in the USB 9pfs transport layer
> where inconsistent size validation between packet header parsing and
> actual data copying allows a malicious USB host to overflow heap buffers.
> 
> The issue occurs because:
> - usb9pfs_rx_header() validates only the declared size in packet header
> - usb9pfs_rx_complete() uses req->actual (actual received bytes) for
> memcpy
> 
> This allows an attacker to craft packets with small declared size
> (bypassing validation) but large actual payload (triggering overflow
> in memcpy).
> 
> Add validation in usb9pfs_rx_complete() to ensure req->actual does not
> exceed the buffer capacity before copying data.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Closes: https://lkml.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> Not actually tested, I'll try to find time to figure out how to run with
> qemu for real this time...
> 
> Changes in v2:
> - run through p9_client_cb() on error
> - Link to v1: https://lore.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
> ---
>  net/9p/trans_usbg.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 6b694f117aef296a66419fed5252305e7a1d0936..43078e0d4ca3f4063660f659d28452c81bef10b4 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -231,6 +231,8 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
>  	struct f_usb9pfs *usb9pfs = ep->driver_data;
>  	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
>  	struct p9_req_t *p9_rx_req;
> +	unsigned int req_size = req->actual;
> +	int status = REQ_STATUS_RCVD;
>  
>  	if (req->status) {
>  		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> @@ -242,11 +244,19 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
>  	if (!p9_rx_req)
>  		return;
>  
> -	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
> +	if (req_size > p9_rx_req->rc.capacity) {
> +		dev_err(&cdev->gadget->dev,
> +			"%s received data size %u exceeds buffer capacity %zu\n",
> +			ep->name, req_size, p9_rx_req->rc.capacity);

Do you want a broken device to be able to flood the kernel log?  You
might want to change this to dev_dbg() instead.



> +		req_size = 0;
> +		status = REQ_STATUS_ERROR;
> +	}
>  
> -	p9_rx_req->rc.size = req->actual;
> +	memcpy(p9_rx_req->rc.sdata, req->buf, req_size);
>  
> -	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
> +	p9_rx_req->rc.size = req_sizel;

Did this code build properly?

thanks,

greg k-h

