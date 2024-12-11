Return-Path: <stable+bounces-100619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC909ECDD1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A07C1619D1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146D2336BF;
	Wed, 11 Dec 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kb2Ghjv1"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDD230274;
	Wed, 11 Dec 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925498; cv=none; b=smJM0U5ZD5E0riEIz87BFoP/0EN78MVSAmKj8LhXdjFsr/jV6ln7naaExATz21RSfuemRy9J1WYihLqv54739I/AqCdd8+yMpoEQ9e+7ytDnfSykQx/1rkn/7tRYcbB/jAOdAgg8Mau5czWiqv01n1nCQE/2nrVqGc/W/Bz/p1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925498; c=relaxed/simple;
	bh=5zzqL6D7fGPcKgWrtWateJa4IM8XUQmF2W5DulY/N4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FybRPqxMcOi0WBchioLEELk+/QnnEaGdh6gRXTzqjLNGw0/yrE2apclv7Y3TgRDTH9Cs8nc9UalBzoG8VnVmkXERHwKWURh5+ngaJlhBr5pTAUy6e178CGoKx85TL72tc2GzwqQbj/X9VL/NtT9v7oHywNNAO5kV7iy+P9GMZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kb2Ghjv1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vfTMOrtYxu8eRmnE9yuAimcO6yn5L7prTopxY60AzJE=; b=Kb2Ghjv1YHHMLQ54vTFs49+B2M
	4Y0WQhLR6Ni5l4ZacXwVn/yXV7WG7iTtGiIGDSmIkbkYjAFHZtF7q3YCwfgul35NsmAy8eY+KoCmD
	/z63p4VLL7Vcg41LCgYbl8vnaXZbSQVCMf9CIhqR0Ix3A3QN16RMkhzVqq//TpUZPGgg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLNDy-0006Tt-MH; Wed, 11 Dec 2024 14:57:58 +0100
Date: Wed, 11 Dec 2024 14:57:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ma Ke <make_ruc2021@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shannon.nelson@amd.com,
	sd@queasysnail.net, u.kleine-koenig@baylibre.com, mdf@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fix NULL dereference in nixge_recv()
Message-ID: <260501e8-9c03-43db-877b-1e88e059b67e@lunn.ch>
References: <20241211083424.2580563-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211083424.2580563-1-make_ruc2021@163.com>

On Wed, Dec 11, 2024 at 04:34:24PM +0800, Ma Ke wrote:
> In function nixge_recv() dereference of NULL pointer priv->rx_bd_v is
> possible for the case of its allocation failure in netdev_priv(ndev).
> 
> Move while() loop with priv->rx_bd_v dereference under the check for
> its validity.
> 
> Cc: stable@vger.kernel.org
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/net/ethernet/ni/nixge.c | 86 ++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 230d5ff99dd7..2935ffd62e2a 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -603,64 +603,64 @@ static int nixge_recv(struct net_device *ndev, int budget)

Is this a hot path function? It appears to be used for every single
packet.

Is it possible to check for allocation failures outside of the hot
path? Is priv->rx_bd_v allocated once during probe? If so, fail the
probe.

	Andrew

