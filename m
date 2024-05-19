Return-Path: <stable+bounces-45420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243658C93C4
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 09:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AA6281758
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C0214006;
	Sun, 19 May 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q+2tvIxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6766AA7;
	Sun, 19 May 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105575; cv=none; b=kxrkLDWm99RAqAgv37+R2YlpqZiUbVen3BKtnTggLh9VRSJ0J2v9+NeBTZ2aQaPng20fnqFNUwqdiUkqiAv4nFxzVCQnwUYXzPSvrwM9Z5kVpeBQMWnZsUoxJ6p5GQlXv6eJ3Z6P91Tms42dLsAD8WeFIDMuAp/++SCaZZvdGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105575; c=relaxed/simple;
	bh=H/2+qHdYi7ZEH7Zr9/SLo5WPHWSoGzS8PBcfWjDh6Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuiTk81F/R8g82N23oq52ZPG1UuZ9kR9+GZuwJdu11gKmo94bDfcuPs9n6LmgowysKwHNRWtVbwvV7Xfu81D7GK2YQr+zKzBP7AucXk7/V4f0dPtO9oeVYNG1sFmqlikqgnpBMXz2edeN/cOoU9R9hYOHHsU+NloEdDR8M7ZMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q+2tvIxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A4FC32781;
	Sun, 19 May 2024 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716105575;
	bh=H/2+qHdYi7ZEH7Zr9/SLo5WPHWSoGzS8PBcfWjDh6Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+2tvIxpjbjvQNCxXWSJzFAJeeMCAvdCKktm2TtN70Zxn9KA+SXM7CaJRPaq/WpPl
	 IbyyFYOyMX8vooiPyAgSrFHyI9DSfvabTdmqdXmlpaS87pHIqmS4kUQO6IRUWyUr7Y
	 9b3oYYAIZC/B0s3437qH/UsmtvzKbdxc5YeUFnf0=
Date: Sun, 19 May 2024 09:59:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB
 on RK3066
Message-ID: <2024051907-extruding-overplant-54f1@gregkh>
References: <20240519074019.10424-1-val@packett.cool>
 <20240519074019.10424-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519074019.10424-2-val@packett.cool>

On Sun, May 19, 2024 at 04:31:32AM -0300, Val Packett wrote:
> Signed-off-by: Val Packett <val@packett.cool>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
>  1 file changed, 1 insertion(+)

Maybe the DRM subsystem has more lax rules, but I know I can't take
patches without any changelog text at all, sorry.

greg k-h

