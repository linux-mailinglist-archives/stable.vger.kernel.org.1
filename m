Return-Path: <stable+bounces-164842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C9B12C25
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615651C21CBC
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8521882F;
	Sat, 26 Jul 2025 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4d92slr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34078F4C;
	Sat, 26 Jul 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753560343; cv=none; b=Q0qNXphBefBeon+jWzvWr7Kva2G7zBSL34TyLu39nR/VnPprnWRD17n+0luAPGWwwPAV59ocPEI/blQLLyaNWrTv0iedDsr4u2GIPfJN01mjrWXfFbTmavnzEb8TjPE7wg5eB1LcFHM/8rltBXGt4dAPNufAEmsRXlza4fwa5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753560343; c=relaxed/simple;
	bh=5rCJ2wQNBQmDKsYmk2VF9549ZJsYeQhJZowIoMiUGPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSdcNYkXXBZ/LbreXLubzOwrYOgZBViWD+bFpNw9fUvd3zbHzpgpVKKC7R/jhSGGoIOueNrJM7MSbuLkxq7MDHuLqltbJhWWwe8wKOOxuD3NvuQ6GMUxjrVNnt4NaK1yH3rfsgmbqD57Tv1RrKgxM5qe8l1tM820jSUK0FXT324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4d92slr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81539C4CEED;
	Sat, 26 Jul 2025 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753560342;
	bh=5rCJ2wQNBQmDKsYmk2VF9549ZJsYeQhJZowIoMiUGPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4d92slr7VEOjfxp308bMJogMXp6wYLJtt3CpUpgtmbtKLpu2zNMm5alMoEDp8wx5
	 MD6ys53CC7iVInMnL/3LBg9CVmZ61BF7pNRAGN6iCiSfHhZ9loPdDQfWNrsvz+/vhg
	 MIIFRdGXnNBOBwxCz9QWOM3xjHQCoaUsJXan1jBH/dbaz2oWwOLFNNnMuMFOUoszlT
	 JB823UOYpLNs8QqA6pVUNg03k/yiNlDqrJlTZ77ceaN8rEJaUz6b0MAvINyx+5CMxF
	 0+GFKChiF3/oacs/VeccqdCnUPzUJGLJjjko+NaKcfgrKCWqvR11L9KIY0924vSAq7
	 uptMiVqWT/+ww==
Date: Sat, 26 Jul 2025 21:05:38 +0100
From: Simon Horman <horms@kernel.org>
To: chalianis1@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] phy: dp83869: fix interrupts issue when using with
 an optical fiber sfp. to correctly clear the interrupts both status
 registers must be read.
Message-ID: <20250726200538.GO1367887@horms.kernel.org>
References: <20250726001034.28885-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726001034.28885-1-chalianis1@gmail.com>

On Fri, Jul 25, 2025 at 08:10:34PM -0400, chalianis1@gmail.com wrote:
> From: Anis Chali <chalianis1@gmail.com>
> 
> from datasheet of dp83869hm
> 7.3.6 Interrupt
> The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
> allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
> selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
> read from ISR (13h) and FIBER_INT_STTS (C19h) registers. Some interrupts are enabled by default and can
> be disabled through register access. Both the interrupt status registers must be read in order to clear pending
> interrupts. Until the pending interrupts are cleared, new interrupts may not be routed to the interrupt pin.
> 
> Fixes: 01db923e8377 ("net: phy: dp83869: Add TI dp83869 phy")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Anis Chali <chalianis1@gmail.com>
> ---
>  drivers/net/phy/dp83869.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index a62cd838a9ea..1e8c20f387b8 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -41,6 +41,7 @@
>  #define DP83869_IO_MUX_CFG	0x0170
>  #define DP83869_OP_MODE		0x01df
>  #define DP83869_FX_CTRL		0x0c00
> +#define DP83869_FX_INT_STS		0x0c19
>  
>  #define DP83869_SW_RESET	BIT(15)
>  #define DP83869_SW_RESTART	BIT(14)
> @@ -195,6 +196,12 @@ static int dp83869_ack_interrupt(struct phy_device *phydev)
>  	if (err < 0)
>  		return err;
>  
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) {
> +		err = phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_INT_STS);
> +		if (err < 0)
> +			return err;		

Hi Anis,

Its invisible, of course, but the line above has trailing whitespace.

Flagged by checkpatch.

> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.49.0
> 
> 

