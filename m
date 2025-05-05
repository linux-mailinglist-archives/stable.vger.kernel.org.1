Return-Path: <stable+bounces-141303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E754DAAB68F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803F51C20F53
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82E36A986;
	Tue,  6 May 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpeJ4SI9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CC2D7AE6;
	Mon,  5 May 2025 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485729; cv=none; b=EyI4qL5roRrb4DUphMMcMSB3/2lGQoxscZFkIFFW4lgkDPMR5RMF63HNsSjczzlNtIazWJ4ANGr+NF6chbflVf+zwjljQ9wBFgrSDoEVExs5C21IR/BYcE8BWf5XKjVX8n4vHbuMME1/vXnT9FzdYO6aLkGXNc40z0//sIdXpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485729; c=relaxed/simple;
	bh=KCH91/zsYJ4aTUBVAhrrGbgMbywzpLFiEgK6TFB6SxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFEbWOyqiX4EgPFCRb5c6gwXQO7VbICKtAxsqTfOaxssMt/XyKsuPzXU1cQGFaFmVuvBOLW+bDKki4dXdxzw17zmwVE9wZWZx8xrM1BnPcG7i4ZPxkxaNXkdfmA/v3KhKKwpdsn2ZBU4oAJ51tjtDzOyLcabE3uwA6yFn6tr6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpeJ4SI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900FCC4CEE4;
	Mon,  5 May 2025 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485727;
	bh=KCH91/zsYJ4aTUBVAhrrGbgMbywzpLFiEgK6TFB6SxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpeJ4SI9iXaSae5UtWgfzH30ggObgB5odAgcQCxPCCsIsCmq08KRRNfl9Ol78TABr
	 Wl7VZUcRkLU90w8TdElWZG5mPp4jwv0hP8hzdK/H95uADvNHWuLkAT5h8jAnlp7kd/
	 x7TjBu3MnJM/Wlrth1NBJsG4gYQ5sYZsg/5nxwWanRXXXv4iyTwlcdgAxJigCPl+p1
	 YeJpGP/6THFm4meXh4ATf6tvUwo/1uL3VqPXuDQNRZ9oVJmCBL2UoV6aJcP19FFZ2D
	 xQTGylI43UdNt7IkBj3Nqenqd/sPuJzCK5+K0DsLCP0Rp2bA6B/YL02I8KPGHfo8iS
	 jgDgtLXiJ5pGA==
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
Subject: [PATCH AUTOSEL 6.12 447/486] arm64: zynqmp: add clock-output-names property in clock nodes
Date: Mon,  5 May 2025 18:38:43 -0400
Message-Id: <20250505223922.2682012-447-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


