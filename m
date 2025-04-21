Return-Path: <stable+bounces-134796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB1A951AD
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F176C7A43B6
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B08266564;
	Mon, 21 Apr 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9/aXBKv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42C265CDF;
	Mon, 21 Apr 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242153; cv=none; b=orEbMDdhePiVAY7p5xvBLLBtwDjAsLYqBj2Spfx1fdaqUUiBjkk+BXQDySJJpICFL+b5UMJ3Tn27MI5ZLEY+a0nAixwo2B05G5KWE+OtYRgNgxvZptLCTObbIG3mTvAZ15YJ+W7IBJKzyS4N43UuzSTFCV4nfQ0EYxODqyouJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242153; c=relaxed/simple;
	bh=OjPb0Os4g0jA2afhKN6cIy2DeKVLhPUQwkDjg8pUgS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at5gKxOslsPFzedQpTr6LFF9zt/lYfXqrtUsTw7pmm/nC1zYXjRixzauGRstoz9weJOt7Bj1pCv5u5E3LIqF75Qe/ZzsMSJ6hgSySUzvuIl1jb1psivTu42rcVBjwifkoEGOh9dinY38IJ4+9mWnfd3/rOf5sg4CJV1DPWZKqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9/aXBKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D329C4CEE4;
	Mon, 21 Apr 2025 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745242152;
	bh=OjPb0Os4g0jA2afhKN6cIy2DeKVLhPUQwkDjg8pUgS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9/aXBKvN9npDfV9FJZez4cOROYseG1kEekFKeg1iwhYLObUU/EfvpSzidlVFpI91
	 RnKxLQ5jK1YsKzrTY6iw0x1Am/cu+4jO6xipAMzYxLSplamBBjj5I4+IU1XLpV4yB9
	 neHBwOBNGva+5DlU/ccArocqWCyflgEsbol044vnHtFuVdESK4BJkZVrQhALJuUymO
	 RpzFNwv5NuK1AnW8A38XwTKnyciLIDBeMcAqFrLnBOFAxyxSOjsSlB+HCb8elPY5mX
	 vniE4FR0PUEZF3khF0ghVXZxWLvQ/tyaTUkSX2rZacg524WVTFnmzm4o3v1hVd+/HV
	 OxZ6AMoimFb0g==
Date: Mon, 21 Apr 2025 14:29:08 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v1 1/1] net: selftests: initialize TCP header and skb
 payload with zero
Message-ID: <20250421132908.GF2789685@horms.kernel.org>
References: <20250416160125.2914724-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416160125.2914724-1-o.rempel@pengutronix.de>

On Wed, Apr 16, 2025 at 06:01:25PM +0200, Oleksij Rempel wrote:
> Zero-initialize TCP header via memset() to avoid garbage values that
> may affect checksum or behavior during test transmission.
> 
> Also zero-fill allocated payload and padding regions using memset()
> after skb_put(), ensuring deterministic content for all outgoing
> test packets.
> 
> Fixes: 3e1e58d64c3d ("net: add generic selftest support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: stable@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


