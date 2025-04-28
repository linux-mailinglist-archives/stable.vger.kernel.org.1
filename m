Return-Path: <stable+bounces-136935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5CA9F820
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D1E3ABCCC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0D2951C9;
	Mon, 28 Apr 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWIuA4pe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CE289343;
	Mon, 28 Apr 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863968; cv=none; b=A6Mn/msF7YuD39LvriyJrVxZ1ij/pPHujyLFewCeUAZ58dKOWZw+iDcWBf5hGspSnUHwbSyL1UziscYatllU/1zUFKvHSF8C+zzkjjk6Bq7hH9ykAR8yLw8ZGJ9JmnZXv6iR8UL7GXDyi/58cIJeTULXdQuKAK/I7YheHXU6WJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863968; c=relaxed/simple;
	bh=KTqQYLBw1XS55ajrDgXBIWQeeAlb817N/mkPEkK6Xfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZhedhKKJllvru5sbBSYQezANLHkbSBizEno013uSn50WJq+NYgYr2bGTyX/t2IcijaapmddPxADOHxAccHp8rEuMCdx+LHOfGP2HufpphVT7Epl7cUThDoYo+O2npX7++83UIgmdNcUsEHB0ai2aEo9PqSEPS8WEa7Z43eCVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWIuA4pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C13C4CEEC;
	Mon, 28 Apr 2025 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745863967;
	bh=KTqQYLBw1XS55ajrDgXBIWQeeAlb817N/mkPEkK6Xfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWIuA4peX9ZsjZC1m/7A/fpkdxquCZ50ltGIQwsvl5bPQXH6/fG73jq8dNkv3sNui
	 9nXcFpAcjM4s+axJKSCs6FKBzGrFnw/+CllMT95PkfTUroNAchm/SjoihsJ4CW7H3G
	 KY5jNIpRIN+m1dXf+VIuOgNWlOUTAV1n9a+at9yE/XO45hJr+rPtjnbCia6HsoT3V9
	 JOlKkYVPwCMRtxWXyCeGQNB+gAb9BT/SpDdLoA2o2J9xCqE6AbN/22vJ8bKEq69fAM
	 A4ljOqumSo96/ynTfEkG7txH+ZEXs27JJtQFQR1uMIbO/7qNlCBXl0drB0hKzosK/I
	 cRf1JI1duM30A==
Date: Mon, 28 Apr 2025 19:12:42 +0100
From: Simon Horman <horms@kernel.org>
To: Da Xue <da@libre.computer>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christian Hewitt <christianshewitt@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] net: mdio: mux-meson-gxl: set reversed bit when using
 internal phy
Message-ID: <20250428181242.GG3339421@horms.kernel.org>
References: <20250425192009.1439508-1-da@libre.computer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425192009.1439508-1-da@libre.computer>

On Fri, Apr 25, 2025 at 03:20:09PM -0400, Da Xue wrote:
> This bit is necessary to receive packets from the internal PHY.
> Without this bit set, no activity occurs on the interface.
> 
> Normally u-boot sets this bit, but if u-boot is compiled without
> net support, the interface will be up but without any activity.
> 
> The vendor SDK sets this bit along with the PHY_ID bits.

I'd like to clarify that:
Without this patch the writel the patch is modifying will clear the PHY_ID bit.
But despite that the system works if at some point (uboot) set the PHY_ID bit?

> 
> Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");

I don't think you need to resend because of this,
but the correct syntax is as follows. (No trailing ';'.)

Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support")

> Signed-off-by: Da Xue <da@libre.computer>
> ---
> Changes since v2:
> * Rename REG2_RESERVED_28 to REG2_REVERSED
> 
> Link to v2:
> https://patchwork.kernel.org/project/linux-amlogic/patch/20250331074420.3443748-1-christianshewitt@gmail.com/

...

