Return-Path: <stable+bounces-131960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D65A8276F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653541B84221
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762A265CB5;
	Wed,  9 Apr 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNOPrJi3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965526156D;
	Wed,  9 Apr 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208093; cv=none; b=KEoWjxSEhAYLul6EEp/UNu8H27SeIko6gk246VqUJXacDIhX5pUSS7cNWt6E4fObhoLUBj73B1fETbxCn0mnNJqScy8Rc0RmmwY0CDVQ/hh+T8vAuiYW/IA4NvS4MH+lCNjjKGSI5zS+KCJDNhB4baSMzrOlkq7e1MDy36LgfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208093; c=relaxed/simple;
	bh=iAuzqC8Qd+VEzJGSAubYlMUnCIszvAwVM1YYMjubFpU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZO6cOQtZ4J8zBtfXO2xFiTarCseYkdOafHpYGUPhiyM2AVwZ2ap+vqCS2IKXt8/KkphO+uotbD7QifB9SMUPyRiC99YIh2winf2jFAVmwxAV8LKmdte2A/5IMVdduNEUeHvV6OtPYaiGwAmdlXqozqKiHQHmN5oXkMqHByVs4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNOPrJi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73142C4CEEE;
	Wed,  9 Apr 2025 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208092;
	bh=iAuzqC8Qd+VEzJGSAubYlMUnCIszvAwVM1YYMjubFpU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GNOPrJi3FLcGTxPcYU2A8vmzBGKk7I1qAEeYRrBXEMQbtQnt9BZvoRGuqBgfQNuTp
	 A7wQ/j0Pklll8ErvQGkIclgOTMixumnPq4i0Ps83xy68CpO6cMp8lI7NunM5s9c8j+
	 Fn1hYsNaBm32ER+RlP/uFkoJXxmuOOnm75r3jE+9AaeSD56tRhsBK+6jsSnCb2zCjE
	 PQfAkYxvsx4i8xQR8/W75alFaWyZyT0cDAHjc5rkRnWzwgVkh4A2Fn0K1txLZC5e8h
	 7yoIO/AFAh4OynLqMFR5DSq3Pg6sCF7QpmbYvEMaN7UAqbwSRC3AVISpKhzEnFVX4J
	 q1fiBjrv/OGuA==
Date: Wed, 09 Apr 2025 09:14:51 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Benjamin Bara <benjamin.bara@skidata.com>, 
 linux-usb@vger.kernel.org, Klaus Goger <klaus.goger@theobroma-systems.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthias Kaehlcke <mka@chromium.org>
To: Conor Dooley <conor@kernel.org>
In-Reply-To: <20250326-fanatic-onion-5f6bf8ec97e3@spud>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
 <20250326-onboard_usb_dev-v1-2-a4b0a5d1b32c@thaumatec.com>
 <20250326-fanatic-onion-5f6bf8ec97e3@spud>
Message-Id: <174420798613.310269.1187763839287532334.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: usb: cypress,hx3: Add support for all
 variants


On Wed, 26 Mar 2025 17:58:11 +0000, Conor Dooley wrote:
> On Wed, Mar 26, 2025 at 05:22:57PM +0100, Lukasz Czechowski wrote:
> > The Cypress HX3 hubs use different default PID value depending
> > on the variant. Update compatibles list.
> >
> > Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
> > Cc: stable@vger.kernel.org # 6.6
> > Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table and onboard_dev_match in drivers/usb/misc/onboard_usb_dev.{c,h} driver
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > ---
> >  Documentation/devicetree/bindings/usb/cypress,hx3.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> > index 1033b7a4b8f9..f0b93002bd02 100644
> > --- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> > @@ -15,8 +15,14 @@ allOf:
> >  properties:
> >    compatible:
> >      enum:
> > +      - usb4b4,6500
> > +      - usb4b4,6502
> > +      - usb4b4,6503
> >        - usb4b4,6504
> >        - usb4b4,6506
> > +      - usb4b4,6507
> > +      - usb4b4,6508
> > +      - usb4b4,650a
> 
> All these devices seem to have the same match data, why is a fallback
> not suitable?
> 
> >
> >    reg: true
> >
> >
> > --
> > 2.43.0
> >
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
 Base: using specified base-commit 1e26c5e28ca5821a824e90dd359556f5e9e7b89f

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250326-fanatic-onion-5f6bf8ec97e3@spud:

arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@1 (usb4b4,6502): 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@1 (usb4b4,6502): 'vdd2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@2 (usb4b4,6500): 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@2 (usb4b4,6500): 'vdd2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: pinctrl (rockchip,rk3399-pinctrl): gpios: {'bios-disable-override-hog-pin': {'rockchip,pins': [[3, 29, 0, 190]], 'phandle': 185}, 'q7-thermal-pin': {'rockchip,pins': [[0, 3, 0, 189]], 'phandle': 184}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#






