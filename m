Return-Path: <stable+bounces-89241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334AC9B5270
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A841F235E5
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B91206E92;
	Tue, 29 Oct 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGsqxFfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD961FBF50;
	Tue, 29 Oct 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229030; cv=none; b=qE9uHnHQjuk5charl+JRw0zYVXkfWmxbwA5bvOBaWNMrFn3PrvWsZie0dSZynh6Ny7qmAK2hpHCyHziqDI+1UIAicT/s2yHjrau7N4LZlLb/o0/oUD3tcmdlJHjl1+w0gFD+GHr4DyinEAPyLFsFnH+mzZ7P02Gw1TzMA71NDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229030; c=relaxed/simple;
	bh=HFiLuGlngAfz+xf8i/WvPUJKfDvtzPbIjebkk6c4+Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD/qVI0FQN9PaXKULVbVV2+89tqj1xTZG9VrbWlkIC/Q8uPuTdveG16pgoS/pcXDqD7YQE8DQsFEGTRnP229TN7yrg1sgzteYLi5oXZk5MX+F2OB/598Emdtb3R1RrfUceYprDB+O7zvFfnmaDgfFk+4EtXAOZeBfZg4YGSrIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGsqxFfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA14C4CECD;
	Tue, 29 Oct 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229030;
	bh=HFiLuGlngAfz+xf8i/WvPUJKfDvtzPbIjebkk6c4+Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gGsqxFfwL1x5C8hV42EFGSrG9tP9C4I0MnqdKQhhPe5RE1ZK25Y+voaXvECNt3Orf
	 aKx/EBosNl6MBzcg3kMCbQM0IdxKEZmL2I/PdH68D+ICAPWuoGpw2ns06v/Rmdf/rR
	 O0Q5UBu2KwZLvDNIGF/okDZsZlwMz7FnQC8+dASVOeQL7WzKKQ11ATerUxYh1VTdC/
	 vecdWVTHukOX50AMJtLpmDOPAPz6Fp+dqIy/Arv044NGvNsvqDl1vyP4EBuaEyx2aW
	 OIJ05gT3u33J7mu8DoVbwYozhZkTm16l4xOhQ1oofv81OLaD2CrlBEEaymLlLokLu0
	 9PG1ueZgrETSg==
Date: Tue, 29 Oct 2024 12:10:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: vertexcom: mse102x: Fix possible double free
 of TX skb
Message-ID: <20241029121028.127f89b3@kernel.org>
In-Reply-To: <20241022155242.33729-1-wahrenst@gmx.net>
References: <20241022155242.33729-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 17:52:42 +0200 Stefan Wahren wrote:
> -static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff *txp,
> +static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff **txp,
>  				unsigned int pad)
>  {
>  	struct mse102x_net_spi *mses = to_mse102x_spi(mse);
> @@ -226,29 +226,29 @@ static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff *txp,
>  	int ret;
> 
>  	netif_dbg(mse, tx_queued, mse->ndev, "%s: skb %p, %d@%p\n",
> -		  __func__, txp, txp->len, txp->data);
> +		  __func__, *txp, (*txp)->len, (*txp)->data);
> 
> -	if ((skb_headroom(txp) < DET_SOF_LEN) ||
> -	    (skb_tailroom(txp) < DET_DFT_LEN + pad)) {
> -		tskb = skb_copy_expand(txp, DET_SOF_LEN, DET_DFT_LEN + pad,
> +	if ((skb_headroom(*txp) < DET_SOF_LEN) ||
> +	    (skb_tailroom(*txp) < DET_DFT_LEN + pad)) {
> +		tskb = skb_copy_expand(*txp, DET_SOF_LEN, DET_DFT_LEN + pad,
>  				       GFP_KERNEL);
>  		if (!tskb)
>  			return -ENOMEM;
> 
> -		dev_kfree_skb(txp);
> -		txp = tskb;
> +		dev_kfree_skb(*txp);
> +		*txp = tskb;
>  	}
> 
> -	mse102x_push_header(txp);
> +	mse102x_push_header(*txp);
> 
>  	if (pad)
> -		skb_put_zero(txp, pad);
> +		skb_put_zero(*txp, pad);
> 
> -	mse102x_put_footer(txp);
> +	mse102x_put_footer(*txp);
> 
> -	xfer->tx_buf = txp->data;
> +	xfer->tx_buf = (*txp)->data;
>  	xfer->rx_buf = NULL;
> -	xfer->len = txp->len;
> +	xfer->len = (*txp)->len;
> 
>  	ret = spi_sync(mses->spidev, msg);
>  	if (ret < 0) {
> @@ -368,7 +368,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
>  	mse->ndev->stats.rx_bytes += rxlen;

Isn't it easier to change this function to free the copy rather than
the original? That way the original will remain valid for the callers.

