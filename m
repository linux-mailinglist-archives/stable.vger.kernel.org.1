Return-Path: <stable+bounces-132877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F9DA9096E
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7E616FFA3
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB00214A7C;
	Wed, 16 Apr 2025 16:56:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from animx.eu.org (tn-76-7-174-50.sta.embarqhsd.net [76.7.174.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2072144D4
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.7.174.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822596; cv=none; b=mqDMpIvpU0z5+hs6i0O1Xcpomg1QKZ3SwWRkFpShsmSoRauAxtnVBN5cRhqqlOKsbdc17BYcQvAmJstuTM9A+0jUfsGcwsl2chYyZOgnv7PllWm3WjcwSMVIBe/FXJ7e2IDNlRBWYY5M3Xgqylc4UAY1ENJrCnDAku8n0NpL3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822596; c=relaxed/simple;
	bh=ybUMujgIyXopRC32WVafznt+z7HjXgKb7kwIFlscb10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn0N/UqFOR2NyAUMQA4Fq8KEm2g9p5drt25cNH7TrgP9KHL/0o09dUhBHuVBq113IvFI4bTZgGPXGPvTlcy7d5fvk2R1ZN22QDPaMUfV39ueiSXEgZPRfgtxkLmY+jFBlBW8rY+h5OVLFhWIesSMaCpNhJ5HkI+dygN+nluCBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=animx.eu.org; spf=pass smtp.mailfrom=animx.eu.org; arc=none smtp.client-ip=76.7.174.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=animx.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animx.eu.org
Received: from wakko by animx.eu.org with local 
	id 1u563n-0003pT-Hd;
	Wed, 16 Apr 2025 12:56:27 -0400
Date: Wed, 16 Apr 2025 12:56:27 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, jfalempe@redhat.com,
	dri-devel@lists.freedesktop.org, ???????????? <afmerlord@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/mgag200: Fix value in <VBLKSTR> register
Message-ID: <Z//hO7ol4nED5UiH@animx.eu.org>
References: <20250416083847.51764-1-tzimmermann@suse.de>
 <Z//LSBwuoc6Hf3zG@animx.eu.org>
 <568a359c-e096-4486-84b3-95b37b2de7a6@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568a359c-e096-4486-84b3-95b37b2de7a6@suse.de>

Thomas Zimmermann wrote:
> Hi
> 
> Am 16.04.25 um 17:22 schrieb Wakko Warner:
> > Thomas Zimmermann wrote:
> > > Fix an off-by-one error when setting the vblanking start in
> > > <VBLKSTR>. Commit d6460bd52c27 ("drm/mgag200: Add dedicated
> > > variables for blanking fields") switched the value from
> > > crtc_vdisplay to crtc_vblank_start, which DRM helpers copy
> > > from the former. The commit missed to subtract one though.
> > Applied to 6.14.2.  BMC and external monitor works as expected.
> 
> Great. Thanks for testing. Can I add your Tested-by tag to the commit?

You may.

> > > Reported-by: Wakko Warner <wakko@animx.eu.org>
> > > Closes: https://lore.kernel.org/dri-devel/CAMwc25rKPKooaSp85zDq2eh-9q4UPZD=RqSDBRp1fAagDnmRmA@mail.gmail.com/
> > > Reported-by: ???????????? <afmerlord@gmail.com>
> > > Closes: https://lore.kernel.org/all/5b193b75-40b1-4342-a16a-ae9fc62f245a@gmail.com/
> > > Closes: https://bbs.archlinux.org/viewtopic.php?id=303819
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Fixes: d6460bd52c27 ("drm/mgag200: Add dedicated variables for blanking fields")
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Jocelyn Falempe <jfalempe@redhat.com>
> > > Cc: Dave Airlie <airlied@redhat.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: <stable@vger.kernel.org> # v6.12+
> > > ---
> > >   drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> > > index fb71658c3117..6067d08aeee3 100644
> > > --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> > > +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> > > @@ -223,7 +223,7 @@ void mgag200_set_mode_regs(struct mga_device *mdev, const struct drm_display_mod
> > >   	vsyncstr = mode->crtc_vsync_start - 1;
> > >   	vsyncend = mode->crtc_vsync_end - 1;
> > >   	vtotal = mode->crtc_vtotal - 2;
> > > -	vblkstr = mode->crtc_vblank_start;
> > > +	vblkstr = mode->crtc_vblank_start - 1;
> > >   	vblkend = vtotal + 1;
> > >   	linecomp = vdispend;
> > > -- 
> > > 2.49.0
> > > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 
-- 
 Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
 million bugs.

