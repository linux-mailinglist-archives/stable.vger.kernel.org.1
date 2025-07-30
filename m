Return-Path: <stable+bounces-165604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C10B16981
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 01:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600E0562CA3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 23:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83F230BC9;
	Wed, 30 Jul 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2kOSmy8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A041760;
	Wed, 30 Jul 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919814; cv=none; b=X6s9tUdrGv4ejLb8pifWhfjGT5m7lU/cN3VW8d8IfTc/ygs2YZ3dN0KAY4f4aoFoNnz+gPh1p+q4isp9YS0J9H5NxY1ASr+xjwxGnIPqtjRyNQpB14rmj0SGmTBlYmmrbN6mB5kg0/XfQyPveVcrpZofx71g89scncjpoYqdsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919814; c=relaxed/simple;
	bh=QZsdIcHWxpI9QDh/Acp10J22Rwmw8P/g++NrOm4SvtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPWVXYZqMoyBXWAKDDgMN93VDaqiuBgcgKkRMz4QZqu9s1447LnZr4H4sDi/a/Eqgp1al0RcHCItko/dsam/W+5rOWgP7dO568Tbi19jkxNF9wygrpDX9l5xLjWDnB6vHuAYhLz8KMRQwVdSG5deqjdq6bsVhF12cqKH5dxxf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2kOSmy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36B9C4CEE3;
	Wed, 30 Jul 2025 23:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753919814;
	bh=QZsdIcHWxpI9QDh/Acp10J22Rwmw8P/g++NrOm4SvtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2kOSmy8UhjztMdU71mBZlIUrHgHNdE1WicfZDCRKVDj7r5Gr0Fa+cFH+0t7sYjqe
	 0ri4igYvUEyFp35/tO5cNqpvtl8w5CF6GVDv+z9SJSCunjeJl8DqDtURRKLv7c0kbM
	 xTGc/JyWp3gbJBMQm6WNO55NVYvPVqWbtyM19f2cNwjs0b5kztu3DeMOHa6xA4f6nN
	 2grq5qZ4F37/qft/lbiVpO5apcljhUiSdFYbQrFI+yNc4GoMAKMGMx2CDQpB/IHa8W
	 5BIpdQxmGi6JJTwUda2/osXLUwaPh1nlkpYRSvjUFbzJJZZ9mXoKFxMcsuOgrnNmF8
	 hY9yZIOO+xKwg==
Date: Wed, 30 Jul 2025 18:56:53 -0500
From: Rob Herring <robh@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Benoit Parrot <bparrot@ti.com>, Lee Jones <lee@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, thomas.petazzoni@bootlin.com,
	Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: ti,am65x-dss: Add clk property
 for data edge synchronization
Message-ID: <20250730235653.GA1914482-robh@kernel.org>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <20250730-fix-edge-handling-v1-1-1bdfb3fe7922@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-fix-edge-handling-v1-1-1bdfb3fe7922@bootlin.com>

On Wed, Jul 30, 2025 at 07:02:44PM +0200, Louis Chauvet wrote:
> The dt-bindings for the display, specifically ti,am65x-dss, need to
> include a clock property for data edge synchronization. The current
> implementation does not correctly apply the data edge sampling property.
> 
> To address this, synchronization of writes to two different registers is
> required: one in the TIDSS IP (which is already described in the tidss
> node) and one is in the Memory Mapped Control Register Modules (added by
> the previous commit).
> 
> As the Memory Mapped Control Register Modules is located in a different
> IP, we need to use a phandle to write values in its registers.

You can always just lookup the target node by compatible. Then you don't 
need a DT update to solve your problem.

> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> ---
> 
> Cc: stable@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 361e9cae6896c1f4d7fa1ec47a6e3a73bca2b102..b9a373b569170332f671416eb7bbc0c83f7b5ea6 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -133,6 +133,12 @@ properties:
>        and OLDI_CLK_IO_CTRL registers. This property is needed for OLDI
>        interface to work.
>  
> +  ti,clk-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to syscon device node mapping CFG0_CLK_CTRL registers.
> +      This property is needed for proper data sampling edge.
> +
>    max-memory-bandwidth:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> 
> -- 
> 2.50.1
> 

