Return-Path: <stable+bounces-166444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37393B19D46
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70ADB167E26
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE02376F8;
	Mon,  4 Aug 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu2A4myV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAD17D346;
	Mon,  4 Aug 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294691; cv=none; b=GPIjzibPFrd5QsU7XEyi9SB2lxKnMTR4msbnfUG0Ud/voAtVJmEPj8pPQdqkbfYQ7zyeED9y4Y/+WWeky+LXj4h7/q+JrAg93WNOz/L5dilDxtUv4JbI4B4r9qnZaQS12cGdaXlbkZKJ76qZBjU62rN2tehHp42UlU8YTf0TFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294691; c=relaxed/simple;
	bh=0VuAiQf0Cv59dj4webRh41zL7rvvJGbD0h50qzSBf/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmJ/QvpEGxLC4t7IMcf+KCIKbkKw2OFgNFjyV8wIwWiIQQbZNmr2Bisl5nY4RzNC9GrnxGU3sM0ULrP2H6kjCx4OLNZN57JWE48PHoSRzo872F/tgkyjjDYK4j9WpRXqyHGh6jBH342VlWzx6hyC9N+GVlYBodJK98GqtZ2XE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu2A4myV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42524C4CEE7;
	Mon,  4 Aug 2025 08:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754294690;
	bh=0VuAiQf0Cv59dj4webRh41zL7rvvJGbD0h50qzSBf/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu2A4myVOFLEZ1l+8CKNrn6eHiM+py3XVDkIXHweOcOB2xEfwRq3CnMqqMvzUeyZh
	 RHSkh/v7PvGQ3FWm9gmm3qBW6PolqxOe/KOoLCm6KMCMAWgaShAapuFroT6C7prGdL
	 cOLydI5cnPK5/NaDfNgMzwg4GpUH0B4Niz+6oOsNF/3ljrgeQDMDY3hwBifM0cPEiz
	 MHIaEgwlOREY+Eba/7cemGZvqIDkB6gaT+fLHXhi5UxykVEr1DsMGjL72OZ+2MMxZ8
	 UVMGy3wZuTB8m7Yh98z+kivQSSVMDyvq7bL0NGazUu7m9KOfAh0tWbvJAV5h40REHf
	 XyNkWWVk+eTlg==
Date: Mon, 4 Aug 2025 10:04:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Benoit Parrot <bparrot@ti.com>, Lee Jones <lee@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, thomas.petazzoni@bootlin.com, Jyri Sarha <jsarha@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mfd: syscon: Add ti,am625-dss-clk-ctrl
Message-ID: <20250804-industrious-neon-gorilla-2bbde6@kuoka>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <20250730-fix-edge-handling-v1-2-1bdfb3fe7922@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730-fix-edge-handling-v1-2-1bdfb3fe7922@bootlin.com>

On Wed, Jul 30, 2025 at 07:02:45PM +0200, Louis Chauvet wrote:
> The dt-bindings for the multi-function device (mfd) syscon need to include
> ti,am625-dss-clk-ctrl. On AM625 chips, the display controller (tidss) has
> external registers to control certain clock properties. These registers
> are located in the device configuration registers, so they need to be
> declared using syscon. They will later be used with a phandle in the tidss
> node.

I don't understand above commit msg. You add new compatible (new device)
but entire commit msg describes something else - some sort of a fix.

> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")

Heh? How? How adding a new driver needs fixes in the bindings?

This is just confusing.

> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> 
> Cc: stable@vger.kernel.org

That's not the way to add stable tag. See stable-kernel docs or any git
log history.


> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 27672adeb1fedb7c81b8ae86c35f4f3b26d5516f..afe4a2a19591e90c850c05ef5888f18bdb64eac9 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -121,6 +121,7 @@ select:
>            - ti,am62-opp-efuse-table
>            - ti,am62-usb-phy-ctrl
>            - ti,am625-dss-oldi-io-ctrl
> +          - ti,am625-dss-clk-ctrl

Don't break the order. o > c

>            - ti,am62p-cpsw-mac-efuse
>            - ti,am654-dss-oldi-io-ctrl
>            - ti,j784s4-acspcie-proxy-ctrl
> @@ -228,6 +229,7 @@ properties:
>            - ti,am62-opp-efuse-table
>            - ti,am62-usb-phy-ctrl
>            - ti,am625-dss-oldi-io-ctrl
> +          - ti,am625-dss-clk-ctrl

Same here

I don't understand also why you are adding clock to syscon. Clock
controllers have their own bindings.

Best regards,
Krzysztof


