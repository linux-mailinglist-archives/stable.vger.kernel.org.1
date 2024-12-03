Return-Path: <stable+bounces-98134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AC9E28FA
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4C286306
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585B1FA163;
	Tue,  3 Dec 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwVM1pPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3611F8AD2;
	Tue,  3 Dec 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246429; cv=none; b=EZZpof9NDrvtAVz6O2/0pHMS8LfaRKPhiZaFVFU12+nglkwmL31yD2NVK9daP6aXoBHNKu0FFh+7hvceMWC0gFSKTVIOywHzdlK8eWp6Xztqteh36r2VThkdzRal6JJWOqmS6n9DUawz8wn0kwkF873bjA3F++ZzlTMiRQf+it4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246429; c=relaxed/simple;
	bh=eu8MFWETCzi5mUkFpsHp3K6rE1uqUbw4E2pfuGZED5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4+vfU8rbQ5Vc8Wt0t+bNm0GVKS1N2G2uRnclvtuVFVqHzlDL3UxZg/1CupEa8h7fYjoFQT58J0s6nLPu/ZcHtCxrWRWPnXPiQdft7nTiux9b/zDRTkxHYx3n344woMpGMvJ/WL/+xcWQnz4WgZ23fWRa2+4nvHWReKpUvJRVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwVM1pPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A538C4CECF;
	Tue,  3 Dec 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733246428;
	bh=eu8MFWETCzi5mUkFpsHp3K6rE1uqUbw4E2pfuGZED5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwVM1pPTEPLNeSSEZQiHBH6Z4pCfskBgJS15+lqTzDaERICXmEXFijOJ+39t1WkDh
	 Mmlt3qH1R2/J7kbNEBBNa8OGc8uG848l+SDnviF7uZqXjdG+6gomChXIEF/PNj4fCq
	 5GCeweIH8jxGsQK2s4SgMyNMbL37kuMMLvFouyNks8GYnNWLHtFcvB3C2M1Utm+Pqo
	 wGYr9QK1ZMAted2QhGKiI8EVFxEmwMJ32HyX2UToWc2UDLugOmTOsf6zIFiDXXjOLj
	 mLANce+Qac3pq3ovswLVEsrczQCAZWTae2lEaiVvyOEdDjQTENw5PNhGigRUDjdGSs
	 vfE8MJ/J/hVCg==
Date: Tue, 3 Dec 2024 11:20:26 -0600
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: fsl: cpm_qe: Limit matching to nodes
 with "fsl,qe"
Message-ID: <20241203172026.GA1988559-robh@kernel.org>
References: <20241202045757.39244-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202045757.39244-1-wenst@chromium.org>

On Mon, Dec 02, 2024 at 12:57:55PM +0800, Chen-Yu Tsai wrote:
> Otherwise the binding matches against random nodes with "simple-bus"
> giving out all kinds of invalid warnings:
> 
>     $ make CHECK_DTBS=y mediatek/mt8188-evb.dtb
>       SYNC    include/config/auto.conf.cmd
>       UPD     include/config/kernel.release
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC [C] arch/arm64/boot/dts/mediatek/mt8188-evb.dtb
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible:0: 'fsl,qe' was expected
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible: ['simple-bus'] is too short
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:compatible:0: 'fsl,qe-ic' was expected
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:reg: [[0, 201326592, 0, 262144], [0, 201588736, 0, 2097152]] is too long
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:#interrupt-cells:0:0: 1 was expected
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000: '#redistributor-regions', 'ppi-partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'reg' is a required property
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'bus-frequency' is a required property
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
> 
> Fixes: ecbfc6ff94a2 ("dt-bindings: soc: fsl: cpm_qe: convert to yaml format")
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> index 89cdf5e1d0a8..9e07a2c4d05b 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> @@ -21,6 +21,14 @@ description: |
>    The description below applies to the qe of MPC8360 and
>    more nodes and properties would be extended in the future.
>  
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,qe
> +  required:
> +    - compatible

Update your dtschema. The select is no longer necessary. dtbs_check will 
also run 5x faster.

Rob

