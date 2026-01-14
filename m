Return-Path: <stable+bounces-208346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D057D1E46F
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8325530119FB
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0F395277;
	Wed, 14 Jan 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0yIRxhM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4130C343;
	Wed, 14 Jan 2026 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388405; cv=none; b=EwescqvfauiNv47gTgryJJSuWNgCpedQURgKdFTtoEkwvUULbuAmlrc/BD/LadtTmlItmWG5Ed0fOz5h7wsCO8y382G2jpst7BduXg1ycEcs/SdDNtMie6iqctGkS3UT6i9Hcw/VA1fpTOdMqnUV18FUl8Kds3IIWpZ/pYLAM3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388405; c=relaxed/simple;
	bh=d85CVElszEKzb8v9RY4JGMFUuDl4vhTlslS0oFyl2v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpkP8v0J7SWZVZDJTxGv0cN2elA6xeFE41T+anTaeStFXI+IimZ/JNnqMSp6tDqP8TShtWUq+ncZaosoeaXGAabxU6wQAgQgoAhgL35fnw9elNionJWazZpicQTMCplyTD+wo1DX37DLYnHuRxmPVsGA3MXoDhlAVHb0J+l8OEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0yIRxhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B180C4CEF7;
	Wed, 14 Jan 2026 11:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768388401;
	bh=d85CVElszEKzb8v9RY4JGMFUuDl4vhTlslS0oFyl2v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0yIRxhMibzYH1bjwup4nkDDyMg/Alta+LZP2Jl4qyeHDkOxGwkNAcd8yKrcFiR3e
	 093DPW47UnoSY67YvaBzjQI6jpx1+/VnIoWceij7qb6XTYKCFaCqFzRsGYJKDcGoCC
	 YOSpP6dy6+XdpmD/hA9rbKhOvWbBYedzV7xUv/3w4UV8ZewVX/dVchA88W8nLoAiRA
	 xzI9AqVSqmxuobRJi+NaHQurqCxJpDLetf6NiHA1oiodVWIKZshJpLhbby8C+QPuEq
	 y7ImBeDbmCinkjXbgwKcPftjKLAzvDKkkqLm93qDVn0iKGPfSkzp4GSytxf5Wv8Xh7
	 NHCsqqMRHdgpg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vfybS-000000002xJ-1rSw;
	Wed, 14 Jan 2026 11:59:54 +0100
Date: Wed, 14 Jan 2026 11:59:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>, linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: tegra124-emc: fix device leak on set_rate()
Message-ID: <aWd3KmGKfaUX87ya@hovoldconsulting.com>
References: <20251121164003.13047-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121164003.13047-1-johan@kernel.org>

On Fri, Nov 21, 2025 at 05:40:03PM +0100, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the EMC device and
> its driver data on first set_rate().
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
> Fixes: 6d6ef58c2470 ("clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver")
> Cc: stable@vger.kernel.org	# 4.2: 6d6ef58c2470
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up for 6.19 (or 6.20) now?

Johan

