Return-Path: <stable+bounces-35659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E503A8961AE
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 02:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229A31C2247B
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253DCDDD3;
	Wed,  3 Apr 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fvCP12fK"
X-Original-To: stable@vger.kernel.org
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E57528FC;
	Wed,  3 Apr 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105593; cv=none; b=W6xygR5zJlSrw7m1sc9DgS2MDyJvHM/fqdrmAY/L4zn5bgud2lwGkOdERzOWC1DXyclBsGsLgT9WoybLyHX+jPboszdW+Gh6lIjVExYAprNUojzUnSGLQjE5WSgfRIcwfcobe0r7WIzy6p0gET8YHkf60EGqrdHOSYgq0n8oz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105593; c=relaxed/simple;
	bh=NrGwl85cIbTQkgIbnPoObq517mfKQuTXt29hKa0W4sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDEQIJu7rzeSnWN0LCOtVIginiCIh0am1YgLGLT5BEPWnxhLgpo/7rI5AvJruunob0F3ZqfSDJ0BmbfR+ThxJ7/ALepeFq19jcbJYWTOigYZ0IQcZx75CCW3IxlX00rWyDs1s5fsdnBCGXvW05q/TsIxzNrQdPVAe/d0TzQ+3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fvCP12fK; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=iKL1lvfiV0UZpRQdrUIKxXwYRsHo/ZzDAdZfyOgJacU=;
	b=fvCP12fK7/MYqgY4kWOMvtM7TOXtShhuegBwHm5B6lNZ1c/66kFvHAWIpJQvAp
	lNx6KoM1NC6EY2OcOnvYXw37Ja4SuYOmM6jfvV4q5v7L9rgFeh1w4k97yWTDYwkt
	Ux2EdXzsT6O1otBdpQmkfo3yYJMWGGXwf29ViMl8+apZY=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADXP0NfqAxmHuKsAQ--.3755S3;
	Wed, 03 Apr 2024 08:52:49 +0800 (CST)
Date: Wed, 3 Apr 2024 08:52:47 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
	linux-arm-kernel@lists.infradead.org, sakari.ailus@linux.intel.com,
	stable@vger.kernel.org, hdegoede@redhat.com,
	devicetree@vger.kernel.org, shawnguo@kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] ARM: dts: imx7s-warp: Pass OV2680 link-frequencies
Message-ID: <ZgyoX55PJD0LDSPf@dragon>
References: <20240328151954.2517368-1-festevam@gmail.com>
 <171165955888.338117.15736314486472326706.robh@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171165955888.338117.15736314486472326706.robh@kernel.org>
X-CM-TRANSID:ClUQrADXP0NfqAxmHuKsAQ--.3755S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW3GryxWr4UXF4rWrWxJFb_yoW8Zr1UpF
	Z3GF1YkF45JFyvya9Fqw1Ika4FkwsakF1Ygw1DWw1UAFW3Z3Wkt34Svw1ruF17KFsagw13
	Zwn3u3Z0qw4UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jD5r7UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGA61ZV6NnqoMcQACse

On Thu, Mar 28, 2024 at 04:01:02PM -0500, Rob Herring wrote:
> 
> On Thu, 28 Mar 2024 12:19:54 -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> > 
> > Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
> > property verification") the ov2680 no longer probes on a imx7s-warp7:
> > 
> > ov2680 1-0036: error -EINVAL: supported link freq 330000000 not found
> > ov2680 1-0036: probe with driver ov2680 failed with error -22
> > 
> > Fix it by passing the required 'link-frequencies' property as
> > recommended by:
> > 
> > https://www.kernel.org/doc/html/v6.9-rc1/driver-api/media/camera-sensor.html#handling-clocks
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification")
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > ---
> >  arch/arm/boot/dts/nxp/imx/imx7s-warp.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y nxp/imx/imx7s-warp.dtb' for 20240328151954.2517368-1-festevam@gmail.com:
> 
> arch/arm/boot/dts/nxp/imx/imx7s-warp.dtb: camera@36: port:endpoint: Unevaluated properties are not allowed ('clock-lanes', 'data-lanes', 'link-frequencies' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov2680.yaml#

So it sounds like that the bindings doc needs an update to include
'link-frequencies'?

Shawn


