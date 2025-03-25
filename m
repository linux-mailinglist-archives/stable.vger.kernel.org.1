Return-Path: <stable+bounces-126192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57483A6FFAE
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10CE165F47
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4D2676D1;
	Tue, 25 Mar 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pXG4T6kj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D822676CB;
	Tue, 25 Mar 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905771; cv=none; b=EisgDEN2/uetE7FmdSdw34vU83Jdtdz63eD4JbQ+JESoIdg6bSyQk6/VsCQJ0YuL4jgv/5MUPSmM2Fl37h5wMS5yoNED3GEG1l0lnW4dGdDZkyDa1UkZ7dk7DGE/iHvfGoW86jmnhfrHz9BNs7WmqeGzcihXynBPlzwySzT3B4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905771; c=relaxed/simple;
	bh=ISHPVYmQ3YnZNhOHSJmo+m12hXYCpVEhd2hYaApp04A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6+1zpY93XeUvNKTSdqJXVSRnOl0x4svWdrha8z4TroM3VciueNzmgsmHLSJkWPCt6Edqh0cgjAnHsH988vGEG66BCtHT9aCXMgHnuCGShzUElh/PUWFaKUJy9JSTDMDEqyoiKD/r3p+UJB4gUxCsEHOxRm8np5wTustRLgNGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pXG4T6kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2BAC4CEE4;
	Tue, 25 Mar 2025 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905771;
	bh=ISHPVYmQ3YnZNhOHSJmo+m12hXYCpVEhd2hYaApp04A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXG4T6kjhDbcwLZoQtBHHQ2KPs2HNzuZvlkowjwD/pXBXDq9RX8UF5TYfU+h8TXu/
	 g3PGMaKaeroX88dNz3Awwc1Jw6pehGgF48l1Ce7XG6DTgJa7GaIpuBva9622hd9L5J
	 D9GPOzZncXyr7xyVxNQNJVNTAKbKnGohfvNeWnMw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 155/198] ARM: dts: bcm2711: Dont mark timer regs unconfigured
Date: Tue, 25 Mar 2025 08:21:57 -0400
Message-ID: <20250325122200.724321065@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Elwell <phil@raspberrypi.com>

[ Upstream commit c24f272ae751a9f54f8816430e7f2d56031892cc ]

During upstream process of Raspberry Pi 4 back in 2019 the ARMv7 stubs
didn't configured the ARM architectural timer. This firmware issue has
been fixed in 2020, which gave users enough time to update their system.

So drop this property to allow the use of the vDSO version of
clock_gettime.

Link: https://github.com/raspberrypi/tools/pull/113
Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250222094113.48198-1-wahrenst@gmx.net
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2711.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index d94e70d36dcad..27b467219a402 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -451,8 +451,6 @@ IRQ_TYPE_LEVEL_LOW)>,
 					  IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
 					  IRQ_TYPE_LEVEL_LOW)>;
-		/* This only applies to the ARMv7 stub */
-		arm,cpu-registers-not-fw-configured;
 	};
 
 	cpus: cpus {
-- 
2.39.5




