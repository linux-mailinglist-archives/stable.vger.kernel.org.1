Return-Path: <stable+bounces-125656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31510A6A78D
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46A516EBCB
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099DF221F25;
	Thu, 20 Mar 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg3jlpiP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C51EDA38;
	Thu, 20 Mar 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478526; cv=none; b=MCFEIN2weO3bj0pmdYULI5F/6nRCRY3+iBEiC+D0IhAZdaxfuGu3LKH+IrJkIB+RlD4UmFoo75bXjOOSeYZCcrtavsedLRadMJbg3XQWt4yVGKGJ/GSQDeoW5BwWbO1eqjWk2EO1tRqE/6anYqx2YNTKTZ5rtQEzTEFIKRM2hM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478526; c=relaxed/simple;
	bh=n2Aa2LlLF6Pk+aaptQYR87WXXsYSLb/Oa2nEIcU7Lb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZDPOAM4nBfi8Kb34Kn6Rj6/ydw+8Hj6GzIxfC6lgsmuM/akQNRV96qwaGE4OKihGNEYmPCoQDR3JvSLqFFRfHlnaR+A7ZBpjorZCEc31beMMfKVoGV2r2MGUEf2/U51gN86xMhi1X5LDs6EplgQ7z1KW6bBUePD2rs3juBG66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg3jlpiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3550C4CEDD;
	Thu, 20 Mar 2025 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478526;
	bh=n2Aa2LlLF6Pk+aaptQYR87WXXsYSLb/Oa2nEIcU7Lb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg3jlpiPx/dB5BNvXf0tThzs8u8gi3vrNWyciwwY5xslP5x65VURw3KYxskp+PSzN
	 nv78QPsVVJjC6f6Hvmi6HVs+I70VB0bquL0V0Yx9zJO8abjCQSfLSZJxVSs76TSC4N
	 yAy8fDudb7VqkMgt0l73bHllyh4/G+WwkkItX1FszsyLpdilq+sznRW6I+E3Ff8Q/3
	 36X4K3Q1QuPEQf5hJ+Hp8ASKgEsLtWWZlNTUppo48fb8jpt062iRwcdJ6VpBMT/8av
	 IN6YtSuRvlzmg3iQciKCx9MvQBEwhtl98eJPNbIDalEwnVkN74cvm5CxHIIsu1K3t6
	 5mc8aOp3kcLKw==
Date: Thu, 20 Mar 2025 13:48:42 +0000
From: Simon Horman <horms@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Message-ID: <20250320134842.GS280585@kernel.org>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-2-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319112156.48312-2-qasdev00@gmail.com>

On Wed, Mar 19, 2025 at 11:21:53AM +0000, Qasim Ijaz wrote:
> In mii_nway_restart() during the line:
> 
>         bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> 
> The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> 
> ch9200_mdio_read() utilises a local buffer, which is initialised
> with control_read():
> 
>         unsigned char buff[2];
> 
> However buff is conditionally initialised inside control_read():
> 
>         if (err == size) {
>                 memcpy(data, buf, size);
>         }
> 
> If the condition of "err == size" is not met, then buff remains
> uninitialised. Once this happens the uninitialised buff is accessed
> and returned during ch9200_mdio_read():
> 
>         return (buff[0] | buff[1] << 8);
> 
> The problem stems from the fact that ch9200_mdio_read() ignores the
> return value of control_read(), leading to uinit-access of buff.
> 
> To fix this we should check the return value of control_read()
> and return early on error.
> 
> Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
> Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


