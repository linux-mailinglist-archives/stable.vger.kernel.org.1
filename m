Return-Path: <stable+bounces-194630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C22C53A6B
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 18:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B763BF423
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C233F36E;
	Wed, 12 Nov 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwbKob8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3D32B985;
	Wed, 12 Nov 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964447; cv=none; b=cQendyDnE1idi+SjqjuzuCSGmXo3m39TIsp0GX5MuFtaBbneA0/klUozWo2M/cEu9WqSGDnhqrSLiifhnw2IvKbFNmbNQ0Htkf0QiZm+nUqNxmZPyrhyzUW/He79YnMbZ3haVtNChhGVtL8OTB1WA+9BSDTiuwh/V7DCsOmsRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964447; c=relaxed/simple;
	bh=rHIrbwjlYH/gBkXgGCh/M7lUpBCIVsmiYtKm0JkgxPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Q1pEeXqptPGaThfpIY4dXgw0sQ/MG12ltAvhLkscu0OeQSsb+uG6tQh+i8KCqSMb4gfprxhkwS/Zi93lIItlQuy/0Wby8zRmtdI441r6AmaYkpFwp+Q90tjQ6eNxeejITOsJsvbkiTkk7WlXzNkQOQvuZKVLOwcwAa9SLbJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwbKob8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13026C4CEF5;
	Wed, 12 Nov 2025 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964447;
	bh=rHIrbwjlYH/gBkXgGCh/M7lUpBCIVsmiYtKm0JkgxPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwbKob8zPfvEsJwbsrZY0piMuxlW03+AXKU/9/+zihz4TvIleDu/JeviNaHOGroWY
	 DzOjMJ6G4YkRDhlPMBuGrHiKXCxx4VfBDWJCAh07/wk/Atwmpt+ZZPqI+jxO90lFUT
	 zdoDcuNxppBEqVBDzte6v2Cv0d3RyDJpg7ak6qCbrq4JaPrj129FIn+0Q6UtM7acNv
	 XNNXve0WdlNKzr3rAePDWe6oINOCAXo2aKAUbfyYq0UF1lsuRAHdy5sqfSDM0NfrE/
	 BRkLd/Q84Rmgr+6v5OiR0492m8RuyJzj85kYkj3ofOEuA8fStSLTFOXhgrBoesWMkp
	 /jy5GOPytQeMA==
Date: Wed, 12 Nov 2025 10:20:45 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v4 phy 01/16] dt-bindings: phy: lynx-28g: permit lane OF
 PHY providers
Message-ID: <176296444496.1846369.12547968881654162757.robh@kernel.org>
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


On Mon, 10 Nov 2025 11:22:26 +0200, Vladimir Oltean wrote:
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
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v3-v4: patch is new (broken out from previous "[PATCH v3 phy 12/17]
>        dt-bindings: phy: lynx-28g: add compatible strings per SerDes
>        and instantiation") to deal just with the lane OF nodes, in a
>        backportable way
> 
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 71 ++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


