Return-Path: <stable+bounces-206026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965EFCFA7E7
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F8E73052442
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981F6355028;
	Tue,  6 Jan 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RJ/MqWrL"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B18354AC8;
	Tue,  6 Jan 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724934; cv=none; b=cyT/Bb2KV82mYt+VjIIQ3EzdmaM9RMaElesS3XYny29BtIacTfj0IfjXmOMB0DrpWHINonyuY4aXtnCxbRzLGnLCVW5MaszCvQLpnvtBvdPIc7Sq7YPopOI/I4iJNLTLEczl1pjywVB14O2CkJJ+vRMRZaV8lKXQ0ci5crhEnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724934; c=relaxed/simple;
	bh=USLm1RPTdRWKKtLUQd/VpTuZjZAG4oRDPtFv3d/c894=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT3fr5fZBMCr89Y73bfxUPx2H4OPnN/vOg9pQYn95NjofkAXjcfv34Vj20HVz8MA1e2yRr0BLGoKVMvFPobUdPK2B/nIgS77+ZpfpyDmDCZlslO1hbaK1N77H5wrxILJBEA906m0tILhnnhfdt8eehRCIObp40tF7yYEE/ij74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RJ/MqWrL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=eKSy9T80IKDTUT4rJm6tF29ciu71tA8nroiwuv6DMCM=; b=RJ/MqWrLOj3blZgZ7htOadqicN
	tTP7/qvr8cLEDE9L1jjdeSlUL6gLRZkSzxKKxq1JtHURzoX8d5lyC/qVxPAoNy0usHl83q8xkyxZ8
	bvBETxsWQVdBxjW5vZirNK+axS4MIViu8DMhKOg9gaGqNVGWkk2mDjO3GeItHNtDWnfMxQr2t2yOD
	Djr+Ndf2NQsM7vDNVZ57CPLvhP3zhPQ+3YUemzXyg/RYk5Vnqwey2Umejuh7ugVpCFAgWQH0/D9HS
	mOFPZ4czXuuqk23b2J7mQwT3DkbbholHInMvjIfmVMNnPkEdM/9QYu+LH+UVK3tFx7IUAUA6auUqV
	gBUfdbww==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vdC0M-001Hfs-Dm; Tue, 06 Jan 2026 19:42:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	John Clark <inindev@gmail.com>,
	Alexey Charkov <alchark@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/7] arm64: dts: rockchip: Sound fixes and additions on RK3576 boards
Date: Tue,  6 Jan 2026 19:41:55 +0100
Message-ID: <176772487188.3029798.5459621815338520362.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
References: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 29 Dec 2025 14:11:57 +0400, Alexey Charkov wrote:
> Here are some device tree updates to improve sound output on RK3576
> boards.
> 
> The first two patches fix analog audio output on FriendlyElec NanoPi M5,
> as it doesn't work with the current device tree.
> 
> The third one is purely cosmetic, to present a more user-friendly sound
> card name to the userspace on NanoPi M5.
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: rockchip: Fix headphones widget name on NanoPi M5
      commit: 5ab3dd9d0a63af66377f58633fec9dad650e6827
[2/7] arm64: dts: rockchip: Configure MCLK for analog sound on NanoPi M5
      commit: 3e4a81881c0929b21a0577bc6e69514c09da5c3f
[3/7] arm64: dts: rockchip: Use a readable audio card name on NanoPi M5
      commit: 309598fca339abd4e8eef0efe0d630714ca79ac9
[4/7] arm64: dts: rockchip: Enable HDMI sound on FriendlyElec NanoPi M5
      commit: bde555926b61740c6256a38a9cf5a4833be345cc
[5/7] arm64: dts: rockchip: Enable HDMI sound on Luckfox Core3576
      commit: 87af7643234a2b4cb49a97dfe7fb455633b3185d
[6/7] arm64: dts: rockchip: Enable HDMI sound on RK3576 EVB1
      commit: f5c9549964adbac931e163693bd17db872976679
[7/7] arm64: dts: rockchip: Enable analog sound on RK3576 EVB1
      commit: d8872b9dd9208c493f1f3811d42997fb968de064

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

