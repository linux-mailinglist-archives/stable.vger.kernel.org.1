Return-Path: <stable+bounces-39412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5991E8A4D80
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880DB1C21352
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14365D74E;
	Mon, 15 Apr 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsZFawOv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE55C90F
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179919; cv=none; b=FYksA0IBpnBG0fhKkFDczR/9iqCLMF6Z02uc8H1+bxt9keU4jDYwKZKrp/VwgHwQYANrat3vQa9Eq+lzQ1Kvfjp+aZvJ+ve5RqACCV4kkSQ6TSZgNNaziar/pRI8LF5rmQI+dWvB5w8qO7vYKgciIqZaIqtRIz5cssFuvegFzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179919; c=relaxed/simple;
	bh=RhtzfOjTWtprf6ipq2m0z/TR+9nGxsV9hJoFABwMEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byURmg8DIFMOm2gPgRKuNBaJlwbPELnPs4kki1sACQOqsjCTXwnVfrIWAXiAJooRgxXkZjuEtBTwXlOPVBAR3Lu+Wb/naMF2oHMjHhnRWcgELx6aKYIBgipWAHryXvq1TrVFEDBg9T62pMs3KaT8P5MoNvqJ9miA8IrjfEWlqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsZFawOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2160C113CC;
	Mon, 15 Apr 2024 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713179919;
	bh=RhtzfOjTWtprf6ipq2m0z/TR+9nGxsV9hJoFABwMEF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsZFawOv0TYX+R35qBmvnPV/vB1RO/bZR3P9+nbwqWPt542UPkkBt03ScngqKI+Te
	 fo3SRgnPKZAwm+VlkA8JlHygmDb4GvTzAv03Ebowrg/eKkYguzCd8isxGnpRMFsVOi
	 WSuiorqjVHXNAxSuXbKX+ZYygeiiXQD+yZc8bQ/A=
Date: Mon, 15 Apr 2024 13:18:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc: Daisuke Mizobuchi <mizo@atmark-techno.com>, stable@vger.kernel.org,
	Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 5.10.y 1/1] mailbox: imx: fix suspend failue
Message-ID: <2024041523-fiscally-unending-4c47@gregkh>
References: <20240412052133.1805029-1-mizo@atmark-techno.com>
 <ZhjK-nJQKVr5RcgZ@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhjK-nJQKVr5RcgZ@atmark-techno.com>

On Fri, Apr 12, 2024 at 02:47:38PM +0900, Dominique MARTINET wrote:
> Added in Cc everyone concerned by the patch as per the broken backport:
> https://lore.kernel.org/stable/20220405070315.416940927@linuxfoundation.org/
> 
> Daisuke Mizobuchi wrote on Fri, Apr 12, 2024 at 02:21:33PM +0900:
> >Subject: Re: [PATCH 5.10.y 1/1] mailbox: imx: fix suspend failue
> 
> failue -> failure
> 
> >
> > When an interrupt occurs, it always wakes up.
> 
> (nitpick: this isn't really clear: "imx_mu_isr() always calls
> pm_system_wakeup() even when it should not, making the system unable to
> enter sleep" ?)
> 
> > Suspend fails as follows:
> >  armadillo:~# echo mem > /sys/power/state
> >  [ 2614.602432] PM: suspend entry (deep)
> >  [ 2614.610640] Filesystems sync: 0.004 seconds
> >  [ 2614.618016] Freezing user space processes ... (elapsed 0.001 seconds) done.
> >  [ 2614.626555] OOM killer disabled.
> >  [ 2614.629792] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> >  [ 2614.638456] printk: Suspending console(s) (use no_console_suspend to debug)
> >  [ 2614.649504] PM: Some devices failed to suspend, or early wake event detected
> >  [ 2614.730103] PM: resume devices took 0.080 seconds
> >  [ 2614.741924] OOM killer enabled.
> >  [ 2614.745073] Restarting tasks ... done.
> >  [ 2614.754532] PM: suspend exit
> >  ash: write error: Resource busy
> >  armadillo:~#
> > 
> > Upstream is correct, so it seems to be a mistake in cheery-pick.
> 
> cheery-pick -> cherry-pick
> 
> (This is a trivial lookup away but might as well name upstream's commit
> e.g. "Upstream commit 892cb524ae8a is correct, so this seems to be a
> mistake during cherry-pick")
> 
> > Cc: <stable@vger.kernel.org>
> > Fixes: a16f5ae8ade1 ("mailbox: imx: fix wakeup failure from freeze mode")
> > Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
> 
> These typos aside I've confirmed the resulting code matches' upstream's:
> Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> The backport in 5.15 also seems correct and does not need this, and
> there does not seem to be any older backport either that need fixing, so
> 5.10 is the only branch that requires fixing.

Thanks for the review, now queued up.

greg k-h

