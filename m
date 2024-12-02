Return-Path: <stable+bounces-96054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2D9E04ED
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031E21691A4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DE2040B7;
	Mon,  2 Dec 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq/j6W6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DE1FECB5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149614; cv=none; b=Amqr5sMEQArGnE88CCMi5d2fmIvBhm9sUAqe9Va/HwSuLoRkMU5P2DbG9B+DvOWgN08aNBXLnYm+fOCfUHWsIjFlT1MFMlaC5qdNIOGVtEca+zKYoaDOglGYgE6UMD4lhU5IuTz6hTn8TGMFmn0vqZ7h/zaV77/FjEAzWFVVTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149614; c=relaxed/simple;
	bh=8cibHt/pI9fBD8d20r/AvV4Oh8HVdyf3T/CfudyHWU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uW6fZPeubxjfP9CluRpi9iwmAMxjrWWom+2tx+5wbMalTtoJtvUzXT8EpZX86dJneNJzI6orFITUEEEYlFTOHi7rCRJMQSCEUYJQJM9luoz1oQa2JW5tqlIfHdOpixqJGolDLFeu5R9OhoBTi6SS8+u0MbfFclO3wrRLUsdmRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq/j6W6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF14C4CED1;
	Mon,  2 Dec 2024 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149614;
	bh=8cibHt/pI9fBD8d20r/AvV4Oh8HVdyf3T/CfudyHWU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qq/j6W6erumWVhna7KpCqckUU3e6+dV2mZ0bovj/Y2+vnFje1e9i7aqiQUBTxL1GI
	 97xGcFZPk2vwtjfDYQtNntuNipzDyQP1ce3JSBOzu8CIVxu/MIcFgmFB9C9NaBZRt3
	 yuL6mEn0+JkU8Ztb3V2sBoGLKuq153YPWL7BKk4AIqfukKDz4QmPy5l9SSX4E+MLv/
	 Fyt5YVwbDJE0UCSQj5TzEDIcXw4oV5Y+oSLyNMRRmRsnTh69EQh5fhVQd2+clNguTw
	 cQnhZ2kQqfsYBu1wgK78EUWtPwoiCb9G1lQv7vw2cWsZaD3qQ9Q8jILZ0AzHo1MUsm
	 9Y1MKpV+iDqNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
Date: Mon,  2 Dec 2024 09:26:52 -0500
Message-ID: <20241202074010-65b0a4acbd94004f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202081552.156183-2-wenst@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  09d385679487c ! 1:  d9497f1e98c62 arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
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
| stable/linux-6.6.y        |  Success    |  Success   |

