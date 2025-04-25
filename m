Return-Path: <stable+bounces-136662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496CA9C00A
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4853B0AC5
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B32309BE;
	Fri, 25 Apr 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Z9LDOL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4F22D7A7;
	Fri, 25 Apr 2025 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567303; cv=none; b=GvLgh+B78PVgV5BPexddGZ6t6K7PeFviZenJnHsZNCH0WZpbPFfr6m+ueZZRfp4K/LiJh4jETUXH9ahtbIC8bebVft4KXgPf9Sov5wHjr+tGRoUhPM6dvorAvGs/H3IxT6Ud8KdS4vCaJkWFeot/eHrCE+qOc2cQycTVbl8KIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567303; c=relaxed/simple;
	bh=jpBGvqF1vhLelKCM+qa40XIBkSN7Xd7BZS/mEIX6rmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEms8tvoouxBRvjMkNZAg7h61pLiMKdMJL5VElUsRDGBT6XOl4qHPMxIVBhtEPJmmOf+jKCghEkcHP091nxatyqNEtesiWh2fr+4veaoRWOvyPwhT49FA4mar/DpnPbbtFfd2gmzgcotk27xfgZJUq8hezp2+3y4A4E+5zvtpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Z9LDOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F0AC4CEE4;
	Fri, 25 Apr 2025 07:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745567302;
	bh=jpBGvqF1vhLelKCM+qa40XIBkSN7Xd7BZS/mEIX6rmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1Z9LDOLe8KEKfAKnMyLYXFqw1Ao+8PnjVcu3u87fGhcykICD0LzaBHMw792sdjnQ
	 9CkZFsnFkTUWmFtbtrvpqHuo7CSVX5YXJBASK5avvKhaZTUHLxW3KEkMwDOf/mQI9Y
	 RtLwSlTKnd/jtQ4xPsby2lOx47vi1I2BYPsrZj6dKAuzQ8apes2/Zlp1BAEkWlAEs/
	 tA/mexzcFSn8NDWQ7+GeysL9OAyqOfGYRY+UVBZZV1Lpctq+zeNQ6PQcYsj33FUDvC
	 OYwdFfPpnWWSghVEkpekzvxikVSWK1KRaAQ6pxXEEYrEVV3vXPsmNhoXw5sCgZ8d5v
	 5mPZKjd7ucYkA==
Date: Fri, 25 Apr 2025 09:48:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Josua Mayer <josua@solid-run.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Francesco Dolcini <francesco@dolcini.it>, Hiago De Franco <hiagofranco@gmail.com>, 
	Moteen Shah <m-shah@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/3] dt-bindings: mmc: sdhci-am654: Add
 ti,suppress-v1p8-ena
Message-ID: <20250425-agile-imported-inchworm-6ae257@kuoka>
References: <20250422220512.297396-1-jm@ti.com>
 <20250422220512.297396-2-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422220512.297396-2-jm@ti.com>

On Tue, Apr 22, 2025 at 05:05:10PM GMT, Judith Mendez wrote:
> Some Microcenter/Patriot SD cards and Kingston eMMC are failing init
> across Sitara K3 boards. Init failure is due to the sequence when
> V1P8_SIGNAL_ENA is set. The V1P8_SIGNAL_ENA has a timing component tied
> to it where if set, switch to full-cycle timing happens. The failing
> cards do not like change to full-cycle timing before changing bus
> width, so add flag to sdhci-am654 binding to suppress V1P8_SIGNAL_ENA
> before changing bus width. The switch to full-cycle timing should happen
> with HIGH_SPEED_ENA after change of bus width.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 676a74695389..0f92bbf8e13b 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -201,6 +201,11 @@ properties:
>        and the controller is required to be forced into Test mode
>        to set the TESTCD bit.
>  
> +  ti,suppress-v1p8-ena:

Do not tell what the drivers should do, but tell what is the issue with
the hardware, e.g. some cards do not like full-cycle.... and this will
also hint you that it should be most likely generic, not specific to
this device.

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:

Best regards,
Krzysztof


