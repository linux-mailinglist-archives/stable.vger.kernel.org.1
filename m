Return-Path: <stable+bounces-96052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D629E04DB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882412853E3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7A204F63;
	Mon,  2 Dec 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhKwBdfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F82040A8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149611; cv=none; b=fdeUwxWXCP4Qup0KEmz20x54XbllEqDY1WKs8Y0S4Rfnhw/xy1ZM/kdp9Ume28KiLJYMGgN1xhtb99zwfltz48SgLg/XK8qFd0LPdzjWj4esx0GYhb54GDj5tecIL6W+08/VSt2IX4Gcz8y47MaSqBYH86G/D5X2/D2a7R2ze9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149611; c=relaxed/simple;
	bh=nbyExx86eokHGr1bBDrrOvKas/+OkNOBkhxrYPEkAuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7Xsi44elxXu1YWEc0ZA127YwDARSJ4N1RaetZH9aZhe9yp1/5WJq4yDJ9hXX9AZMdISEsgJHve8XooMcJi5mSt5ddKwDOFA3U4BabJKC5BpkgkZ7sWUlIr1se8QX6vQx+MTZPrO8WGwFbGcqi86K+dwYwA1lPmMSaVMg88kpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhKwBdfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A6DC4CED1;
	Mon,  2 Dec 2024 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149610;
	bh=nbyExx86eokHGr1bBDrrOvKas/+OkNOBkhxrYPEkAuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhKwBdfb+aizJ+H8WPoMgyDSCEy5FJpiXqRSsO+dCK9croq820KA5ZT0XE4RTuaid
	 jDAIoaZlahSd2FZeipCkiYlcPV/xsHRvxMoNGNpP52ABcUcaWB9g/ylKRIxGYKtPaJ
	 qyiXbRsl+mrx7xwYJ0BTJWiUN9/zj6ZMlD/47a17t9dw7MSosAv7g11RsEfl7ijB1J
	 uKnldq9JokvGEIAOdHE0Dp5INwsOGL9COTZMhW8JJjxaG0umU3Zm6jbidsN8GQaEst
	 3XXGTJn3bKdZWhztqgLfngxdjdx1+dJOF8S4Y+qPbgw7n0D8GuhZe1191ubD87buIq
	 ryjn+K4HGBFRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
Date: Mon,  2 Dec 2024 09:26:48 -0500
Message-ID: <20241202075505-3c21e61761ae89c7@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202081624.156285-2-wenst@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 09d385679487c58f0859c1ad4f404ba3df2f8830


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 598cfa441b59)
6.6.y | Present (different SHA1: 090386dbedbc)
6.1.y | Present (different SHA1: edca00ad79aa)

Note: The patch differs from the upstream commit:
---
1:  09d385679487c ! 1:  0d2c7a29a4219 arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
    @@ Metadata
      ## Commit message ##
         arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
     
    +    [ Upstream commit 09d385679487c58f0859c1ad4f404ba3df2f8830 ]
    +
         USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
         pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
         design.
    @@ Commit message
         Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
         Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
         Cc: stable@vger.kernel.org
    -    Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
         Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
         Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    +    Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
     
      ## arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi ##
     @@ arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi: &xhci1 {
    - 	rx-fifo-depth = <3072>;
    + 
      	vusb33-supply = <&mt6359_vusb_ldo_reg>;
      	vbus-supply = <&usb_vbus>;
     +	mediatek,u3p-dis-msk = <1>;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

