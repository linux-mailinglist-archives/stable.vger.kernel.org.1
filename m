Return-Path: <stable+bounces-33111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD1890C1A
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A17C1F2319A
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717B139598;
	Thu, 28 Mar 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diHMXmWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA39380;
	Thu, 28 Mar 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659664; cv=none; b=fynsDE2T3SDA9gWZsw6+FBcZIYV+n6HVGyx4oe/pTNrVR4wVmiyB7EszK1iO3P5csZWZAyYnEzGUWfNFKg9JsJDvutSfXKYyp77DcUNmS1fZ/P7+cMR6M/OMCURDI1/yj2Q3NOI12MJdkfrc4SbxynJ8d13gB+9rWk93wAHO1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659664; c=relaxed/simple;
	bh=s87B919J/IE988PjAPhqMvTH41tTdROEkf+az6h6LiY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ePhVffVEEilzepzh4cPzVN01uiMs9SaTTF7MyAAOt3eFBBH5JipNGaw2tMWU7RN6CWuNfCc+uKAO1ty0hLyipValn5NoJXeh1g/Hf0isSjft974ZnlAKDqfUZXGrCAZZwvCoydO8FU1Cld59EISzEm8/bCbsUrHSvrFfY6kNnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diHMXmWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9963C433F1;
	Thu, 28 Mar 2024 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711659664;
	bh=s87B919J/IE988PjAPhqMvTH41tTdROEkf+az6h6LiY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=diHMXmWjisB0rrKfVKpzn+Xqv27dlxAYzkHVq/gL+zM27vwGRJgf7MftmssCwx78Q
	 l9Xt4C+J98a7QXotzvU+54TrJISxAAlr2TNdBSzqCpSIqv+CJBetHBGQiiVJd+9fmV
	 /99eJBsUTKyKoxUalYXwyyJfFNYA6FEm0X34xHfzUVG2zpveiYRkc/iNuRP95hPwJ9
	 byhVETM9RfEcjZedDvt5V8QlCp+1Wiv8jqL0KNEgysfYQ6yqy3uIRdKjPSyYYXWPeB
	 E87FA5EA/+Bc6zYRQuD+UEjdMmBWw5Q+e2PZ27GRDP03MCSzSbkciIpVntHUYW/wFY
	 B7XQ/eOvHnrAw==
Date: Thu, 28 Mar 2024 16:01:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <festevam@denx.de>, linux-arm-kernel@lists.infradead.org, 
 sakari.ailus@linux.intel.com, stable@vger.kernel.org, hdegoede@redhat.com, 
 devicetree@vger.kernel.org, shawnguo@kernel.org, conor+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240328151954.2517368-1-festevam@gmail.com>
References: <20240328151954.2517368-1-festevam@gmail.com>
Message-Id: <171165955888.338117.15736314486472326706.robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx7s-warp: Pass OV2680 link-frequencies


On Thu, 28 Mar 2024 12:19:54 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
> property verification") the ov2680 no longer probes on a imx7s-warp7:
> 
> ov2680 1-0036: error -EINVAL: supported link freq 330000000 not found
> ov2680 1-0036: probe with driver ov2680 failed with error -22
> 
> Fix it by passing the required 'link-frequencies' property as
> recommended by:
> 
> https://www.kernel.org/doc/html/v6.9-rc1/driver-api/media/camera-sensor.html#handling-clocks
> 
> Cc: stable@vger.kernel.org
> Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  arch/arm/boot/dts/nxp/imx/imx7s-warp.dts | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y nxp/imx/imx7s-warp.dtb' for 20240328151954.2517368-1-festevam@gmail.com:

arch/arm/boot/dts/nxp/imx/imx7s-warp.dtb: camera@36: port:endpoint: Unevaluated properties are not allowed ('clock-lanes', 'data-lanes', 'link-frequencies' were unexpected)
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov2680.yaml#






