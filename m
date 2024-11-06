Return-Path: <stable+bounces-91721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6E9BF685
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDAA28493F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85420495E;
	Wed,  6 Nov 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s0qyczx2"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27517B4FF;
	Wed,  6 Nov 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921488; cv=none; b=JCtcypVI1qIaN2jO/zgpCvBhX78jKRaG6/+tawVA6tNEPXcQGAP94GaWBuyw/WMQVMl8XqGUTPv3QixQPQxNuH6ReovaY6e7y+vOTwwL3S3P5qNAUcUwoS7mmSv+WDKu2OaQ+j7h6PdM81BBUGZG4rReGpbo5Bx2xabjIKXp7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921488; c=relaxed/simple;
	bh=3Oj/WuRN6RbpcyqndmgIBePZms1CAmV12kQnndB2nu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8m46FxVHTL47+xUPteE7yuOqOwSsih1nrol+vvQnJCx17g5BM9VCtLujMY/t8jYRiTZu1P6u7fcWbnFetQHV0WbIAIV3sdTVyc7gELgGy9TILPXAquc3xuB5Gbww4kXGcsx30vUi7tQmzBaB5B4ki4HQgc9xeG8iG86Vntf9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=s0qyczx2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F43B670;
	Wed,  6 Nov 2024 20:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730921476;
	bh=3Oj/WuRN6RbpcyqndmgIBePZms1CAmV12kQnndB2nu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0qyczx2Uzkmh9/w4AAcX5AtqJdEqc59Ysvm5OK1t6qSvQ3+/+A7dG58sOJvO8xqR
	 4/inylLAZuH51FyL8G2IEkwfH+Gx3cRlxAuKFoq5RrnXI/btsMgxaAKEPYnvhsXfAW
	 W7rZ/3s8gu0b/OcqTQpyzFnEb8BXz5bgDCbZPVkQ=
Date: Wed, 6 Nov 2024 21:31:18 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: display: adi,adv7533: Drop single
 lane support
Message-ID: <20241106193118.GB21454@pendragon.ideasonboard.com>
References: <20241106184935.294513-1-biju.das.jz@bp.renesas.com>
 <20241106184935.294513-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106184935.294513-3-biju.das.jz@bp.renesas.com>

Hi Biju,

Thank you for the patch.

On Wed, Nov 06, 2024 at 06:49:29PM +0000, Biju Das wrote:
> As per [1], ADV7535/7533 support only 2-, 3-, or 4-lane. Drop
> unsupported 1-lane from bindings.
> 
> [1]
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADV7535.pdf

No need for a line break, you can write

[1] https://www.analog.com/media/en/technical-documentation/data-sheets/ADV7535.pdf

> 
> Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v3:
>  * New patch.
> ---
>  .../devicetree/bindings/display/bridge/adi,adv7533.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml b/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
> index df20a3c9c744..ec89115c74e4 100644
> --- a/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
> @@ -90,7 +90,7 @@ properties:
>    adi,dsi-lanes:
>      description: Number of DSI data lanes connected to the DSI host.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 1, 2, 3, 4 ]
> +    enum: [ 2, 3, 4 ]
>  
>    "#sound-dai-cells":
>      const: 0

-- 
Regards,

Laurent Pinchart

