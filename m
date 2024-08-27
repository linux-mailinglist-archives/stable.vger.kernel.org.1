Return-Path: <stable+bounces-70340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5621B960A9A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA20FB20ADB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DE81B3B0F;
	Tue, 27 Aug 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DTumabjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827E19D8A9
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762245; cv=none; b=gKQw1aNXz/Ppnjms3ERi0z6zYWG7kq8rrHbQBWWjKdNXD8d3LlykRUspN77UhQmOpMq+zGh1O9z6dVeJXoPLBk2wykOBaPjeScqKnIKaDkj8kDL/pqXyTxNWqEf4aYXURPcVzr6baPpt9FD9kttLMXEdmta3gCXaTS+TVeQEDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762245; c=relaxed/simple;
	bh=vt5ZXD2hkLfV4bxt678rYoH6v1sFPWwpiQPY31g9zR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFr6crLlJHwc0sC4JEczJb60qxaLQXUcx5LyUEQEtSdCnkEYNB50kYzWYwf1jbFdmpazfvlwg7bcYhaffp9GyNxq4v/whiq3huyeuOTWVbaTPiylz9eexdF3HcX231chmjxcZDG/tqahPpzwkq2D9aPQ/Eb+6WcXjLUAQ3S+PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DTumabjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA02BC6106E;
	Tue, 27 Aug 2024 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762244;
	bh=vt5ZXD2hkLfV4bxt678rYoH6v1sFPWwpiQPY31g9zR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTumabjOZ7os/fapgIXH9CXfPG09mvad1C+QXltoPrA5YHtm7KWbNag9stYiWPz56
	 znPiPss1T/jJhrBAUbWBJGPkfTWi5r2p9aAjjMLs1bmgA5YOci58wL+Z4zehXc18kA
	 uoFYzkWnFa5W3s6czqdRF/MHHWt2Te3SHjxJvcpc=
Date: Tue, 27 Aug 2024 14:37:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v6.6.y] ALSA: timer: Relax start tick time check for
 slave timer elements
Message-ID: <2024082715-quickly-declared-749e@gregkh>
References: <20240819154754.7629-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819154754.7629-1-tiwai@suse.de>

On Mon, Aug 19, 2024 at 05:47:45PM +0200, Takashi Iwai wrote:
> commit ccbfcac05866ebe6eb3bc6d07b51d4ed4fcde436 upstream.
> 
> The recent addition of a sanity check for a too low start tick time
> seems breaking some applications that uses aloop with a certain slave
> timer setup.  They may have the initial resolution 0, hence it's
> treated as if it were a too low value.
> 
> Relax and skip the check for the slave timer instance for addressing
> the regression.
> 
> Fixes: 4a63bd179fa8 ("ALSA: timer: Set lower bound of start tick time")
> Cc: <stable@vger.kernel.org>
> Link: https://github.com/raspberrypi/linux/issues/6294
> Link: https://patch.msgid.link/20240810084833.10939-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Greg, this is a backport for 6.6.y and older stable kernels that failed
> to cherry-pick the original one.
> 

Now queued up, thanks.

greg k-h

