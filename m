Return-Path: <stable+bounces-16425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919C840B22
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87761B26EAC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30B155A5D;
	Mon, 29 Jan 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kKX6THEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBA155A57;
	Mon, 29 Jan 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545116; cv=none; b=gKHoUq3hVVdVIgPxl5Y1Z5SfLvK5kZOMTnmeOECQSXoDm4WCAPC8G03hH3Yzqv4Rm02rd7Wh/heYUKJKIscaztix5IocvhH2dqORYjFIA9azrsxbAmnZYQnx8KQYjEqvBL6YLUkrwc0dSoTOdq75tW0WpGHvQMkR9RzLRSu73wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545116; c=relaxed/simple;
	bh=nOB10xYZrV+PiFOQMdDmiDQG6/6o2auBVDVT16MLekA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBTiq5FNJlPxrx01DMlHBaF20l8z5pdy/xvyUQUxlc+9pi9Kh4JE1dHcY4/N1u0l5jN6iKGBhPdCWeFTNNhtckHaJbliHh2Erb3h4a81Qlnp7oP3VO8p88F0fY0Y7mt9/oNMNSiiZt3N4x+MOAl2+skZIha2wzbTniF4hoj5+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kKX6THEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE66BC433F1;
	Mon, 29 Jan 2024 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706545115;
	bh=nOB10xYZrV+PiFOQMdDmiDQG6/6o2auBVDVT16MLekA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKX6THEwtNjv0HzzEdOoHqdYLF8BDliGT8sVgvWTgLwKR1rZMRyMDoZ3GnMZDPIYy
	 0hu2OzldvJ1S3/qxUOb25er74gtquJVq/3uiSt49eFvfKvenFyGi2jrzTuOin//qhK
	 +hOopY9ziOo3X2elpe6m7h8VT1VRfSW3pipwBnAI=
Date: Mon, 29 Jan 2024 08:18:35 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "driver core: Annotate dev_err_probe() with __must_check"
 has been added to the 4.19-stable tree
Message-ID: <2024012909-slit-heaviness-a5ef@gregkh>
References: <2024012619-spider-attempt-7896@gregkh>
 <ZbZZIGcUSOK8pPSQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbZZIGcUSOK8pPSQ@smile.fi.intel.com>

On Sun, Jan 28, 2024 at 03:39:44PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 26, 2024 at 05:33:20PM -0800, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     driver core: Annotate dev_err_probe() with __must_check
> > 
> > to the 4.19-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      driver-core-annotate-dev_err_probe-with-__must_check.patch
> > and it can be found in the queue-4.19 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> But it got reverted, no need to have it in any stable kernels.

Thanks for reminding me, I hadn't run the "find the fixes for commits in
the queue" script yet, that just got caught and I've queued it up now.

greg k-h

