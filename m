Return-Path: <stable+bounces-19747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCA85345E
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53CBB21B84
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B35DF3A;
	Tue, 13 Feb 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HtggZqQk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DF5DF26
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836909; cv=none; b=aHrSIls2EYvkgVJ5cC81pMrXcSK2gPqgb3WwFHzUL3pzsJzvX4yz6sjrUao5NxbXEKShSAxSXCpzOBAwX9YeVTgGK4otT4ZV27d7r73PtXg9KBLazcQ0OwytFo/W+wAQ7FqiUlvVC7xmwV+YnVH+3oBB2c6YjYdVpfh90Af4qew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836909; c=relaxed/simple;
	bh=OPxMMtjQugwAgu91AmdtaTipRGRo1zSFcKF6GuWakpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTiPFUnYEI0Ii9Iina9SyrkXu25QL4WYquH5u+/Jw9WxuK80PSXHPPGlEbpcLgHB2MV+3/TNc93zSN1cTmqFQVjwkFDgVKSE8UPXfEg2PBHV3NVlJK1SLw0hvn+2F/Na0OacWNixzsPXYV3rW2BKhKZjlrsYw24qEeoWjSaeKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HtggZqQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120BEC433C7;
	Tue, 13 Feb 2024 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836908;
	bh=OPxMMtjQugwAgu91AmdtaTipRGRo1zSFcKF6GuWakpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtggZqQkqFAvnp3UW0nBLFN9r2zl68OuYyoAbFIWVSbBAUBsSNfCI+1d2ho5h88hV
	 6wUdbjPbRRyeq44kAuHo48Js9rJf9LJlyf3UT39bSqdibmKl5mwVOC8vVqmWJzwg8W
	 X3vdSbMezyhpntNZH8s7aMrar9VpbmmXDc7EtyNY=
Date: Tue, 13 Feb 2024 16:08:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: fix sr->len for
 IORING_OP_RECV with MSG_WAITALL" failed to apply to 5.15-stable tree
Message-ID: <2024021318-patriarch-slicing-6bd5@gregkh>
References: <2024021339-flick-facsimile-65c3@gregkh>
 <22be60b9-f51f-44e5-9568-55e31954daa7@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22be60b9-f51f-44e5-9568-55e31954daa7@kernel.dk>

On Tue, Feb 13, 2024 at 07:57:25AM -0700, Jens Axboe wrote:
> On 2/13/24 6:16 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 72bd80252feeb3bef8724230ee15d9f7ab541c6e
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021339-flick-facsimile-65c3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Turns out this issue doesn't exist in 5.10/5.15-stable, so you can ignore
> those two failures.

Great, thanks for letting us know.

greg k-h

