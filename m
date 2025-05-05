Return-Path: <stable+bounces-140319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1775AAA774
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECA3188BE56
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7D29824F;
	Mon,  5 May 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFKpTaLG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD8298246;
	Mon,  5 May 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484629; cv=none; b=e1CWKzzfmgHQHOfS7UBUVfj25AaGgIT/4ai0DgVkWUwGIxYO7kghw8IAk1DLPLvhCU/U827QrFrAPbgzjA7rrFUloHcLcMuC5Ot3M8RG//z0CgGM3guqexI4C1dspUkA6RFesb/fQu/CuSXOfSsl//69IyeV7s/us20XrOa3b2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484629; c=relaxed/simple;
	bh=KCH91/zsYJ4aTUBVAhrrGbgMbywzpLFiEgK6TFB6SxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKscyWomVANOk/IsVzE9aMY4DMqoo6hP3RSaAkDwbt4Jp4hyVORMZjQ3JFpXwzUi9bfkHEMdUyHZ60ypoODTu+kxCp3vVZFTzorroCr9ZAdkgIXtUXmk8l54/q6IpUOL/8zzdViSSUV3q1Hrh1jbCANLxM82cXDp8VGjSNqNtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFKpTaLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC450C4CEE4;
	Mon,  5 May 2025 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484629;
	bh=KCH91/zsYJ4aTUBVAhrrGbgMbywzpLFiEgK6TFB6SxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFKpTaLGTEPQuV0QvBLr4QPYosS1SRMoKYHoitm6f2cf5g4C42JWGZa7EzkjuUAOx
	 PRmN9gU9PpxTuj4t9JnFrv+xwWTkKzXxkLTzYYLLbbBmrxrDuEhxbRmoNYMFsBRa33
	 I389BwoQ8clbVVm95FLO7rzJhfaFqiOO0TuaeqP5wrD1NE0HGtN9hvv584/Gv0NEha
	 OFYcVIHYeOOjGZgNvwGznPEIwOgJA+uAOsh8bhBioi/xX8gV45OXSKDnAzK/FGYOU/
	 ZWBFIG5ZX8pOVT6h8HpK+TMaTfVjqBgbdNHPhY+ilx6P/9EQxDRZo9ZR7BKIe6CO5+
	 Msz9NpoRlKxZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naman Trivedi <naman.trivedimanojbhai@amd.com>,
	Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sean.anderson@linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 571/642] arm64: zynqmp: add clock-output-names property in clock nodes
Date: Mon,  5 May 2025 18:13:07 -0400
Message-Id: <20250505221419.2672473-571-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Naman Trivedi <naman.trivedimanojbhai@amd.com>

[ Upstream commit 385a59e7f7fb3438466a0712cc14672c708bbd57 ]

Add clock-output-names property to clock nodes, so that the resulting
clock name do not change when clock node name is changed.
Also, replace underscores with hyphens in the clock node names as per
dt-schema rule.

Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
Acked-by: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
Link: https://lore.kernel.org/r/20241122095712.1166883-1-naman.trivedimanojbhai@amd.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 60d1b1acf9a03..385fed8a852af 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -10,39 +10,44 @@
 
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 / {
-	pss_ref_clk: pss_ref_clk {
+	pss_ref_clk: pss-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
+		clock-output-names = "pss_ref_clk";
 	};
 
-	video_clk: video_clk {
+	video_clk: video-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
+		clock-output-names = "video_clk";
 	};
 
-	pss_alt_ref_clk: pss_alt_ref_clk {
+	pss_alt_ref_clk: pss-alt-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
+		clock-output-names = "pss_alt_ref_clk";
 	};
 
-	gt_crx_ref_clk: gt_crx_ref_clk {
+	gt_crx_ref_clk: gt-crx-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <108000000>;
+		clock-output-names = "gt_crx_ref_clk";
 	};
 
-	aux_ref_clk: aux_ref_clk {
+	aux_ref_clk: aux-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
+		clock-output-names = "aux_ref_clk";
 	};
 };
 
-- 
2.39.5


