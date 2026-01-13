Return-Path: <stable+bounces-208255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6ED17C01
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D259B309564F
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C2322B93;
	Tue, 13 Jan 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBkZISuq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F534192B75;
	Tue, 13 Jan 2026 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297042; cv=none; b=WI2y8DJLBWUNonzZpQJedl97s7IXVIUaAGAg7eYuUysqjzw+yC7yaQVANrxd3gjsf3yxcWcd5MeFmK9Wr8/uvotLaUf4ySVXtgtlxF2L4xZiZ3hbLPB2CJPkJuF/EPAkrBc7z3tZySx4TKeVy8ksm8KZ9O3O3IasEsgQCY1tL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297042; c=relaxed/simple;
	bh=cIOwD58Ak3CSKnQkYorESYs4Kr9I5bL41mQonQmvir0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5qAoR546KtI6hPeS1z6LyvANz40dOO2KO+G2JWv4+9APmk5ctUvH+rsyMTQ1PWRBS7OdV3ChrbiKZElqNyWiUUN4s4s5+qkcXcdZvceigVDE6P9qE7M0693aAmxAXixDWW2ikarKQPv3iAFlH72QT2pMrXfv1hsyV64zaaPgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBkZISuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFD3C19423;
	Tue, 13 Jan 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768297041;
	bh=cIOwD58Ak3CSKnQkYorESYs4Kr9I5bL41mQonQmvir0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBkZISuq3zLz7rwGsDG/uxDJP89ZjWYZC8pGI9aBdbIQis/rWdcoim/+eWjOeUmte
	 5FL84gG/S8J58j0z9OPaRtgYpx5kbFhpEHU9M9bb4WM0iSme3Vc5gO3dIvX4Unys+0
	 ALfaktbCVUcPQxEEvSlrmHJ3iBIFP0H3SX2ygcyDd2n8eW0I7ExQf7jPhcze7xdVat
	 1yKFpUEmEEFCubyoSwmQvbZUL8l/KpGJe4BHah0sHtPnwN12Ivd8SvYZWTGtUy/gvd
	 otpRhvksxjykieG1c84JR1CVj19hRZnfuZT9a8DaQvoMGqpQszPuOcqnSwtGSC9Xeb
	 IYUBRfE5tTqCA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vfapt-000000005qF-2o82;
	Tue, 13 Jan 2026 10:37:14 +0100
Date: Tue, 13 Jan 2026 10:37:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: omap-usb-host: fix OF populate on driver rebind
Message-ID: <aWYSSa0w4eNdRyEC@hovoldconsulting.com>
References: <20251219110714.23919-1-johan@kernel.org>
 <20260109163725.GB1808297@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109163725.GB1808297@google.com>

On Fri, Jan 09, 2026 at 04:37:25PM +0000, Lee Jones wrote:
> On Fri, 19 Dec 2025, Johan Hovold wrote:
> 
> > Since commit c6e126de43e7 ("of: Keep track of populated platform
> > devices") child devices will not be created by of_platform_populate()
> > if the devices had previously been deregistered individually so that the
> > OF_POPULATED flag is still set in the corresponding OF nodes.
> > 
> > Switch to using of_platform_depopulate() instead of open coding so that
> > the child devices are created if the driver is rebound.
> > 
> > Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
> > Cc: stable@vger.kernel.org	# 3.16
> > Signed-off-by: Johan Hovold <johan@kernel.org>

> > @@ -819,8 +819,10 @@ static void usbhs_omap_remove(struct platform_device *pdev)
> >  {
> >  	pm_runtime_disable(&pdev->dev);
> >  
> > -	/* remove children */
> > -	device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
> > +	if (pdev->dev.of_node)
> > +		of_platform_depopulate(&pdev->dev);
> 
> devm_of_platform_populate()?

Looks like that would work here, but I prefer using explicit removal for
both the OF and non-OF for symmetry and readability reasons.

If you think that the non-OF support can be removed then a devres
conversion can be done as part of that change.

> > +	else
> > +		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);

Johan

