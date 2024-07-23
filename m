Return-Path: <stable+bounces-60723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417D93987E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 04:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D667B21F34
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011C13C90E;
	Tue, 23 Jul 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcNy7B/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3713C818;
	Tue, 23 Jul 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703457; cv=none; b=fN1vopOFtjF34E8s0UBeNpB7z5S/cJbbYazqJ7mAyoJ6TbGlgiLgtK0xG7MBH2QU8oUvQImNok9hv515GXXmGaW1qIli0MNlyli1sORZJrKxL7mkgCMuDqvd785NHvCgnM4e+nh7ZADlKqGAJShpa3tGpj3bwRtEMUuYLKLZ8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703457; c=relaxed/simple;
	bh=S/zDUoK/wOB3rI+BZgSAPwfa6YvcK/ZFEfSAjQA7fkw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UVJLk9B0u0Xs57Akg8Kp7pdtY9JBaKQxsqnuHdRoHI0JJY05zWST4sQZyPoxPSVjXSdWAFyo8GiuzQEz/vVSzsgdokF574/9goDtQ0KT8X38GDpRGpuyTfcuKNPpi47C32KdgZRNRIRasHuGl2NboWC7nQA6BPAcGQsdhglheiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcNy7B/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E264BC32782;
	Tue, 23 Jul 2024 02:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721703457;
	bh=S/zDUoK/wOB3rI+BZgSAPwfa6YvcK/ZFEfSAjQA7fkw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mcNy7B/zTna23ZuGW3hu2uV2aX6ZzmjF+yDG/Ps07WonEgj876aF7xrL3AIaWhb5f
	 sVebQLFRySpZs6Mr8V9MV+h+/lcX6KuijBZskrViVWdCihT1P6nhE9n9GwwPdFry8V
	 SuuK52Uwfxrt+1HFAuPc/On5uO/ydPGJ3fUOmjSaoTb6a711+JHhgoxiH4vgl7Yu8e
	 lpey7xTJL0t9X53QFh4rbNxMFLb+6zLKAuSbkLwWcceI26BjTlCXASkel4aaHrjjFA
	 wiT6UTHXMkg/CI0cV3AZQdv0g02EUTLx1vQE1dbKzksiwWjJM+TakGH5FN9MgX6snL
	 dn8v1YC9jI5gA==
Date: Mon, 22 Jul 2024 20:57:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 linux-phy@lists.infradead.org, Yazan Shhady <yazan.shhady@solid-run.com>, 
 Konstantin Porotchkin <kostap@marvell.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>
In-Reply-To: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
Message-Id: <172170324618.205229.14421004930608036629.robh@kernel.org>
Subject: Re: [PATCH RFC v3 0/6] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys


On Sat, 20 Jul 2024 16:19:17 +0200, Josua Mayer wrote:
> Armada 380 has smilar USB-2.0 PHYs as CP-110 (Armada 8K).
> 
> Add support for Armada 380 to cp110 utmi phy driver, and enable it for
> armada-388-clearfog boards.
> 
> Additionally add a small bugfix for armada-388 clearfog:
> Enable Clearfog Base M.2 connector for cellular modems with USB-2.0/3.0
> interface.
> This is not separated out to avoid future merge conflicts.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - updated bindings with additional comments, tested with dtbs_check:
>   used anyOf for the newly-added optional regs
> - added fix for clearfog base m.2 connector / enable third usb
> - dropped unnecessary syscon node using invalid compatible
>   (Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> - Link to v2: https://lore.kernel.org/r/20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com
> 
> Changes in v2:
> - add support for optional regs / make syscon use optional
> - add device-tree changes for armada-388-clearfog
> - attempted to fix warning reported by krobot (untested)
> - tested on actual hardware
> - drafted dt-bindings
> - Link to v1: https://lore.kernel.org/r/20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com
> 
> ---
> Josua Mayer (6):
>       arm: dts: marvell: armada-388-clearfog: enable third usb on m.2/mpcie
>       arm: dts: marvell: armada-388-clearfog-base: add rfkill for m.2
>       dt-bindings: phy: cp110-utmi-phy: add compatible string for armada-38x
>       arm: dts: marvell: armada-38x: add description for usb phys
>       phy: mvebu-cp110-utmi: add support for armada-380 utmi phys
>       arm: dts: marvell: armada-388-clearfog: add description for usb phys
> 
>  .../phy/marvell,armada-cp110-utmi-phy.yaml         |  34 +++-
>  .../boot/dts/marvell/armada-388-clearfog-base.dts  |  41 ++++
>  arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   8 +
>  arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi |  30 ++-
>  arch/arm/boot/dts/marvell/armada-38x.dtsi          |  24 +++
>  drivers/phy/marvell/phy-mvebu-cp110-utmi.c         | 209 ++++++++++++++++-----
>  6 files changed, 288 insertions(+), 58 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240715-a38x-utmi-phy-02e8059afe35
> 
> Sincerely,
> --
> Josua Mayer <josua@solid-run.com>
> 
> 
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


New warnings running 'make CHECK_DTBS=y marvell/armada-388-clearfog-base.dtb marvell/armada-388-clearfog.dtb' for 20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com:

arch/arm/boot/dts/marvell/armada-388-clearfog-base.dtb: usb@58000: phy-names:0: 'usb' was expected
	from schema $id: http://devicetree.org/schemas/usb/generic-ehci.yaml#
arch/arm/boot/dts/marvell/armada-388-clearfog.dtb: usb@58000: phy-names:0: 'usb' was expected
	from schema $id: http://devicetree.org/schemas/usb/generic-ehci.yaml#
arch/arm/boot/dts/marvell/armada-388-clearfog-base.dtb: usb3@f0000: Unevaluated properties are not allowed ('compatible', 'dr_mode', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm/boot/dts/marvell/armada-388-clearfog-base.dtb: usb3@f8000: Unevaluated properties are not allowed ('compatible', 'dr_mode', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm/boot/dts/marvell/armada-388-clearfog.dtb: usb3@f0000: Unevaluated properties are not allowed ('compatible', 'dr_mode', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm/boot/dts/marvell/armada-388-clearfog.dtb: usb3@f8000: Unevaluated properties are not allowed ('compatible', 'dr_mode', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#






