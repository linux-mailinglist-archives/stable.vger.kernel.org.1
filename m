Return-Path: <stable+bounces-74124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F351972ADF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBF1F23B42
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611717C9EB;
	Tue, 10 Sep 2024 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IJ3tyDmd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C4282E2
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953659; cv=none; b=Pq8pIKtDd+lUGBY3xlc3vVjW9v1Dg4sT9qjn4s5eA4Qfd3GyQy5sQOVmj96rkV0OgBuWut7BZK4DjUQgjgYzFqPOU5stkIe/AszGJ9jSZfTp5qrdKqcSK23H4dTiIunbOEWs9y/7lxmBirkEMqU1uYzxVSNHX1Oc7B3H39nNSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953659; c=relaxed/simple;
	bh=YHXDyjbJVI5G6YbuP+a1bt1G5PiyMEYzg/1hPQqsvP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNqC94mrBp7B4N8qteiD/0AjKA0K3PTMVIL7GMfrFiZxRrMvGHq/KWwjT1N8BjUhrzdMEYhUMCAm9KqvRCJvBxFmsVucDltqixAVH789/rvAvZa4BWGCUOyFeUmwQdrlZn9lrSRz0EA3itC5pgYGUx57dCKMLOXnBap2U74kwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IJ3tyDmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C56C4CEC3;
	Tue, 10 Sep 2024 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725953659;
	bh=YHXDyjbJVI5G6YbuP+a1bt1G5PiyMEYzg/1hPQqsvP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJ3tyDmdvtXSVFqsGYrfkNM++/7IyV40k0HZYEHtkjlC9MDJz1h2bLGKgnoT1UATP
	 7xwUihtiKPQ/kLOsnGni05FBq3f1aAgfED87vvRPWFkn2PVyQAbEiJYDjvKKYk6C21
	 SSNEtfxEbT4GsZmx70xVmBqy7qKLPBa6tYkF5+N8=
Date: Tue, 10 Sep 2024 09:34:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mu001999@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y, 5.4.y, 4.19.y] rtmutex: Drop rt_mutex::wait_lock
 before scheduling
Message-ID: <2024091010-mummified-shorty-9ed0@gregkh>
References: <2024090850-nuclear-radar-ea2b@gregkh>
 <87jzflcpwv.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzflcpwv.ffs@tglx>

On Mon, Sep 09, 2024 at 08:16:48AM +0200, Thomas Gleixner wrote:
> 
> From: Roland Xu <mu001999@outlook.com>
> 
> commit d33d26036a0274b472299d7dcdaa5fb34329f91b upstream.
> 
> rt_mutex_handle_deadlock() is called with rt_mutex::wait_lock held.  In the
> good case it returns with the lock held and in the deadlock case it emits a
> warning and goes into an endless scheduling loop with the lock held, which
> triggers the 'scheduling in atomic' warning.
> 
> Unlock rt_mutex::wait_lock in the dead lock case before issuing the warning
> and dropping into the schedule for ever loop.
> 
> [ tglx: Moved unlock before the WARN(), removed the pointless comment,
>   	massaged changelog, added Fixes tag ]
> 
> Fixes: 3d5c9340d194 ("rtmutex: Handle deadlock detection smarter")
> Signed-off-by: Roland Xu <mu001999@outlook.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/ME0P300MB063599BEF0743B8FA339C2CECC802@ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM
> ---
> Backport to 5.10.y, 5.4.y, 4.19.y

Now queued up, thanks!

greg k-h

