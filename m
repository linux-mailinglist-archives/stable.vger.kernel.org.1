Return-Path: <stable+bounces-203219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD81CD6300
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 14:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F25E3016F90
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F222631B131;
	Mon, 22 Dec 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="V+Us1nEN"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9A3126D0;
	Mon, 22 Dec 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410723; cv=none; b=dlCEcyyQG42o1Dc3gjL+wmpUR5aMa9dfUQWPY/AcKTP9i+Gytzop/bBfMTokPyF9TOD4GsHJ/7NC2qfSCiLiVePTLXVGil3MqQ7cyZyM1yc2HKT6ImrsoUJMbXzwKOCD9XZNSb/5j0IbVm+GzmPw0bR9qwW/GZU1ON1NEOqaGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410723; c=relaxed/simple;
	bh=3UMJ+E0r0XL0TaXU3iwLEnMdCYq98u1dBbwf1ZmLBv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTL39BeGiFVArV3wSq82nRz3mWAzJ0hukGQJCCaDQPaRkpDye40ve1fYBOkXyXYWMB7H9vozgJXTy9H998Tc/LkOHLw+XzZ52v3VzidIxbsiVVnYjcoEcWA7gLP2EwDTTYp3pTH9C911YydTDcJ0M4Nxe1amNpQ9HQzckiw5PVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=V+Us1nEN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=HoYxV+zXHdjx75Q4JXjcDA7Kc8dxz5Omy/iV5ZA3rIg=; b=V+Us1nENppsFP8DjeU7zR9HX+c
	dA81FE0TPgbx81C+jqK6AtS0CRTvA/BEZ9TX43OOmmwTLXvyk+MxWNreCJpqSLWcJlhenwn7GAyZz
	nyDvl3soKpHAQP+JqfC7BiFvTRoRjJ4KhKG2DVeaxzxsIl8jdoeGtUBrue5ONxGRXHnEBc0g8pBls
	BFw2L7VkAKih5Se0J8mEyUTdljEdB4oDLPsxCDdCy4Qz4s0KUCxBefw7jzxPND6L5zYeJ6fpJULz8
	GO9Se/MYQwr0W/MtcR5NyxRgA4xqblN5vZMJr4L0Cpjmtw9zwUbGM/Gz+QSiYv0PS+77u25VwUJ8R
	3PICEp0g==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vXg7K-0005s2-Q4; Mon, 22 Dec 2025 14:38:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix unit-address for RK3588 NPU's core1 and core2's IOMMU
Date: Mon, 22 Dec 2025 14:38:23 +0100
Message-ID: <176641067338.1648325.5634476513505380555.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251215-npu-dt-node-address-v1-1-840093e8a2bf@cherry.de>
References: <20251215-npu-dt-node-address-v1-1-840093e8a2bf@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 15 Dec 2025 17:45:56 +0100, Quentin Schulz wrote:
> The Device Tree specification specifies[1] that
> 
> """
> Each node in the devicetree is named according to the following
> convention:
> 	node-name@unit-address
> [...]
> The unit-address must match the first address specified in the reg
> property of the node.
> """
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix unit-address for RK3588 NPU's core1 and core2's IOMMU
      commit: cd8967ea3105d30adb878a9fea0e34a9378df610

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

