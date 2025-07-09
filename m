Return-Path: <stable+bounces-161428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD8AFE7C8
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FC83B2097
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80B2D3ED6;
	Wed,  9 Jul 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgLCsqJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5F2980BF;
	Wed,  9 Jul 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060584; cv=none; b=nqsQL4wFhD7hxtGJPKjs+NLZ58Q8fmXEfYp3VjIOJOlt7qCzBfaIQWsPDmmejGxOvOPaDRFWHRlRM48aFmbOPlm2k6Mo2OBR0hvudQ2hnLjcQllfr4TzLb3MTdZCxnnyStXYZbgJhAbVh1MAqYi+9KSuqWEOXPl7/mCS2BB6ayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060584; c=relaxed/simple;
	bh=IRZxyqnzZvMjQk+tLWeeqMaC+6mkzZbTnyoHCMOOF1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6q8LhBNHk1lyA5v4K4z16/U0z4kDRjAjCD23yLVPahjS/7KnPRvcZMsWxNK82xldP5CRFJuwT6RqK0N7rTz0F3K1/m+WaPI/yrlB8Ep31IsrPP7CbU4Q6xsM3MhM8ptWc57c0s73jvCx+GO38UobJGD3zaGpTGc7t20DXfmsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgLCsqJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B930FC4CEEF;
	Wed,  9 Jul 2025 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752060581;
	bh=IRZxyqnzZvMjQk+tLWeeqMaC+6mkzZbTnyoHCMOOF1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgLCsqJklmNxRry5+lRubsrkObVqrvr42VVdcT2TOrMB/7/wGOK+3/a8GwStVehvX
	 XnDepqfuP6ecopmhwk3yC9jd2TCZVGicv5/jeNbCubQVvjGA4m/rvaFvvRK5Vsw0os
	 qTBT6LxO5VvsVxuZULuLQDvZgAqlq6PopA0ylz43YPC0SaKX6uLh3gSNTD1RvJqoM0
	 /dQavuc/WIef/vgeD9eJAoaLvp2FCMMlBAn/YCmS2SdcoJZurMmh+rE22JDXb1TV7w
	 p48a8/n0p87WLsTMCxlAOvmmws0NYEwYOYATxOei89mHiAAWRAIAgvm2/SwnV8lRoj
	 h0uFa9KMaLHtg==
Date: Wed, 9 Jul 2025 12:29:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix multicast packets received count
Message-ID: <20250709112937.GU452973@horms.kernel.org>
References: <FD180EC06F384721+20250709063512.3343-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD180EC06F384721+20250709063512.3343-1-jiawenwu@trustnetic.com>

On Wed, Jul 09, 2025 at 02:35:12PM +0800, Jiawen Wu wrote:
> Multicast good packets received by PF rings that pass ethternet MAC
> address filtering are counted for rtnl_link_stats64.multicast. The
> counter is not cleared on read. Fix the duplicate counting on updating
> statistics.
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 0f4be72116b8..a9519997286b 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2778,6 +2778,7 @@ void wx_update_stats(struct wx *wx)
>  		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
>  	}
>  
> +	hwstats->qmprc = 0;
>  	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
>  	     i < wx->mac.max_rx_queues; i++)
>  		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));

Sorry if I am being dense, but I have a question:

The treatment of qmprc prior to this patch seems consistent
with other members of hwstats. What makes qmprc special?

