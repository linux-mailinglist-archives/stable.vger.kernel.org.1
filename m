Return-Path: <stable+bounces-55026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250D5915112
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE78D1F25EC5
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63913D2BC;
	Mon, 24 Jun 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fnf5kK1I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D519AD92
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240815; cv=none; b=nbHZ244dDOl/F4+y4S9O3hcJQDzyA8U83/fVHnBKiDvMdmg8+Ksc/nL70pdDKaiSV7AZZUua4etalmBljjQnz6lWNDxGXJ8N3GFSZsh12xSguxOKgOBag5dhK54V7INTHoLG0RYx1H+2S7wl0xrjrP5/X1gtbyGLgXP/NpWOs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240815; c=relaxed/simple;
	bh=RtJvbGSG1OCBq7rxwQmiXYnm6vr2jOm0nvVHnvCZFdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KunNKwH5XZeXfZPKpM9JooSHRQFxGYPjtE8CQCfIhfggohxEdPnm5aiPLMuBx6uwjKnAOtL3P0v/RctSrJZ2unzxmkkYVljGd3hQUq40A9U7hpB4tTFefUju9j+AUeGgU9XtUd0oRiCtH9qvbST1nbdmxRldbORpIQ5KTpOHHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fnf5kK1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEECC2BBFC;
	Mon, 24 Jun 2024 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719240814;
	bh=RtJvbGSG1OCBq7rxwQmiXYnm6vr2jOm0nvVHnvCZFdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fnf5kK1Ik51rpKuVrIUJV3O8QeiyxsjpK+bdS7nL/NUdqHN0NnzU0p4NI1S/ZEOaJ
	 2GGiaUNvGYS/XDAL54PGNBaFGRFIgcxzmJlSu4PdwJCxchGRZ7FiG+A4mxmW95DJI0
	 6XtN1wgCBAyixJDT0NSdvwxpr53nMCRpXKxrv++A=
Date: Mon, 24 Jun 2024 16:53:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: stable@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: enable the vf610 gpio driver
Message-ID: <2024062424-scanning-haziness-fa69@gregkh>
References: <20240604181043.3481032-1-festevam@gmail.com>
 <CAOMZO5C1ghUi2a-G3vn-r326_j_4S2n8LR89NFZqSoX7XUtdNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C1ghUi2a-G3vn-r326_j_4S2n8LR89NFZqSoX7XUtdNA@mail.gmail.com>

On Wed, Jun 19, 2024 at 10:13:06AM -0300, Fabio Estevam wrote:
> Hi Greg,
> 
> On Tue, Jun 4, 2024 at 3:10 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > From: Martin Kaiser <martin@kaiser.cx>
> >
> > commit a73bda63a102a5f1feb730d4d809de098a3d1886 upstream.
> >
> > The vf610 gpio driver is used in i.MX8QM, DXL, ULP and i.MX93 chips.
> > Enable it in arm64 defconfig.
> >
> > (vf610 gpio used to be enabled by default for all i.MX chips. This was
> > changed recently as most i.MX chips don't need this driver.)
> >
> > Cc: <stable@vger.kernel.org> # 6.6.x
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> > Hi,
> >
> > This fixes a boot regression on imx93-evk running 6.6.32.
> >
> > Please apply it to the 6.6.y stable tree.
> 
> A gentle ping.
> 
> Please consider applying this one to 6.6 stable as it fixes a boot regression.

Sorry for the delay, now queued up.

greg k-h

