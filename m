Return-Path: <stable+bounces-204134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A458CCE824C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70548301AD0C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21C2D23A4;
	Mon, 29 Dec 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA5VvINc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730ED2C326B;
	Mon, 29 Dec 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767040766; cv=none; b=iYWUYAO4oDVGCzYpz6wDvW3n8x/RO1WhDSzUIiGMrZ3ATr2WTFNdTprRZXi518RWPpaxw1L/rWM+HxGLjhZwDPHGGZnPE882AZRJvA5QWH/Afg0RDf8ulwhyJN0m8rVkEY4/03E7AvAHu5o5L1DyKu1Kx2AjlwRXPBJiOEcWW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767040766; c=relaxed/simple;
	bh=8HiZDGiFI1Ej64HDHXl6T0blCYp6fT2OhJ3cyCelRKU=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nnoD7c8OyNm8HT3k8+ct5TQRMJz3ZkGR4wZ1hUWgT3dQyzjtnuKcOwwIJQCQKoRbyr9DM3/xpjUV+pLOheKqRWeytC9/DMtJW7CRHL0LiY3AHr3c+/9QwtL7YmrudkNBuLkvfjCaGKvVwKb3ppI/+AK+dEYyoUQyaWwEK5rKbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA5VvINc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E217CC4CEF7;
	Mon, 29 Dec 2025 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767040766;
	bh=8HiZDGiFI1Ej64HDHXl6T0blCYp6fT2OhJ3cyCelRKU=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=PA5VvINckjhy4V91bcU3EZ2+mTR8tSVR3Oy4ve5TUmnE2AMeiRMtdvDAN3oKV/6ch
	 SuS/pYBISnOn7ZPurKX/hWny5LPJas8W3FvgZEGUpilFYsnutsmShIsmX2BkHAe5ES
	 1F5Fyz6pxmMMjQF4xLk6QnutvUf7oEDIIDQn5XncAUWL/e3abzDMx2XX2xuh4rfnka
	 WmiFghSe8RSjd3JRT+okRsJGWZp0PmCNskgXDFaTJ83UJNg00RTsZCiaxQ6ZEvHt9K
	 uvW/u8A1vJO7P63IhpHuGuwRRa0ZBsec+ObGO8pOhg5egOisAnHY2vExM7zrvckxDi
	 FvH9guXxu1dGA==
From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Dec 2025 14:39:25 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 jserv@ccns.ncku.edu.tw, conor+dt@kernel.org, eleanor15x@gmail.com, 
 linux-arm-kernel@lists.infradead.org, linusw@kernel.org, krzk+dt@kernel.org, 
 arnd@arndb.de, devicetree@vger.kernel.org
To: Kuan-Wei Chiu <visitorckw@gmail.com>
In-Reply-To: <20251225173118.580110-1-visitorckw@gmail.com>
References: <20251225173118.580110-1-visitorckw@gmail.com>
Message-Id: <176703895443.2172504.7231951665641312391.robh@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: integrator: Fix DMA ranges mismatch
 warning on IM-PD1


On Thu, 25 Dec 2025 17:31:18 +0000, Kuan-Wei Chiu wrote:
> When compiling the device tree for the Integrator/AP with IM-PD1, the
> following warning is observed regarding the display controller node:
> 
> arch/arm/boot/dts/arm/integratorap-im-pd1.dts:251.3-14: Warning
> (dma_ranges_format):
> /bus@c0000000/bus@c0000000/display@1000000:dma-ranges: empty
> "dma-ranges" property but its #address-cells (2) differs from
> /bus@c0000000/bus@c0000000 (1)
> 
> The "dma-ranges" property is intended to describe DMA address
> translations for child nodes. However, the only child of the display
> controller is a "port" node, which does not perform DMA memory
> accesses.
> 
> Since the property is not required for the child node and triggers a
> warning due to default address cell mismatch, remove it.
> 
> Fixes: 7bea67a99430 ("ARM: dts: integrator: Fix DMA ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Switch approach to remove the unused "dma-ranges" property instead of
>   adding "#address-cells" and "#size-cells".
> 
>  arch/arm/boot/dts/arm/integratorap-im-pd1.dts | 1 -
>  1 file changed, 1 deletion(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20251219 (exact match)
 Base: tags/next-20251219 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/arm/' for 20251225173118.580110-1-visitorckw@gmail.com:

arch/arm/boot/dts/arm/integratorap-im-pd1.dtb: display@1000000 (arm,pl110): 'port@0' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/arm,pl11x.yaml






