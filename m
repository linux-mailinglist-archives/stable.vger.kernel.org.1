Return-Path: <stable+bounces-176543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86BB390E7
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 03:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D54167FEA
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19C1E32D6;
	Thu, 28 Aug 2025 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1VVtCDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BD4A00;
	Thu, 28 Aug 2025 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343787; cv=none; b=QQW/b5nHky16dTLUQ5Hf22wxwqJTOxiQCQ/ynOgMYWYbYev+rjGao/Ms+lARIGcp2O1Isl3t6K9MSW77AER4iiBKJxb6lyybczpx2YTB2Sq6k5yMYoP7JWuigpGlnWrb0MJDBZx7MMFfjJBcrjv6byN+FrrPGJpntI/QQ+cppbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343787; c=relaxed/simple;
	bh=1qvh7FuwAHEr4HKxFymbYY2odFZkstc1OtXh+ux1otw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KevPTw/4KBL1LmvRp3irEjfYwnQSonvPPpTwOEJ/ljjIjbTH/1Yo4NfFW/xG/4kE7o+CXAbMkApxod+xEm/W9fvge3VTmSg1wb3H924lVxPnnnxDXPGbt7jHLEA2f3Q7CIUMYljE0qqb5nn6yG5HBj/hrTocSMCxw0MxZS410L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1VVtCDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90BAC4CEEB;
	Thu, 28 Aug 2025 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756343787;
	bh=1qvh7FuwAHEr4HKxFymbYY2odFZkstc1OtXh+ux1otw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H1VVtCDq8VzVgnW8qc384lkGjTID6Tgrh52L8O+ejsVygga8IYPyd46WYoVbv5zme
	 GafxmernB0BMHDZJLzimPFNvmayADOV0lUuxCEgMtC4bS3QtPDkK0VTBIdr1iw3jM+
	 JtnX6bY7jceabW+uqjqCf2VIQvEu/Dq//r7f+W8H0DLNK5FIXYUQ6VxKV1ycLG+FiR
	 9ZBOPc08b0y1nq7Qxo9m0rTD1jUEbfMIx19iIqd5v4SEM3goC6iPSL2CzSUdfUOyy8
	 eiLyIYvwt6dUTiBL5g6c6oP3szad9kzVKxzNIit/KBQubRYHGZPWSmtDcu6yiXXovl
	 BxZNtaqodqynA==
Date: Wed, 27 Aug 2025 18:16:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.simek@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH net-next] net: xilinx: axienet: Add error handling for
 RX metadata pointer retrieval
Message-ID: <20250827181626.7d1dbc3f@kernel.org>
In-Reply-To: <20250826180549.2178147-1-abin.joseph@amd.com>
References: <20250826180549.2178147-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 23:35:49 +0530 Abin Joseph wrote:
> Subject: [PATCH net-next] net: xilinx: axienet: Add error handling for RX metadata pointer retrieval

Sounds like a fix, please repost as [PATCH net], against the
netdev/net tree.

> Add proper error checking for dmaengine_desc_get_metadata_ptr() which
> can return an error pointer and lead to potential crashes or undefined
> behaviour if the pointer retrieval fails.
> 
> Properly handle the error by unmapping DMA buffer, freeing the skb and
> returning early to prevent further processing with invalid data.
> 
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 0d8a05fe541a..1729fd21d83b 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1166,8 +1166,17 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	skb = skbuf_dma->skb;
>  	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
>  						       &meta_max_len);
> -	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
> -			 DMA_FROM_DEVICE);
> +
> +	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size, DMA_FROM_DEVICE);

80 char width is still strongly preferred, at least in networking.
So please don't unwrap this line for no apparent reason :\

> +	if (IS_ERR(app_metadata)) {
-- 
pw-bot: cr

