Return-Path: <stable+bounces-104009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DB9F0AA9
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABAF18827B7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F571DB527;
	Fri, 13 Dec 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MrZ566Ue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE51C3C10
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088523; cv=none; b=T6wA2abaevpPZJcNu0lIk/2Q9mRmaGb6hQ6YK7ZnXxqQ2Eft2asZNTn9jcNWYjIal9FKTc+vksMq/Il+gjlqaMYqIqJmcSESntRGC5hel8kYc+x7kyRTOiPHuwalb2wSskHum9WcxEzM7c2jUxkcFmoGFl9nS7ORHuD21624D7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088523; c=relaxed/simple;
	bh=9ZLejwhKtLPp3ho7MKQ4ifUz9Y6k5bXSDFstz+oMAZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU8/1yG7hoi7Ee1I3kdAYxkU3+qzp33XKaksSdkujRMMz1gyI5qZipqo18L9FLWtCqPxIbeuxnNhQ9QQLRcdZN3diNiCAK+iMT1GdcMIsw3u5FpsQD9xr6Yha9LgqdZO6o902bS38vHGOO2Ex6ptKDG2mh+ibtg7cYD8M/lMZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MrZ566Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96900C4CED0;
	Fri, 13 Dec 2024 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088523;
	bh=9ZLejwhKtLPp3ho7MKQ4ifUz9Y6k5bXSDFstz+oMAZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrZ566UeSnYLrXzoKfswr8s1MnDNwTg1KYXvUrDjhWzycjIMH2npSZV2XaoXYPWAA
	 KVtW2sNbfrGyz+TJHKLLb3Ww4IJpmtw89Cis7ZxR8u+hSLXDVNR058zMqZFJvSAAw2
	 GPkruMWXynNdUCSHia30xz2J/68uXcPSfdU9DbcY=
Date: Fri, 13 Dec 2024 12:15:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org, gnstark@salutedevices.com,
	andy.shevchenko@gmail.com
Subject: Re: [PATCH 6.1] leds: an30259a: Use devm_mutex_init() for mutex
 initialization
Message-ID: <2024121313-chemist-factual-1b89@gregkh>
References: <20241213035206.3518851-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213035206.3518851-1-bin.lan.cn@eng.windriver.com>

On Fri, Dec 13, 2024 at 11:52:06AM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: George Stark <gnstark@salutedevices.com>
> 
> [ Upstream commit c382e2e3eccb6b7ca8c7aff5092c1668428e7de6 ]
> 
> In this driver LEDs are registered using devm_led_classdev_register()
> so they are automatically unregistered after module's remove() is done.
> led_classdev_unregister() calls module's led_set_brightness() to turn off
> the LEDs and that callback uses mutex which was destroyed already
> in module's remove() so use devm API instead.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link: https://lore.kernel.org/r/20240411161032.609544-9-gnstark@salutedevices.com
> Signed-off-by: Lee Jones <lee@kernel.org>
> [ Resolve merge conflict in drivers/leds/leds-an30259a.c ]
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> ---
>  drivers/leds/leds-an30259a.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

