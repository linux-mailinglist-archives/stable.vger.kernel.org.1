Return-Path: <stable+bounces-194709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A70C58F5B
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A4D43563A9
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D235E539;
	Thu, 13 Nov 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQpzzHWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442F2F5316;
	Thu, 13 Nov 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052414; cv=none; b=BJoh0/cwox+B4C3XST6RpMd5e1BlPaR3Xh48yNFRGlPVdHCq2InEnzyLKO0SwLi20M7xZ668t4Y28GfAbQdWKmGeyS0gWqnTmOodYU7ajU+dBTpaQIdMGZjRzPhSaywMhURirXuyOsJnHdUckm9scb6PSEvFdICPVxSbQc85eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052414; c=relaxed/simple;
	bh=6iUKG8NMVDDWdZqxXodaG87MpkmvyRMnCj8mZaI9oGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjsS9wQr4h9zPexPpWhgr9ekF/N7PbXQlc45gAZRUaTx2csEXr9QOaTE2WH9osh+8GnljaEJbdv/6Znoa8IXZxsrORcqSC7qXFaOEETTr2jnUml1z5ZX5Q7BzB9EiMRbYonyrFDxeYOjGxgaNDCB1G3wWsw/ZyOpfEOgHfKCISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQpzzHWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84FC4CEF1;
	Thu, 13 Nov 2025 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052413;
	bh=6iUKG8NMVDDWdZqxXodaG87MpkmvyRMnCj8mZaI9oGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQpzzHWZfMEVz7RF4t4SEwrbP4KnU0Mrr9M8bfDObp4UMhIvCk0AlwJpTVufHaRaf
	 HaFOR3enGDvFET1hyxQjgRoVgPm+fdkx+iwYVNYNTX3nmmT/kln7mrJYCYqO7tkEUu
	 reTVMej3LCfiM5gsJy+BqqMDUPTdNKHjy6UPtknxZ0YS6wyOywEWML4WUUr+aKd/uX
	 ORtQUsIR5Igrh+FzXxW1r/PqEoVa4Uz5eNzNisf1TYPM3SRbNdPCoFdAH6Wbr4T1Pl
	 I6OK88FQACAHQjzNTR+bKj7ksLuRnhM81EOQzPYAjDxbInFxaFqW7qph15laI/tp1e
	 1Tw/WNah60/5A==
Date: Thu, 13 Nov 2025 22:16:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 phy 01/16] dt-bindings: phy: lynx-28g: permit lane OF
 PHY providers
Message-ID: <aRYLeVUSk5G3DYlF@vaman>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110092241.1306838-2-vladimir.oltean@nxp.com>

On 10-11-25, 11:22, Vladimir Oltean wrote:
> Josua Mayer requested to have OF nodes for each lane, so that he
> (and other board developers) can further describe electrical parameters
> individually.
> 
> For this use case, we need a container node to apply the already
> existing Documentation/devicetree/bindings/phy/transmit-amplitude.yaml,
> plus whatever other schemas might get standardized for TX equalization
> parameters, polarity inversion etc.
> 
> When lane OF nodes exist, these are also PHY providers ("phys" phandles
> can point directly to them). Compare that to the existing binding, where
> the PHY provider is the top-level SerDes node, and the second cell in
> the "phys" phandle specifies the lane index.
> 
> The new binding format overlaps over the old one without interfering,
> but there is a caveat:
> 
> Existing device trees, which already have "phys = <&serdes1 0>" cannot
> be converted to "phys = <&serdes_1_lane_a>", because in doing so, we
> would break compatibility with old kernels which don't understand how to
> translate the latter phandle to a PHY.
> 
> The transition to the new phandle format can be performed only after a
> reasonable amount of time has elapsed after this schema change and the
> corresponding driver change have been backported to stable kernels.
> 
> However, the aforementioned transition is not strictly necessary, and
> the "hybrid" description (where individual lanes have their own OF node,
> but are not pointed to by the "phys" phandle) can remain for an
> indefinite amount of time, even if a little inelegant.
> 
> For newly introduced device trees, where there are no compatibility
> concerns with old kernels to speak of, it is strongly recommended to use
> the "phys = <&serdes_1_lane_a>" format. The same holds for phandles
> towards lanes of LX2160A SerDes #3, which at the time of writing is not
> yet described in fsl-lx2160a.dtsi, so there is no legacy to maintain.
> 
> To avoid the strange situation where we have a "phy" (SerDes node) ->
> "phy" (lane node) hierarchy, let's rename the expected name of the
> top-level node to "serdes", and update the example too. This has a
> theoretical chance of causing regressions if bootloaders search for
> hardcoded paths rather than using aliases, but to the best of my
> knowledge, for LX2160A/LX2162A this is not the case.
> 
> Link: https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: stable@vger.kernel.org

You can keep cc lines after s-o-b line after the '---' separator, that
way it will be skipped when applying while email client will cc folks.

My main question was cc stable, for a binding additions, that might not
be helpful as dts may not have these updates, so why port bindings?

-- 
~Vinod

