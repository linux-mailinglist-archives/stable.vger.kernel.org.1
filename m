Return-Path: <stable+bounces-6389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27680E268
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 04:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75603282424
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71683524E;
	Tue, 12 Dec 2023 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyA2Wa1t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEED4436;
	Tue, 12 Dec 2023 03:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE0EC433C8;
	Tue, 12 Dec 2023 03:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702350077;
	bh=A2w+VyEa7EufnRdgHvOJ8URmwSWfL2S7heSgfha9Q74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lyA2Wa1tdZBjqIthf5et8euY6lk8umO1H9/JobO1+OkayZhlX/dmPOy50Oko2pQTO
	 8JJMZWeY0VYnZ5aiRVfSlstBbxPj5JA/no2eREU61t3C/mIwgOnZ004xs8cTrH2f+4
	 noHwnfKh1QdVU9wP39uDPHmqjN6PFybl1Vkw+KAv9jxHg671cm+EbOntFj+kgyl4YW
	 sJ8D2kF8tcSGSrILwTbwzRRUgJB3AmsNxwWspIUCiLcS6GSiHW8G33ECNVhHvSP2qs
	 qsCI/mAmsa78fmGcWTw1wRN0kmp2ZQmIp1v0RWV80d7YvJq2v6UX67h2ljm4yXOdWd
	 u3PeWxtdRF+1g==
Date: Mon, 11 Dec 2023 19:01:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: duanqiangwen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, pabeni@redhat.com,
 yang.lee@linux.alibaba.com, shaozhengchao@huawei.com, error27@gmail.com,
 andrew@lunn.ch, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: libwx: fix memory leak on free page
Message-ID: <20231211190116.5415a79a@kernel.org>
In-Reply-To: <20231208080216.20176-1-duanqiangwen@net-swift.com>
References: <20231208080216.20176-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 16:02:16 +0800 duanqiangwen wrote:
> ifconfig ethx up, will set page->refcount larger than 1,
> and then ifconfig ethx down, calling __page_frag_cache_drain()
> to free pages, it is not compatible with page pool.
> So deleting codes which changing page->refcount.
> 
> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> 
> Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>

nit: no empty line between Fixes and Signed-off-by, please fix and
repost

> @@ -335,11 +269,12 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
>  		if (size <= WX_RXBUFFER_256) {
>  			memcpy(__skb_put(skb, size), page_addr,
>  			       ALIGN(size, sizeof(long)));
> -			rx_buffer->pagecnt_bias++;
> -
> +			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);

FWIW I'm 90% sure you can pass true as the last argument here.
The rule for "allow direct recycling" is basically - are you
in the same context the context which will allocate from this
page pool.
-- 
pw-bot: cr

