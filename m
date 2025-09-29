Return-Path: <stable+bounces-181866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76CBA8D4E
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63226189B0F0
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755EC2FAC0A;
	Mon, 29 Sep 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8iurAn0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1E2D5941;
	Mon, 29 Sep 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140714; cv=none; b=V+vl1GA/jJ+7YpYGPtjM6gQ9gOI+Om8ik4unq9ZPHFRMbqkz8D92sMer+vXby2EIKPvyVYvBj30HrSbvL+DnE26XPmfqDu3B6Dunop2KQSNhB3Rn1QXK1LexkGu5affeLM5pkvsPYDd3e5y4L5ApZnvhp4UAc631jqON9JcgmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140714; c=relaxed/simple;
	bh=bappC4oStoNKCMlW7YZlHyC8czJ0rG294apAS852hhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGg1q12AOlZE3iTcElbLkT8TlaX0X7jS2HiaKL+OelkQOdhomFaurZx+oQlhfC8KMaavDSBrYcC9VEHBLWuvelN6V9lINbsdd2ggMYChy74KlJj6dy0g2xRmkLbmJusg6aQzhWz4DQxloY5EgkDUbcxAJZV5KAwUMAzBZ7uofGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8iurAn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC5C4CEF4;
	Mon, 29 Sep 2025 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759140713;
	bh=bappC4oStoNKCMlW7YZlHyC8czJ0rG294apAS852hhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8iurAn0431nSDnuXjWvSM2gSlIKGq/7ZQjb+DkKJnHDO0KjMf3Q4jv/nZnWpmAKR
	 9++n+ZCLM6CqXrE82EEraKLI2ZI6eC99qOgAEHkC7LhNGTTJTEeIPdQ4zxV7TUXMV9
	 2ZbiMz0QGCeAY+YIqkzoAsuVsczz6dedgpyxCqMl+mlundIC4VAVQg0cgo40wVkcV6
	 edtVG/K7g4gCJfl5/npKLGsnL2GWJtG7vyJ4zFylPeesHmeZzZk/Gc8Bl8PxrpEkcc
	 Wv1u7a4mb3CTOYzt9AfcarWeZ8yAbwrtlUxf9ygswgtjdwM6cs2/aH0LXTPinw2skd
	 wS/sXBlvNQ1WA==
Date: Mon, 29 Sep 2025 11:11:50 +0100
From: Simon Horman <horms@kernel.org>
To: Bo Sun <bo@mboxify.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] octeontx2-vf: fix bitmap leak
Message-ID: <aNpbZkQZxa3HkrJj@horms.kernel.org>
References: <20250927071505.915905-1-bo@mboxify.com>
 <20250927071505.915905-2-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927071505.915905-2-bo@mboxify.com>

On Sat, Sep 27, 2025 at 03:15:04PM +0800, Bo Sun wrote:
> The bitmap allocated with bitmap_zalloc() in otx2vf_probe() was not
> released in otx2vf_remove(). Unbinding and rebinding the driver therefore
> triggers a kmemleak warning:
> 
>     unreferenced object (size 8):
>       backtrace:
>         bitmap_zalloc
>         otx2vf_probe
> 
> Call bitmap_free() in the remove path to fix the leak.
> 
> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bo Sun <bo@mboxify.com>

Reviewed-by: Simon Horman <horms@kernel.org>

For reference, as a fix for code present in net, this series
should be targeted at net, like this:

Subject: [PATCH net 1/2] ...

See: https://docs.kernel.org/process/maintainer-netdev.html

