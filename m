Return-Path: <stable+bounces-205087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A8CF8BD1
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 15:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D5AD30141DD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40430E837;
	Tue,  6 Jan 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wEpWPC1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0451DD9AC
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709219; cv=none; b=WTkhHNbSM/fiN6HTv8vZRR/XaITLltTX2LEstWL6SSm/8nNdDpzIdoZFSyry6j+UOr8vz2Z3Dzjrb26z6ciJT1fR9j/MgkPkPbEL4d3recDcZy9wrQawLNfvZcY4wnY2Q8j5+qQEJj7IJf/aSX2rAsLkY5kEKHdQZn27+oWZbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709219; c=relaxed/simple;
	bh=Q/RPSHFo/aTo7LY7nIJD1kCkgYFKNpROn8qVPiCwcTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX0FkIaDqNWdPnoJebHc2+7VTfRCwSONcIfoHzPMfIPWto7l4nwvIES1dvKT0j9PS1+sjvq2iVhFAiNdMNoMI2UmEqoEsI6DTivPEhSDNHhHBhg/+Vj1W/+l6r5YEqXpp8NhfrkIL4g2xwNlp9ZH5kwAqVg5zNL2rR7sbeBj5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0wEpWPC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7FAC16AAE;
	Tue,  6 Jan 2026 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767709218;
	bh=Q/RPSHFo/aTo7LY7nIJD1kCkgYFKNpROn8qVPiCwcTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0wEpWPC1jxMa6vOxSHIJiVZvOr+x5NR9fasH8dKM6jXWlLqrJC2gnboi87+E1QWsA
	 EjOE9UxupZ5JIJy4Q67m+Qk1Jp34f49gSppT4gm1qIkGzHhCzdhVmLFUCxQ4V3iTQX
	 vZpOvW+Z+M1XpLk3xrLVVhwGltxHKwqi6zViFINA=
Date: Tue, 6 Jan 2026 15:20:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: dianders@chromium.org, luca.ceresoli@bootlin.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/tilcdc: Fix removal actions in case
 of failed probe" failed to apply to 6.12-stable tree
Message-ID: <2026010623-sierra-delay-cd63@gregkh>
References: <2026010529-certainty-unguided-7d41@gregkh>
 <20260105154701.5bc5d143@kmaincent-XPS-13-7390>
 <2026010512-flame-zips-0374@gregkh>
 <20260105174732.47163620@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105174732.47163620@kmaincent-XPS-13-7390>

On Mon, Jan 05, 2026 at 05:47:32PM +0100, Kory Maincent wrote:
> On Mon, 5 Jan 2026 17:30:39 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Jan 05, 2026 at 03:47:01PM +0100, Kory Maincent wrote:
> > > On Mon, 05 Jan 2026 14:26:29 +0100
> > > <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > The patch below does not apply to the 6.12-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > > 
> > > > To reproduce the conflict and resubmit, you may use the following
> > > > commands:  
> > > 
> > > No conflict on my side on current linux-6.12.y.
> > > Have you more informations?  
> > 
> > Did you try building it?  I don't remember why this failed, sorry.
> 
> Yes, and I didn't face any errors.

Fails due to other stable patches in the queue in this same area:
	Applying drm-tilcdc-fix-removal-actions-in-case-of-failed-probe.patch to linux-6.12.y
	Applying patch drm-tilcdc-fix-removal-actions-in-case-of-failed-probe.patch
	patching file drivers/gpu/drm/tilcdc/tilcdc_crtc.c
	patching file drivers/gpu/drm/tilcdc/tilcdc_drv.c
	Hunk #1 succeeded at 171 (offset -1 lines).
	Hunk #2 succeeded at 218 (offset -1 lines).
	Hunk #3 succeeded at 311 (offset -1 lines).
	Hunk #4 succeeded at 322 (offset -1 lines).
	Hunk #5 FAILED at 371.
	1 out of 5 hunks FAILED -- rejects in file drivers/gpu/drm/tilcdc/tilcdc_drv.c
	patching file drivers/gpu/drm/tilcdc/tilcdc_drv.h
	Patch drm-tilcdc-fix-removal-actions-in-case-of-failed-probe.patch does not apply (enforce with -f)

Care to rebase on the next release and send it then?

thanks,

greg k-h

