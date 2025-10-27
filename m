Return-Path: <stable+bounces-191111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE7C11072
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27A8582C2B
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC055302CB9;
	Mon, 27 Oct 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSA+zOms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F612C15BB;
	Mon, 27 Oct 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593038; cv=none; b=LklEduKpBkAa7CDkNdCi2JcS52cWTF19v7FVI09Pr4fIQIYxf19mVBdcWA/6Ozou5u6CnxbseVP6NFolr1uiI2F2+vH6JdiOouw7FP3SeK4zPFylkn8HNI80MrRDQ4PgfvBxBNgZcYfjPFgz/6K3hOYyS3LgbN3LCdx/pFpPARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593038; c=relaxed/simple;
	bh=MAPa9ak95kUmJpF0B3c5hE2Y5p+74FBaCNY30J2gzs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXlygxKd1WhYfMwRrjYrt7ShEaBMly8rJvYp9+sOa8hLUses6hULQSlS1TBxgS+5Ysd1EdoGPYR06vIT3lWkVuq0Ut0cek9iQZeu056Y9ceaFZcODVBuM+PlY8Vu9kW9m9awnVXfK4/Kwe0abhNcJNyWUpTsc0mdTPTUFQto97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSA+zOms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A241C4CEF1;
	Mon, 27 Oct 2025 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593038;
	bh=MAPa9ak95kUmJpF0B3c5hE2Y5p+74FBaCNY30J2gzs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wSA+zOms002+oc7mf68pmhE+hKm2YHqk3b5GA2n7y7S41CWQiOEe6T4paACU80Jac
	 X9cKsXUce8e0hfcHOT+m5vm3uWKGzFCE4m+Ax2vkY2DmH/HS19N4xfTj5180RAjSOO
	 dH4KSvowUWboyH7dB2Vrne9Xap4WF3tskIA5fvng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Robinson <pbrobinson@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 071/117] arm64: dts: broadcom: bcm2712: Define VGIC interrupt
Date: Mon, 27 Oct 2025 19:36:37 +0100
Message-ID: <20251027183455.930457113@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit aa960b597600bed80fe171729057dd6aa188b5b5 ]

Define the interrupt in the GICv2 for vGIC so KVM
can be used, it was missed from the original upstream
DTB for some reason.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Andrea della Porta <andrea.porta@suse.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Fixes: faa3381267d0 ("arm64: dts: broadcom: Add minimal support for Raspberry Pi 5")
Link: https://lore.kernel.org/r/20250924085612.1039247-1-pbrobinson@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 0f38236501743..209f99b1ceae7 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -264,6 +264,8 @@
 			      <0x7fffe000 0x2000>;
 			interrupt-controller;
 			#address-cells = <0>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+					IRQ_TYPE_LEVEL_HIGH)>;
 			#interrupt-cells = <3>;
 		};
 	};
-- 
2.51.0




