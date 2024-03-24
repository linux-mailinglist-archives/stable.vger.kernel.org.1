Return-Path: <stable+bounces-29563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72188864F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4C828CF92
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AE14883C;
	Sun, 24 Mar 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKcuileL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0931DF0FF;
	Sun, 24 Mar 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320744; cv=none; b=KRoWCvK2cy4+RM79DtyMofehtQ19thLiFG0AmZ1HVTVsxYufWrwsoIdOVvDTef4tEged/Y8XQ2APPiFjd0UJKJmfOjWvbLChjp5pC2BcMPXmLRgpUNt6v7TBH3N3iA2g1oqVJHBDwIWIE3TjoVXr3TO/MUI2OBrATgHB6Zbj2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320744; c=relaxed/simple;
	bh=hmQWRWL7arDI/JH7/+hDhSSggeI1GZPVqcl3qHGLP78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIAPEi7tx7VCz3640aHcAgAvfdX4W1LViQsEVjlP/rNJPBvTc+yPsZsDG4xm4LklUOmwMgwbprI99XXBNbVtTp4lqqukp3UmH9l2/G/P3vGpqL1gYU0c8GKqh4t/4V0aavRKW9AUbaW+p5OIRc2JYSDPHARVnj6+dvgVwaosJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKcuileL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D57DC433F1;
	Sun, 24 Mar 2024 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320743;
	bh=hmQWRWL7arDI/JH7/+hDhSSggeI1GZPVqcl3qHGLP78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKcuileLlrm42CzTPBs2hsUg8Cys8mAGKL0I6q0exdFpRiRaXusyDwBrSe38+lYod
	 P+7w7+eQWvTtUA07lWoxsa8N6o2nr8cfSwzlZDGgOs9edeZylMJW92lF4Tjoh0YeZv
	 hSOZFPGAZG9H63OwFjfEbYFLsrHkImERXnAsspxerAJZ60PzGHQhdfEYvoJ5Zrl+8n
	 0iF2dRE5AkOZtHAPDNFySUrKotusUOomhHVr85FnwsmhZinV1zkNWJi4ampSSEYZKJ
	 hjbQNgxTl/MoLmO0WnuWFm1dwnEyARAuqu0WGgvPJ7YFwXPXzLkFaRqiuH/iJjhEPc
	 bw5TlUZecCa4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 307/713] arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 18:40:33 -0400
Message-ID: <20240324224720.1345309-308-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7edbb5880dc3317a5eaec2166de71ff394598e6b ]

All Ethernet AVB instances on R-Car V4H have registers related to UDP/IP
support, but the declared register blocks for the first two instances
are too small to cover them.

Fix this by extending the register block sizes.

Fixes: 848c82db56923a8b ("arm64: dts: renesas: r8a779g0: Add RAVB nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/83437778614a7c96f4d8f1be98dffeee29bb4a0b.1707660323.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 0c83940b3d8a1..d7677595204dc 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -767,7 +767,7 @@ channel7 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
@@ -814,7 +814,7 @@ avb0: ethernet@e6800000 {
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6810000 0 0x800>;
+			reg = <0 0xe6810000 0 0x1000>;
 			interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


