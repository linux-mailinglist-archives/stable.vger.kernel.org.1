Return-Path: <stable+bounces-200206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935ACA9856
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 23:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FDE831F82FD
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9F2D8767;
	Fri,  5 Dec 2025 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4zQviDM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A32ED871;
	Fri,  5 Dec 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764974210; cv=none; b=ORRRsLxJNm6ndcrtnfI0FFkAwzBElGrKMphMvHxfWNOkqeKaVj/ZNhuPE6mJPfN3mS3qpkD9VAm1z0ObfKsT0TT1MrKcPlQ7CEcHNvIil4KOWYlhHFqHOJDaqdVDqmjwzilIXv7DFd3ycXcgFlCSv5WCqR83LknsoxIWOGJeqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764974210; c=relaxed/simple;
	bh=a+i6OuMIceb2KmmLexgRXeIiGsHIMcZGP0HUwSar5+U=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sBWxOwKJGswWJfri/luCG/FC7mwAcuZ0W+5gAEzikC5RuJ9Mtv8pP2DwO5FTiBa2SZBaUqtQHpEiA191uM84RILJKJ1gTu5RB7UOCHZtNnAcQC6V9VnoB8ptvejaJ+3knD7vpb9DgeRoY64k+FZstMakSJWsczAA2KqKnLab5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4zQviDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C8C4CEF1;
	Fri,  5 Dec 2025 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764974207;
	bh=a+i6OuMIceb2KmmLexgRXeIiGsHIMcZGP0HUwSar5+U=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=M4zQviDM94cwfYTDIH84VqYAmVj0dqH0Tk/7q54eVs17XLFKBu0T7B5q5YuhobEmB
	 hK1PEvvEroUi5XELMncX3pmEso7mVWTfkJBrQT2EYpkYwuUvhYmsz9WK294W1rGCuf
	 EYWznZ7HduZdpML6Q9dCylQGrRGYRNxSESl0qxi/aipNWSoGfdC29HlZXiEUXost5Y
	 /swkuERMh3CQO4L3iwT+ZV55vBa9OjS6/JozBH7oM7r4+oMJSBBNbJnZXeCgZppeJr
	 wUpOdRAWO5GQWlr0jUn1zISlX3L6Ba73qmGpV0s23INhHhLNuhXxWnw5vEJPBgG0uM
	 Z+MyP2N8q9IyA==
From: Rob Herring <robh@kernel.org>
Date: Fri, 05 Dec 2025 16:36:46 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: linus.walleij@linaro.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 arnd@arndb.de, devicetree@vger.kernel.org, stable@vger.kernel.org, 
 krzk+dt@kernel.org, jserv@ccns.ncku.edu.tw
To: Kuan-Wei Chiu <visitorckw@gmail.com>
In-Reply-To: <20251204164228.113587-1-visitorckw@gmail.com>
References: <20251204164228.113587-1-visitorckw@gmail.com>
Message-Id: <176497381720.863571.13455719382013086980.robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: integrator: Fix DMA ranges mismatch warning
 on IM-PD1


On Thu, 04 Dec 2025 16:42:28 +0000, Kuan-Wei Chiu wrote:
> When compiling the device tree for the Integrator/AP with IM-PD1, the
> following warning is observed regarding the display controller node:
> 
> arch/arm/boot/dts/arm/integratorap-im-pd1.dts:251.3-14: Warning
> (dma_ranges_format):
> /bus@c0000000/bus@c0000000/display@1000000:dma-ranges: empty
> "dma-ranges" property but its #address-cells (2) differs from
> /bus@c0000000/bus@c0000000 (1)
> 
> The display node specifies an empty "dma-ranges" property, intended to
> describe a 1:1 identity mapping. However, the node lacks explicit
> "#address-cells" and "#size-cells" properties. In this case, the device
> tree compiler defaults the address cells to 2 (64-bit), which conflicts
> with the parent bus configuration (32-bit, 1 cell).
> 
> Fix this by explicitly defining "#address-cells" and "#size-cells" as
> 1. This matches the 32-bit architecture of the Integrator platform and
> ensures the address translation range is correctly parsed by the
> compiler.
> 
> Fixes: 7bea67a99430 ("ARM: dts: integrator: Fix DMA ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  arch/arm/boot/dts/arm/integratorap-im-pd1.dts | 2 ++
>  1 file changed, 2 insertions(+)
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
 Base: tags/v6.18-rc6-2004-g29bce9c8b41d (exact match)
 Base: tags/v6.18-rc6-2004-g29bce9c8b41d (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/arm/' for 20251204164228.113587-1-visitorckw@gmail.com:

arch/arm/boot/dts/arm/integratorap-im-pd1.dtb: display@1000000 (arm,pl110): '#address-cells', '#size-cells', 'dma-ranges', 'port@0' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/arm,pl11x.yaml






