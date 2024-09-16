Return-Path: <stable+bounces-76521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6397A768
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 20:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797E528560A
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE21115ADAF;
	Mon, 16 Sep 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGZIHWSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699C168DA;
	Mon, 16 Sep 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512288; cv=none; b=p70o7qT2QfTJEBFjZb0T+cs73wTRc8Rrzinc+kDpy+rQYDc9rvM0KOoCMvgQbwx9+rIFAxsxglRpuZjWCtFXgPM6XHckR39nemNc5+vXJ2Nt2VworefC36llt0vBbBzi4rFCo+kza9CSjm6oMKEr33asuSNvyWfWlCaAgra6WQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512288; c=relaxed/simple;
	bh=dISbbvHmGqx42WhRvhAuosf+zG38HM57MieCseV03VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMB1rONJFEHaZRzJ5i/I5OOQyjfr8x8BFqzbOWkffFh7ZEaJaNyTPZQI8ab6pjQwWx/9I3BVRShnHfGNMWDbsBo3X+YQQfpZt7StWm2aqTc/qaYJ2oXVEGVgX5ufFn727kJcInug5Jq0Q8VbHUZItUXdmj2ACzrwmvG/UJ8mBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGZIHWSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F730C4CEC4;
	Mon, 16 Sep 2024 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726512288;
	bh=dISbbvHmGqx42WhRvhAuosf+zG38HM57MieCseV03VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGZIHWSUpBrO/9dBhEZrpz3JLP1orNjuR8/LGD00vQuz6hl8o3FztyRFi4evCZAuM
	 yVHhiRuVFboh9OxfJHtZm5OBW/0SXfMHmiwDoG0tmgqc2jFHvo+yLDP2cNXBoMUYFT
	 YcCrOf/DR+QqzIxlzynv22HVzDT7ls/9DVDXm/WfQdsPFS7vyKRaVm/wNyOZ9ZU32J
	 cD77aNIFWJtKh6kgFXAH4W9RyYwLpyGpExfKOvRZF1ZFpbnpu85aCFjs8ICGoXdUGC
	 jD4fWn6aChHWgFgnWFbTcd3D2mrelbdjuyr1dFhXcOKguqBSNNoTWg6HTtsUG9VA3/
	 fW/D4kOMr3lFA==
Date: Mon, 16 Sep 2024 19:44:43 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Message-ID: <20240916184443.GC396300@kernel.org>
References: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>

On Mon, Sep 16, 2024 at 06:53:15PM +0200, Thomas Weißschuh wrote:
> The rpl sr tunnel code contains calls to dst_cache_*() which are
> only present when the dst cache is built.
> Select DST_CACHE to build the dst cache, similar to other kconfig
> options in the same file.
> 
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Cc: stable@vger.kernel.org
> ---
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

