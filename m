Return-Path: <stable+bounces-59137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B980592EBC8
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DB2285911
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED16158216;
	Thu, 11 Jul 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="M0D1OhMD"
X-Original-To: stable@vger.kernel.org
Received: from smtp85.iad3a.emailsrvr.com (smtp85.iad3a.emailsrvr.com [173.203.187.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5522F46
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712211; cv=none; b=bQsF+wOjmfdMMQ8teabHXw51JvwRD8DhrVoPeGU2xT23sIMVZzMWWzG7YGGQ/HUbl4tdyHqVgFUl6InrzRdVzXpw9FpeZcWamBuQl76zQ5W1H4dPPbGVNmk0R8Gv1d43kcQfA5h85Pj0WdVnOuKM3owWnPs2NpsWOXUpHQU/2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712211; c=relaxed/simple;
	bh=0uwD1M9nJAbWVzYpgSCZB5Zm24KRaWsiQ4PiDZVyuS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qw+lOZK5umJHSFVfk485omdcLJicDtf1r6vAtROvyalcCsYwJmIRsLuVWmS8PykPTJaBNvzEFjXhUSZ0ugOkRFSIbqvWDObXD3YnrjOR/Zt10geKUF8bFd+u1qgf5U+2vp5Rh1ciR9FFlYuaQn25yQvnFXQhXO1o0RVr0z9VnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=M0D1OhMD; arc=none smtp.client-ip=173.203.187.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1720711749;
	bh=0uwD1M9nJAbWVzYpgSCZB5Zm24KRaWsiQ4PiDZVyuS0=;
	h=Date:Subject:To:From:From;
	b=M0D1OhMDuM2DuydxSuNKRB+6Q24adcgvzEH3brk9cnPXCOVG/2nEKpqwDe/STM8gk
	 tkvwA7BA/20IiQUMrrfNvv5HKB9jukCxCwVLoOitaFY9OHLFfkEELnIs1RE3hHRSmi
	 bFcucWYRX5AYntFPCaikvfPhxqoQHwE/4+CcYVWM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp19.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 887565150;
	Thu, 11 Jul 2024 11:29:08 -0400 (EDT)
Message-ID: <6f122282-1675-497f-bc2f-0bbfba6640aa@mev.co.uk>
Date: Thu, 11 Jul 2024 16:29:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] rtc: ds1343: Force SPI chip select to be active
 high
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
References: <20240710175246.3560207-1-abbotti@mev.co.uk>
 <20240710184053c34201f0@mail.local>
 <2b0e8a6c-f89e-4d71-a816-9da46ea695eb@mev.co.uk>
 <bd7c0eb9-bcb6-42e3-8be6-3d07452e3fd5@sirena.org.uk>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <bd7c0eb9-bcb6-42e3-8be6-3d07452e3fd5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 43f7e90d-b81b-44ea-bc3d-341a7d3df9f3-1-1

On 11/07/2024 15:21, Mark Brown wrote:
> On Thu, Jul 11, 2024 at 03:05:01PM +0100, Ian Abbott wrote:
> 
>> I think the devicetree node for the RTC device ought to be setting
>> `spi-cs-high` but cannot do so at the moment because the driver clobbers it.
> 
> Specifying spi-cs-high in the device tree should almost always be
> redundant or a mistake, if the device needs a high chip select then we
> already know that from the compatible.  The property is adding nothing
> but potential confusion, in the normal course of affairs the driver
> should just specify the configuration it needs for the bus.

So `spi->mode |= SPI_CS_HIGH;` is safer than `spi->mode ^= SPI_CS_HIGH;`?

Regarding `spi-cs-high` in the device tree, what about the compatibility 
table for `spi-cs-high` and `cs-gpio` active level in 
"Documentation/devicetree/bindings/spi/spi-controller.yaml"?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


