Return-Path: <stable+bounces-146450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E0AC515E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288AC3ADD8D
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B1278E5A;
	Tue, 27 May 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJ5co7XB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB062741CD
	for <stable@vger.kernel.org>; Tue, 27 May 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357713; cv=none; b=TVNAEW+8/ygbQthn5sL1jbvnyeCP0ZZNxyX0EKRyZbGftmCSyvE/nCwGCM9hAhGRz3yyOakwjLViJamWYDX+MaJiuD/9OH593prIwCHcrn/fRhdivhX8FFFbDgGQglawvNMmTOvj9Rj/tjYvekm8LKZRMKvlXYxx4ej494TEj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357713; c=relaxed/simple;
	bh=l8S6Je0sXvdYBAORqLJ3HtfreUd5b2lWW9ZoaoWPP7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbx1ix4hyfHazm7KNuaes1jfa91r1z9yohMp92FQ2mOG44lyFUVAbFEs4Hoo+jK0LiHXKKxHtA4Bi2l4qxpHi9TiMEBFN4MIu8u2Q3AATIefxNmlpUBVTxJfSkP8yXmk8jXBwWiXbRXjsKIhVVjpcVoRmG8D8R+mRTERQztvN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KJ5co7XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDEBC4CEE9;
	Tue, 27 May 2025 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748357712;
	bh=l8S6Je0sXvdYBAORqLJ3HtfreUd5b2lWW9ZoaoWPP7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJ5co7XB/7vLlXgJ93AsFEWOA3aGp8ZziAqPQmK0q/EVu8Hl1gyo3mcTz2AaGyI6R
	 IJ8+pl+ZEges2T8v3E1bo57QXwf+MiXhllo6FF8b4qeA7b6E6/xVU6s4WLrnItQoM6
	 gppy78v1ztX/zBA0E7IZWK/zPI7u6rDTQOsfbblw=
Date: Tue, 27 May 2025 16:55:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianlin Lv <iecedge@gmail.com>
Cc: jianlv@ebay.com,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org, Ahmed Naseef <naseefkm@gmail.com>,
	Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [SRU] [Noble] [PATCH 1/1] net: usb: usbnet: restore usb%d name
 exception for local mac addresses
Message-ID: <2025052753-wrinkly-gurgle-f6f3@gregkh>
References: <cover.1747992812.git.iecedge@gmail.com>
 <7de740f8e6f5ba6b23f96f2f89ccf5949845c36b.1747992812.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de740f8e6f5ba6b23f96f2f89ccf5949845c36b.1747992812.git.iecedge@gmail.com>

On Fri, May 23, 2025 at 05:37:23PM +0800, Jianlin Lv wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
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

What stable branch is this backport for?

confused,

greg k-h

