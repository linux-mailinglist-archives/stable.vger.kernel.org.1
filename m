Return-Path: <stable+bounces-114065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C6A2A5DA
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE4B18887D8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94CB226554;
	Thu,  6 Feb 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iot787BE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DA18B03;
	Thu,  6 Feb 2025 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838064; cv=none; b=P5iTwt1wGRmTQOMPpKnVyljrpUQtLu4Wyn/IOofFkfoA+pPJqw3O3WkZO26AC038E9teeF1P35NtNZudMvlljUUm++sFJqUMxCeH1o1vWQQK3Fl2QXKEbCER730d3CZlaGJhxRRX0HOYuUvzW9ej+qHPutja7qVX94VamONo2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838064; c=relaxed/simple;
	bh=HtJGuuBPY7GzLXY3kxC0VzXl+lpKcP1odVWAB06tJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NIJHoiLweQNY//MQ0CmuHbqWXwNTKd0Ts4/KjD064Ka70ZhirwmlR0am2/NL36Z9YeC5wneVHKGiz+VTCW/LAkhj3IKQJv1jJelLqKZ3TXRwr8pXESaCr3oN5bJd/hYVn+hfpAwvS4axk2x7jn0sRx1CQzHdCCq3/3o7WbRV6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iot787BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E42C4CEDD;
	Thu,  6 Feb 2025 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738838063;
	bh=HtJGuuBPY7GzLXY3kxC0VzXl+lpKcP1odVWAB06tJ9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Iot787BECykWp2gtP3LBBfpkGun7l00fOPAElaA5BAiQCtwwTeI+lVecYMzKwAnts
	 4mcyF+D7fWht1j+3rEu3Cj1DeyPer4iHjAMiI9YUWs+kcZZlBXtr31rsdaxfYzyLlo
	 W04h+ye22xoupObrmhPOhQ3wmdVoNLUsufgqTPam+umbVH0CCgAW87+XGI3BvdHj7B
	 6bGGqk9nn8pKjJ1FUWcQSS28fa1KRdLaD1dIgqoGtHBv8bFZMZk/H7/f1DvM+JP+ZX
	 woAuP/pEtkO6VckSw7t2BXzkqiKH0LqFV0wwy5n6jYGwhxehp1ZAZDN0bLIEDFYrQR
	 6h+Szxrv3EMNQ==
Date: Thu, 6 Feb 2025 10:34:18 +0000
From: Simon Horman <horms@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Steven Price <steven.price@arm.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
Message-ID: <20250206103418.GO554665@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6OjmtiZ4A8BzvsP@shell.armlinux.org.uk>
 <CAGb2v64CZWZwC7T9NNN7Re8pkCLQZEh3bcraYjcQRyVxtJgS5w@mail.gmail.com>

On Thu, Feb 06, 2025 at 01:40:17AM +0800, Chen-Yu Tsai wrote:
> On Thu, Feb 6, 2025 at 1:38 AM Simon Horman <horms@kernel.org> wrote:

...

> > I think the point is that someone needs to formally
> > submit the revert. And I assume it should target the net tree.
> 
> Russell sent one a couple hours ago, so I think we're covered.
> 

On Wed, Feb 05, 2025 at 05:44:58PM +0000, Russell King (Oracle) wrote:
> On Wed, Feb 05, 2025 at 05:38:24PM +0000, Simon Horman wrote:

...

> > I think the point is that someone needs to formally
> > submit the revert. And I assume it should target the net tree.
> 
> For what I think is the third time today (fourth if you include the
> actual patch...)
> 
> https://lore.kernel.org/r/E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk

Thanks, I see it now.

