Return-Path: <stable+bounces-208345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE940D1E41B
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3080F300296C
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1EB395DB6;
	Wed, 14 Jan 2026 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHjS9huI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38330C343;
	Wed, 14 Jan 2026 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388301; cv=none; b=I7l7HkGdZyOBLwJkkHdfsU5yM8jERgNlQ0iyjrQACbDkolmjevZz3NBHVE3Zkpsn2F1vpAfcpeG1H4mGg5Irfn/JD03gBrBRKGIYTCbX4bYrJrredQB4UFt2G06BhMv+3VQzHkHeKoY2JLy1qeHSiPpNaPvaC2eqCBEMlQaEJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388301; c=relaxed/simple;
	bh=FB084Np/65yIBtVlFoVrgt1UnmRqnwSuLFcsfpReaVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeTAXl7r68vq6RDqsKxlgiSfbkpVN1f3u3e3v694MGqNGxmu0oE4cy+CXICZyk0Ty4IcPp7+2IZPmGbHGgMjJ8VdIiqMS8NsjcTvxafu4MppbEpUe9vhj+zMVInjztzYjoCs8vTDlAdzxFR1pZ317WPrz5ZHr8NtdzffHFd+2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHjS9huI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25891C4CEF7;
	Wed, 14 Jan 2026 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768388301;
	bh=FB084Np/65yIBtVlFoVrgt1UnmRqnwSuLFcsfpReaVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHjS9huI0ccr9soEgGscgbKtE43l9HoUp/hC1eo0cIGhBsCn9dJQ/i3ZIJLF2/tyQ
	 amyXviqtbyFwiwPqMCCkE7ybli1l1L7uLcmE410r3+fzCb4AgnKG6MLoefvKtrgpZ+
	 TZga5GCgoOBB9Yc1cpQCdUhZRA9IS92eC7ZyjsF+IQaFDBIe5TvbGgLMB2jE42YxvR
	 XGUwhqTa/A/I0zQs8+J3JZQtEuIJ1h1jv/vfcDpzvvge3IbDNnlr40c5eIyh3PRoBS
	 V2+VlFWOgtnUXT1Tt/gb1/b4mv5nMuhX+/1OQ0cLFz6voLx3zb8lhHExs4+cbx4FIr
	 FG11aC9Tw8HRg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vfyZq-000000002tn-2MjG;
	Wed, 14 Jan 2026 11:58:14 +0100
Date: Wed, 14 Jan 2026 11:58:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] drm/imx/tve: fix probe device leak
Message-ID: <aWd2xizOQAnVRaSs@hovoldconsulting.com>
References: <20251030163456.15807-1-johan@kernel.org>
 <aR8TWJurF1a0LLGJ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR8TWJurF1a0LLGJ@hovoldconsulting.com>

On Thu, Nov 20, 2025 at 02:10:48PM +0100, Johan Hovold wrote:
> On Thu, Oct 30, 2025 at 05:34:56PM +0100, Johan Hovold wrote:
> > Make sure to drop the reference taken to the DDC device during probe on
> > probe failure (e.g. probe deferral) and on driver unbind.
> > 
> > Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
> > Cc: stable@vger.kernel.org	# 3.10
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> > 
> > Changes in v2:
> >  - add missing NULL ddc check
> 
> Can this one be picked up for 6.19?

It's been two more months so sending another reminder.

Can this one be merged now?

Johan

