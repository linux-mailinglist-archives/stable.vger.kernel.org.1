Return-Path: <stable+bounces-136890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F262EA9F17C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190033B29BA
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF002222A0;
	Mon, 28 Apr 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKqUe1gO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025426A1C9;
	Mon, 28 Apr 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844869; cv=none; b=MfLg8neBbJvIQG23MqTzz1fTXJ7ub/b8LqhbIsK8y0fEmAqLa1U24e4bjI9+AMCortH5tw6Mn49QXdteUg/VNceIL6NkLYqx2yd4WS94eXAgDBl/zh03t2zMWBRpoQvznmbaw/HWalcAJvWmtOTmYHIbnyN4VKruu774wx8CAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844869; c=relaxed/simple;
	bh=YqrDjLkBrhnaV9yjOSRyWySxuTsVl41VwmfzZMDL+qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVsforPhIljUMBvXrVsPBZy6VnYoVLRJk2lG9LBlA2gigtLCfqmDhwA0Je18xI2qtBTOrGgMefHK8U7AocdoRx+YYPTJNyT6rRVO1by2d9p0V7fxnUox9AdFc2l1CNkd2QAPowVkUwNhbfXyWg2udOGJfOyKIqO8XAlsBh3hGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKqUe1gO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132FC4CEE4;
	Mon, 28 Apr 2025 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745844869;
	bh=YqrDjLkBrhnaV9yjOSRyWySxuTsVl41VwmfzZMDL+qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKqUe1gOrZsbfRp7TyjcjprWhH8xs1A72RtqY+xokIr0gm+t9oP8HYeD6iwHvvt0u
	 lr7pLO8qEY78N4Esb5/OUt6VbwSX01p2zYicNQazw07PIL9pALzrY/qJ95hx19d6m9
	 csm5tl2OHomd6ka0x6t6ZJMlREbZZ+COn9XfbhqAOcL3gGr7wz1jgWppyAJIQCRlWz
	 6+iJK8djbcxLpxnYh3BJ5owzZr5OCYs+ubbRDouJNvpxsX+rmxwjtiJM7mjoXY8KDy
	 RbrUBq52j+HKeRnVTcS/58yOYNXNYEPNWmb5FQismQZCYg5E/fLuxjd8+H27F/MCJt
	 b4i/q6Ls6StHw==
Date: Mon, 28 Apr 2025 13:54:24 +0100
From: Simon Horman <horms@kernel.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Thomas.Lendacky@amd.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Raju.Rangoju@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net V3] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
Message-ID: <20250428125424.GC3339421@horms.kernel.org>
References: <20250424130248.428865-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424130248.428865-1-Vishal.Badole@amd.com>

On Thu, Apr 24, 2025 at 06:32:48PM +0530, Vishal Badole wrote:
> According to the XGMAC specification, enabling features such as Layer 3
> and Layer 4 Packet Filtering, Split Header and Virtualized Network support
> automatically selects the IPC Full Checksum Offload Engine on the receive
> side.
> 
> When RX checksum offload is disabled, these dependent features must also
> be disabled to prevent abnormal behavior caused by mismatched feature
> dependencies.
> 
> Ensure that toggling RX checksum offload (disabling or enabling) properly
> disables or enables all dependent features, maintaining consistent and
> expected behavior in the network device.
> 
> v2->v3:
> -------
> - Removed RSS feature toggling as checksum offloading functions correctly
> without it
> 
> v1->v2:
> -------
> - Combine 2 patches into a single patch
> - Update the "Fix: tag"
> - Add necessary changes to support earlier versions of the hardware as well

Hi Vishal,

I don't think there is any need to resend because of this.
But, for future reference, these days it is preferred to put changelog
information, such as the above two paragraphs, below the scissors ("---").

This way they are present in mailing list archives and so on.
But are omitted from git history (because the patch description is
truncated at the scissors).

> 
> Cc: stable@vger.kernel.org
> Fixes: 1a510ccf5869 ("amd-xgbe: Add support for VXLAN offload capabilities")
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-desc.c |  9 +++++++--
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c  | 24 +++++++++++++++++++++--
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 11 +++++++++--
>  drivers/net/ethernet/amd/xgbe/xgbe.h      |  4 ++++
>  4 files changed, 42 insertions(+), 6 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


