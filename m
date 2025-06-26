Return-Path: <stable+bounces-158722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D70AEAA88
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 01:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE10D1C27CF8
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8A221FD2;
	Thu, 26 Jun 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgMvjXc4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6821CA08;
	Thu, 26 Jun 2025 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980272; cv=none; b=dDrZ66YeTTky9T8yc1LiSeAmk3oxfKkjPNVZppQavmS7fXZbfEaey/QvI9X6T1NQb1eqnUu0QF6KKtR5bvDidg2Z5IrxRP5LIgVLKcEnLhQ5i4SGQweEw4FTu1upY4sFHTCboffZWLSGdI4+37mXVCpGRxSna45wdEix6LlhUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980272; c=relaxed/simple;
	bh=3iYSIjl6d68LlL0ejDj5mcWaYaC3T+fv98YPCHJ3fTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXuwDiEdMqTXR6l7EIaA/LpTLCF0saMwZO/UXRbiT1EcbP5zXH6qwlrMtaZGgADYuyyMX8apduH6E3yKwS9iX7GxYw/0/7CQi/nFO9/qsL7G3JwCvWGDpT7I7bkZxhHOg4EdYN9oAzwwu1bVRojzFZ/OZ83XgovQUy7OZgmYvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgMvjXc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A3C4CEEB;
	Thu, 26 Jun 2025 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750980271;
	bh=3iYSIjl6d68LlL0ejDj5mcWaYaC3T+fv98YPCHJ3fTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgMvjXc4WdjDgwxyvHc2vg/f6VLnOix6GSsAs0057BSFLwx50Jak4odQh2wiqBlRM
	 /DoEOpZ0xrOndlPf2BWV6ocn6lt7KNeq6pl5xFBmnmBSoo7Oyg47UZPtgnUFOsvlm6
	 lATCkAR3de9ehf2tRs4vkSCeMwC831j/7XHkql/c3VQiEZgn5aTuQYmrmLNc8hUgf3
	 r+nhGKXrRtIfVzKOU3/En+E/yTQZXTdldvQ7zXhx5ZXGWnn9OC87BEeFvd4zKkf9dP
	 OUcSsMGTRxsTIdJkH5Nh2veJv/kRIDTvVrBwGFvMTt+jtqibnPgOS3E6BHlRtemQCo
	 inTsjBqfaqC8Q==
Date: Thu, 26 Jun 2025 18:24:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andy Yan <andyshrk@163.com>, David Airlie <airlied@gmail.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, stable@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/3] dt-bindings: display: vop2: Add optional PLL clock
 property for rk3576
Message-ID: <175098027014.1394278.11992805068398675511.robh@kernel.org>
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
 <20250612-rk3576-hdmitx-fix-v1-1-4b11007d8675@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-rk3576-hdmitx-fix-v1-1-4b11007d8675@collabora.com>


On Thu, 12 Jun 2025 00:47:47 +0300, Cristian Ciocaltea wrote:
> As with the RK3588 SoC, RK3576 also allows the use of HDMI PHY PLL as an
> alternative and more accurate pixel clock source for VOP2.
> 
> Document the optional PLL clock property.
> 
> Moreover, given that this is part of a series intended to address some
> recent display problems, provide the appropriate tags to facilitate
> backporting.
> 
> Fixes: c3b7c5a4d7c1 ("dt-bindings: display: vop2: Add rk3576 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../bindings/display/rockchip/rockchip-vop2.yaml   | 56 +++++++++++++++++-----
>  1 file changed, 44 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


