Return-Path: <stable+bounces-50241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55906905289
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5397B2456B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9916FF22;
	Wed, 12 Jun 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ar1LUyG8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88216D4E0;
	Wed, 12 Jun 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195613; cv=none; b=doCim5IIh0W+KZRTsUBL49Ka+sAJlRfdrlNAMTrg33zhWtZERZHlQgOw5mWP49q/lK9fUyDHXUc1NZeCcWgUiVcvwNB/x/QHQ17XnfbSLMFz6rgwlEh4nPGXhpdV8w5NcFwG/Acf7iVsYpqTQV6CZ74/71daiBzemyLHxrFDGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195613; c=relaxed/simple;
	bh=nYtneE5e+vMYGHBuKz6oETBn917d+OEnNQZ8IkT9QRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1ndumIYXJjwCDwGbGTbuXW3sqaZpej8axVApyYhu30yuFJtXwnWyH7/5lIBKySDXdrQ0cI4tiJqMJhz4FW65ZuVypHVCvTfeYFWY2m20BCMWTVaJx/9QBuFEhnLc55bKhTscO41YUDfkmsQtC4eraGloXDNjayZY4aHhJmXvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ar1LUyG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3E2C3277B;
	Wed, 12 Jun 2024 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195612;
	bh=nYtneE5e+vMYGHBuKz6oETBn917d+OEnNQZ8IkT9QRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ar1LUyG8bKL1gwx3oKGQRKIF+vF61+rAi1h/5kYe/HrJzd7CzfpsAale9n5FwvQjg
	 gYP44vD3RjLQtw8L+55RAraQsaS2ik5Ors2OkOuAS3wPoqeKVMvbrA9hM7MK0eJbgr
	 RLlkD+WYpiWdhZ83wwN5ZhN/bnOTW5vHkvGqh0kc=
Date: Wed, 12 Jun 2024 14:33:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: stable@vger.kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: sfp-bus: fix SFP mode detect from bitrate
Message-ID: <2024061214-aloe-fried-9841@gregkh>
References: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
 <20240115165848.110ad8f9@device-28.home>
 <ZaVYKgCPZaidGimU@shell.armlinux.org.uk>
 <ZlhXe81dILU5XytA@makrotopia.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlhXe81dILU5XytA@makrotopia.org>

On Thu, May 30, 2024 at 11:39:55AM +0100, Daniel Golle wrote:
> Hi stable team,
> 
> > > On Mon, 15 Jan 2024 12:43:38 +0000
> > > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > > 
> > > > The referenced commit moved the setting of the Autoneg and pause bits
> > > > early in sfp_parse_support(). However, we check whether the modes are
> > > > empty before using the bitrate to set some modes. Setting these bits
> > > > so early causes that test to always be false, preventing this working,
> > > > and thus some modules that used to work no longer do.
> > > > 
> > > > Move them just before the call to the quirk.
> > > > 
> > > > Fixes: 8110633db49d ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> please apply this patch also to Linux stable down to v6.4 which are
> affected by problems introduced by commit 8110633db49d ("net: sfp-bus:
> allow SFP quirks to override Autoneg and pause bits").
> 
> The fix has been applied to net tree as commit 97eb5d51b4a5 ("net:
> sfp-bus: fix SFP mode detect from bitrate") but never picked for older
> kernel versions affected as well.

Ok, applied to 6.6 only.

greg k-h

