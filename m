Return-Path: <stable+bounces-57924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D79261B0
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34D21C22ABE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2017A926;
	Wed,  3 Jul 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lWtcybac"
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D017A599;
	Wed,  3 Jul 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012827; cv=none; b=npmMcTxlGi+LalGU8JdYqqiHYynCiSqc15YR46zbxZ9TDzivNsIohNX24jsuPMEw6X1CTB2cPq5Wc6SSPKhABW8heic8mpSfI3kslEIUSzcdjV7q3Fsp57dNaj0ppD05yTCpbb+nvDRFMrdzAmYg4ODojpW+bI3B4b0SxtwSkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012827; c=relaxed/simple;
	bh=NRq1qfIgPD2u6cT1j0/APC2DPBFEetcouNuEPTEwhUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cv3osDOH+5HimqMxzjDpAF0uferI3h7QYIf1BOJ8JbnVdzCg0L6FrdxBeSYc7Va3190hB+9wcsgo6iiPYh+pshzAP/0LUrjvdtOwLfUYY4ydJlrllSQ9nznnjegZ3WcAYTJ4QB25Agy2YjLqz8D5xrTjF2LQCdVWdy1OvbwyzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lWtcybac; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720012820;
	bh=NRq1qfIgPD2u6cT1j0/APC2DPBFEetcouNuEPTEwhUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWtcybac9l6OiKGnk1TexKAJwT11/vMjxjrrT8bvwImiov5gDBLydrks1t5+GgQJm
	 aZ4As9mJUiaZlAE1fHwLLRscVlC/UqzVIVynMCrzkQioRYOGIVrjiJ7PnDic5n25ZQ
	 FsWlRrOL3yLos/tn3E2cahdm+BUJVcpvOv/ACIi+1zzaR8SzWoGoa1zoGMIOUwWtBp
	 2fh+6pZTQ7euct9iiN0sb2posIhFEqFnWUdwq3jcEoVrPHicMpYz5BAF8KrI4c0UCV
	 PSTPekzeCpL4SDJ177NBDDUHb+bECJOwXYkOygbe5P1ut5fIev5kkBjNFkeYLSXuTk
	 0R1uAqD1Oqcvw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3120378209B;
	Wed,  3 Jul 2024 13:20:19 +0000 (UTC)
Date: Wed, 3 Jul 2024 15:20:18 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org, Diederik
 de Haas <didi.debian@cknow.org>, Furkan Kardame <f.kardame@manjaro.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Mark simple_ondemand governor as softdep
Message-ID: <20240703152018.02e4e461@collabora.com>
In-Reply-To: <f672e7460c92bc9e0c195804f7e99d0b@manjaro.org>
References: <4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org>
	<f672e7460c92bc9e0c195804f7e99d0b@manjaro.org>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jul 2024 14:42:37 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> Hello everyone,
> 
> On 2024-06-17 22:17, Dragan Simic wrote:
> > Panfrost DRM driver uses devfreq to perform DVFS, while using 
> > simple_ondemand
> > devfreq governor by default.  This causes driver initialization to fail 
> > on
> > boot when simple_ondemand governor isn't built into the kernel 
> > statically,
> > as a result of the missing module dependency and, consequently, the 
> > required
> > governor module not being included in the initial ramdisk.  Thus, let's 
> > mark
> > simple_ondemand governor as a softdep for Panfrost, to have its kernel 
> > module
> > included in the initial ramdisk.
> > 
> > This is a rather longstanding issue that has forced distributions to 
> > build
> > devfreq governors statically into their kernels, [1][2] or has forced 
> > users
> > to introduce some unnecessary workarounds. [3]
> > 
> > For future reference, not having support for the simple_ondemand 
> > governor in
> > the initial ramdisk produces errors in the kernel log similar to these 
> > below,
> > which were taken from a Pine64 RockPro64:
> > 
> >   panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init [panfrost]]
> > *ERROR* Couldn't initialize GPU devfreq
> >   panfrost ff9a0000.gpu: Fatal error during GPU init
> >   panfrost: probe of ff9a0000.gpu failed with error -22
> > 
> > Having simple_ondemand marked as a softdep for Panfrost may not resolve 
> > this
> > issue for all Linux distributions.  In particular, it will remain 
> > unresolved
> > for the distributions whose utilities for the initial ramdisk 
> > generation do
> > not handle the available softdep information [4] properly yet.  
> > However, some
> > Linux distributions already handle softdeps properly while generating 
> > their
> > initial ramdisks, [5] and this is a prerequisite step in the right 
> > direction
> > for the distributions that don't handle them properly yet.
> > 
> > [1] 
> > https://gitlab.manjaro.org/manjaro-arm/packages/core/linux/-/blob/linux61/config?ref_type=heads#L8180
> > [2] https://salsa.debian.org/kernel-team/linux/-/merge_requests/1066
> > [3] https://forum.pine64.org/showthread.php?tid=15458
> > [4] 
> > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=49d8e0b59052999de577ab732b719cfbeb89504d
> > [5] 
> > https://github.com/archlinux/mkinitcpio/commit/97ac4d37aae084a050be512f6d8f4489054668ad
> > 
> > Cc: Diederik de Haas <didi.debian@cknow.org>
> > Cc: Furkan Kardame <f.kardame@manjaro.org>
> > Cc: stable@vger.kernel.org
> > Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>  
> 
> Just checking, could this patch be accepted, please?

Yes, sorry for the delay. Here's my

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Steve, any objection?

> The Lima 
> counterpart
> has already been accepted. [6]
> 
> The approach in this patch is far from perfect, but it's still fine 
> until
> there's a better solution, such as harddeps.  I'll continue my research
> about the possibility for introducing harddeps, which would hopefully
> replace quite a few instances of the softdep (ab)use that already extend
> rather far.  For example, have a look at the commit d5178578bcd4 (btrfs:
> directly call into crypto framework for checksumming) [7] and the lines
> containing MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [8]
> 
> If a filesystem driver can rely on the (ab)use of softdeps, which may be
> fragile or seen as a bit wrong, I think we can follow the same approach,
> at least until a better solution is available.
> 
> [6] 
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0c94f58cef319ad054fd909b3bf4b7d09c03e11c
> [7] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5178578bcd4
> [8] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/super.c#n2593
> 
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index ef9f6c0716d5..149737d7a07e 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -828,3 +828,4 @@ module_platform_driver(panfrost_driver);
> >  MODULE_AUTHOR("Panfrost Project Developers");
> >  MODULE_DESCRIPTION("Panfrost DRM Driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_SOFTDEP("pre: governor_simpleondemand");  


