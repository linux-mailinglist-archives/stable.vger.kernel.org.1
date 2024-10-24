Return-Path: <stable+bounces-88024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A249AE165
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EF6281448
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520461B392C;
	Thu, 24 Oct 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG5uvlzk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8D166F06;
	Thu, 24 Oct 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763354; cv=none; b=qVmyy9p8CozTtl8M1cFw4yTc7VM56RBgr4gbFWSYwkBgTmWCDrnkYCZIPTu0rWJrty3bpCDGZPYd9kowA6Rlptf2hL2w/OTTnFJ4SvYse5D0g7Twmt5CESkVzSWDhp+HZneZlfP4OEkdgQAeM9CC6o28diXftuktraQAJIIRgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763354; c=relaxed/simple;
	bh=9BLhkgL4XURDbwaZGl4ZxVwtctRHd2YeCfbIW4oFy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZws3qL1BixP8OrKac3w+wCk+HAX8bUQxDwmIQwYURE6Rz/wpFo5/VLS1nN+ZDMNktx5cPYn9wui+P9jkndirMubCQccgEqa5UAi25hMSrRqaDlZNa3m9ZN21aamTb/oThi9o6tMuqN5Hry+Wfr6J1IfnQgUrs6Nv/U+wLW9X4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG5uvlzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FDAC4CEC7;
	Thu, 24 Oct 2024 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729763353;
	bh=9BLhkgL4XURDbwaZGl4ZxVwtctRHd2YeCfbIW4oFy60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nG5uvlzkQv6ocwBO4tA+Hk9n6WT7a95p/Uu5oSA1QkeS22jjr2n4qpw/iSioI8Gkr
	 grFjuOWy9WggkQSYz/IFMWTutrvaBP0/voS3/oOiHdXS1pqybFRETGpDT4glpIOC8Z
	 VIRUYe3bDNuhcC7aWjwrshmvcnA9KWyaH+D+VFVDa9dPVFe3vjdUXiVXFKxyknB+Xj
	 v4djoCgBVrf/63smVhyUNmpPssGkh6PlfnmNjr3OMvxP1Dxx/+1DTlWzWuR8oPfHWn
	 g1hMttwxQDvJVQvbjfiADk5+bXSQgPq9cM4qoKjXpYzZR1BriVrW4Ll5rJLXgDBzS4
	 yho+XMgHeGOqA==
Date: Thu, 24 Oct 2024 10:49:09 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: vertexcom: mse102x: Fix possible double free of
 TX skb
Message-ID: <20241024094909.GL402847@kernel.org>
References: <20241022155242.33729-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022155242.33729-1-wahrenst@gmx.net>

On Tue, Oct 22, 2024 at 05:52:42PM +0200, Stefan Wahren wrote:
> The scope of the TX skb is wider than just mse102x_tx_frame_spi(),
> so in case the TX skb room needs to be expanded, also its pointer
> needs to be adjusted. Otherwise the already freed skb pointer would
> be freed again in mse102x_tx_work(), which leads to crashes:
> 
>   Internal error: Oops: 0000000096000004 [#2] PREEMPT SMP
>   CPU: 0 PID: 712 Comm: kworker/0:1 Tainted: G      D            6.6.23
>   Hardware name: chargebyte Charge SOM DC-ONE (DT)
>   Workqueue: events mse102x_tx_work [mse102x]
>   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : skb_release_data+0xb8/0x1d8
>   lr : skb_release_data+0x1ac/0x1d8
>   sp : ffff8000819a3cc0
>   x29: ffff8000819a3cc0 x28: ffff0000046daa60 x27: ffff0000057f2dc0
>   x26: ffff000005386c00 x25: 0000000000000002 x24: 00000000ffffffff
>   x23: 0000000000000000 x22: 0000000000000001 x21: ffff0000057f2e50
>   x20: 0000000000000006 x19: 0000000000000000 x18: ffff00003fdacfcc
>   x17: e69ad452d0c49def x16: 84a005feff870102 x15: 0000000000000000
>   x14: 000000000000024a x13: 0000000000000002 x12: 0000000000000000
>   x11: 0000000000000400 x10: 0000000000000930 x9 : ffff00003fd913e8
>   x8 : fffffc00001bc008
>   x7 : 0000000000000000 x6 : 0000000000000008
>   x5 : ffff00003fd91340 x4 : 0000000000000000 x3 : 0000000000000009
>   x2 : 00000000fffffffe x1 : 0000000000000000 x0 : 0000000000000000
>   Call trace:
>    skb_release_data+0xb8/0x1d8
>    kfree_skb_reason+0x48/0xb0
>    mse102x_tx_work+0x164/0x35c [mse102x]
>    process_one_work+0x138/0x260
>    worker_thread+0x32c/0x438
>    kthread+0x118/0x11c
>    ret_from_fork+0x10/0x20
>   Code: aa1303e0 97fffab6 72001c1f 54000141 (f9400660)
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


