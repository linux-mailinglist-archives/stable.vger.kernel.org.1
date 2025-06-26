Return-Path: <stable+bounces-158697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4331AEA1E4
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 17:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1C87B9F60
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE622EBDFA;
	Thu, 26 Jun 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h/yjG2dW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB22EBDC8;
	Thu, 26 Jun 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949846; cv=none; b=YsoGTW8NYPouongvolmjDmLaqiRUB8GP7B03nqnShafhf48pSlsc494DaI+jdyB6NAa8cLxIN7mMVHG2bmXDgMmL5WZpwsleSJVaha21xg9Cr9zkEzwXB8tWAqVTDOze+LNrbOX+m+79rOiQBST0jLvMmhgFJ02KlzejJq4/f18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949846; c=relaxed/simple;
	bh=DpQu293QtnkVCjW/dcgcoz5uwg7vQNBKK1Jw3JgSQ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzpBN+s0YtiXfhdS+QGcSIGjE+JTp9Sji5Zk2RHNRQ3yh2qd9TyKxdR+eu9I6hcqTMUz0JQp5aMNc7mNsVq8WYv9wld6c3AT8NZyJ3b5Wvp6X2qb7ylcByUiAfo+5dwLeukXpBvdAQGn9mvc8pv5kXGjZ5OdgRhB0vtdu+KP8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h/yjG2dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43249C4CEEB;
	Thu, 26 Jun 2025 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750949845;
	bh=DpQu293QtnkVCjW/dcgcoz5uwg7vQNBKK1Jw3JgSQ40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/yjG2dWFn9WJLfhtEMNsY4uEfjYEayQAJL4nbfuLyf0IEfVA+bsMr2naPrff9YRz
	 Qz0s6K8uKmFpUpVU0AmSQoOFAeH27b6xFGkUTBMAvZK21AdAQSCnNa2CWGoYWKyz+L
	 LamXjn3K8rm15iHh60tz+sPTgTVcYHzezZVx0GFA=
Date: Thu, 26 Jun 2025 15:57:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
	mcanal@igalia.com, arthurgrillo@riseup.net, mairacanal@riseup.net,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH] drm/vkms: Fix race-condition between the hrtimer and the
 atomic commit
Message-ID: <2025062607-hardener-splotchy-1e70@gregkh>
References: <20250626142243.19071-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626142243.19071-1-pranav.tyagi03@gmail.com>

On Thu, Jun 26, 2025 at 07:52:43PM +0530, Pranav Tyagi wrote:
> From: Maíra Canal <mcanal@igalia.com>
> 
> [ Upstream commit a0e6a017ab56936c0405fe914a793b241ed25ee0 ]
> 
> Currently, it is possible for the composer to be set as enabled and then
> as disabled without a proper call for the vkms_vblank_simulate(). This
> is problematic, because the driver would skip one CRC output, causing CRC
> tests to fail. Therefore, we need to make sure that, for each time the
> composer is set as enabled, a composer job is added to the queue.
> 
> In order to provide this guarantee, add a mutex that will lock before
> the composer is set as enabled and will unlock only after the composer
> job is added to the queue. This way, we can have a guarantee that the
> driver won't skip a CRC entry.
> 
> This race-condition is affecting the IGT test "writeback-check-output",
> making the test fail and also, leaking writeback framebuffers, as the
> writeback job is queued, but it is not signaled. This patch avoids both
> problems.
> 
> [v2]:
>     * Create a new mutex and keep the spinlock across the atomic commit in
>       order to avoid interrupts that could result in deadlocks.
> 
> [ Backport to 5.15: context cleanly applied with no semantic changes.
> Build-tested. ]

Did you forget about 6.1.y?

confused,

greg k-h

