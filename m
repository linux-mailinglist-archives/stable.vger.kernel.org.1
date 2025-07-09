Return-Path: <stable+bounces-161435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1342AFE82E
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAEB1C805AA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765432D9EDC;
	Wed,  9 Jul 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc78Q/b2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3114E2D8388;
	Wed,  9 Jul 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061632; cv=none; b=Vh+EUsHqLpUQvJAbhKs7c5lQlxbdxSpRYzErWdbTer9q0ZG4uII0v/2AKOHfBO6sf3ZkppyfvSZDdPIPUkXdOnpY0oGLI8OM7dnsnqukJ5bnBgnfOrfdxSGfpnbjf0lDQqw6QBUtn5gx06Rwkf2sfgA72NMwmkQiialn8WJBkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061632; c=relaxed/simple;
	bh=INkH8n9wJ+PlunRIbvmZf5Vrr4beSD/Eb3R7GLF6RJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltOqKfZqktKPBwwVSpBd0Zvtx5pVOz9n+GumbIZMCLgvimusj5hOZ1wX4r5hpSAnw+8oUZr1dlVnwNuxw7DYdssJVyYO/ha9ERuJNr5rWULa0qGUqEfiV7PzkvNgXB0oUPsC5lmSVa3LtS1bp0el+d47cMC8A+0vhaX/m7c4BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc78Q/b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8BBC4CEEF;
	Wed,  9 Jul 2025 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061631;
	bh=INkH8n9wJ+PlunRIbvmZf5Vrr4beSD/Eb3R7GLF6RJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sc78Q/b27ahsVrYzsaePgVwmgumFh5J3Q/PCPuv5VQlYIf+rQU3L5197He79AuyRy
	 GldoXvcFyJmxruVsulkARBnj1ImhbT+SwUcQiDNmxVGxzp0XY4mbwP2NuJPe/o2WE/
	 nYIMB1AVUwFRYat3cPTDbRwflpPUceEQR9T+kEXDiVLk5Rm2awnT3oezat7z00mOQz
	 k7N9LzvTlY3dZELUfEKKgEXjNjLJAR6mb4dMukV3GGLR4AshMP5zlnMze8U4WgHcpy
	 spsAvLF/GWZ8mssOpumixyVN4toQA1RxPjRPftYKQzHQm0cZEkwszZc+U/AF50Q4NK
	 TuAAjbMvuDJPQ==
Date: Wed, 9 Jul 2025 12:47:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: libwx: remove duplicate
 page_pool_put_full_page()
Message-ID: <20250709114707.GX452973@horms.kernel.org>
References: <20250709064025.19436-1-jiawenwu@trustnetic.com>
 <20250709064025.19436-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709064025.19436-2-jiawenwu@trustnetic.com>

On Wed, Jul 09, 2025 at 02:40:23PM +0800, Jiawen Wu wrote:

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 55e252789db3..7e3d7fb61a52 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -174,10 +174,6 @@ static void wx_dma_sync_frag(struct wx_ring *rx_ring,
>  				      skb_frag_off(frag),
>  				      skb_frag_size(frag),
>  				      DMA_FROM_DEVICE);
> -
> -	/* If the page was released, just unmap it. */
> -	if (unlikely(WX_CB(skb)->page_released))
> -		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
>  }
>  
>  static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
> @@ -227,10 +223,6 @@ static void wx_put_rx_buffer(struct wx_ring *rx_ring,
>  			     struct sk_buff *skb,
>  			     int rx_buffer_pgcnt)
>  {
> -	if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
> -		/* the page has been released from the ring */
> -		WX_CB(skb)->page_released = true;
> -
>  	/* clear contents of rx_buffer */
>  	rx_buffer->page = NULL;
>  	rx_buffer->skb = NULL;
> @@ -2423,9 +2415,6 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
>  		if (rx_buffer->skb) {
>  			struct sk_buff *skb = rx_buffer->skb;
>  
> -			if (WX_CB(skb)->page_released)
> -				page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
> -
>  			dev_kfree_skb(skb);
>  		}
>  

I think the page_released member of wx_cb.
It seems to be unused now.

