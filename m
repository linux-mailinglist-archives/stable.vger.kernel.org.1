Return-Path: <stable+bounces-45586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFD68CC47C
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4091C20D75
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2B722EEF;
	Wed, 22 May 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzCH5zDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CEB101EC
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393046; cv=none; b=OM1f8oinJnB7GvBYI1bbnPkyT6pY5ne1j5+ddi3cf9EHBJ1n2187kPD1Y/IEwTPSMrkYVRTJaVjfzEW0A+P9erSe18kV09ZOGFntb/Nu4V7Qm+PmYZ8+Q7aPjYEBs3OATmDRydXoscEEwH3eOIAfklwAqMa+ifXOJ3qsRvDDfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393046; c=relaxed/simple;
	bh=C3tkeMLZXJD7ZKTFfALxat7fMjgmAdf0FyaIZXBI3kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNr2GGAKgDDUHlk0nGXDV5zyJkUF0+WE+sO+zMU1v8QiIv7Gncz6i+Omli7c2veQh1EOCmY4QAhRaiwP5+IwL0zg6EB29NpjtmwEmctZXnQeLvYXlh35ATfDRRlMcVDTQuv4V8mm5ucHpU0rH2fsFHStJhSJ2dRFQq+jAmJ+LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzCH5zDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D483AC2BBFC;
	Wed, 22 May 2024 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716393046;
	bh=C3tkeMLZXJD7ZKTFfALxat7fMjgmAdf0FyaIZXBI3kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzCH5zDIMi81+rGJumUH8ZoRGAA+8fEHTpx5rWG5rnePMryEXocEsLzUMGyyZQRGa
	 lswTRbByZEznjz7sXKLXbCurdlSdwlVvinV+NQfC6RkfoGzvAXqQ2S7/8oPU1Jhxsv
	 /k74YdPK/EXYvjrggayTUkvPLAf9Tks3Ec0kpbeg=
Date: Wed, 22 May 2024 17:50:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5.15.y] nfsd: don't allow nfsd threads to be signalled.
Message-ID: <2024052217-unguarded-cardinal-a639@gregkh>
References: <20240503170000.752108-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503170000.752108-1-cel@kernel.org>

On Fri, May 03, 2024 at 01:00:00PM -0400, cel@kernel.org wrote:
> From: NeilBrown <neilb@suse.de>
> 
> [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
> 
> The original implementation of nfsd used signals to stop threads during
> shutdown.
> In Linux 2.3.46pre5 nfsd gained the ability to shutdown threads
> internally it if was asked to run "0" threads.  After this user-space
> transitioned to using "rpc.nfsd 0" to stop nfsd and sending signals to
> threads was no longer an important part of the API.
> 
> In commit 3ebdbe5203a8 ("SUNRPC: discard svo_setup and rename
> svc_set_num_threads_sync()") (v5.17-rc1~75^2~41) we finally removed the
> use of signals for stopping threads, using kthread_stop() instead.
> 
> This patch makes the "obvious" next step and removes the ability to
> signal nfsd threads - or any svc threads.  nfsd stops allowing signals
> and we don't check for their delivery any more.
> 
> This will allow for some simplification in later patches.
> 
> A change worth noting is in nfsd4_ssc_setup_dul().  There was previously
> a signal_pending() check which would only succeed when the thread was
> being shut down.  It should really have tested kthread_should_stop() as
> well.  Now it just does the latter, not the former.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/callback.c     |  9 +--------
>  fs/nfsd/nfs4proc.c    |  5 ++---
>  fs/nfsd/nfssvc.c      | 12 ------------
>  net/sunrpc/svc_xprt.c | 16 ++++++----------
>  4 files changed, 9 insertions(+), 33 deletions(-)

Looks like a clean cherry-pick, right?

Also applied to 6.1.y as we can't have regressions when moving forward.

thanks,

greg k-h

