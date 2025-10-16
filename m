Return-Path: <stable+bounces-186052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D01BE3773
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089F41A62F75
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E232D7E5;
	Thu, 16 Oct 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCFKqBBx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5681487D1;
	Thu, 16 Oct 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618657; cv=none; b=PYzQJupsOHK+y3hT/GGnMtK3ndnsh6rfAwpU3jwktZqpLtN29O7CBzj7HYXmsPrxSGairLWWlMft4Q4zBJD4DykbcGL5Mid3T0RIJe0QPT96crXBC9ZyaxISFvCDs6NC3CwPP0vCTxr+m/S641V/Evv0P9B0eXSAOwB5AbM2g+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618657; c=relaxed/simple;
	bh=UiRMtD4HrkDHeIc4FGb7iyKCK1GPw3RQ8DKO8RCSw5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQpyhk47t7u4MoTCI+S5xdkEhjxE/3etQy9/DIWUfibE3oLL0fAfgUNk6F4Rum5Hx3bHy/QXHYUC/f8JZNYScHuZzh/9TBtnTwj7vAisfiwEHPqfGTCWIbApGmIQL57JsXmCpVYYAJlFpMAkzcyOOLkqM/Z+NvPth0mV0KVNXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCFKqBBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EC5C4CEFE;
	Thu, 16 Oct 2025 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618657;
	bh=UiRMtD4HrkDHeIc4FGb7iyKCK1GPw3RQ8DKO8RCSw5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCFKqBBxtc6cr2E4/WHp9X+Dzi6MJkbJAQ+uGPYm0MhZ+op0QysqkVonP0Jt5Mr/U
	 6kSxCU7N/D+1N0FB0QlP20qeBjt4zhXci6QO4xfSzp3/M929nLo/dQVJeR6rWMdvJ9
	 hVvNJXMnOrRc3h2RSqaCvYYE+iEPz/nntSDPXlrTD0PUgljaxOTg2C8jQq5xwJTsqj
	 28DodsnyHG3d/Xuh7PVG1A2okfgLqMOz6gemfEBe8DiitEBXUaRfU0fc8HrppWRxu+
	 EfNW7uAWbvSy7/TFVC/PMg/vNbwadAhE31W+isieJeDlUU43LuivccbV1vmPeXdxrh
	 pfzpgvEENwWnw==
Date: Thu, 16 Oct 2025 13:44:12 +0100
From: Simon Horman <horms@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Fix disabling
 set_clock_selection
Message-ID: <aPDonJRMVKjsC6g7@horms.kernel.org>
References: <20251014-rockchip-network-clock-fix-v1-1-c257b4afdf75@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-rockchip-network-clock-fix-v1-1-c257b4afdf75@collabora.com>

On Tue, Oct 14, 2025 at 05:49:34PM +0200, Sebastian Reichel wrote:
> On all platforms set_clock_selection() writes to a GRF register. This
> requires certain clocks running and thus should happen before the
> clocks are disabled.
> 
> This has been noticed on RK3576 Sige5, which hangs during system suspend
> when trying to suspend the second network interface. Note, that
> suspending the first interface works, because the second device ensures
> that the necessary clocks for the GRF are enabled.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk3588")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Simon Horman <horms@kernel.org>


