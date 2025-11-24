Return-Path: <stable+bounces-196670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA6C7FCCC
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2993A2FE5
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19226CE17;
	Mon, 24 Nov 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi2RSZIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8B2459EA;
	Mon, 24 Nov 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978613; cv=none; b=g/v8nmVLx4xb2/ouau8gIPELqEWerF9py7lePi5WzFfdkonENhohzlt/VuCwNR5gERZBRO+Kx92HodOfrQtLE7f/OakmBwJMG8yfsaLH9HP4O9mwoEhMnL1qHqu7W7DOURHROSGjLqHdU9FmI7wukPt23WiiWqKV5YjMqSE/S+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978613; c=relaxed/simple;
	bh=3OFtNIJlB5pb83NXaUCm1QhQaxVx50ZAfl+2hNDkg0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcrW4CvyXpl5QjjGu0l4B/bL3ec6SK+iC4OhhA1nDP1g4WBSX7GMpilMslZRxvTgEkoFqqCj6VQUEXRNLDTTTHZRhnPBMx7mxdRGccecKp3oakpYFlPtmO/WxiULcvXFM4pALbT5YDABVt4I3mcEefhAxUfxOf9eDyGNJCO0tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi2RSZIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AD2C116D0;
	Mon, 24 Nov 2025 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763978613;
	bh=3OFtNIJlB5pb83NXaUCm1QhQaxVx50ZAfl+2hNDkg0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi2RSZIhIrMeP9lQ7E6Lmm9GslpS3QdXywuDs9Fna/5l1DPEkZkA/RedhcXdqoZdD
	 1utTkzWvZrIn1dFLitOdHpNORhel1fHvMHmVBd3JgQ6icLqYTo5m6nS9ZD+IGQQl4t
	 BNa6eSjaJj0x0RjIUtxTPQ6isX7nQxOGoUvsqaz54aLB8So6aXI4d6dcRfzw9Sv+gk
	 BsE5tMwq60c9kDu6ArZZUCjQ0uCNx8Zv6XJOW+rFhrSsfcgYjwBg+tbby5yE7hafcM
	 Lus0cO5JsPfxtypi0XoMIp9JD9CYTEqK6+1Xrucbf1V7kFnUOU6puou0/bJOzXQaj2
	 CMaT59c1woIqQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vNTPw-0000000025T-2FTh;
	Mon, 24 Nov 2025 11:03:32 +0100
Date: Mon, 24 Nov 2025 11:03:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] drm/tegra: fix device leak on probe()
Message-ID: <aSQtdG3MiSq9YJAP@hovoldconsulting.com>
References: <20251121112432.32456-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121112432.32456-1-johan@kernel.org>

On Fri, Nov 21, 2025 at 12:24:32PM +0100, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the companion
> device during probe().
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: f68ba6912bd2 ("drm/tegra: dc: Link DC1 to DC0 on Tegra20")
> Cc: stable@vger.kernel.org	# 4.16
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/tegra/dc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 59d5c1ba145a..7a6b30df6a89 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -3148,6 +3148,8 @@ static int tegra_dc_couple(struct tegra_dc *dc)
>  		dc->client.parent = &parent->client;
>  
>  		dev_dbg(dc->dev, "coupled to %s\n", dev_name(companion));
> +
> +		put_device(companion);

I noticed that this has been fixed in rc7 when rebasing so please
disregard this one.

Johan

