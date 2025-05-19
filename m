Return-Path: <stable+bounces-144865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4570ABBFF8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2747B1B649FD
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF72797AD;
	Mon, 19 May 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mYU08EI6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4127D78A
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662794; cv=none; b=jERrqX58+cGCpyKV8Vij9XiS2EUo0tyuqUbYGTElCWZ/HZdgBrAThjmIZIZp2yczprKI1CSFFrStzyJWRIMw/Nx6Eb7SSDL/XtREZrXZ8u0eqsgfzMWQUF5fQ16cmoXdxIVk0f33TLZxVEmgMC6JP32qiSdDEN0VeKF1uMECPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662794; c=relaxed/simple;
	bh=Ek23+N3I7H6qF61nRu2GFsw5raUKTXdOJR0gLVSmuQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B948NSeHw/NJ6UO4xSS3Ju+aHWgaRPn4KjoBiqKKsxzc0dppGGxCeytLnza5GMNiDxiL1h2LkLfY2jkNpUg0e3kxQmTjrqUI6sKd0+q6nZ1G9icPBHDCyWoCSqPECJRK9trSjwkAWAYbcgyJ4EZk1j/HzgTukxBTn9AgLxsiHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mYU08EI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAAAC4CEE4;
	Mon, 19 May 2025 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747662794;
	bh=Ek23+N3I7H6qF61nRu2GFsw5raUKTXdOJR0gLVSmuQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYU08EI6Qx0g5/HoDs50A5XmKEEu7Bz3zk2nQaCcyDdpYE+/4dYqkEopCVc8Lpgzd
	 /O8jw2/nbQQw4LN56kuMP1bjyZhRlddi7wXAd0R+hO8bpk0lFUl6ycmLB09M1tn1RS
	 ObKSrjpCrUfCGW5FF8OkE5bongzVrxY0R1qxiDBk=
Date: Mon, 19 May 2025 15:53:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@denx.de>
Cc: javierm@redhat.com, tzimmermann@suse.de, stable@vger.kernel.org,
	festevam@gmail.com
Subject: Re: FAILED: patch "[PATCH] drm/tiny: panel-mipi-dbi: Use
 drm_client_setup_with_fourcc()" failed to apply to 6.12-stable tree
Message-ID: <2025051942-glamour-overrule-508c@gregkh>
References: <2025051936-qualify-waged-4677@gregkh>
 <136-682b3480-1-3097af80@2841359>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <136-682b3480-1-3097af80@2841359>

On Mon, May 19, 2025 at 03:38:23PM +0200, Fabio Estevam wrote:
> Hi Greg and Thomas,
> 
> On Monday, May 19, 2025 09:00 -03, <gregkh@linuxfoundation.org> wrote:
> 
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051936-qualify-waged-4677@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Locally,  I am running 6.12 with these two extra dependencies applied:
> 
> commit 8998eedda2539d2528cfebdc7c17eed0ad35b714
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Tue Sep 24 09:12:03 2024 +0200
> 
>     drm/fbdev-dma: Support struct drm_driver.fbdev_probe
>     
>     Rework fbdev probing to support fbdev_probe in struct drm_driver
>     and reimplement the old fb_probe callback on top of it. Provide an
>     initializer macro for struct drm_driver that sets the callback
>     according to the kernel configuration.
>     
>     This change allows the common fbdev client to run on top of DMA-
>     based DRM drivers.
>     
>     Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>     Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-6-tzimmermann@suse.de
> 
> 
> commit 1b0caa5f5ac20bcaf82fc89a5c849b21ce3bfdf6
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Tue Sep 24 09:12:29 2024 +0200
> 
>     drm/panel-mipi-dbi: Run DRM default client setup
>     
>     Call drm_client_setup() to run the kernel's default client setup
>     for DRM. Set fbdev_probe in struct drm_driver, so that the client
>     setup can start the common fbdev client.
>     
>     v5:
>     - select DRM_CLIENT_SELECTION
>     
>     Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>     Cc: "Noralf Trønnes" <noralf@tronnes.org>
>     Acked-by: Noralf Trønnes <noralf@tronnes.org>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-32-tzimmermann@suse.de
> 
> I have only tested panel-mipi-dbi (the only display available on the board I use). I am unsure if applying these extra patches to linux-6.12 stable is safe or if they could cause issues with other fbdev drivers.

Can you send these as a patch series for us to consider applying?

thanks,

greg k-h

