Return-Path: <stable+bounces-18838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468D849BD4
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75081C22D82
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F551CD0B;
	Mon,  5 Feb 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG/97fVh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803022EF9;
	Mon,  5 Feb 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139928; cv=none; b=iMZ9lmPsYxcxzTzM3BYXukvFgVbz713FvVfwhQhiawpeNfLUsMSDznnP8ZGJIpn275RbPnxPcK0cE1WnrFP5J5KoA1j4rpkMRHgv5T7W40femjLRowJeVF0mNcaorROIM0HklBiXueQcwHb7yBYN5oNlZp13mNAcwLdIt4bZNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139928; c=relaxed/simple;
	bh=UfvJ7sEWE2/19mbyvGbE8STsck4O9H+cJOhv7PXy4IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj0oSgYi8mS5mVNeuJjyYOFMb1oLj1J3rwBMmWJ58m8j86v9ST5ejklN39WwV97CCuu6jXYLYrecz8H0FLe2GJoCaWw8himOa016+vUzEH3KLoAYVsO/KkBOVw4IhqXzLndeWnBuIz+ZWHfaNMiaA7dJPQKsYiPOeB40YTKuizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG/97fVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74053C433F1;
	Mon,  5 Feb 2024 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707139927;
	bh=UfvJ7sEWE2/19mbyvGbE8STsck4O9H+cJOhv7PXy4IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG/97fVh9gN9RgFPfsPhTM9X5zTm6ZMPvrrWIizKvhgtonmEl6KjePD2vcdco+J8u
	 ZBRMYHNlUxi5zCTh5L04y7ht7cuaB9vZ5BkFv/CZOiK8sZvPcRCOvX/ulBXNi/5H4i
	 RJLX3J7wadfoq6dUqpe/JlH6M4AUq/KrWAk1AvuE23+CyIKa4kTS+KUXvI1GYTuEHU
	 ME6xQ6g5wk8+HoZUjLziWoz9rw/WeBwmOn+O+E8K92BQ8ntNOPjmRnT7Lv32eXv9Fx
	 s1b9F1N3xMukkpj6dB2D/p4tC0wKJbwucssmZi1xN/MTSOC4VGFXOIw/sBZQKtF+gr
	 HTIgvzxzEbuXA==
Date: Mon, 5 Feb 2024 13:32:03 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 2/3] nfp: flower: prevent re-adding mac index for
 bonded port
Message-ID: <20240205133203.GK960600@kernel.org>
References: <20240202113719.16171-1-louis.peens@corigine.com>
 <20240202113719.16171-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202113719.16171-3-louis.peens@corigine.com>

On Fri, Feb 02, 2024 at 01:37:18PM +0200, Louis Peens wrote:
> From: Daniel de Villiers <daniel.devilliers@corigine.com>
> 
> When physical ports are reset (either through link failure or manually
> toggled down and up again) that are slaved to a Linux bond with a tunnel
> endpoint IP address on the bond device, not all tunnel packets arriving
> on the bond port are decapped as expected.
> 
> The bond dev assigns the same MAC address to itself and each of its
> slaves. When toggling a slave device, the same MAC address is therefore
> offloaded to the NFP multiple times with different indexes.
> 
> The issue only occurs when re-adding the shared mac. The
> nfp_tunnel_add_shared_mac() function has a conditional check early on
> that checks if a mac entry already exists and if that mac entry is
> global: (entry && nfp_tunnel_is_mac_idx_global(entry->index)). In the
> case of a bonded device (For example br-ex), the mac index is obtained,
> and no new index is assigned.
> 
> We therefore modify the conditional in nfp_tunnel_add_shared_mac() to
> check if the port belongs to the LAG along with the existing checks to
> prevent a new global mac index from being re-assigned to the slave port.
> 
> Fixes: 20cce8865098 ("nfp: flower: enable MAC address sharing for offloadable devs")
> CC: stable@vger.kernel.org # 5.1+
> Signed-off-by: Daniel de Villiers <daniel.devilliers@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Hi Daniel and Louis,

I'd like to encourage you to update the wording of the commit message
to use more inclusive language; I'd suggest describing the patch
in terms of members of a LAG.

The code-change looks good to me.

> ---
>  drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> index e522845c7c21..0d7d138d6e0d 100644
> --- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> +++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> @@ -1084,7 +1084,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
>  	u16 nfp_mac_idx = 0;
>  
>  	entry = nfp_tunnel_lookup_offloaded_macs(app, netdev->dev_addr);
> -	if (entry && nfp_tunnel_is_mac_idx_global(entry->index)) {
> +	if (entry && (nfp_tunnel_is_mac_idx_global(entry->index) || netif_is_lag_port(netdev))) {
>  		if (entry->bridge_count ||
>  		    !nfp_flower_is_supported_bridge(netdev)) {
>  			nfp_tunnel_offloaded_macs_inc_ref_and_link(entry,
> -- 
> 2.34.1
> 
> 

