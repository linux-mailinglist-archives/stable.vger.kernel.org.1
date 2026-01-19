Return-Path: <stable+bounces-210257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5AD39E6E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95E0D300CCD2
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D4326B764;
	Mon, 19 Jan 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWqe0ygg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC12550D5;
	Mon, 19 Jan 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803916; cv=none; b=R5616oyRmto+cwzFusOpRPIVMsuqQEjWmcBt0QfBqXcmzzBIQQLI4gsJM4+aQ89JEzkKO23ECNQYU9HUlPdb8N7NkTbw8uIOD9eAAs1MKLbduYG263kX04slPjoYUodpSD7KlZBccntA7uR0qNbfF2k6HIy3cOxLm0Pu5qos6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803916; c=relaxed/simple;
	bh=hrLfJZN98wDHwiiS6sK917nZ5lAJjvKHlHlZhidDSEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBtFgY3zLy49ML+F6MNo6lo6nGnt0NE7gq+/B7RLj1aDL2/4cBM8Jh9TJyIFByRa2MfcL63H7EgVtwSy2YxYilalaUb1SSYzg/Wfno6AFVyUX8HE2oaNi5iFi8kAkpTBiGT4lW26mcNlGAVFXcCKAHV39sWc8QIW1tLnSfadKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWqe0ygg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE06C116C6;
	Mon, 19 Jan 2026 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768803915;
	bh=hrLfJZN98wDHwiiS6sK917nZ5lAJjvKHlHlZhidDSEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bWqe0yggxFwmo/EFnmWtBaRfMhVjGSEpjbt92ZB1mDPq+tTpjH2xUUfZBsBK/tan4
	 CO2KB4CRGpNQ/zFS5uL9b9f7mV7Scci/pI/VRWZoKYdbHEQ+KlOgQ5YoGn5bOWzh0I
	 Jfou+nIMyzYaAmSRdHnzaEeuZzWeyGKN3BVLXp0Qu85x7FGPgF4rxqqCsSCUtJTMiL
	 JDOVIWXaHtbcjcmduX23WantHzLRuILG+N0lYCNWgxOs1JyLqb04Ph2v4tF2nyN+D3
	 2cep81s3BUu6pcHxQQNb245MaOsOV8nJt7M7elztFDGRb9jWiZvVX/ALS6ICvEtj/m
	 c7Pby45NwHhzw==
Message-ID: <7dfab6ea-fec3-4ddb-a6b7-db692e39474c@kernel.org>
Date: Mon, 19 Jan 2026 07:25:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: caif: fix memory leak in ldisc_receive
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sjur Braendeland <sjur.brandeland@stericsson.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
 stable@vger.kernel.org
References: <20260118174422.10257-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260118174422.10257-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 01. 26, 18:44, Osama Abdelkader wrote:
> Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
> prevent memory leaks when the function is called during device close
> or in race conditions where tty->disc_data or ser->dev may be NULL.
> 
> The memory leak occurred because ser->dev was accessed before checking
> if ser or ser->dev was NULL, which could cause a NULL pointer
> dereference or use of freed memory. Additionally, set tty->disc_data
> to NULL in ldisc_close() to prevent receive_buf() from using a freed
> ser pointer after the line discipline is closed.
> 
> Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> CC: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:
> 1.Combine NULL pointer checks for ser and ser->dev in ldisc_receive()
> 2.Set tty->disc_data = NULL in ldisc_close() to prevent receive_buf()
> from using a freed ser pointer after close.
> 3.Add NULL pointer check for ser in ldisc_close()
> ---
>   drivers/net/caif/caif_serial.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index c398ac42eae9..970237a3ccca 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -152,6 +152,8 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
>   	int ret;
>   
>   	ser = tty->disc_data;
> +	if (!ser || !ser->dev)

NACK. If receive_buf is called with NULL tty->disc_data (outside of 
ldisc open-close window), it's a bug one layer up. I.e. another race in 
old bad tiocsti().

> +		return;
>   
>   	/*
>   	 * NOTE: flags may contain information about break or overrun.
> @@ -170,8 +172,6 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
>   		return;
>   	}
>   
> -	BUG_ON(ser->dev == NULL);
> -
>   	/* Get a suitable caif packet and copy in data. */
>   	skb = netdev_alloc_skb(ser->dev, count+1);
>   	if (skb == NULL)
> @@ -355,11 +355,15 @@ static void ldisc_close(struct tty_struct *tty)
>   {
>   	struct ser_device *ser = tty->disc_data;
>   
> +	if (!ser)

Meaning close can be called twice? Or without open? Really?

> +		return;
> +
>   	tty_kref_put(ser->tty);
>   
>   	spin_lock(&ser_lock);
>   	list_move(&ser->node, &ser_release_list);
>   	spin_unlock(&ser_lock);
> +	tty->disc_data = NULL;

This wouldn't hurt, but should not be needed since:
dd42bf119714 tty: Prevent ldisc drivers from re-using stale tty fields

thanks,
-- 
js
suse labs

