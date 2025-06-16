Return-Path: <stable+bounces-152741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26EADBD61
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 01:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7FF189061C
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091082264C4;
	Mon, 16 Jun 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ba1Vh+Nr"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265E223DD5;
	Mon, 16 Jun 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115416; cv=none; b=q9X5Jt6mZjsTBFBvmzcNyq7VGHyU+t5bBSdRlDB2pN0L/IwIzVc/HzUqNjdgFFO0rO83e+gg0Z+T1aKVLR3hdT54GUYcMa0ghb6tpbYQZLH7sL2LjYHjPOQLI7dYNKPgL9W12gP53ngLjZ8GIw6W4gxwkpfLRheUcbitse0leVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115416; c=relaxed/simple;
	bh=l/dsEKZik8069kBgbRAsR0tcPdM8xcTYaQmnuK2tb18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoc3gh/IxUWhOCpTpzxd72d7kaubKJLjkWmmIyAvP4jeVn0dJr36xj/q/P1z/dS5Bu+BYsbL2qJczHuOhy4axBcHZrxB871AWOTpyY0pq3lnJpO9iPKYC4XsXXKXtEWwecoB/Rx8blF2goDzFWWf/lNGUic/z7Zi/RHfrA537Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ba1Vh+Nr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 45E3014C2D3;
	Tue, 17 Jun 2025 01:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750114827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LSj4gXCyHisTwhB2BQnYcgpL/7V+l81OjPQ3XMozPiY=;
	b=ba1Vh+NrSIjd7dsdd0+OHQAo7kEOIiMCbiZJITasBMpb06v5GCKFJzfa1Q00oZ7ppDVJYG
	V+JsgYIurMccniqSrkVZn6QnSlVESpbxMFZPC8sfVKmKZ+D3eo+daYi/ML7Vs8MJu4t/cR
	1BtXctHoYjA4lz1+e8LJvfTLuJIMFlCmmGvQXCcVMABgSNMwml7IPYNukXzENuyJR/XK7w
	LIkPx8oP95IJ7trvfZ/myMEkKZumsIBRyJr+knK01jJeJ8WRyBrEAcGxgk9x92o3cIZwfM
	mlxTijTq0BCrtF6ANKmdm/PJN/2PMo81dXOiCXGii/KvVky1ARmGdwrB/hSKmw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ffc07ee8;
	Mon, 16 Jun 2025 23:00:23 +0000 (UTC)
Date: Tue, 17 Jun 2025 08:00:08 +0900
From: asmadeus@codewreck.org
To: Yuhao Jiang <danisjiang@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <aFCh-JXnifNXTgSt@codewreck.org>
References: <20250616132539.63434-1-danisjiang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616132539.63434-1-danisjiang@gmail.com>

Yuhao Jiang wrote on Mon, Jun 16, 2025 at 09:25:39PM +0800:
> A buffer overflow vulnerability exists in the USB 9pfs transport layer
> where inconsistent size validation between packet header parsing and
> actual data copying allows a malicious USB host to overflow heap buffers.
> 
> The issue occurs because:
> - usb9pfs_rx_header() validates only the declared size in packet header
> - usb9pfs_rx_complete() uses req->actual (actual received bytes) for memcpy
> 
> This allows an attacker to craft packets with small declared size (bypassing
> validation) but large actual payload (triggering overflow in memcpy).
> 
> Add validation in usb9pfs_rx_complete() to ensure req->actual does not
> exceed the buffer capacity before copying data.

Thanks for this check!

Did you reproduce this or was this static analysis found?
(to knowi if you tested wrt question below)

> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> ---
>  net/9p/trans_usbg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 6b694f117aef..047a2862fc84 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -242,6 +242,15 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
>  	if (!p9_rx_req)
>  		return;
>  
> +	/* Validate actual received size against buffer capacity */
> +	if (req->actual > p9_rx_req->rc.capacity) {
> +		dev_err(&cdev->gadget->dev,
> +			"received data size %u exceeds buffer capacity %zu\n",
> +			req->actual, p9_rx_req->rc.capacity);
> +		p9_req_put(usb9pfs->client, p9_rx_req);

I still haven't gotten around to setting up something to test this, and
even less the error case, but I'm not sure a single put is enough --
p9_client_cb does another put.
Conceptually I think it's better to mark the error and move on
e.g. (not even compile tested)
```
	int status = REQ_STATUS_RCVD;

	[...]

	if (req->actual > p9_rx_req->rc.capacity) {
		dev_err(...)
		req->actual = 0;
		status = REQ_STATUS_ERROR;
	}
	
	memcpy(..)

        p9_rx_req->rc.size = req->actual;

        p9_client_cb(usb9pfs->client, p9_rx_req, status);
        p9_req_put(usb9pfs->client, p9_rx_req);

	complete(&usb9pfs->received);
```
(I'm not sure overriding req->actual is allowed, might be safer to use
an intermediate variable like status instead)

What do you think?

Thanks,
-- 
Dominique Martinet | Asmadeus

