Return-Path: <stable+bounces-74085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6B97236B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 22:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF62C1C21C94
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71AA18A6BD;
	Mon,  9 Sep 2024 20:16:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2813B2B0
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.104.188.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912987; cv=none; b=E4iJY9rLbfBulAjGwyzDnhmxsyRvobGdTIvlakjnWW6IWXPdKKeK5bRO44Wxj54ENriCJM7TK1BLvecxDTUn4WureLS/4OmsQpisx+JmkKPNNmZw/2+FGASouVIPcL1JDD2JFLHocU6hACE21W3lMq9dUjmlyoMd1GJloThQP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912987; c=relaxed/simple;
	bh=Xcepxi3Vf5hzhYTTmdtAHNH6ZioEjv18t57AIxS4jVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAbvzmWKzeNw0FSFqFEUmuhJT49bMQ5f57f/mKz+ELbiF5dAiKvo8sJZjGTmxfApFcmmj/6NYc6Wqloan3B5ez3ELhCsPzi7Qm5ce8yMmNrl+++H5KgHoDmlw61NEWq9fJq+Ty0f7mJUWf015GHHIFfnRgIF7XhsXAUED1Ea+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com; spf=pass smtp.mailfrom=m5p.com; arc=none smtp.client-ip=74.104.188.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m5p.com
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:8ac4:0:0:0:0:f7])
	by mailhost.m5p.com (8.18.1/8.17.1) with ESMTPS id 489K2B7q017432
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 9 Sep 2024 16:02:17 -0400 (EDT)
	(envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
	by m5p.com (8.18.1/8.15.2/Submit) id 489K28xU017431;
	Mon, 9 Sep 2024 13:02:08 -0700 (PDT)
	(envelope-from ehem)
Date: Mon, 9 Sep 2024 13:02:08 -0700
From: Elliott Mitchell <ehem+xen@m5p.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ariadne Conill <ariadne@ariadne.space>,
        xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
        stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
Message-ID: <Zt9UQJcYT58LtuRV@mattapan.m5p.com>
References: <20240906184209.25423-1-ariadne@ariadne.space>
 <877cbnewib.wl-tiwai@suse.de>
 <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>

On Sat, Sep 07, 2024 at 11:38:50AM +0100, Andrew Cooper wrote:
> On 07/09/2024 8:46 am, Takashi Iwai wrote:
> > On Fri, 06 Sep 2024 20:42:09 +0200,
> > Ariadne Conill wrote:
> >> This patch attempted to work around a DMA issue involving Xen, but
> >> causes subtle kernel memory corruption.
> >>
> >> When I brought up this patch in the XenDevel matrix channel, I was
> >> told that it had been requested by the Qubes OS developers because
> >> they were trying to fix an issue where the sound stack would fail
> >> after a few hours of uptime.  They wound up disabling SG buffering
> >> entirely instead as a workaround.
> >>
> >> Accordingly, I propose that we should revert this workaround patch,
> >> since it causes kernel memory corruption and that the ALSA and Xen
> >> communities should collaborate on fixing the underlying problem in
> >> such a way that SG buffering works correctly under Xen.
> >>
> >> This reverts commit 53466ebdec614f915c691809b0861acecb941e30.
> >>
> >> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> >> Cc: stable@vger.kernel.org
> >> Cc: xen-devel@lists.xenproject.org
> >> Cc: alsa-devel@alsa-project.org
> >> Cc: Takashi Iwai <tiwai@suse.de>
> > The relevant code has been largely rewritten for 6.12, so please check
> > the behavior with sound.git tree for-next branch.  I guess the same
> > issue should happen as the Xen workaround was kept and applied there,
> > too, but it has to be checked at first.
> >
> > If the issue is persistent with there, the fix for 6.12 code would be
> > rather much simpler like the blow.
> >
> >
> > thanks,
> >
> > Takashi
> >
> > --- a/sound/core/memalloc.c
> > +++ b/sound/core/memalloc.c
> > @@ -793,9 +793,6 @@ static void *snd_dma_sg_alloc(struct snd_dma_buffer *dmab, size_t size)
> >  	int type = dmab->dev.type;
> >  	void *p;
> >  
> > -	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> > -		return snd_dma_sg_fallback_alloc(dmab, size);
> > -
> >  	/* try the standard DMA API allocation at first */
> >  	if (type == SNDRV_DMA_TYPE_DEV_WC_SG)
> >  		dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC;
> >
> >
> 
> Individual subsystems ought not to know or care about XENPV; it's a
> layering violation.
> 
> If the main APIs don't behave properly, then it probably means we've got
> a bug at a lower level (e.g. Xen SWIOTLB is a constant source of fun)
> which is probably affecting other subsystems too.

This is a big problem.  Debian bug #988477 (https://bugs.debian.org/988477)
showed up in May 2021.  While some characteristics are quite different,
the time when it was first reported is similar to the above and it is
also likely a DMA bug with Xen.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445



