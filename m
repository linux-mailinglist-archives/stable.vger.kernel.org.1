Return-Path: <stable+bounces-31789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157388984C
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77472B382AF
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C1179655;
	Mon, 25 Mar 2024 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScBUdi+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE9272995;
	Sun, 24 Mar 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323314; cv=none; b=dhm4hTx2XxeSlAOcbZzsBW1tQacjgdWQOcrG5dclptfb25UySOnavRB8SpZqQjuMas+7bB2A6CT2JNhX3DhRjeTp++JfVx0CcVkbkifqoLOHDeF2P2NSAkjyBvM1zMnzj7EXYJ9GwMoN8lPpcdv+R5HVFqeIutVCgJKDn9C7lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323314; c=relaxed/simple;
	bh=lDJ/WcAUElCfR9BHJ0p9gKCvoLwlAhMexx0r5bWWcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luNOq/dYQAO7IVz4dnFVRX3aPQaf2Tz83kIecVqRLKwuVUhqd9kZMkZCpaqFKSeNDAZd+q9CkmIMZ0sh67D1lWRwYLWdsZ8mS3LA99dNFmAFUuoNSNIgAHIoIGSXZOtD25lLZuIguWsvljChinc74yXUbtfFjGdYrLM538O1Tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScBUdi+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B4DC433F1;
	Sun, 24 Mar 2024 23:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323314;
	bh=lDJ/WcAUElCfR9BHJ0p9gKCvoLwlAhMexx0r5bWWcn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScBUdi+4wL1YALfn7MAE8sujdiJbuAcih1JswxcOqy+Rae3NjOocPZB6L8+LOZort
	 I1Nz33Qon2nXZNwZPKPs1eFICET+RTGto5dZ3wng5NXU4Mj/z1RoarBm3THzv5I/IE
	 bVwjOicPg2sm8meki9ZdCjA3rU/i3M0L21RjSkyE6+FsijfWxcdhg8NzUdBJTSTn+L
	 enMl217DZ7s6KZbIzyl0O3UfPOFQ/lyUTzmuLqbYZLwxom1YDOYZCC9yO7Rruq7Qst
	 /iCSirpVCc9SdkvQkFKJNAaeda9JpObyQIhgVwCHMaC0+ypW9bkDcrINNoyCHBFSRv
	 baxvMsilvrcHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 014/317] riscv: dts: sifive: add missing #interrupt-cells to pmic
Date: Sun, 24 Mar 2024 19:29:54 -0400
Message-ID: <20240324233458.1352854-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit ce6b6d1513965f500a05f3facf223fa01fd74920 ]

At W=2 dtc complains:
hifive-unmatched-a00.dts:120.10-238.4: Warning (interrupt_provider): /soc/i2c@10030000/pmic@58: Missing '#interrupt-cells' in interrupt provider

Add the missing property.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index b40990210fb50..3c621f31b5fd2 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -70,6 +70,7 @@ pmic@58 {
 		interrupt-parent = <&gpio>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		regulators {
 			vdd_bcore1: bcore1 {
-- 
2.43.0


