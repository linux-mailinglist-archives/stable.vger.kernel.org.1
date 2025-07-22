Return-Path: <stable+bounces-163653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E7B0D14C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 07:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7063B59B4
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 05:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAC28A71D;
	Tue, 22 Jul 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/5rocj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7D289344
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162642; cv=none; b=hILCoF0+DUAL2JIJvjiSozXuW942AIwS4xXKykTLpjt9YLe5tvSz5P8VKFkjz0vTDl16Oz45j6RUsQHsaX1cIdt2wqgXjRn08tR4Mi3jmhdCMQg1ar1F8WoJhYHWSZ3lvRxlIvaHTkxzzOc+3AttICevUGwL9Iv5t6e0/q2O6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162642; c=relaxed/simple;
	bh=6OeUV6vhqJLsvC9pIE7RSWmAz7grhudUT+xqTJEByQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMElnq6LURrLDIPxfgSCDLuzzqzosAZbvvvIzMHo0i5vF/YzVIwF8/d1qOyLvQgq7h7JRXpBrvBeKbGIH3lUdGtuOSmqw5QccYDNd+2/ESXWS8A7nRQGl9M4Vs5bFQrFZN4TXw6Ps+NK+ZBk2QL76C2DhcsNfuGNeMTcjUhb2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/5rocj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49096C4CEEB;
	Tue, 22 Jul 2025 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753162641;
	bh=6OeUV6vhqJLsvC9pIE7RSWmAz7grhudUT+xqTJEByQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/5rocj6H6ng7UzhhAu0z++OLlOb5VYPZFDcdGCqL0u+l9VlHPYU2BrXFtkaTW1bv
	 y3oek+QTTjiWVOGK7a1LiMLvpSo0VZ9ZhhKqApBan/gXHZHtS1wnlioxJB/HghjVkE
	 sYOyJf/agzCBqdpgsmYU0J/Mf9381hOKTn+SdLsU=
Date: Tue, 22 Jul 2025 07:37:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: libwx: fix multicast packets received count
Message-ID: <2025072212-sacrament-radiated-4f06@gregkh>
References: <2025072137-disarm-donator-b329@gregkh>
 <DCAB16D0A9C714C3+20250722020037.3406-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCAB16D0A9C714C3+20250722020037.3406-1-jiawenwu@trustnetic.com>

On Tue, Jul 22, 2025 at 10:00:37AM +0800, Jiawen Wu wrote:
> Multicast good packets received by PF rings that pass ethternet MAC
> address filtering are counted for rtnl_link_stats64.multicast. The
> counter is not cleared on read. Fix the duplicate counting on updating
> statistics.
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://patch.msgid.link/DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index deaf670c160e..ac5957d31674 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2356,6 +2356,8 @@ void wx_update_stats(struct wx *wx)
>  		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
>  	}
>  
> +	/* qmprc is not cleared on read, manual reset it */
> +	hwstats->qmprc = 0;
>  	for (i = 0; i < wx->mac.max_rx_queues; i++)
>  		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
>  }
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

