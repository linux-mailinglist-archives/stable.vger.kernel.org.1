Return-Path: <stable+bounces-50230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1745905217
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F291C22674
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E15416F286;
	Wed, 12 Jun 2024 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdG3v1Ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54116EBF6
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194103; cv=none; b=o1mUksylQEpXPOVB8jd+PmKc0MCBoLLZwnCYynd89bjUO7aZ0e6moAqRK/oreDGdXx/jg6rBhOcNNHSpd7noRjKgzPdKKMScw0KBhRi/PHrl5q+LGb6nW2vtiwVNsSpwPWdXUEhBiwVptAyMNeFbn0heroFdx/ckH8QO0Mrg9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194103; c=relaxed/simple;
	bh=ZjrRvT/ywn7UfYnFttgDJpGtIhdiisNzSubXOefT8WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCx1x7bxtrlLevo0/SJ+9oGn4dNQs748PaMsF9uz2ZXW2u7cc+VkM1QQdbcsNOjyiJKu/KTFw7+OfZhNB26XkKhJP1lVIilJdg3GL761uh2JhHVxlkxtYifPFsMne9OGJwsfkZ8TSfYuvA9KL+Gck8hXDPWJCP0Yu/lG6FRgfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdG3v1Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7388AC3277B;
	Wed, 12 Jun 2024 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194102;
	bh=ZjrRvT/ywn7UfYnFttgDJpGtIhdiisNzSubXOefT8WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdG3v1Ya1gG1DjM+93G5RfJ82s4byXQHbKwRclT3HkgOUFOr29s8MKGoy3oUopptZ
	 s6RV8YibtzNM9tGR37g6ZsiKcXo6kYoqRgoFP4nAkdUy33KTuMS6M89+SkzNAePvkW
	 ms8XOjg43vUnX04xoWox3vT77Ha2O5aHJaW9ELOY=
Date: Wed, 12 Jun 2024 14:08:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiDlm57lpI06IOWbnuWkjTogYmFja3BvcnQg?= =?utf-8?Q?a?= patch for
 Linux kernel-5.15 kernel-6.1 kenrel-6.6 stable tree
Message-ID: <2024061246-enlighten-timothy-0386@gregkh>
References: <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052313-taste-diner-2d78@gregkh>
 <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052426-recognize-luxurious-bda8@gregkh>
 <PSAPR03MB56537E5242876A4EE9E910A495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052432-ashamed-carport-c4a0@gregkh>
 <PSAPR03MB5653D6A7D9FB3668FD499A1A95F72@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB5653D6A7D9FB3668FD499A1A95F72@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Sun, May 26, 2024 at 02:51:42AM +0000, Lin Gui (桂林) wrote:
> Dear  gregkh@linuxfoundation.org,
> 
> I'm very sorry for the trouble, here's the update:
> 
> From f033ef0bfb29cd413d10aba860ce8d178cc314e2 Mon Sep 17 00:00:00 2001
> From: Mengqi Zhang <mailto:mengqi.zhang@mediatek.com>
> Date: Mon, 25 Dec 2023 17:38:40 +0800
> Subject: [PATCH] mmc: core: Add HS400 tuning in HS400es initialization
> 
> commit 77e01b49e35f24ebd1659096d5fc5c3b75975545 upstream
> 
> During the initialization to HS400es stage, add a HS400 tuning flow as an optional process. For Mediatek IP, the HS400es mode requires a specific tuning to ensure the correct HS400 timing setting.
> 
> Signed-off-by: Mengqi Zhang <mailto:mengqi.zhang@mediatek.com>
> Link: https://lore.kernel.org/r/20231225093839.22931-2-mengqi.zhang@mediatek.com
> Signed-off-by: Ulf Hansson <mailto:ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index a56906633ddf..c1eb22fd033b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1799,8 +1799,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  
>  		if (err)
>  			goto free_card;
> -
> -	} else if (!mmc_card_hs400es(card)) {
> +	} else if (mmc_card_hs400es(card)) {
> +		if (host->ops->execute_hs400_tuning) {
> +			err = host->ops->execute_hs400_tuning(host, card);
> +			if (err)
> +				goto free_card;
> +		}
> +	} else {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
>  		if (err > 0 && mmc_card_hs(card)) {
> --

Better, thanks, but your email client still did odd things to the email
addresses.

I've fixed this up by hand, but please, be more careful next time...

greg k-h

