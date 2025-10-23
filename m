Return-Path: <stable+bounces-189048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B46BFED4E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76FB44F1B22
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96081FBEA6;
	Thu, 23 Oct 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwI4lMh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB21F239B;
	Thu, 23 Oct 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182548; cv=none; b=cN0XR15wKkq5MHLMnw0X0rIQRIngkmkkjxnSHTpPZ6NmBbqilEyrMdpk/xAqfWGdS1lRjViE21DX6pAQZZqGqpDmE6u0Lae1520HwNoO3x61cr1Gz/VSgdrIe4Y7mf1e1k2Ok5PTzOP003qxfhLmixzIuNNI9QbhYA7jtXamCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182548; c=relaxed/simple;
	bh=M/kOOtmuCLonxyhFvM6Jte5Rr17Ar3gXBIKaIvRR38w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4lmUMKwzuyUNUYu0kwAcdmDA/11LWUNp+TrE76ihUrHSPVA9pxJt1LOvljgKF0Pftz2MSgJNtjYWkNKiBkaEyiw3/5l9sED2jUaOQHxl1iZ0ksR5bjBAWyqnLYUcr0hUyysykdIZd3Sl1o4nA7Nnhx6LJ9jvx6Eg6TnQR7O2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwI4lMh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB19C4CEE7;
	Thu, 23 Oct 2025 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182548;
	bh=M/kOOtmuCLonxyhFvM6Jte5Rr17Ar3gXBIKaIvRR38w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VwI4lMh0tBD6FYDFmmepO9ymPEfNz7TD6GaA1jTJJoXOBR5lc4dIxFDEDFHvzGR6a
	 LtIIHI+22Juf/zPuy6YPMvQ3UTL9pxBh1XIVX0UmMyTBuWJKmnIoEV2i4uMdSAebuK
	 HigmeQyhcpwGzBiVkcArueYrUS9GmVXjEUA2QAQXUseADEZFwqCWwokxVk8IPntm8q
	 gBHQzB+rUiHcFt9rACfVYgUSVDSLoGal7kRVbDv1TKM7/kjjZ/q5BgHpMT2sydMRYW
	 wi2AhBiAxi2Fw0CDS6mFYtzZP8PlFEWp59+pnwrwKvDYTOiQY1ktcU3gmEtheORODE
	 pT/lbhzh6oidg==
Date: Wed, 22 Oct 2025 18:22:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bo Sun <bo@mboxify.com>
Cc: pabeni@redhat.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] octeontx2-af: CGX: fix bitmap leaks
Message-ID: <20251022182226.00967149@kernel.org>
In-Reply-To: <20251020143112.357819-2-bo@mboxify.com>
References: <20251020143112.357819-1-bo@mboxify.com>
	<20251020143112.357819-2-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 22:31:12 +0800 Bo Sun wrote:
> The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
> are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
> Unbinding and rebinding the driver therefore triggers kmemleak:
> 
>     unreferenced object (size 16):
>         backtrace:
>           rvu_alloc_bitmap
>           cgx_probe
> 
> Free both bitmaps during teardown.
> 
> Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bo Sun <bo@mboxify.com>

Looks like rvu_free_bitmap() exists. We should probably use it?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index ec0e11c77cbf..f56e6782c4de 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
>  		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>  		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
>  		kfree(lmac->mac_to_index_bmap.bmap);
> +		kfree(lmac->rx_fc_pfvf_bmap.bmap);
> +		kfree(lmac->tx_fc_pfvf_bmap.bmap);
>  		kfree(lmac->name);
>  		kfree(lmac);
>  	}
-- 
pw-bot: cr


