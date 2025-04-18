Return-Path: <stable+bounces-134541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D280EA93501
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8124619E6C2D
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3263A9;
	Fri, 18 Apr 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGDGAwbz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81E26FA5A
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966808; cv=none; b=WoydXsUdxyWe0fzbdPVIqFVk/8396JUJKV035SmFFJYc+v32g2/j3DfnaW059FS79vyUaFVSYs1z+auZnrjvK9I2V7DF328c6LRRXy1sPOuYa/LJAzyQQ6rjvO9UTnE6RvY63ZhjFaPDISEjEO1PXn3nF8lhHJq2PG1jfEde1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966808; c=relaxed/simple;
	bh=RSlYFVc9jN6qvgy6kj80nshG+VS+ipaKqljtFD6ofl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRO9yj0nGadDAzDT/yNfiEmb83YmwjNfGn5+dw51Qhc/iexdf2DK0k948cNbeMvnshc331bRySVDmMQ005NGWyPRyvdpYjGvHCRldrv03//+AWcl1Ltxgpj4WIMTGyzyQlireadVrGM92G/DoRWyA5zeBfRVdOioXIvDF4LX6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGDGAwbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFE7C4CEE2;
	Fri, 18 Apr 2025 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744966807;
	bh=RSlYFVc9jN6qvgy6kj80nshG+VS+ipaKqljtFD6ofl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGDGAwbzDW6nXXYDAW/+YcA/psR2wqpn5GvRHbCR6K9anxUa3JcoamnZ9oIN460S3
	 RCaYta2WatNJtKBNN4LEbV8+W40DSWcGWP40TQqaiBSzSth7GEvMXq4uZwl8IAWNwp
	 rotHmiYaBQIgNMBLv7TCXfNynTtkt2V6IHu/c4bw=
Date: Fri, 18 Apr 2025 11:00:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: gnoack@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] landlock: Add the errata interface"
 failed to apply to 5.15-stable tree
Message-ID: <2025041840-gorged-salsa-eb3c@gregkh>
References: <2025041713-engine-energy-1f26@gregkh>
 <20250418.Queez5Eeng7v@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418.Queez5Eeng7v@digikod.net>

On Fri, Apr 18, 2025 at 10:40:08AM +0200, Mickaël Salaün wrote:
> Hi Greg,
> 
> On Thu, Apr 17, 2025 at 03:39:13PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 15383a0d63dbcd63dc7e8d9ec1bf3a0f7ebf64ac
> 
> Running this command works for me:
> 
>   $ git cherry-pick -x 15383a0d63dbcd63dc7e8d9ec1bf3a0f7ebf64ac
>   Auto-merging include/uapi/linux/landlock.h
>   Auto-merging security/landlock/setup.c
>   Auto-merging security/landlock/setup.h
>   Auto-merging security/landlock/syscalls.c
>   Auto-merging tools/testing/selftests/landlock/base_test.c
>   [linux-5.15.y e2b5baf61146] landlock: Add the errata interface
>    Date: Tue Mar 18 17:14:37 2025 +0100
>    6 files changed, 185 insertions(+), 5 deletions(-)
>    create mode 100644 security/landlock/errata.h
> 
>   $ git version # without custom .gitconfig
>   git version 2.49.0
> 
> I previously tested and validated this approach that produces a working
> commit.
> 
> However, trying to apply the raw patch does not work:
> 
>   $ git apply this.patch
>   error: patch failed: security/landlock/setup.c:6
>   error: security/landlock/setup.c: patch does not apply
>   error: patch failed: security/landlock/setup.h:11
>   error: security/landlock/setup.h: patch does not apply
>   error: patch failed: security/landlock/syscalls.c:169
>   error: security/landlock/syscalls.c: patch does not apply
> 
> This is the case for these stable trees: 5.15, 6.1, and 6.6
> 
> Could you please use Git to cherry-pick this commit on these 3 trees?

Sorry, but we don't use git cherry-pick, we need them in patch form.

thanks,

greg k-h

