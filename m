Return-Path: <stable+bounces-146453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE43AC51A1
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D24C3A3A52
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED53278E40;
	Tue, 27 May 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCYEasoy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB227701E
	for <stable@vger.kernel.org>; Tue, 27 May 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358500; cv=none; b=HqYdbi43CHLFJ3FECb+lYdRV/YkuFxqFrMYBWyWyyjP1Fay+r3B9f5BQ6PzSyDKqzWI4sKk/FgGqAqyqv96ydXDYXaaXqcvw4e98BbeXVuGyc/GaffAfW8Vy9f262YlPdpNFML1HaENI37Etvh8LOWgqYOU+bkg0ZEIARYWuYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358500; c=relaxed/simple;
	bh=R+gv/aqeG+mCrHMJb764Cr93UO7ICsb/UzSq99+zZn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6yWEnHgccZ/jzv5WE1igSuzm7dn06533EwkutyLP0rxd39VmDOugTHuRSjgfsa8uSlQkZlh6A8xkZdyj52wOrSp9lcSqlLZJoMVOpwUQaoElHLnN1gTsDzdcSkCmxHWY5F+VheeMKXPGt8BaLvESyPgI4oB1lw396/PyQfkRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCYEasoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7BCC4CEE9;
	Tue, 27 May 2025 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748358494;
	bh=R+gv/aqeG+mCrHMJb764Cr93UO7ICsb/UzSq99+zZn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xCYEasoyASRbzO22FKLBDd1d9Jqb+SdBV0BDwKipc16CVgz8dzjLN39J+wXRT5OtZ
	 6OzKvQdXQNB/bAjfX1evQKKZsV92gFuhZ9DqV3NRV3GhTldujIpd4zorUVTlDprP0C
	 mNQy+g7n+tE0k79IdBIIwzAgBRQlARo38mcbdeMQ=
Date: Tue, 27 May 2025 17:08:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianlin Lv <iecedge@gmail.com>
Cc: kernel-team@lists.ubuntu.com, jianlv@ebay.com,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org, Ahmed Naseef <naseefkm@gmail.com>,
	Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [SRU] [Noble] [PATCH 1/1] net: usb: usbnet: restore usb%d name
 exception for local mac addresses
Message-ID: <2025052735-suffix-culinary-9241@gregkh>
References: <cover.1748010457.git.iecedge@gmail.com>
 <83eababe153e10f30ba5097717299b5260d0b574.1748010457.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83eababe153e10f30ba5097717299b5260d0b574.1748010457.git.iecedge@gmail.com>

On Fri, May 23, 2025 at 10:30:58PM +0800, Jianlin Lv wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> BugLink: https://bugs.launchpad.net/bugs/2111592
> 
> commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
> that local addresses always came from the kernel, but some devices hand
> out local mac addresses so we ended up with point-to-point devices with
> a mac set by the driver, renaming to eth%d when they used to be named
> usb%d.
> 
> Userspace should not rely on device name, but for the sake of stability
> restore the local mac address check portion of the naming exception:
> point to point devices which either have no mac set by the driver or
> have a local mac handed out by the driver will keep the usb%d name.
> 
> (some USB LTE modems are known to hand out a stable mac from the locally
> administered range; that mac appears to be random (different for
> mulitple devices) and can be reset with device-specific commands, so
> while such devices would benefit from getting a OUI reserved, we have
> to deal with these and might as well preserve the existing behavior
> to avoid breaking fragile openwrt configurations and such on upgrade.)
> 
> Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
> Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
> Cc: stable@vger.kernel.org
> Tested-by: Ahmed Naseef <naseefkm@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Acked-by: Oliver Neukum <oneukum@suse.com>
> Link: https://patch.msgid.link/20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> (cherry picked from commit 2ea396448f26d0d7d66224cb56500a6789c7ed07)
> Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> ---
>  drivers/net/usb/usbnet.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

This is already in all stable kernel branches, why send it again?

confused,

greg k-h

