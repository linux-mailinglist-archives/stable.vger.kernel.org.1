Return-Path: <stable+bounces-106290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A869B9FE727
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B281882DFF
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DDD1A7ADD;
	Mon, 30 Dec 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LLElhWVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7F9443;
	Mon, 30 Dec 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735569156; cv=none; b=Q5a47AVTTZlamO//08ZIXVcxgJB7QT7q3B8OgYEvSamFkb/wxP6+3dTy6ZLaM6x6pzmGaBmbbb52PU8JjhBOeAiPsmv+tHh9gQcfBNC9BcbwbDVbQ0MZH8eqioryRsXNKVUoP0wRGSXbfbvnx4YiUYk4jpaXq2r2h2vFEdCSqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735569156; c=relaxed/simple;
	bh=t5XEC/CDA35zr1PW/hTk0Mz6b1B/M7HAkbd6sfCglSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXDMbzITPYhOaJtqL7+b5wNWKWH5/zgVh+hDVHSUMgLLLVmSJUvvOS0eBQHehJ3TqhXgwBGEPIsawucZId6dqFcZgP2fqAUiEGMhz6mDx1cxU/QWe0gl/E4VJtapPUY/4xGgoNxuWoZPzt8eGkyZ9Z54MtfQ+Hi9SEN9hNbRioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLElhWVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEDC4CED4;
	Mon, 30 Dec 2024 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735569156;
	bh=t5XEC/CDA35zr1PW/hTk0Mz6b1B/M7HAkbd6sfCglSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLElhWVTeS7DvUMieVdtD259ND0DA1qsY2mUStD/chrS5/uzJeCpJpHk7piVhbk1v
	 Fin2UhFMlAuTSNCQlnMvQyipJnSIf47I6BVyL97Nw6m67U3uPbOoVt9w2PwV1Zy/lk
	 aWJ1V1vflz7ZkBuTaNt+tOsedYd81yHGN+VekRME=
Date: Mon, 30 Dec 2024 15:32:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	bt.cho@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: Patch "watchdog: s3c2410_wdt: add support for exynosautov920
 SoC" has been added to the 6.12-stable tree
Message-ID: <2024123026-ether-pushpin-a62e@gregkh>
References: <20241228142016.3647634-1-sashal@kernel.org>
 <c7f22382-5a75-475f-a851-621fab2d0b27@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f22382-5a75-475f-a851-621fab2d0b27@kernel.org>

On Sun, Dec 29, 2024 at 10:42:07AM +0100, Krzysztof Kozlowski wrote:
> On 28/12/2024 15:20, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     watchdog: s3c2410_wdt: add support for exynosautov920 SoC
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      watchdog-s3c2410_wdt-add-support-for-exynosautov920-.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This is a new device support, depending on several other pieces like
> syscon support, Exynos PMU and of course arm64/boot/dts patches. It
> really relies on the rest of SoC support and alone is useless.
> 
> This is way beyond simple quirks thus I believe it does not meet stable
> criteria at all.
> 
> Based on that I recommend to drop this patch from stable backports.

Now dropped, thanks.

greg k-h

