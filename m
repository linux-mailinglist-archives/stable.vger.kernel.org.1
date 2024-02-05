Return-Path: <stable+bounces-18839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6733849BF3
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86011C23C51
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595151CD1C;
	Mon,  5 Feb 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpQKRRDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2F2C1A3;
	Mon,  5 Feb 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140150; cv=none; b=QoYAFW8KXpQk2nX9qwuEQ3CcyuQMXJkb+pf63IRGppP7Xs93gPt0yEM2/tofi+z2FSBU7wD530i0kuWRxE/l8v49I3+OxN7Eo49AAM9q48mI5HDDGcN1U3k7FzAobGpsv66uv+leDP2vgZMqV6FTtpe5p65M9/Egrsuf6I57yB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140150; c=relaxed/simple;
	bh=gXsiwKu0fmXcNczWKkuGEIePEvZZ6KW9bACGghjBRDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRiHpkT/tuL3AuyE2TbsSMTneAvEnqdWVKBKke5RMcemPNw8kHkymggRmwfetY2NosQh8qpxsgJaPUO2i87G78P3dnkqbC6c28e23gh6F9V3Zq1yXaoYckf8Nq3oYAMdqeqeQZbUOCgpzJagVSBogJ2jSngnfVmYMdWAzYRoOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpQKRRDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE02C433F1;
	Mon,  5 Feb 2024 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707140149;
	bh=gXsiwKu0fmXcNczWKkuGEIePEvZZ6KW9bACGghjBRDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpQKRRDStcV6jpRFUH/LoBNcqATgei5zNPaMnr8IIYTcMhjoGOovb5SS3nGglBJim
	 f4jxbngyPz4kLV1r/te8vQkmik4pbF8X6FJ65oilJkDeTmXU8SbOtUuQCDWZoHg5zy
	 3a8UnkoYQZ5LrjxnbGo6NjHp5d7Mo+Yun6+6X19p8s/ZMYWduIeInWScIOJeC0XZME
	 zFVx6+wGRXO8KhQmzbHRMK5NVRO4DpQS3yZRUsS1h/G3Bffs7Yfz2UQOEwn7yXtuX0
	 AwdojbFJj8GxWChN6POGeg5TDnaLwIAUWx7RIjn+2iUTUNIdTI5+/Vryk3wj7q8K0T
	 50rKmupnb9TZg==
Date: Mon, 5 Feb 2024 13:35:45 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 1/3] nfp: use correct macro for LengthSelect in BAR
 config
Message-ID: <20240205133545.GL960600@kernel.org>
References: <20240202113719.16171-1-louis.peens@corigine.com>
 <20240202113719.16171-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202113719.16171-2-louis.peens@corigine.com>

On Fri, Feb 02, 2024 at 01:37:17PM +0200, Louis Peens wrote:
> From: Daniel Basilio <daniel.basilio@corigine.com>
> 
> The 1st and 2nd expansion BAR configuration registers are configured,
> when the driver starts up, in variables 'barcfg_msix_general' and
> 'barcfg_msix_xpb', respectively. The 'LengthSelect' field is ORed in
> from bit 0, which is incorrect. The 'LengthSelect' field should
> start from bit 27.
> 
> This has largely gone un-noticed because
> NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT happens to be 0.
> 
> Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
> Cc: stable@vger.kernel.org # 4.11+
> Signed-off-by: Daniel Basilio <daniel.basilio@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Hi Daniel and Louis,

If I'm reading this right then this is a code-correctness issue
and there is no runtime effect (because 0 is 0 regardless of shifting and
masking).

If so, I'd suggest that this is net-next material.
And, in turn, if so the Fixes tag should be dropped.

> ---
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> index 33b4c2856316..3f10c5365c80 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> @@ -537,11 +537,13 @@ static int enable_bars(struct nfp6000_pcie *nfp, u16 interface)
>  	const u32 barcfg_msix_general =
>  		NFP_PCIE_BAR_PCIE2CPP_MapType(
>  			NFP_PCIE_BAR_PCIE2CPP_MapType_GENERAL) |
> -		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT;
> +		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
> +			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT);
>  	const u32 barcfg_msix_xpb =
>  		NFP_PCIE_BAR_PCIE2CPP_MapType(
>  			NFP_PCIE_BAR_PCIE2CPP_MapType_BULK) |
> -		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT |
> +		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
> +			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT) |
>  		NFP_PCIE_BAR_PCIE2CPP_Target_BaseAddress(
>  			NFP_CPP_TARGET_ISLAND_XPB);
>  	const u32 barcfg_explicit[4] = {
> -- 
> 2.34.1
> 
> 

