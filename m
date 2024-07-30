Return-Path: <stable+bounces-62954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A8941669
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3414281BE8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75A1BA87E;
	Tue, 30 Jul 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeelipS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7B19F467;
	Tue, 30 Jul 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355180; cv=none; b=VWQYfW6KaBjeyPyPDbnMn2BXUBK20PWcsdzuEMizlYnHsH8kYDTT0VjGedg+P//5phkjA8XMu54OF+6eKgfvPA6GogJddu4brzpL+786h8uKd/THycqKgDP/+elVF/wiuyl5KDaaB37GjZ5KTHw/QxdSga2CmwP9qMopJtmsnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355180; c=relaxed/simple;
	bh=mygkWpuo/6s51hbZGcRA4bBeZSgbT2tmp0NkY8+nCNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEz9P33F+Ln8dsqoXDw/f1tyMn2IKltSWniWlIV7QIDg3tcUJv25JF/TsCRPvG9taVmmfygLpM5RfEckjtYtQnDiTgvoW31mU45UNsWBSHnkXMYiTQR1BXcBbOzEmDoDjn4uesMK+fEomhoF7qMVIiAvb6C/6fdfQlToT+7S1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeelipS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9700CC32782;
	Tue, 30 Jul 2024 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355180;
	bh=mygkWpuo/6s51hbZGcRA4bBeZSgbT2tmp0NkY8+nCNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeelipS9texNSlvcLEhyKkEuxG84WgXCPd7/RXUUCONwuK1GdVoT7PeUyYyY+z98X
	 V0Xae3cpRl124DE+GrrhI4a8YkUIFPChd0LAYiY9TZSiiREvcRTSnDCWdhcOdzeGMw
	 ueKKVNTQXnlgKec2RdbuRA19j4NFfjFT0cFwO4Z0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/440] arm64: dts: renesas: Drop specifying the GIC_CPU_MASK_SIMPLE() for GICv3 systems
Date: Tue, 30 Jul 2024 17:44:58 +0200
Message-ID: <20240730151618.304030749@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 8b6a006c914aac1702ef85b4ea42ff566b157c85 ]

The GICv3 interrupts binding does not have a cpumask. The CPU mask only
applies to pre-GICv3. So just drop using them from GICv3 systems.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230206002136.29401-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: 6fca24a07e1d ("arm64: dts: renesas: r8a779a0: Add missing hypervisor virtual timer IRQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi    | 11 +++++------
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi    | 11 +++++------
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi    | 11 +++++------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi  |  8 ++++----
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi   |  8 ++++----
 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi |  7 -------
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi |  7 -------
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi   |  8 ++++----
 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi |  7 -------
 9 files changed, 27 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index b677ef6705d94..fa76827c81c93 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -2209,8 +2209,7 @@ gic: interrupt-controller@f1000000 {
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		fcpvd0: fcp@fea10000 {
@@ -2857,9 +2856,9 @@ sensor5_crit: sensor5-crit {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 4092c0016035e..ba94e4d31cc8d 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -935,8 +935,7 @@ gic: interrupt-controller@f1000000 {
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		prr: chipid@fff00044 {
@@ -991,10 +990,10 @@ sensor3_crit: sensor3-crit {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	ufs30_clk: ufs30-clk {
diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 8aa3ea645668c..369370c0a61e3 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -550,8 +550,7 @@ gic: interrupt-controller@f1000000 {
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		prr: chipid@fff00044 {
@@ -562,9 +561,9 @@ prr: chipid@fff00044 {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 011d4c88f4ed9..beab2bfd253b8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -41,10 +41,10 @@ psci {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index d26488b5a82df..4a74906061dd8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1091,9 +1091,9 @@ target: trip-point {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
index 1d57df706939c..56a979e82c4f1 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
@@ -15,13 +15,6 @@ cpus {
 		/delete-node/ cpu-map;
 		/delete-node/ cpu@100;
 	};
-
-	timer {
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
 
 &soc {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
index 9d89d4590358e..9cf27ca9f1d2a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
@@ -15,11 +15,4 @@ cpus {
 		/delete-node/ cpu-map;
 		/delete-node/ cpu@100;
 	};
-
-	timer {
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index b3d37ca942ee3..0e319cc2460c5 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1097,9 +1097,9 @@ target: trip-point {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
index c448cc6634c1a..d85a6ac0f0245 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
@@ -15,11 +15,4 @@ cpus {
 		/delete-node/ cpu-map;
 		/delete-node/ cpu@100;
 	};
-
-	timer {
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
-- 
2.43.0




