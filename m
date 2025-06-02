Return-Path: <stable+bounces-149418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C075ACB2D9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728F4940D61
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F223183D;
	Mon,  2 Jun 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWCT1HsZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806421E3772;
	Mon,  2 Jun 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873903; cv=none; b=KqpsO2NCRGlgoJJkQCu3oN+N8A+M3FkLqVcmSFsLeI15De4k2+di93iAUhl3sy8q7vd2MaRxQat2uFOmMjFn+xungzq7BhrkTpet7DjaGyMmtvz4EaRsSYNu+gKc5js9FUuZ+a5LAiXpS8vfLGo6D0eXyuOm8Zjtjpj2sgWSuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873903; c=relaxed/simple;
	bh=geXcXXpPfURGRdTFj3dI6C3EkH4ebtDU4LeqRYtgsUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM6Cj0zFMM85Yh8AFE5KKIoSv3XXfD8cY0mG/QwH7k6DhC/qv94PFCDqPvOohSByoyI40h8CkD0vMhZQGJRDAezvOdxLJiuSo+MHkUZ7fzwKredxaX6fRh7Bil7SMRhVzttfHsoP+DjTw+QbQeXN1yn8DmtMQv4VY29MUOMOgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWCT1HsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9C8C4CEEB;
	Mon,  2 Jun 2025 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873903;
	bh=geXcXXpPfURGRdTFj3dI6C3EkH4ebtDU4LeqRYtgsUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWCT1HsZtDwKacUXeSJN4x5DV+mfpKG+yxPS/AmF+xzaFVXv+h+AycqH5xXWAumgR
	 P2dSkWBjHuR/IqfKpyoFTmwOwxWFhrjoXa1+BSt7muteez8pNnhhBb/efA5imhUc+m
	 5chtOUoiVweseqoFVZipORSTNVLJHkxhKpWTePGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naman Trivedi <naman.trivedimanojbhai@amd.com>,
	Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 291/444] arm64: zynqmp: add clock-output-names property in clock nodes
Date: Mon,  2 Jun 2025 15:45:55 +0200
Message-ID: <20250602134352.766747344@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ccaca29200bb9..995bd8ce9d43a 100644
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




