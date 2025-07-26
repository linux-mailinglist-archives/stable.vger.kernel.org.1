Return-Path: <stable+bounces-164844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50487B12C65
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781E1169FD4
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C33289343;
	Sat, 26 Jul 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbagI7oL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1B216E2A;
	Sat, 26 Jul 2025 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562963; cv=none; b=LfnblOruGUcMl+XAU4vgS+DWkupIbl0YUO1ATO4Zwu6cTVsQts7VIo0EN9Ohu1fDbihTXaxiRpRlgpap7XKnXlacoss08Em86sOMOsSwLjeSl+64Qc5z9zB1CaHDFDlneDrBFEiZ/pth/MYxMVxXxW4a/ENkvN7PayEXzAweQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562963; c=relaxed/simple;
	bh=0yZGopN/hY6jjc5Z28lf1KXbdoTOGhFqzN1wGVQjGU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBPjELS5yHOgCogBqFA1f8kw5c6stGFDRApJk/Q3Chc2Iy6qfnpAJBTEGzdD5QhTQVlsFdnkxGJJNtUICoblGJIVKrIQoNkOHqBJjg7pkkwTYA8X5tOKTvhx0sQCUC9BiaANLSifMG/EbTIor3vbrgcr8vmyqAPk7929hicruE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbagI7oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FDFC4CEED;
	Sat, 26 Jul 2025 20:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753562962;
	bh=0yZGopN/hY6jjc5Z28lf1KXbdoTOGhFqzN1wGVQjGU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbagI7oLPLKpBYAsJwTLtgWBRm22dpgQhxHDBwfqbedmkqhlaxX5fFwQpoxV1vq8S
	 auhoJG0PdOt+ojimF9uwd8Q4lpILovrtrAtVQv6VOWase2N6QLbIMwqW6uGkpvlpDn
	 XV3eBHPumwT4JQV0a0UnpYwoNFbiXiuuvvsrjqTaDTnIz9KKXWNEpqAxfCE5114kyO
	 n/37jWRNtSmUlwo9VC5+EpRMh5jVXIpwlBZufbcWdrP6NXWuGmJ2xXiTC0ZrQEswXA
	 gIgLR4nGvVYoc1uSBHL6k4Gs3PBlRTbYQYKt5nrfHXXArRfWKNQ+9NE/pCMbMQlqU1
	 owhWYS3ZrH4Cw==
Date: Sat, 26 Jul 2025 21:49:16 +0100
From: Simon Horman <horms@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] net: enetc: fix device and OF node leak at probe
Message-ID: <20250726204916.GR1367887@horms.kernel.org>
References: <20250725171213.880-1-johan@kernel.org>
 <20250725171213.880-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725171213.880-3-johan@kernel.org>

On Fri, Jul 25, 2025 at 07:12:10PM +0200, Johan Hovold wrote:
> Make sure to drop the references to the IERB OF node and platform device
> taken by of_parse_phandle() and of_find_device_by_node() during probe.
> 
> Fixes: e7d48e5fbf30 ("net: enetc: add a mini driver for the Integrated Endpoint Register Block")
> Cc: stable@vger.kernel.org	# 5.13
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

