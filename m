Return-Path: <stable+bounces-71547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B618965188
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F70BB214A4
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296C18C013;
	Thu, 29 Aug 2024 21:12:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B618B482
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965925; cv=none; b=eelmUzdfcWo7loGzLch5vADypZZ6kfFhsSJUkPOBzbJwtEKuyXjQQfAo5luxlCRsiKGwmcmsXb4ZPuMP4RTOrkGpBQJ7RL1m1SXAlOqoLpOg7AxYlZK7/aMUVtgpX2WpY9IfSK6jrAi4KEybCnFXn0WoNa1NqwPYaZleYnyinLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965925; c=relaxed/simple;
	bh=ajsUGNyZXgkadl/Qi5QNq/d4nCBtSVb9PgBi6qfVYZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZgIYOqlpOKs3H14lZPKVfqr9IAT+kj0hBesHbW7cwWVxLgXrOE6/49jrevEtJwJhtTlShKstykkiKwvpazKiEqZjth6RlNv2DY07aHvasBGEF8DtW4XiIS1H1ekhEV4FttyXEvCCZkjGGABBpmlyVky4PJZNLKiUmc6UGq/SAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 984DC72C8CC;
	Fri, 30 Aug 2024 00:11:54 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 90A4936D0184;
	Fri, 30 Aug 2024 00:11:54 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id 8E498360BF9D; Fri, 30 Aug 2024 00:11:53 +0300 (MSK)
Date: Fri, 30 Aug 2024 00:11:53 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Julia Lawall <julia.lawall@inria.fr>, Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>, 
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.1 202/321] fbdev: offb: replace of_node_put with
 __free(device_node)
Message-ID: <ppqadq365psk4abmtn7kpfvfxbps4qzhn3fz25ysqtzj72opob@jfzmajuq6dyw>
References: <20240827143838.192435816@linuxfoundation.org>
 <20240827143845.922698611@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827143845.922698611@linuxfoundation.org>

Greg, Sasha,

On Tue, Aug 27, 2024 at 04:38:30PM GMT, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.

We got v6.1.107 build error on ppc64le due to this commit, with:

    CC      drivers/video/fbdev/offb.o
  drivers/video/fbdev/offb.c: In function 'offb_init_palette_hacks':
  drivers/video/fbdev/offb.c:358:24: error: cleanup argument not a function
    358 |                 struct device_node *pciparent __free(device_node) = of_get_parent(dp);
        |                        ^~~~~~~~~~~
  make[4]: *** [scripts/Makefile.build:250: drivers/video/fbdev/offb.o] Error 1

Where CONFIG_FB_OF is enabled. Perhaps, due to this commit not being picked:

  9448e55d032d ("of: Add cleanup.h based auto release via __free(device_node) markings")

Thanks,

> 
> ------------------
> 
> From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> 
> [ Upstream commit ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76 ]
> 
> Replaced instance of of_node_put with __free(device_node)
> to simplify code and protect against any memory leaks
> due to future changes in the control flow.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/video/fbdev/offb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 91001990e351c..6f0a9851b0924 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -355,7 +355,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
>  			par->cmap_type = cmap_gxt2000;
>  	} else if (of_node_name_prefix(dp, "vga,Display-")) {
>  		/* Look for AVIVO initialized by SLOF */
> -		struct device_node *pciparent = of_get_parent(dp);
> +		struct device_node *pciparent __free(device_node) = of_get_parent(dp);
>  		const u32 *vid, *did;
>  		vid = of_get_property(pciparent, "vendor-id", NULL);
>  		did = of_get_property(pciparent, "device-id", NULL);
> @@ -367,7 +367,6 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
>  			if (par->cmap_adr)
>  				par->cmap_type = cmap_avivo;
>  		}
> -		of_node_put(pciparent);
>  	} else if (dp && of_device_is_compatible(dp, "qemu,std-vga")) {
>  #ifdef __BIG_ENDIAN
>  		const __be32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
> -- 
> 2.43.0
> 
> 
> 

