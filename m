Return-Path: <stable+bounces-78797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716D98D508
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0541F21B42
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60C1D043F;
	Wed,  2 Oct 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GhCH2vTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481881CF28B;
	Wed,  2 Oct 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875559; cv=none; b=pilglOR+iS4/fTUP0juRHkSP33RYYSdoHtm8A+1fUCVryW9uB4YbzmBm0yg1lr2Hd4V3iM4lnHh42xUU2ws/L29ByS8MZvegaDlug1jZ1X5HbwfXjD+oK+Vj84YtiFhsjdApmkUbwK9cjlyIhv8K9hfGe3mUTZq5txNULALK+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875559; c=relaxed/simple;
	bh=dDGmRgSkL+d4veLv4DBQuktaK8LwwqxGijWcn0rR5wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTHeM6Tb+kyFoFECsm3ZsCVrMz9pjbHpYLbhXjWETZ4GTZO5aB5SrGYYZS1qByGz185hryHzF3Mk1DDhp5d7Th2QlrmLQ6GWVHmUJX/XHeUCOa4/TcheQgJ4M5xzc1fuyXXwRvxqpG80FWS/EY5iFDSnAGC2snKKEQ75sU/ijK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GhCH2vTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAE3C4CEC5;
	Wed,  2 Oct 2024 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875558;
	bh=dDGmRgSkL+d4veLv4DBQuktaK8LwwqxGijWcn0rR5wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhCH2vTx1iSOGpHtlL5rmc9AqpxA02ba6WPIYCnjvFXKrV64eNmAY9qY7/IIohQzZ
	 vgbtt/RUGqjYBgPK1le3KAbLgJK6CQ3NG76O7DFC88V3kJIoCiDwN/aKTAhZLg58Uw
	 4VhxPwE8/dlqTf429ZR+Ts28wSeENTCdc6ALvYbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 142/695] arm64: dts: renesas: r9a07g054: Correct GICD and GICR sizes
Date: Wed,  2 Oct 2024 14:52:20 +0200
Message-ID: <20241002125828.153514990@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 45afa9eacb59b258d2e53c7f63430ea1e8344803 ]

The RZ/V2L SoC is equipped with the GIC-600. The GICD is 64KiB + 64KiB
for the MBI alias (in total 128KiB), and the GICR is 128KiB per CPU.

Fixes: 7c2b8198f4f32 ("arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/20240730122436.350013-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1de2e5f0917d9..8a9b61bd759a7 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1051,8 +1051,8 @@
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <0x0 0x11900000 0 0x40000>,
-			      <0x0 0x11940000 0 0x60000>;
+			reg = <0x0 0x11900000 0 0x20000>,
+			      <0x0 0x11940000 0 0x40000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
-- 
2.43.0




