Return-Path: <stable+bounces-164847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD9B12C6D
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 22:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DE316D4D3
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A0289E3C;
	Sat, 26 Jul 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJOyo9H7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E7218ACA;
	Sat, 26 Jul 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563012; cv=none; b=EiP+aaV+chErWSEVs0vtdfBH3vLSI8F0P4m+RkmWqG+lz3lkf+o/gL5/t1R43wxZZIC8hG+pWDcj6QBEp7b2GBOJI6BtWV70MBqCm+0V5CPEPJSk5VWypdJWjEzPIOe3nkV+XfENgMFxQRrTVITQSkZHlu0RhFZqec3MJaNyIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563012; c=relaxed/simple;
	bh=lsogWYffGMntRuE0nmrEIvyEQKZCa4/Fg+UJfvetyUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovM0jjx/f2vWFSzIN3oq/jH8JHCqM+qH+6W7DFI/3W2nawRMbk6uRkhweZgqNtOWV25qViLJnw3PJRVlpse4STXfq+fZMNTMGzhw9sGWraoUftPRjKyu7+3lLL/+D8T50Cos9M/FVcgQcoIQkdCKJKCYcG9Dg9sL4csypVRLx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJOyo9H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADE0C4CEED;
	Sat, 26 Jul 2025 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753563011;
	bh=lsogWYffGMntRuE0nmrEIvyEQKZCa4/Fg+UJfvetyUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJOyo9H7C89NP4fsH1rvk2cO/eN9skZISwfzR9VxyRLcR9bx9rNR2//6MF4PPDn8/
	 ZZkKXN5d0fR7wd7JgTbYedOXP3zITscSfjYYLu4dHIO+AOruFBD1bu6Cpiw61XmEv5
	 Y9kjGEEkfwDwCEnhJUDDA+TwBqRYL4ZtYldeNWJqIWfnlI0Y8K22h8I1Jui9YZxdb1
	 NJwkVLwk2lvMz/SFVJYZN+nreSzFjduD5Q6m4iabIXFupLWWRx7SdOdi4VEo7qdnyt
	 vo/epbx7ak5wOT57uIYftQxRhQlpmzHYwayGScoIUVO/T5BQykhnmCF5PR71wVngCe
	 UzZ8yre9hVwyQ==
Date: Sat, 26 Jul 2025 21:50:06 +0100
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
Subject: Re: [PATCH 5/5] net: ti: icss-iep: fix device and OF node leaks at
 probe
Message-ID: <20250726205006.GU1367887@horms.kernel.org>
References: <20250725171213.880-1-johan@kernel.org>
 <20250725171213.880-6-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725171213.880-6-johan@kernel.org>

On Fri, Jul 25, 2025 at 07:12:13PM +0200, Johan Hovold wrote:
> Make sure to drop the references to the IEP OF node and device taken by
> of_parse_phandle() and of_find_device_by_node() when looking up IEP
> devices during probe.
> 
> Drop the bogus additional reference taken on successful lookup so that
> the device is released correctly by icss_iep_put().
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Cc: stable@vger.kernel.org	# 6.6
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


