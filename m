Return-Path: <stable+bounces-147886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE047AC5C58
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670491BA464A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B22144DD;
	Tue, 27 May 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GwH/VnrM"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6020551C;
	Tue, 27 May 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382167; cv=none; b=Hro7bu5LCjJajq6FYNUEr3/N8nir3cggZD5oguaYXP8WXt3ox0GjUubQCHYBuck6b9pTAGp6MloiQ58P0KuwZ6hQhrmdb0vdYeWVK46xO1e+tP37UWdAAVpYrkPuoYYD1VpjXx9HMGnOt3YfvjG+MO1HV+nKLD3f0MGsIf9ybg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382167; c=relaxed/simple;
	bh=WrSGRooY/S5bv9/nZlTjnpVWBJU+gSbJd1d8TsGd+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY011H4p4qWLS6fO17eai+8AX5i+ldiIAkM8wgaj2WwGem3NBeJN8XHuztu6ccTjDHwOqIPcL0qq1SmJstsmUr98dXVRItwZXjSZOErLTnu0ajmbd+APTNC5adWCtB10V9zY6e2WSqAphr4QeLx/cohaMgYiqce2hmiZjTJdeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GwH/VnrM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i+gW2LdhsX8mVrWu3C6sM6tUvLVRRXub0MosDWgoTfc=; b=GwH/VnrMSLT1WoOmGD2gqW5PKI
	pgPx7dreOe02g96LUx9QD2tM3nNkyJfD4n0vJbwdCvXAp5h/V01RTeOZpuMHGlGPpWoo14pa+n2m3
	gk4hh3fcOMAGURgHjs/uQecCMNZTf64588vX+MkpN9jBF5xaYyOlrsLKm9N8ETXPsVXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uK241-00E6ye-OG; Tue, 27 May 2025 23:42:25 +0200
Date: Tue, 27 May 2025 23:42:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mikael Wessel <post@mikaelkw.online>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	torvalds@linuxfoundation.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, kuba@kernel.org, pabeni@redhat.com,
	security@kernel.org, stable@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: fix heap overflow in e1000_set_eeprom()
Message-ID: <10cf162e-ca02-44b0-b238-74a93fe05f54@lunn.ch>
References: <20250527211332.50455-1-post@mikaelkw.online>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527211332.50455-1-post@mikaelkw.online>

On Tue, May 27, 2025 at 11:13:32PM +0200, Mikael Wessel wrote:
> The ETHTOOL_SETEEPROM ioctl copies user data into a kmalloc'ed buffer
> without validating eeprom->len and eeprom->offset. A CAP_NET_ADMIN
> user can overflow the heap and crash the kernel or gain code execution.
> 
> Validate length and offset before kmalloc() to avoid leaking eeprom_buff.
> 
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Reported-by: Mikael Wessel <post@mikaelkw.online>
> Signed-off-by: Mikael Wessel <post@mikaelkw.online>
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 98e541e39730..d04e59528619 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -561,7 +561,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
>  		return -EOPNOTSUPP;
>  
>  	if (eeprom->magic !=
> -	    (adapter->pdev->vendor | (adapter->pdev->device << 16)))
> +		(adapter->pdev->vendor | (adapter->pdev->device << 16)))
>  		return -EFAULT;

That look like a white space change, which should not be part of a
fix.

Please also take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to set the tree in the Subject line.

    Andrew

---
pw-bot: cr
	

