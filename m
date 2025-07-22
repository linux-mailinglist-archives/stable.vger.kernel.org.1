Return-Path: <stable+bounces-163654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FEAB0D14D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 07:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AA417CA5F
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 05:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023AB2882B6;
	Tue, 22 Jul 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TpFgSVeS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61701E377F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162647; cv=none; b=S5sWrS9EWw58QTtFhfQfSJ+xN/qU+XdysvGN8JpRvj+h3tNF+dKaBU9IkYk2idBEqOskZ4yZGed+2ZNfQDKxuMrpr3PaeYzOFMq9YwIRbzRtBYpaTnkxrdFQUD4lsVUWGORH0GkUr5RtcUBnIg2EMHuG8YzlVuBpgMHRq19GNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162647; c=relaxed/simple;
	bh=CEcHRbbknrp5z4U6MeMCXZjaFJk9G0olmvyaWFHdd2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/uOjliJThMdr8FvciXcdGErItlHTHi3mXHBQPYWPmJ6odJMsOXbeF3BW5xhURWCh8qXkt/WwPOqF3MjrHx4iBX8t1s6QnOiDDBdG4fBbYSg1tqB92GD3Hew7N5E/v63g4EvWHi68gt2PBDWStdvWaWxbmT759IlCrRYkP0I8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TpFgSVeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA92CC4CEEB;
	Tue, 22 Jul 2025 05:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753162647;
	bh=CEcHRbbknrp5z4U6MeMCXZjaFJk9G0olmvyaWFHdd2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpFgSVeSY/rRO34lIXBHTpFJ7i12bNXmLH5GqgWsRBRPjCo7QVwzAKjx0sfkiuWHp
	 O5IENhxjOp1xE0ZS545c+6N7qpvdJ9B6+/chIoQnGHA/cR5qxkUSdEeYrDTUEICDCg
	 /byshRzb2yMbRTKT+iLl9+/Rk04QEUek5dQt/ViE=
Date: Tue, 22 Jul 2025 07:37:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.15.y] net: libwx: fix multicast packets received count
Message-ID: <2025072220-crave-twiddling-65d9@gregkh>
References: <2025072136-steersman-voicing-574e@gregkh>
 <528914E284765D4D+20250722020129.3432-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528914E284765D4D+20250722020129.3432-1-jiawenwu@trustnetic.com>

On Tue, Jul 22, 2025 at 10:01:29AM +0800, Jiawen Wu wrote:
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
> index 490d34233d38..884986973cde 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2524,6 +2524,8 @@ void wx_update_stats(struct wx *wx)
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

