Return-Path: <stable+bounces-208348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE043D1E4BF
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CC2230056CC
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97D395257;
	Wed, 14 Jan 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmdtSw4i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2C2D94BB;
	Wed, 14 Jan 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388653; cv=none; b=R7rhSil/8XUBOXga6fWUOTEmhLAOH3VUbdJkuvdcVvzO5SyhlEQtfC6VxsIo4/BqzrWGaqpNeVkfauLy/itUFTAk1IwKy9sMcBS/sHh/QlZcPekRMBPwWPkpiPUZ49X2QZaJG4YI6xDBH00hQAbdp8WNHnwrT268XJ29MtQVsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388653; c=relaxed/simple;
	bh=hIrixXtFyZal2+s8Tsd7UycF82XubUKq7ZgNR6lwRWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TthQjtqJPKodRqskpC4rsu2P0yDNGLpDu0Ne06xeCYZt3L006apLGhWVE7rghUgd/IoYTGX7uuqGlBFOH6mKDUi2xl4dp8MnLiP4FsYsvELOqmqHqrG0wbhEUyriIAmhoeCqDJrij4DQLR1diHvTm7pk73FzAU8FI3E5aqPtwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmdtSw4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75416C4CEF7;
	Wed, 14 Jan 2026 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768388652;
	bh=hIrixXtFyZal2+s8Tsd7UycF82XubUKq7ZgNR6lwRWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmdtSw4idmg1xfDdi+ByZXAXP1Wrf7gGpHtnSerrxd0DQbEuuwNILky1wAuG72SYt
	 45mA0Zev0MHomsmHoTGzp1tO0aKrBx16idTusyHRXjrwJeTJKQgUyP6kX0VFoJTKwe
	 CGpwl6ZwUTwCtXIdwPHojS21V+hQF3PfeK2raehJ/Jm8xnt3u8F55WsyJ1upU7cUJH
	 GFMBi7F7Cvs41PWro/oGTy9EbPWLvOu9vNpGoYyEarXD7bxIMtar7ZJjyaNHRHmcp/
	 egksGyYXHiz8kmBzPEIqNu4Qgh/WNCw5ahm9e/fxYz+jPkCxRWoJLC931C+youFkhc
	 eeus1oh0/d8lg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vfyfW-0000000036p-0K5T;
	Wed, 14 Jan 2026 12:04:06 +0100
Date: Wed, 14 Jan 2026 12:04:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: fix regmap leak on probe failure
Message-ID: <aWd4JtXYJFlI-hj6@hovoldconsulting.com>
References: <20251127134942.2121-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134942.2121-1-johan@kernel.org>

On Thu, Nov 27, 2025 at 02:49:42PM +0100, Johan Hovold wrote:
> The mmio regmap allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> Fixes: a5caf03188e4 ("soc: ti: k3-socinfo: Do not use syscon helper to build regmap")
> Cc: stable@vger.kernel.org	# 6.15
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up now?

Johan

