Return-Path: <stable+bounces-45407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28028C8F94
	for <lists+stable@lfdr.de>; Sat, 18 May 2024 06:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C70B216D8
	for <lists+stable@lfdr.de>; Sat, 18 May 2024 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43306FB0;
	Sat, 18 May 2024 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LeBVXADE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB31A2C03
	for <stable@vger.kernel.org>; Sat, 18 May 2024 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716005979; cv=none; b=atyD0TvLUbIyHpX6B6iZndUEk74xf5qCRFwpaedDImzO0Bd4ZsgX5Mcfu0Kv9q0JLKrOBQJ76ocIsLzOB0nVf2G/P3Bi/kt/FqvUUROEpV6wbNmNtrZsGs6sh0ZeF8Odpzcls+cfkeeNOb28Pw84fBkULY5P1Yl2w4TP4xJJwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716005979; c=relaxed/simple;
	bh=wzpt2PPuWVBlqdNpDvsBs4gZXh1Nhr8wMHjdxtKWEJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkpBzyEOEkoOzSQndRkOSJ+Xm6H2NvLK6ziHHVasDT8QDtbrfI0nGHRlQvjYU7MsRmAFBULmW2l+10ZQn983EPnDymmnOL268Mhtnj3IACPc8DRWXSNSwrP07/y5uLK3vup1eRsbCTgFP388enSIUE6tT6vAYUHx9LMw7BdFIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LeBVXADE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546C4C113CC;
	Sat, 18 May 2024 04:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716005978;
	bh=wzpt2PPuWVBlqdNpDvsBs4gZXh1Nhr8wMHjdxtKWEJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeBVXADEwf2WxDN/QAnfGK8DcNYW0Lyl05tEVQT5HWCpFz0uKsqSaN7pZzqRExE1s
	 lZ/E9Zz4QS3wSyxTFHtNPHNvNI3Yw3/+eoFarjbOxzvmDelDXm6/RI9f4JiSNceyum
	 j18Mey3YnYvc6QJOpkQwTay7FC82ktx61oYYKSh4=
Date: Sat, 18 May 2024 06:19:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	chuck.lever@oracle.com, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 5.15] nfsd: don't allow nfsd threads to be signalled.
Message-ID: <2024051859-fossil-exposable-722d@gregkh>
References: <20240517175930.365694-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517175930.365694-1-cel@kernel.org>

On Fri, May 17, 2024 at 01:59:30PM -0400, cel@kernel.org wrote:
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
> 
> Greg, Sasha - This is the third resend for this fix. Why isn't it
> applied to origin/linux-5.15.y yet?

I only see one previous send, where is the second?

Anyway, we are working to catch up, there's been a few hundred other
commits that were also needed :)

thanks,

greg k-h

