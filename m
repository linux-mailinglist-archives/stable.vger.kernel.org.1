Return-Path: <stable+bounces-46340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC538D0311
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC341C220E1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446216D9C9;
	Mon, 27 May 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGU5bMod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A515F3FD;
	Mon, 27 May 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819174; cv=none; b=DzZcPRTbgorGC0ylwapiOhWF0i7hLBksh1cI2VstxfLKh7r9gESVvv6jyboW28gUfMJ0goOvB5/Ex2q+sbyw/S51WJZ0cQbKYPb5pn/PGecqZYEw5k++Z/gNJR9eDZMASHoJAojqVS6FSlxJWVOnCJCGY+cWt5FAMUqvn7Jd5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819174; c=relaxed/simple;
	bh=u6qFsFok2jeIPfIgLDCqMxuh5YFGDR29kCcIbVjQGMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/2eY+a+dverWatJMISaMK/aSqSfnBb5vAVQaz+LrvGMMbedE+y1n/1dU3hPyNOXZBH6bwU6r8hPwDmxqGl7hmWxeNj8sAEWsKSkhNr5lzWVT1EW/9lf7Lo+JQhEvpqKp9YQoyBwZ6UbRckn19r9j+sjWUbo8A2VPFVzw6K6AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGU5bMod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0E9C2BBFC;
	Mon, 27 May 2024 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819174;
	bh=u6qFsFok2jeIPfIgLDCqMxuh5YFGDR29kCcIbVjQGMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGU5bMod+6cqL5vtSe1PRBsKvGsrkCsJvyPlrqX2Ij9uwqAxwo43/4BOKG88D8+3m
	 Hz8625a2xy8jXU+tXs9mq4mzUnf1oDblti+DN4XLSlBCABRAb+OW935DIDVduNA6mW
	 4CW+NE1U8oI5Ek2ulw3xYczmxSCYK+mLjtjqmG5QBglBQ3rDjpbSyLRkmx8ZC2MOMb
	 TX+THRuyKWH/a8RRTMdAschRORic0Exb+phzOw8K34fN1HUkSshH7RArA5fl+p+n1w
	 2I6UXWPM7fkyH19hwOyID4SxJzTuhcxyvQdfy0akBbvLQ0oGe20m/4NJNVK9kUSuri
	 4/s5sQqBwG4Tw==
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
Subject: [PATCH AUTOSEL 6.9 20/35] arm64/sysreg: Update PIE permission encodings
Date: Mon, 27 May 2024 10:11:25 -0400
Message-ID: <20240527141214.3844331-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index 9e8999592f3af..af3b206fa4239 100644
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


