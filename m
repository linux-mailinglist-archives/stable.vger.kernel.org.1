Return-Path: <stable+bounces-54635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE990EFE0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C5F281608
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A931514E4;
	Wed, 19 Jun 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uIgUTdRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8681509BF;
	Wed, 19 Jun 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806462; cv=none; b=tV6rJPc4kUenWs3l2P7ye8LlD7AK211IOq28kbyOy4wy1yoRoFJYda47sG8/38JJIplPiBNVxklgGbdaFxkEhSE3igbF/r2Qw+iHT2qyWW5k6WhQ8xuyXC/XxmsuVdI/3wta6iGEK3mVY1MM9U2HBUEd+Ojc2pnE9gDeEVWdAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806462; c=relaxed/simple;
	bh=geZZ9r9QIaXr11UIqQ/HNcvurorYi/PCLRL6sWqc/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPQoxe9eLlpYurfc7lQ5mnNGDSrnXeqd03vajhnrZ1N0fccLsLaUNT75gxIWS0OiFowMOoAoYucdiAlytYVMxyFuF/pbB2jHacjMg23wOYRtWMig0ppkMsl63E98sky9R473hyUnNfP3XdGpDwpQMtp9VZhw/3pmaNk8lWvza7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uIgUTdRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F872C32786;
	Wed, 19 Jun 2024 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718806461;
	bh=geZZ9r9QIaXr11UIqQ/HNcvurorYi/PCLRL6sWqc/5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIgUTdRWHdl9qwEOu8hrOVemL+5TXDvJB1NpsId9WTSM5p65vPxdRwS9ucWgnDjrS
	 AXEkrd8rjl6QQ9u+Ls0nTsY5o9jPFGhnmQnma24ptxgQ1cqFHVIQmzHurAxyZZFLQN
	 JosS6g5mAIaMRPVWJB2V0fs+FadgfEecPyQB2lTY=
Date: Wed, 19 Jun 2024 16:14:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Lee Jones <lee@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 resend] MAINTAINERS: Fix 32-bit i.MX platform paths
Message-ID: <2024061951-singular-jersey-ffd0@gregkh>
References: <20240619115610.2045421-1-alexander.stein@ew.tq-group.com>
 <13561511.uLZWGnKmhe@steina-w>
 <2024061933-oxidizing-backspin-8c4e@gregkh>
 <3326703.44csPzL39Z@steina-w>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3326703.44csPzL39Z@steina-w>

On Wed, Jun 19, 2024 at 03:40:54PM +0200, Alexander Stein wrote:
> Am Mittwoch, 19. Juni 2024, 14:37:09 CEST schrieb Greg KH:
> > On Wed, Jun 19, 2024 at 02:23:36PM +0200, Alexander Stein wrote:
> > > Am Mittwoch, 19. Juni 2024, 14:18:35 CEST schrieb Greg KH:
> > > > On Wed, Jun 19, 2024 at 01:56:10PM +0200, Alexander Stein wrote:
> > > > > The original patch was created way before the .dts movement on arch/arm.
> > > > > But it was patch merged after the .dts reorganization. Fix the arch/arm
> > > > > paths accordingly.
> > > > > 
> > > > > Fixes: 7564efb37346a ("MAINTAINERS: Add entry for TQ-Systems device trees and drivers")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > ---
> > > > >  MAINTAINERS | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index c36d72143b995..762e97653aa3c 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -22930,9 +22930,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
> > > > >  L:	linux@ew.tq-group.com
> > > > >  S:	Supported
> > > > >  W:	https://www.tq-group.com/en/products/tq-embedded/
> > > > > -F:	arch/arm/boot/dts/imx*mba*.dts*
> > > > > -F:	arch/arm/boot/dts/imx*tqma*.dts*
> > > > > -F:	arch/arm/boot/dts/mba*.dtsi
> > > > > +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> > > > > +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> > > > > +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
> > > > >  F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
> > > > >  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
> > > > >  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
> > > > 
> > > > Why is a MAINTAINERS change needed for stable kernels?
> > > 
> > > This fixes the original commit introducing these entries, mainlined in v6.6
> > > Unfortunately that got delayed so much it was merged after commit
> > > 724ba67515320 ("ARM: dts: Move .dts files to vendor sub-directories"), which
> > > was merged in v6.5.
> > > Thus the (32-Bit) arm DT paths are incorrect from the very beginning.
> > 
> > That's fine, who is using these paths on older kernels anyway?  You
> > should always be doing development on the latest kernel tree, so they
> > shouldn't matter here.
> > 
> > or am I missing something?
> 
> Sure development is on newer trees, but I'm wondering if anyone uses
> scripts on that stable version evaluating this file.

Usually not, otherwise we would be backporting all of these types of
changes all the time.

> I don't mind if this is not applied to stable. Want me to send without Fixes
> and CC tag?

Please do, thanks!

greg k-h

