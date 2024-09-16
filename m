Return-Path: <stable+bounces-76522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9797A76F
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 20:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B651F26973
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514715B570;
	Mon, 16 Sep 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZCGFs6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6810A18;
	Mon, 16 Sep 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512536; cv=none; b=LhaiZlCdQXtvo6egPo/Q6GCpGxkzxHghuCupoFkjA0ymapBzBX1nViHKVXf3U1vaPZaoLybiKSxRArCcD/uQ912k1j994iV8LRvWwYHmM2aY7FM7uEeJVzWq8HCsbJgPmtvvRl4Q/9dq/9jzlH9QeYPWRYrzagoRLxlDJkUgJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512536; c=relaxed/simple;
	bh=3VFv/zWrSisLpDzIWFHA15d2bpwzJzlBd+b9/du9r1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZYu+f1HPJ3+R01eU6+xPEm7Bnez6taMa/pxNripgZHlTpBlUvPK0LAf398YOT8c+ugQL2yfEnXouDBkSWfRUsGH1/1tlH55CPCb4O8VkPa38ZYAaMg2W2pO7Ke12637u8fhSGOU+xELFd+J3N4M8FeC1pVtDig+TQshgWKE1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZCGFs6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C02CC4CEC4;
	Mon, 16 Sep 2024 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726512536;
	bh=3VFv/zWrSisLpDzIWFHA15d2bpwzJzlBd+b9/du9r1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZCGFs6sZYp6PmL7WuXolGSY7O9LtSI0HVW9jpvaxIlqJd0mrpA+ykMtEKbyAraZt
	 pyISlamNCM0GDtT/mM2nOwBRPM5LGZ0Y6zbqUrKvaGUaTB5KoTGFDQi0g+HFYkCHMG
	 OZHAWM/DMVcaDu/YV2zfO/UvMp8XLR5E/2NuEnI6+PDEOAba9JtnG+znWk6ccrG7MN
	 4oA+pN+Hpjy60b/G7ibTBf8uCfcVHryMluFmjL5zOR07Q2eq+Eo5CZA/gyOO9e9Y38
	 7c/1EUy/YpBzTtqRLiQULydHPCRGRRibu+FSElSYDgQ3F4uonygQhzXF+2cIV1AAeD
	 Ic9NVD3UXsqoQ==
Date: Mon, 16 Sep 2024 19:48:51 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Message-ID: <20240916184851.GD396300@kernel.org>
References: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>
 <20240916184443.GC396300@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916184443.GC396300@kernel.org>

On Mon, Sep 16, 2024 at 07:44:43PM +0100, Simon Horman wrote:
> On Mon, Sep 16, 2024 at 06:53:15PM +0200, Thomas Weißschuh wrote:
> > The rpl sr tunnel code contains calls to dst_cache_*() which are
> > only present when the dst cache is built.
> > Select DST_CACHE to build the dst cache, similar to other kconfig
> > options in the same file.
> > 
> > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> > Cc: stable@vger.kernel.org
> > ---
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org> # build-tested

Sorry Thomas, I missed one important thing:

Your Signed-off-by line needs to go above the scissors ('---')
because when git applies your patch nothing below the scissors
is included in the patch description.

