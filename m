Return-Path: <stable+bounces-124731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52925A65B87
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB977A8562
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3CE1B042E;
	Mon, 17 Mar 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arrb2wum"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E491A3171;
	Mon, 17 Mar 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233882; cv=none; b=f/v30mJRdCnfvyxpXLLXefsikX5WE7ux3nmfcdaYA2h4qUVhHI+Y47dmM6AbUunkHfbL9WTB1P5Z4OUZerEudHrxDu+n9DJlxDnxO2r7yRGz+3FCTa9FqKVq3Z0f/CzJz1kE1VCp22l9m2WQHhEYzAoalJTgIMgG3JuD9+gLqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233882; c=relaxed/simple;
	bh=/cKV0Fyi6T03lXlvNH38U4UTUiANpMHFR7ZBQzIISmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKKbFFm580N0sp73uAwgHnecmry4bEaeIDn3m6uGx1ZrM+8ut5IBDfNRpa1sLxQCTFlN+4Z+8cfst2TSxeIt7VTx7Wjn8Z2MjdfYBJf987EJ+qdxZayd8minoKHG+DpkZAO/0b8as1HAwysh+3/nmGas6yUce1feruacOED48eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arrb2wum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC9C4CEE3;
	Mon, 17 Mar 2025 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742233881;
	bh=/cKV0Fyi6T03lXlvNH38U4UTUiANpMHFR7ZBQzIISmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arrb2wumol6HA37c5JOUXQf10sXU/GN+zJFEfCtDCiaKqg/WN2FG50ycPyMY59aS4
	 Z/7BYhHlwL4BMFqrv9HEs6MRf6WmpFNzvKFbKy/VwLFbRVS3OBVnumwoV7KfxydqqY
	 i8YgmHNAci1IUoDcEtT43m1elrMU9JejrLRzwxFJgePhcuWwu4gjYk5JsgAElu3xwq
	 otcjlKsHUVJf0aaOp4dq90YdEvZfOx6vbnzT7l+qosELAXeGdUzAYNgC09R9aGHkW9
	 rn45UNgoNC/qQjg0lm4Auv+z5gppF+pDmfiwoRvE1rKwTbMkUS1dCFtkSfsiEBLHxR
	 iMQ8bCZ+9TnWg==
Date: Mon, 17 Mar 2025 17:51:17 +0000
From: Simon Horman <horms@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart() and
 cleanup error handling
Message-ID: <20250317175117.GI688833@kernel.org>
References: <20250311161157.49065-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311161157.49065-1-qasdev00@gmail.com>

On Tue, Mar 11, 2025 at 04:11:57PM +0000, Qasim Ijaz wrote:
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
> Furthermore the get_mac_address() function has a similar problem where
> it does not directly check the return value of each control_read(),
> instead it sums up the return values and checks them all at the end
> which means if any call to control_read() fails the function just 
> continues on.
> 
> Handle this by validating the return value of each call and fail fast
> and early instead of continuing.
> 
> Lastly ch9200_bind() ignores the return values of multiple 
> control_write() calls.
> 
> Validate each control_write() call to ensure it succeeds before
> continuing with the next call.

Hi Qasim,

I see that these problems are related, but this is quite a lot
of fixes for one patch: the rule of thumb is one fix per patch.
Could you consider splitting it up along those lines?

> 
> Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
> Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

...

> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
> index f69d9b902da0..e938501a1fc8 100644
> --- a/drivers/net/usb/ch9200.c
> +++ b/drivers/net/usb/ch9200.c
> @@ -178,6 +178,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  {
>  	struct usbnet *dev = netdev_priv(netdev);
>  	unsigned char buff[2];
> +	int ret;
>  
>  	netdev_dbg(netdev, "%s phy_id:%02x loc:%02x\n",
>  		   __func__, phy_id, loc);
> @@ -185,8 +186,10 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  	if (phy_id != 0)
>  		return -ENODEV;
>  
> -	control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
> -		     CONTROL_TIMEOUT_MS);
> +	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
> +			   CONTROL_TIMEOUT_MS);
> +	if (ret != 2)
> +		return ret;

If I understand things correctly, control_read() can (only) return:

* 2: success
* negative error value: a different failure mode

If so, I think it would be more idiomatic to write this as:

	if (ret < 0)
		return ret;

This makes it easier for those reading the code to see that
an error value is being returns on error.

Likewise elsewhere in this patch.

>  
>  	return (buff[0] | buff[1] << 8);
>  }

...

