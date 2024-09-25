Return-Path: <stable+bounces-77065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440C985091
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17471F21C9D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08925336B;
	Wed, 25 Sep 2024 01:09:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D98DDA6
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.104.188.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727226589; cv=none; b=T7jsVHQG78VvYPhBrj56QngZfX5VUbMGvulpPkfVTSoSLis7JL3ZBXQ5WO8psk9O6zK2omBHSnA4N/QnV6lAPhA+WUaGaFiYbS1OWCP27Gz0l5IqYe4eK69GXrB4He9FDq0dLLT42FOAJeo77un7iAYx5rjSPSanMf+ENJAvX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727226589; c=relaxed/simple;
	bh=gmYT3Xhb1sy7FpiYtJile2lqEnWT1QUgxCz2yd0yloI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtzaYCp/Db7fL2RReIhq1/LDDLYrj911evsX9WBe9JpYOAzdaDTlKVXIv9hM1pjLMCVoIdrLJN6IO3GyqDlIvbZOGS+WGghUP1W9hlo+HDzI1WY201vMf+z6uO+0Bsz99HQ0DkgU3xpDtQFbdgmhRaJKzvdJC7OzYlK1qhR6dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com; spf=pass smtp.mailfrom=m5p.com; arc=none smtp.client-ip=74.104.188.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m5p.com
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
	by mailhost.m5p.com (8.18.1/8.17.1) with ESMTPS id 48P0mAe2019775
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 24 Sep 2024 20:48:15 -0400 (EDT)
	(envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
	by m5p.com (8.18.1/8.15.2/Submit) id 48P0m5gn019774;
	Tue, 24 Sep 2024 17:48:05 -0700 (PDT)
	(envelope-from ehem)
Date: Tue, 24 Sep 2024 17:48:05 -0700
From: Elliott Mitchell <ehem+xen@m5p.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
        Ariadne Conill <ariadne@ariadne.space>, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
Message-ID: <ZvNdxXCNu4Uc5gc_@mattapan.m5p.com>
References: <20240906184209.25423-1-ariadne@ariadne.space>
 <877cbnewib.wl-tiwai@suse.de>
 <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
 <Zt9UQJcYT58LtuRV@mattapan.m5p.com>
 <8734m77o7k.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734m77o7k.wl-tiwai@suse.de>

On Tue, Sep 10, 2024 at 01:17:03PM +0200, Takashi Iwai wrote:
> On Mon, 09 Sep 2024 22:02:08 +0200,
> Elliott Mitchell wrote:
> > 
> > On Sat, Sep 07, 2024 at 11:38:50AM +0100, Andrew Cooper wrote:
> > > 
> > > Individual subsystems ought not to know or care about XENPV; it's a
> > > layering violation.
> > > 
> > > If the main APIs don't behave properly, then it probably means we've got
> > > a bug at a lower level (e.g. Xen SWIOTLB is a constant source of fun)
> > > which is probably affecting other subsystems too.
> > 
> > This is a big problem.  Debian bug #988477 (https://bugs.debian.org/988477)
> > showed up in May 2021.  While some characteristics are quite different,
> > the time when it was first reported is similar to the above and it is
> > also likely a DMA bug with Xen.
> 
> Yes, some incompatible behavior has been seen on Xen wrt DMA buffer
> handling, as it seems.  But note that, in the case of above, it was
> triggered by the change in the sound driver side, hence we needed a
> quick workaround there.  The result was to move back to the old method
> for Xen in the end.
> 
> As already mentioned in another mail, the whole code was changed for
> 6.12, and the revert isn't applicable in anyway.
> 
> So I'm going to submit another patch to drop this Xen PV-specific
> workaround for 6.12.  The new code should work without the workaround
> (famous last words).  If the problem happens there, I'd rather leave
> it to Xen people ;)

I've seen that patch, but haven't seen any other activity related to
this sound problem.  I'm wondering whether the problem got fixed by
something else, there is activity on different lists I don't see, versus
no activity until Qubes OS discovers it is again broken.


An overview of the other bug which may or may not be the same as this
sound card bug:

Both reproductions of the RAID1 bug have been on systems with AMD
processors.  This may indicate this is distinct, but could also mean only
people who get AMD processors are wary enough of flash to bother with
RAID1 on flash devices.  Presently I suspect it is the latter, but not
very many people are bothering with RAID1 with flash.

Only systems with IOMMUv2 (full IOMMU, not merely GART) are effected.

Samsung SATA devices are severely effected.

Crucial/Micron NVMe devices are mildly effected.

Crucial/Micron SATA devices are uneffected.


Specifications for Samsung SATA and Crucial/Micron SATA devices are
fairly similar.  Similar IOps, similar bandwith capabilities.

Crucial/Micron NVMe devices have massively superior specifications to
the Samsung SATA devices.  Yet the Crucial/Micron NVMe devices are less
severely effected than the Samsung SATA devices.


This seems likely to be a latency issue.  Could be when commands are sent
to the Samsung SATA devices, they are fast enough to start executing them
before the IOMMU is ready.

This could match with the sound driver issue.  Since the sound hardware
is able to execute its first command with minimal latency, that is when
the problem occurs.  If the first command gets through, the second
command is likely executed with some delay and the IOMMU is reliably
ready.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445



