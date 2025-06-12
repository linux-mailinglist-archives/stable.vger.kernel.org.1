Return-Path: <stable+bounces-152577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4778AD7B0A
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8673A218F
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1D2D3A94;
	Thu, 12 Jun 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNTvg/oM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7FD2D3220
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756532; cv=none; b=CEcfS9RaNGZse8MNrcazCGlzzD1UqFVTn7qfzrzfRGvLWq5v+vl9IO0saauzaKnldR/lQSfsueNjDHFopG+zUDw/SLIEUCew+Cg3vqkTuuo/BcQIUPKgo600z6+LCM2zht9EOId38Bpi/EMzdl78wFoPLnXrVdadkAD3pxijusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756532; c=relaxed/simple;
	bh=1u/pfBgQx4QmRl4W9usL976z1pHD4z10B6qilgfDvBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkm1k4vn3rgczuabn7jEWbArobu6M3phDOsu+WmBprtSKKEulp2kQpE8xAmTiTpty54N3ayK8Gk/Q5FBuaLnkvDHZ3TU6bkdtDOI4oiRRrLadkF1sSG8b2LA0A2SLOvi7gwlTJKIloWw2g8a04n/sQbxTax6tl+NvRupDbnsB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNTvg/oM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E33DC4CEEA;
	Thu, 12 Jun 2025 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749756531;
	bh=1u/pfBgQx4QmRl4W9usL976z1pHD4z10B6qilgfDvBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNTvg/oMe27krJOZq8CTL09J3rS1QvQ3R6d64Yp6AksOyZ0FGWpkuaSHeEuFTiRuB
	 dUNoIE4sqhi2HiLT5rknpjqwgLIQVT7XNQgy1IAxboyhdtUi5NrPry0o+6cuRCWb/i
	 GUg+fzB6joeA6YbF0W8HS9hgMKtZcPBQmvqbopSpmNJRVKnJeUy3nfJ3jXAWwDvP7j
	 2XRnMqgXN2tKCzLZALV8D2tIPWpatH3qOhpxsXHc6WqQlzp/krV9W7JrSXkcu4eRzA
	 JJfg9HKkIC7qWLrN0OXfMPkDdEZ/Klun3hjBTRSlemeJ/TWSLGyPBtRgy0UIftwNFI
	 JNegSSKMJiqoQ==
Date: Thu, 12 Jun 2025 15:28:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-stable <stable@vger.kernel.org>
Subject: Re: Backport sh-sci fixes to 6.12.y
Message-ID: <aEsqctMnzUfinUga@lappy>
References: <6aa4a135-eb89-49e0-b450-7fa30d7684ee@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6aa4a135-eb89-49e0-b450-7fa30d7684ee@tuxon.dev>

On Wed, Jun 11, 2025 at 08:23:54AM +0300, Claudiu Beznea wrote:
>Hi, stable team,
>
>Please backport the following commits to 6.12.y:
>
>1/ 239f11209e5f ("serial: sh-sci: Move runtime PM enable to
>   sci_probe_single()")
>2/ 5f1017069933 ("serial: sh-sci: Clean sci_ports[0] after at earlycon
>   exit")
>3/ 651dee03696e ("serial: sh-sci: Increment the runtime usage counter for
>   the earlycon device")
>
>These applies cleanly on top of 6.12.y (if applied in the order provided
>above) and fix the debug console on Renesas devices.

Could you please take another look at this? The first commit applies,
the second one is already in tree, and the third one conflicts.

-- 
Thanks,
Sasha

