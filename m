Return-Path: <stable+bounces-46372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AAD8D0388
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B291C216B3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA1179204;
	Mon, 27 May 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPPUKTtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FC1607A7;
	Mon, 27 May 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819294; cv=none; b=eDss7X48ZwiCIjjeM49xj7bIwvjnplCpwij/zbPQO34pIvlUQVgR+QQ7ICIOi1ff2JOqBSlqsALbTJjgEX+0gCCgjzQDTVK4dEWKcCEYFyOU5/UfErGOwdhy7anuKPwsO0FVRSrfU3db4ubsg+vuzgqeoNUypOETF4OlXoHU5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819294; c=relaxed/simple;
	bh=BTZoMen+1fpA/CNBnCxA92Z/GJb+IgPtUAZjq1CtUdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAcnwOUqiy5r4T+9lzJXYYOpflrucmMsh4OMNitMVUoqZDrE4wn74IEXYIXzldnQQ3jWALqEdFp1XsEgALfJzYLNMqpuRxkC2t3YGJYJTIaLCqj32Hn3nqevTmmazS1+gtzSsNfZB3J0uAWMuRn/YztwEVDD6A8+O5UaQ9WcdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPPUKTtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C37C32789;
	Mon, 27 May 2024 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819294;
	bh=BTZoMen+1fpA/CNBnCxA92Z/GJb+IgPtUAZjq1CtUdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPPUKTtYuF2poydhh3WzL2077JNmTuSYjigz2Yn0prvdV7VlFl0hOuxB0tkGLhfXi
	 tIVHEPuwh+RQdOyS39ueFw8c+XKE8EZJLLBcYEN3G1x/ttiFsSieU8t8lS2+YOMXLy
	 M1Ctf1z8yvqajyklZMX/qYQ8WAVLFNoFDqUD6lL3cUcYJ/fbH+tieZmEEgf58XSrvF
	 N7TYwyDsAjHb/Nw1c3YpRWapm4MVlq0PHOUBKPVxwuerwd5Y+7bzesaX7d/3rd8mp4
	 4OKhQQrTLuS3Gby+298Skna4zU7ZRvYc/Y+AC/ysC90+3xFc7D3AGSSKfVGGmNU+yA
	 p6NPXmEMreJCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiqi Liu <shiqiliu@hust.edu.cn>,
	Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	suzuki.poulose@arm.com,
	miguel.luis@oracle.com,
	joey.gouly@arm.com,
	oliver.upton@linux.dev,
	jingzhangos@google.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 17/30] arm64/sysreg: Update PIE permission encodings
Date: Mon, 27 May 2024 10:13:26 -0400
Message-ID: <20240527141406.3852821-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Shiqi Liu <shiqiliu@hust.edu.cn>

[ Upstream commit 12d712dc8e4f1a30b18f8c3789adfbc07f5eb050 ]

Fix left shift overflow issue when the parameter idx is greater than or
equal to 8 in the calculation of perm in PIRx_ELx_PERM macro.

Fix this by modifying the encoding to use a long integer type.

Signed-off-by: Shiqi Liu <shiqiliu@hust.edu.cn>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20240421063328.29710-1-shiqiliu@hust.edu.cn
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/sysreg.h       | 24 ++++++++++++------------
 tools/arch/arm64/include/asm/sysreg.h | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c3b19b376c867..5396176d23b7e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1036,18 +1036,18 @@
  * Permission Indirection Extension (PIE) permission encodings.
  * Encodings with the _O suffix, have overlays applied (Permission Overlay Extension).
  */
-#define PIE_NONE_O	0x0
-#define PIE_R_O		0x1
-#define PIE_X_O		0x2
-#define PIE_RX_O	0x3
-#define PIE_RW_O	0x5
-#define PIE_RWnX_O	0x6
-#define PIE_RWX_O	0x7
-#define PIE_R		0x8
-#define PIE_GCS		0x9
-#define PIE_RX		0xa
-#define PIE_RW		0xc
-#define PIE_RWX		0xe
+#define PIE_NONE_O	UL(0x0)
+#define PIE_R_O		UL(0x1)
+#define PIE_X_O		UL(0x2)
+#define PIE_RX_O	UL(0x3)
+#define PIE_RW_O	UL(0x5)
+#define PIE_RWnX_O	UL(0x6)
+#define PIE_RWX_O	UL(0x7)
+#define PIE_R		UL(0x8)
+#define PIE_GCS		UL(0x9)
+#define PIE_RX		UL(0xa)
+#define PIE_RW		UL(0xc)
+#define PIE_RWX		UL(0xe)
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
diff --git a/tools/arch/arm64/include/asm/sysreg.h b/tools/arch/arm64/include/asm/sysreg.h
index ccc13e9913760..cd8420e8c3ad8 100644
--- a/tools/arch/arm64/include/asm/sysreg.h
+++ b/tools/arch/arm64/include/asm/sysreg.h
@@ -701,18 +701,18 @@
  * Permission Indirection Extension (PIE) permission encodings.
  * Encodings with the _O suffix, have overlays applied (Permission Overlay Extension).
  */
-#define PIE_NONE_O	0x0
-#define PIE_R_O		0x1
-#define PIE_X_O		0x2
-#define PIE_RX_O	0x3
-#define PIE_RW_O	0x5
-#define PIE_RWnX_O	0x6
-#define PIE_RWX_O	0x7
-#define PIE_R		0x8
-#define PIE_GCS		0x9
-#define PIE_RX		0xa
-#define PIE_RW		0xc
-#define PIE_RWX		0xe
+#define PIE_NONE_O	UL(0x0)
+#define PIE_R_O		UL(0x1)
+#define PIE_X_O		UL(0x2)
+#define PIE_RX_O	UL(0x3)
+#define PIE_RW_O	UL(0x5)
+#define PIE_RWnX_O	UL(0x6)
+#define PIE_RWX_O	UL(0x7)
+#define PIE_R		UL(0x8)
+#define PIE_GCS		UL(0x9)
+#define PIE_RX		UL(0xa)
+#define PIE_RW		UL(0xc)
+#define PIE_RWX		UL(0xe)
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
-- 
2.43.0


