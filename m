Return-Path: <stable+bounces-161552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A93AFFFD2
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BB31C43877
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927F2E0917;
	Thu, 10 Jul 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyYXSU+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF724501E;
	Thu, 10 Jul 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144896; cv=none; b=lz34PvM7tnIdgg7pT5UXGLn3zI405z+P6oZqMKXBmLPVBKVxx4ACwBaHoQpbCg/8Gt8uJNuDcyzuskEszrZK7aiEmTvmRHcFGD9+zOmUr6ONKexB89dLoTqIruQLKIB7y2sRO5DFzH79VTRNabx3B4a24Zjgm85v/x8NJZy3F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144896; c=relaxed/simple;
	bh=1VX9TvZ3DGGumivCkIis24uSb+17Yx1ILvWmwZv/GhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC3qgAHWKRhoUhX8YDedGupsMxAyrtFoi4LgnJaNV6uInleuzmETByNDEyXnOkP5zbhExfgyiy9oNEXPQQ78OsL3968juBEjGZYCpMe6sEH+IBmIihsBu1Ek9daUHD5Q6EGu50/aAtJpYNglyMV6qdoIGFC2iHVv1ie7vd6y900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyYXSU+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD97C4CEE3;
	Thu, 10 Jul 2025 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752144896;
	bh=1VX9TvZ3DGGumivCkIis24uSb+17Yx1ILvWmwZv/GhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyYXSU+mHx3JqzPupvxbD2ncbpuReRxK4FvCJgHyu8u455YmqrT1eAzTX36j+yf+c
	 x55nPoVMLwOHUXL1vRl1+rS6aiMq/GOjsv+pvQ6d7xwQQHFS3Rlp50htO50mXEr4iS
	 9XHvP4xoIDlLrgAduep0Ux9snIlxchvZcaiY/QhlacC3fkgibf7JoUYfRhMd4GLnaF
	 h8hA+JslL7bZDym1DWOazUc8RHmzs2DJ7w4ZcaUYViKtCzcmvnBFK25aNuf00yl/G5
	 kTHy1bt0ixgBchsUDsZNUbMyKgMZWHeN39SU1HQmikd7dnH446cpGg3lEcvmjF6xh9
	 1ypslTFnfkJUg==
Date: Thu, 10 Jul 2025 11:54:52 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix multicast packets received count
Message-ID: <20250710105452.GQ721198@horms.kernel.org>
References: <FD180EC06F384721+20250709063512.3343-1-jiawenwu@trustnetic.com>
 <20250709112937.GU452973@horms.kernel.org>
 <086c01dbf13d$84ab4ec0$8e01ec40$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086c01dbf13d$84ab4ec0$8e01ec40$@trustnetic.com>

On Thu, Jul 10, 2025 at 09:54:05AM +0800, Jiawen Wu wrote:
> On Wed, Jul 9, 2025 7:30 PM, Simon Horman wrote:
> > On Wed, Jul 09, 2025 at 02:35:12PM +0800, Jiawen Wu wrote:
> > > Multicast good packets received by PF rings that pass ethternet MAC
> > > address filtering are counted for rtnl_link_stats64.multicast. The
> > > counter is not cleared on read. Fix the duplicate counting on updating
> > > statistics.
> > >
> > > Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > ---
> > >  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > > index 0f4be72116b8..a9519997286b 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > > @@ -2778,6 +2778,7 @@ void wx_update_stats(struct wx *wx)
> > >  		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
> > >  	}
> > >
> > > +	hwstats->qmprc = 0;
> > >  	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
> > >  	     i < wx->mac.max_rx_queues; i++)
> > >  		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
> > 
> > Sorry if I am being dense, but I have a question:
> > 
> > The treatment of qmprc prior to this patch seems consistent
> > with other members of hwstats. What makes qmprc special?
> 
> The other members are read from CAB registers, and they are cleaned
> on read. 'qmprc' is read from BAR register, it is designed not to be
> cleared on read.

Thanks that makes perfect sense.

Do you think you could add a comment to the code regarding this.
Or at least something in the commit message.

