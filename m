Return-Path: <stable+bounces-39407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2038A4CE4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726D41F2318E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569A5D48D;
	Mon, 15 Apr 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qt5fnyUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD85CDC0
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178164; cv=none; b=Sctce5amMBLxE9f9P9rbfM1r0DHgtPXT6AnXdid22Yjvr6Sx9z3IFD5INNoq81uwnujvYVieEhRTPzCWlqAy0y1RGXCJ0Z1/2cxDxnah8z9IXCkF0grfLR6SL4EfppZjwRASwy19jVkgpEFwCNyo23rYabtYzhomStl+yXZTkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178164; c=relaxed/simple;
	bh=0GezCsp3bPfFoZZlSyKP++mjHxnO4jUIrHRCIRYoVpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EksHZko2zoKrAbqdT53yswtebDE8fYMxOwcjefG5TFUjPdK5Bf+JsMScNUNilveLbta6npYSlTcSKqsHza5sSBpQVrU59D62DLqJNtXefNWNxFj8sluIZnDRspnACOVH4S1NUwjGnWt7MTT9PPOTDSk3TrzFSPja4TQpiWv8C/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qt5fnyUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1631C113CC;
	Mon, 15 Apr 2024 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713178163;
	bh=0GezCsp3bPfFoZZlSyKP++mjHxnO4jUIrHRCIRYoVpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt5fnyUEOSaBryq15SNOrlbN6AH2uALxKBnO6DppHm2a+XIuvsCCqcgT6zVvEQOUI
	 H1iHLQlcf8HWAMUsYQtaMMjcMbpnFSDikSCbK4Anl2A9JblLjIvxi/W+M+ko4OIqBi
	 cbiokdvPmFCaWpiGXBaHt+lc+5E01aEhqZT6AsfA=
Date: Mon, 15 Apr 2024 12:49:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: disable io-wq execution of
 multishot NOWAIT" failed to apply to 6.8-stable tree
Message-ID: <2024041512-small-buzz-8df0@gregkh>
References: <2024040826-handbrake-five-e04e@gregkh>
 <4d095453-00d6-471a-aafd-7586d94a76a7@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d095453-00d6-471a-aafd-7586d94a76a7@kernel.dk>

On Thu, Apr 11, 2024 at 10:28:54AM -0600, Jens Axboe wrote:
> On 4/8/24 3:11 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x bee1d5becdf5bf23d4ca0cd9c6b60bdf3c61d72b
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040826-handbrake-five-e04e@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
> 
> Here's the dependency and the patch itself backported, please add for
> 6.8. Thanks!

Both now queued up, thanks!

greg k-h

