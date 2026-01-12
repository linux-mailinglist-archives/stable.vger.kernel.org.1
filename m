Return-Path: <stable+bounces-208202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B26D152FB
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 21:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BFC73015E00
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89AB31326C;
	Mon, 12 Jan 2026 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7dU0Rky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B6224AE8;
	Mon, 12 Jan 2026 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249241; cv=none; b=SnWyIihML1mFuZ/rP9e09i9woufmHP4yATJPjbv4uTELJuTw2BQF+L7Y2XG7b3xZsyAJtHZSI4Tv9B9uSR3c4/0+sSgPWiRc2L8j0bs1AwBHnKou1bLwSOS2oYlDCi9T9VHOP1033SMRblN3RTaVSWsyDmTJ3MhCoDV05rX2Cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249241; c=relaxed/simple;
	bh=hgImCKI6sHo18MQkK7hVM8HOcjLUYeplEKC2f9UsKP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqhKS5nzmcPcUuY+k1jMdAOz/dRRWoTAi8q5TxNbSjndk20/UVQbXhL7Zo0HQLuVc/z8zmrkLUCihOOA37rZQITi8HyuidP9EP/vLOroXjYtT0xSCDixeeIynp0InGJx3U5IPBQ7SoNJ8UMCNKNiJ/fnieSbI773C1wRMrreYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7dU0Rky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203FCC116D0;
	Mon, 12 Jan 2026 20:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768249241;
	bh=hgImCKI6sHo18MQkK7hVM8HOcjLUYeplEKC2f9UsKP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7dU0RkydbSACk5/L3mM4qNFpPULDG1+GlswjyTrILwdR/WKKP9k7Z0bLNjP7PTTr
	 O1lbpn8FkDzcczb6vSQjw/9W1QP1IYWk7jYWs7GBx6xDiUPiq5U2lxOKf1582J0MTq
	 7+bOnXEhYaD6Q/W1VKn2Xu5hCTx51rqIm2PzvY4Zp0rxRo89LjY/sO3R+GKzdO5+p2
	 gBe1vs5WfD2CTnSxGzrXNartOhcZgNazJT8oVqMJ1z2ltS0dE1w6ghtG8SV/UUjFX0
	 0mQ18NOs+cK7jigyaV1aluSVqYs0cueERGX2ogbIMqpkBEo/yrRZ83pqrUu/1tvv3s
	 g59GR9wT2yCvQ==
Date: Mon, 12 Jan 2026 14:20:40 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: parade,ps5511: Disallow
 unevaluated properties
Message-ID: <20260112202040.GA943734-robh@kernel.org>
References: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com>

On Mon, Jan 12, 2026 at 10:01:50AM +0100, Krzysztof Kozlowski wrote:
> Review given to v2 [1] of commit fc259b024cb3 ("dt-bindings: usb: Add
> binding for PS5511 hub controller") asked to use unevaluatedProperties,
> but this was ignored by the author probably because current dtschema
> does not allow to use both additionalProperties and
> unevaluatedProperties.  As an effect, this binding does not end with
> unevaluatedProperties and allows any properties to be added.
> 
> Fix this by reverting the approach suggested at v2 review and using
> simpler definition of "reg" constraints.
> 
> Link: https://lore.kernel.org/r/20250416180023.GB3327258-robh@kernel.org/ [1]
> Fixes: fc259b024cb3 ("dt-bindings: usb: Add binding for PS5511 hub controller")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/usb/parade,ps5511.yaml       | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
> index 10d002f09db8..154d779e507a 100644
> --- a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
> +++ b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
> @@ -15,6 +15,10 @@ properties:
>        - usb1da0,5511
>        - usb1da0,55a1
>  
> +  reg:
> +    minimum: 1
> +    maximum: 5
> +

This 'reg' would be the upstream USB port. We have no idea what its 
constraints are for the value.

>    reset-gpios:
>      items:
>        - description: GPIO specifier for RESETB pin.
> @@ -41,12 +45,6 @@ properties:
>              minimum: 1
>              maximum: 5
>  
> -additionalProperties:
> -  properties:
> -    reg:
> -      minimum: 1
> -      maximum: 5

Removing this is wrong. This is defining the number of downstream USB 
ports for this hub.

What's wrong here is 'type: object' is missing, so any property that's 
not a object passes (no, 'properties' doesn't imply it's an object).

We should fix dtschema to allow additionalProperties when not a 
boolean property to coexist with unevaluatedProperties. I'll look into 
it.

Rob

