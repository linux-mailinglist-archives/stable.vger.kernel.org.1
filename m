Return-Path: <stable+bounces-210208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0373D39754
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4407830084EE
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43677262FF8;
	Sun, 18 Jan 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVJlEEbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE41FC7;
	Sun, 18 Jan 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748568; cv=none; b=bfK3SkYOBneew4uyPw0cgnAH3lgBfuVS1Iov1owwZ19UtXT+e3RNWYWZvxxFiZkMa0/Da3p3IfYOyGc2YGrTYeuuR5yZqI4LAOQ1NHzVEa+oT4ZvcKYNM50gz6Ik2B8i9KwK7lMp7C1cxun0/UXiJ1EwbEF3B1iYppbmzu5J8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748568; c=relaxed/simple;
	bh=1ZRSWtYq+sT9Vl8/81NHJCo4yQ58u1wefI9Lpdu8cM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+zutMt5ppytJ3Sps506HdG8qlfOoBiQnRYkjFquaYhHUsxmIrukT77Yn19bgSYJsiTcYd3wmGdfcc2BkfX0ZiY4jb4YX4zPJKzn8ST/NeO/OWC9NAPyx9rrxWK9mYV9nBz1M+BPGZ2f0RYzk2W02AJuXIeJB3xTP+gCmU9WkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVJlEEbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E22EC116D0;
	Sun, 18 Jan 2026 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768748567;
	bh=1ZRSWtYq+sT9Vl8/81NHJCo4yQ58u1wefI9Lpdu8cM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVJlEEbWUL5fgD4iqFNfSDQ+qtAn0dn3SFLFbTjLJtrJSHcs9vG1qVWpg4o8fJ1yl
	 IupSqG9FmVZkwtWtwjLn1DXNzVhrzs2avW09h89G9oNXF3rigmsOYxeLcIoyf19FDM
	 UxuT7/wiO4MjgdR9j0vYfNDohOqDnVZuZCFRPGP4=
Date: Sun, 18 Jan 2026 16:02:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: caif: fix memory leak in ldisc_receive
Message-ID: <2026011805-bamboo-disband-926a@gregkh>
References: <20260118144800.18747-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118144800.18747-1-osama.abdelkader@gmail.com>

On Sun, Jan 18, 2026 at 03:47:54PM +0100, Osama Abdelkader wrote:
> Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
> prevent memory leaks when the function is called during device close
> or in race conditions where tty->disc_data or ser->dev may be NULL.
> 
> The memory leak occurred because netdev_alloc_skb() would allocate an
> skb, but if ser or ser->dev was NULL, the function would return early
> without freeing the allocated skb. Additionally, ser->dev was accessed
> before checking if it was NULL, which could cause a NULL pointer
> dereference.
> 
> Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
> Closes:
> https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3

Please do not wrap this line.

> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> CC: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/net/caif/caif_serial.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index c398ac42eae9..0ec9670bd35c 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -152,12 +152,16 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
>  	int ret;
>  
>  	ser = tty->disc_data;
> +	if (!ser)
> +		return;

Can this ever be true?

>  	/*
>  	 * NOTE: flags may contain information about break or overrun.
>  	 * This is not yet handled.
>  	 */
>  
> +	if (!ser->dev)
> +		return;

Why is this check here and not just merged together with the one you
added above?  And how can ->dev be NULL?

And where is the locking to prevent this from changing right after you
check it?

thanks,

greg k-h

