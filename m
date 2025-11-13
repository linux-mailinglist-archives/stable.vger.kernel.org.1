Return-Path: <stable+bounces-194710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A0FC59482
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F02514FF8E0
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69620368299;
	Thu, 13 Nov 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDCka9IN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD936828C;
	Thu, 13 Nov 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052600; cv=none; b=rasus+PqAqlVC88Z/XC8B2daZGhV6S0XlB3FWw1rTEPhtiRIPpnUkoQ9041iZ3/4A2q9Os6aRmpZrpiUdL3XOJdqIArNq6kSTuPcRPe2ldMNWEgaV2QUX/D+KJTxl0tLIPdLYtRicR6sNMCH4AXDYg/hLOeuZ4PLAaphyipmhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052600; c=relaxed/simple;
	bh=jKwcaTs9OGE50tqCMbBmlyCuHrBkn1lUUry6R0uYFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBoGtDktBzOC1MyDBwdyHouPX7LjmQ27NdWQZXEgZIeHu8fdLrjiMRk+H8D5BWJD8iYidK1dGt3Q9jCId/4FRPQT1VVP09oraxgBWI5lxyVe5qZ4K9SqUhJTEWipIfaj0QuAa4U3QgM0sWBK8CD8WT0L0oMEaqOsWGFW0SdS5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDCka9IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D47C4CEF5;
	Thu, 13 Nov 2025 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052599;
	bh=jKwcaTs9OGE50tqCMbBmlyCuHrBkn1lUUry6R0uYFMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDCka9INhlxX07+ZDkwnA2BjwPRDB17OtwMyUZVrOEBEhyHVb+xmEc1mytZUl6/vq
	 Z7noKS7xpGVkazchihr3BbMzvaqQbqP8pIetPJOrQSsXmuT02ZSz5OhHaNRB2U2gQe
	 fcN6dRUBnzSTOcb+dvdM5St1UnCO6atN1eAQYClN3l6lBU0c5mgTipIHTtClUhn2nN
	 ye4xmZIJnrosr7q2piuE2OI/reh0PnmZNAuDRlU3KoxkiJw5bHZwNOe3+7QIpzbVuy
	 rbwdZwdCFl34DkpUnAgbC8sFaAPlwx8D22NVCh2GYxEZpE14p1aVEsDfRZ3qSbw5xr
	 us7AUkWo3VPUw==
Date: Thu, 13 Nov 2025 22:19:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 phy 02/16] phy: lynx-28g: refactor lane probing to
 lynx_28g_probe_lane()
Message-ID: <aRYMM3ZuyBYH8zEC@vaman>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110092241.1306838-3-vladimir.oltean@nxp.com>

On 10-11-25, 11:22, Vladimir Oltean wrote:
> This simplifies the main control flow a little bit and makes the logic
> reusable for probing the lanes with OF nodes if those exist.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v3->v4:
> - patch is new, broken out from previous "[PATCH v3 phy 13/17] phy:
>   lynx-28g: probe on per-SoC and per-instance compatible strings" to
>   deal only with lane OF nodes, in a backportable way
> 
>  drivers/phy/freescale/phy-fsl-lynx-28g.c | 42 +++++++++++++++---------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> index c20d2636c5e9..901240bbcade 100644
> --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> @@ -579,12 +579,33 @@ static struct phy *lynx_28g_xlate(struct device *dev,
>  	return priv->lane[idx].phy;
>  }
>  
> +static int lynx_28g_probe_lane(struct lynx_28g_priv *priv, int id,
> +			       struct device_node *dn)
> +{
> +	struct lynx_28g_lane *lane = &priv->lane[id];
> +	struct phy *phy;
> +
> +	memset(lane, 0, sizeof(*lane));

priv is kzalloc, so why memset here?

-- 
~Vinod

