Return-Path: <stable+bounces-144517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33766AB8548
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0194F1899C0C
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953342989B8;
	Thu, 15 May 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BCqr3+JK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C329899E;
	Thu, 15 May 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309868; cv=none; b=GcN5aDAZwLkonaukOUDNtjqNQmeQZihXzNkB7m895MU2HTCZo3ZCnnnwXk3Z4s8LWSy+pTUPZ2hwFAcLQed5IPWOj21OsryG3N4qQ/Xka76OulRm/W1hpyxuiuESyaua0nIhjlrisI8zPqowEfolZZmeQ09SRRATwrrkU9y6vII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309868; c=relaxed/simple;
	bh=uzV7iVarlKgq0MA+9EScPwftRklHr0wRg/TqVeBJYIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJe9uA5I9dmdmGrWOg/inh10N3PIOiM8etwXU+u9D3bqrLVqoBIYmkW3Rpw7m9H6SqI9hHWIgOOzVhmr2EsICFsY3uz8UDhWYi+K0aLQQ2PVKQu5yezdXpGwuaYqQLuAYrqInfK4UoD+kD4pNElHE9K+TyOEI93bIkiC87ZwORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BCqr3+JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A541C4CEE7;
	Thu, 15 May 2025 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747309867;
	bh=uzV7iVarlKgq0MA+9EScPwftRklHr0wRg/TqVeBJYIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCqr3+JKZNTQ2riFaJ5zZXWDSukWex3bIPuBaHTXfXsaS7uFIkp4EQyfgJSZjwF7F
	 IeQZ5Rb4WlvNX5MeciFZ+5UAiXJRRTex8f8Ep8M9RkRP2BKWr1pEJj3z+g4I3VaJEO
	 4oCgzwZNT2j5zxgEE/gmAizsxkTatohbU+GYPKxo=
Date: Thu, 15 May 2025 13:49:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: usb: cypress,hx3: Add support for
 all variants
Message-ID: <2025051550-polish-prude-ed56@gregkh>
References: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
 <20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com>
 <3784948.RUnXabflUD@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3784948.RUnXabflUD@diego>

On Thu, May 15, 2025 at 01:43:59PM +0200, Heiko Stübner wrote:
> Am Freitag, 25. April 2025, 17:18:07 Mitteleuropäische Sommerzeit schrieb Lukasz Czechowski:
> > The Cypress HX3 hubs use different default PID value depending
> > on the variant. Update compatibles list.
> > Becasuse all hub variants use the same driver data, allow the
> > dt node to have two compatibles: leftmost which matches the HW
> > exactly, and the second one as fallback.
> > 
> > Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
> > Cc: stable@vger.kernel.org # 6.6
> > Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb: usb-device: relax compatible pattern to a contains") from list: https://lore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f14e800@cherry.de/
> > Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.c driver
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> 
> Looking at linux-next, it seems like patch1 of this series was applied [0].

It is in 6.15-rc6, not "just" linux-next

> The general convention would be for the binding (this patch) also going
> through a driver tree.
> 
> I guess I _could_ apply it together with the board-level patches, but
> for that would need an Ack from Greg .
> 
> @Greg, do you want to merge this patch ?

I thought a new series was going to be sent for some reason, which would
make this a lot easier.  But if you want to just take this one now,
that's fine with me as it's not in my queue.

thanks,

greg k-h

