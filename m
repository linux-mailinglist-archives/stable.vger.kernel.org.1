Return-Path: <stable+bounces-164843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82361B12C62
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2466D3B963A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73537289343;
	Sat, 26 Jul 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfgOr/v1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA3215175;
	Sat, 26 Jul 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562915; cv=none; b=e2TpIsoYK7A4GTG5HxNLnVosNPrqnGUMJD4Jmhjob+51beU9iWfgmnCD/AeEiCzbPGecgRW9JSvjMKnhFoTeluzn2u6s6HOMMwxtmjlaUTFN5g2vwm7BwTZZln93sJ93QR9/zJfJzn6/mg0lXxd+ZXAtoThkKBOKZMb37i/+50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562915; c=relaxed/simple;
	bh=bU+4aFNSARke7Rm+3vDlswJMu5NtAU+xV7xo2Lk+CW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtJGWDcaPZK6oa/874tYGyu3dvjaw47slTttowSUKSw2ycYiM/RgSNK7OyNOIq8Pb/3Ie6h5FuWMkLXZQhqJBGQBPaq5zF7nGwY/j2eiluf7CCzNnppNz4W7Z7R/Eeezo3TJS7luNxt8PkOK0XsjCYgXJbyalS4D2I6gh3BNrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfgOr/v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACAFC4CEED;
	Sat, 26 Jul 2025 20:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753562914;
	bh=bU+4aFNSARke7Rm+3vDlswJMu5NtAU+xV7xo2Lk+CW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfgOr/v1cU8iQKAqQr9RiJro70NI+tbPO8epuBLnp9p0T8u9W9YSjjWTpPfCPgOcS
	 QaGZCiRsVQVvHplc5W4oLtOic2YBpSDryZWRvlYRai65SPmrR1f+BK4FY3V3P7eetV
	 Z82fRY5G+aEmglZKANsDHHmNzuGSVs9yWDyjlays2haLFkyX+hTkeJ1qxsAATg+y8g
	 EK8Gl8ZwMi3MSPjLLGiaXHpP3IWlnvfY/yFsPVaLxVnfweUikh7X8ul85PkueORCnn
	 mo2NVdbPywxxJt2PFCK9mYKkX/RrCYm4YOZzNiHbeyzldVTceE2Uz2sVKd+OD9cmif
	 HcgIPD9eZeCyg==
Date: Sat, 26 Jul 2025 21:48:28 +0100
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH 1/5] net: dpaa: fix device leak when querying time stamp
 info
Message-ID: <20250726204828.GQ1367887@horms.kernel.org>
References: <20250725171213.880-1-johan@kernel.org>
 <20250725171213.880-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725171213.880-2-johan@kernel.org>

On Fri, Jul 25, 2025 at 07:12:09PM +0200, Johan Hovold wrote:
> Make sure to drop the reference to the ptp device taken by
> of_find_device_by_node() when querying the time stamping capabilities.
> 
> Note that holding a reference to the ptp device does not prevent its
> driver data from going away.
> 
> Fixes: 17ae0b0ee9db ("dpaa_eth: add the get_ts_info interface for ethtool")
> Cc: stable@vger.kernel.org	# 4.19
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


