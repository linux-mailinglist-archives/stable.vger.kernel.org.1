Return-Path: <stable+bounces-192473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E17C33C7E
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 03:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1230018C5C35
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220821E0AD;
	Wed,  5 Nov 2025 02:33:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378B1624D5;
	Wed,  5 Nov 2025 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310026; cv=none; b=TIQBWMJe2SzL1uCV/J/SXZIZR/2Vu234CSBBw2BrqdTbriFJmIqdKCYsnmrymefnLnCkpZeijiofV2xViOvQzcsSI5I6qFN7QP9UUQS2Rxjc1AIshUxduf2RuOmTK7/qQMLMCJ0XcJ8zLusy6uA39IVW8EhN/Chtdq5eSjzL2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310026; c=relaxed/simple;
	bh=rjrR/8p2+UPQYdZh5dxskS4iYX1WrNMgZSwvL/qYOKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGeh+z+k3AvHQ99k8CHJtXZKRIsaC0F05dB68NvNVTg6vXT3xc3F+nsfWZ8RRo9d7Cja2oxN5PLiyivbwXXAaS5c2BeMDORVCtuuJZPo4Nhheg54hTQiIuA2S4qMMM1qJcx5mkypECkb581eeDxjfXGNBqP4lYfEbMFygSrOXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 96Hye9UyTOaXxfI6BIxJcw==
X-CSE-MsgGUID: jdkfdahWSWaBEVYy4ZCsIw==
X-IronPort-AV: E=Sophos;i="6.19,280,1754928000"; 
   d="scan'208";a="157351177"
Date: Wed, 5 Nov 2025 10:33:38 +0800
From: Owen Gu <guhuinan@xiaomi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <linux-usb@vger.kernel.org>, Al Viro
	<viro@zeniv.linux.org.uk>, Ingo Rohloff <ingo.rohloff@lauterbach.com>,
	Christian Brauner <brauner@kernel.org>, Chen Ni <nichen@iscas.ac.cn>, "Peter
 Zijlstra" <peterz@infradead.org>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Akash M <akash.m5@samsung.com>, Chenyu <chenyu45@xiaomi.com>, Yudongbin
	<yudongbin@xiaomi.com>, Mahongwei <mahongwei3@xiaomi.com>, Jiangdayu
	<jiangdayu@xiaomi.com>
Subject: Re: [PATCH 6.12.y] usb: gadget: f_fs: Fix epfile null pointer access
 after ep enable.
Message-ID: <aQq3gkC7k9QCEiYl@oa-guhuinan-2.localdomain>
References: <20251104034946.605-1-guhuinan@xiaomi.com>
 <2025110452-graffiti-blizzard-9cbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025110452-graffiti-blizzard-9cbc@gregkh>
X-ClientProxiedBy: bj-mbx11.mioffice.cn (10.237.8.131) To BJ-MBX05.mioffice.cn
 (10.237.8.125)

On Tue, Nov 04, 2025 at 02:15:44PM +0900, Greg Kroah-Hartman wrote:
> On Tue, Nov 04, 2025 at 11:49:46AM +0800, guhuinan wrote:
> > From: Owen Gu <guhuinan@xiaomi.com>
> > 
> > [ Upstream commit cfd6f1a7b42f ("usb: gadget: f_fs: Fix epfile null
> > pointer access after ep enable.") ]
> > 
> > A race condition occurs when ffs_func_eps_enable() runs concurrently
> > with ffs_data_reset(). The ffs_data_clear() called in ffs_data_reset()
> > sets ffs->epfiles to NULL before resetting ffs->eps_count to 0, leading
> > to a NULL pointer dereference when accessing epfile->ep in
> > ffs_func_eps_enable() after successful usb_ep_enable().
> > 
> > The ffs->epfiles pointer is set to NULL in both ffs_data_clear() and
> > ffs_data_close() functions, and its modification is protected by the
> > spinlock ffs->eps_lock. And the whole ffs_func_eps_enable() function
> > is also protected by ffs->eps_lock.
> > 
> > Thus, add NULL pointer handling for ffs->epfiles in the
> > ffs_func_eps_enable() function to fix issues
> > 
> > Signed-off-by: Owen Gu <guhuinan@xiaomi.com>
> > Link: https://lore.kernel.org/r/20250915092907.17802-1-guhuinan@xiaomi.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/gadget/function/f_fs.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> What about 6.17.y?  You do not want to upgrade from 6.12 to a newer
> kernel and have a regression.
> 
> And if this fixes a bug, why was it not marked with a Fixes: tag or a
>  cc: stable tag?  Did I just miss that before?
> 
> thanks,
> 
> greg k-h
Hi Greg KH,

I noticed that the patch for version 6.17.y has already been submitted:
 https://lore.kernel.org/all/20251025160905.3857885-311-sashal@kernel.org/

I apologize for forgetting to include the 'Fixes' tag in the previous
patch submission. Are there any corrective actions available now?
The fix reference is:
Fixes: ebe2b1add1055 ("usb: f_fs: Fix use-after-free for epfile")"

Thanks,
Owen

