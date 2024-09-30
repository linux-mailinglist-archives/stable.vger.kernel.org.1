Return-Path: <stable+bounces-78266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51B98A5E1
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47617282390
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE318FDB2;
	Mon, 30 Sep 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0KwEj6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCA1EB56;
	Mon, 30 Sep 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704241; cv=none; b=HxlCUUEy7MGfqzYL4MFW7ZJgl7h2jkTbe1y0Nnq1uyl8IIfb52BV6WZNX2qP44tQc6WqpGI9s/IOlU3/HIhv3o9Vm1IqrzPK6Xeh710NhP3Uha8xDiiKzP7sSKU9TaA6SwX14mCgqGXN3iDLkAnevdfMoR5tZa2IHiUCg7SgQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704241; c=relaxed/simple;
	bh=lKoyRADkcWjiRRXHAbLZJh0byrlozFqRiaV3hRP3foc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcokflkmJQkQZZuMVLUj8wmwUQGkGvl2F8viEZZiDtIWm4MjVj9aWqgjNjBf0Q0H1I0vqx7KTMMPFObfwMaD49WP7V3Owq79mUgC/KTXkqK3vq1P/P5VIMstygBHVjKx68q5bgAYeeB3MrAfaSx/MhwbTTUYC75H7w8StwRoBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0KwEj6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7C1C4CEC7;
	Mon, 30 Sep 2024 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704240;
	bh=lKoyRADkcWjiRRXHAbLZJh0byrlozFqRiaV3hRP3foc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0KwEj6sElowAia8rnohtPGSB4x7Bue01ApMw2xH+wGPgEDLbU0kAo+kjDr9BAfaO
	 Zkk2BSk+DvRXOOztjLhvnfURK4cRSylJocE4tSLlaAvbTZrnHLTz1iKAM9GFrCSrMT
	 ScnbxzVrZY0FrIY8BreFKIIB/MxuD0Qu6gIkt/vklDC917scw0G/oRsV/83CeZvj6I
	 Aregw6v/Hfv0NbXcC92KpA8OTX/6M5E8mwpWoNLvPaNe76eu/f6tNyVVytkmmykn4A
	 hSVIx9eb5NZwRQUqbnOpjGguBujtr04AXySWfWjBUP6+e9IZRBPVRqneLhLnN1rYFC
	 lL06QBuJDRU5w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1svGnO-000000004jK-3Cl1;
	Mon, 30 Sep 2024 15:50:39 +0200
Date: Mon, 30 Sep 2024 15:50:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, elder@kernel.org, gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: Fix atomicity violation in get_serial_info()
Message-ID: <Zvqsrj5ee9iNQXsX@hovoldconsulting.com>
References: <20240930101403.24131-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930101403.24131-1-chenqiuji666@gmail.com>

On Mon, Sep 30, 2024 at 06:14:03PM +0800, Qiu-ji Chen wrote:
> Atomicity violation occurs during consecutive reads of the members of 
> gb_tty. Consider a scenario where, because the consecutive reads of gb_tty
> members are not protected by a lock, the value of gb_tty may still be 
> changing during the read process. 
> 
> gb_tty->port.close_delay and gb_tty->port.closing_wait are updated
> together, such as in the set_serial_info() function. If during the
> read process, gb_tty->port.close_delay and gb_tty->port.closing_wait
> are still being updated, it is possible that gb_tty->port.close_delay
> is updated while gb_tty->port.closing_wait is not. In this case,
> the code first reads gb_tty->port.close_delay and then
> gb_tty->port.closing_wait. A new gb_tty->port.close_delay and an
> old gb_tty->port.closing_wait could be read. Such values, whether
> before or after the update, should not coexist as they represent an
> intermediate state.
> 
> This could result in a mismatch of the values read for gb_tty->minor, 

No, gb_tty minor is only set at probe().

> gb_tty->port.close_delay, and gb_tty->port.closing_wait, which in turn 
> could cause ss->close_delay and ss->closing_wait to be mismatched.

Sure, but that's a pretty minor issue as Dan already pointed out.

> To address this issue, we have enclosed all sequential read operations of 
> the gb_tty variable within a lock. This ensures that the value of gb_tty 
> remains unchanged throughout the process, guaranteeing its validity.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations.
> 
> Fixes: b71e571adaa5 ("staging: greybus: uart: fix TIOCSSERIAL jiffies conversions")

And this obviously isn't the correct commit to blame. Please be more
careful.

> Cc: stable@vger.kernel.org

Since this is unlikely to cause any issues for a user, I don't think
stable backport is warranted either.

> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/staging/greybus/uart.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index cdf4ebb93b10..8cc18590d97b 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -595,12 +595,14 @@ static int get_serial_info(struct tty_struct *tty,
>  {
>  	struct gb_tty *gb_tty = tty->driver_data;
>  
> +	mutex_lock(&gb_tty->port.mutex);
>  	ss->line = gb_tty->minor;

gb_tty is not protected by the port mutex.

>  	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
>  	ss->closing_wait =
>  		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
>  		ASYNC_CLOSING_WAIT_NONE :
>  		jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
> +	mutex_unlock(&gb_tty->port.mutex);
>  
>  	return 0;
>  }

Johan

