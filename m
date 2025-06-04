Return-Path: <stable+bounces-151331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F3DACDC29
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15868189929C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D428D8C4;
	Wed,  4 Jun 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwt2UIhb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412828C5B6;
	Wed,  4 Jun 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034279; cv=none; b=ba6c1j6IKGuZX0+dOa7+WBasW1E34WnqJ2P5WtRGaoaYuUmQE/ZdWPh/B0Q5wFPx0QC8q1qB5ftkbplSFd5AYAU3uKbM+Y1WREZ3BjNyunK/aN0rFpP43EA59xSJPkA++BmlJRZtH/mmRKiBsKiI958e8ZlfjWgQOQhwoLOKjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034279; c=relaxed/simple;
	bh=UCEfnjbgjemB7iS4saU8V8U10oXHF3AzXkN2nknaRYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkLX+0WxxAwW/oxLaFXG72iRmXGK43OP9pgn8lSm664LceCJ5Ok4shjHWhRnIyX2WU9BmA9KuWXRBng7fNkwoARZomwgJYgkl7CvQXvWJiDrLez0ryQ4Litukt84kzsQSGgTMTQjZ0W6nVJbWqX6VbKmIZqA/pS1vI9olsGQr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwt2UIhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FF2C4CEE7;
	Wed,  4 Jun 2025 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749034279;
	bh=UCEfnjbgjemB7iS4saU8V8U10oXHF3AzXkN2nknaRYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwt2UIhbRd8AU4xNki733+dLh8FsjWptGhN9vrPhQXVx1FGbPApH6zUYi6TyEQGM9
	 l01qXdVdepzevbXPjjmhKPI5MJL3jNamFtTurnd8oUNmx3bvZIBo9CthMbYkUxMXE4
	 tSl1oCwfUOinlJnJmdNVs2UAznZrSY0WFFqabbJJoHbT5Tf/ayGVSZijLo8mSmIVBA
	 A3wSuAUYsTFmIu4BAqalR9NqmNR1O4he5PLGHX9F+sEiSFVa+TqFp7aK2LJUSWAW2X
	 lfjaG0jkbMUowyIB8nOfQRTjGmuAPhlSVGRfQf8hU/oE3nK10gYPnlWgiO0orPMnvX
	 pWsmehfU6X4lg==
Date: Wed, 4 Jun 2025 10:51:16 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Zsolt Kajtar <soci@c64.rulez.org>, stable@vger.kernel.org
Subject: Re: [PATCH] sysfb: Fix screen_info type check for VGA
Message-ID: <aEAlJMrX8VfkkVaI@google.com>
References: <20250603154838.401882-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603154838.401882-1-tzimmermann@suse.de>

On Tue, Jun 03, 2025 at 05:48:20PM +0200, Thomas Zimmermann wrote:
> Use the helper screen_info_video_type() to get the framebuffer
> type from struct screen_info. Handle supported values in sorted
> switch statement.
> 
> Reading orig_video_isVGA is unreliable. On most systems it is a
> VIDEO_TYPE_ constant. On some systems with VGA it is simply set
> to 1 to signal the presence of a VGA output. See vga_probe() for
> an example. Retrieving the screen_info type with the helper
> screen_info_video_type() detects these cases and returns the
> appropriate VIDEO_TYPE_ constant. For VGA, sysfb creates a device
> named "vga-framebuffer".
> 
> The sysfb code has been taken from vga16fb, where it likely didn't
> work correctly either. With this bugfix applied, vga16fb loads for
> compatible vga-framebuffer devices.
> 
> Fixes: 0db5b61e0dc0 ("fbdev/vga16fb: Create EGA/VGA devices in sysfb code")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
> Cc: Zsolt Kajtar <soci@c64.rulez.org>
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

