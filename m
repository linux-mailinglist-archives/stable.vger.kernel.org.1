Return-Path: <stable+bounces-191672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F461C1D2DF
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 21:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B8E188A772
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779A3358CD;
	Wed, 29 Oct 2025 20:15:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02532E22BD;
	Wed, 29 Oct 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768954; cv=none; b=WHWPUtXLUZjCT6yagf5ZbnoK2ahrd6n0km5KZeO03kVXX+x+ysCYcGy8OunvUde3YP7jZfAvbqxbqyW3SKrZr/NeRzqFMw/3mKxI5FPse/DehHl8YZtMN1yP7ZuWezRIzhEAOtl1r92e5/rQ0e8GhVoNAEf1G81Kl4buK8VPuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768954; c=relaxed/simple;
	bh=HDfewOV5mACxbjXjrW/oald4KFBK1ql0agAzRq4tGg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=of9v1cDNu12n+wm3BF6pomOfQG5GderqfR7+aokEn+BBAt3zV3r32uOx0xa/QY8dfsU9aBrwQgL6Da1BVa/U6QWRHSy8AMyrHhe3TEGnKKu4WZhPWSxxbxQZB3fE/yK8cArSxGF6loE+1Tl3Hdbv3ehzyPdKKgphnnNJtZSy8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.214] (p57bd9c51.dip0.t-ipconnect.de [87.189.156.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5914B617C4FA6;
	Wed, 29 Oct 2025 21:15:31 +0100 (CET)
Message-ID: <9778a6a1-ffb0-4972-a2e7-893128a51e52@molgen.mpg.de>
Date: Wed, 29 Oct 2025 21:15:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: rfcomm: fix modem control handling
To: Johan Hovold <johan@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251023120530.5685-1-johan@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251023120530.5685-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Johan,


Thank you for your patch.


Am 23.10.25 um 14:05 schrieb Johan Hovold:
> The RFCOMM driver confuses the local and remote modem control signals,
> which specifically means that the reported DTR and RTS state will
> instead reflect the remote end (i.e. DSR and CTS).
> 
> This issue dates back to the original driver (and a follow-on update)
> merged in 2002, which resulted in a non-standard implementation of
> TIOCMSET that allowed controlling also the TS07.10 IC and DV signals by
> mapping them to the RI and DCD input flags, while TIOCMGET failed to
> return the actual state of DTR and RTS.
> 
> Note that the bogus control of input signals in tiocmset() is just
> dead code as those flags will have been masked out by the tty layer
> since 2003.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

There is a linux-history git archive [1], if somebody wants dig further. 
But not relevant for the tag used by the stable folks.

Is there any way to test your change, to read DTR and RTS state?

> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes in v2
>   - fix a compilation issue discovered before sending v1 but never folded
>     into the actual patch...
> 
> 
>   net/bluetooth/rfcomm/tty.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 376ce6de84be..b783526ab588 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -643,8 +643,8 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
>   		tty_port_tty_hangup(&dev->port, true);
>   
>   	dev->modem_status =
> -		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |
> -		((v24_sig & RFCOMM_V24_RTR) ? (TIOCM_RTS | TIOCM_CTS) : 0) |
> +		((v24_sig & RFCOMM_V24_RTC) ? TIOCM_DSR : 0) |
> +		((v24_sig & RFCOMM_V24_RTR) ? TIOCM_CTS : 0) |
>   		((v24_sig & RFCOMM_V24_IC)  ? TIOCM_RI : 0) |
>   		((v24_sig & RFCOMM_V24_DV)  ? TIOCM_CD : 0);
>   }
> @@ -1055,10 +1055,14 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
>   static int rfcomm_tty_tiocmget(struct tty_struct *tty)
>   {
>   	struct rfcomm_dev *dev = tty->driver_data;
> +	struct rfcomm_dlc *dlc = dev->dlc;
> +	u8 v24_sig;
>   
>   	BT_DBG("tty %p dev %p", tty, dev);
>   
> -	return dev->modem_status;
> +	rfcomm_dlc_get_modem_status(dlc, &v24_sig);
> +
> +	return (v24_sig & (TIOCM_DTR | TIOCM_RTS)) | dev->modem_status;
>   }
>   
>   static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
> @@ -1071,23 +1075,15 @@ static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigne
>   
>   	rfcomm_dlc_get_modem_status(dlc, &v24_sig);
>   
> -	if (set & TIOCM_DSR || set & TIOCM_DTR)
> +	if (set & TIOCM_DTR)
>   		v24_sig |= RFCOMM_V24_RTC;
> -	if (set & TIOCM_RTS || set & TIOCM_CTS)
> +	if (set & TIOCM_RTS)
>   		v24_sig |= RFCOMM_V24_RTR;
> -	if (set & TIOCM_RI)
> -		v24_sig |= RFCOMM_V24_IC;
> -	if (set & TIOCM_CD)
> -		v24_sig |= RFCOMM_V24_DV;
>   
> -	if (clear & TIOCM_DSR || clear & TIOCM_DTR)
> +	if (clear & TIOCM_DTR)
>   		v24_sig &= ~RFCOMM_V24_RTC;
> -	if (clear & TIOCM_RTS || clear & TIOCM_CTS)
> +	if (clear & TIOCM_RTS)
>   		v24_sig &= ~RFCOMM_V24_RTR;
> -	if (clear & TIOCM_RI)
> -		v24_sig &= ~RFCOMM_V24_IC;
> -	if (clear & TIOCM_CD)
> -		v24_sig &= ~RFCOMM_V24_DV;
>   
>   	rfcomm_dlc_set_modem_status(dlc, v24_sig);
>   


Kind regards,

Paul


[1]: 
https://web.git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

