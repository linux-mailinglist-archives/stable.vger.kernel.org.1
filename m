Return-Path: <stable+bounces-134939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA9A95B6C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422AC3A6394
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BE25D527;
	Tue, 22 Apr 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB868pTE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DED25D219;
	Tue, 22 Apr 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288243; cv=none; b=U4z8J8BOby/nSPuUsCBp/aIcNldMq+A6e28bKoF+j/a0+XdzvxQXoFL38j2lq7jHckBry+4PSdolIbLiN5Vyymzg4WygC0NjAe93FEkP+T+0Aw/tzVb35GCuYhKh6bbV9W+Zxn41FqYmr5w+zHMgULD7+frCq7mN1+Lz0JbcMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288243; c=relaxed/simple;
	bh=k0CvyBXD/JneYEp1nm10fppRGqN6XZUKVHkWxBtVi+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJfQhrAOaYlgHfs3NPHG37SVlJMbGxz/8LNOGTXXQgqjfHH2oPvHyeEUGRg1TGBkMfdfjrXo1PeOIu6wx1QNE3zzTa/X+Gz+kvWM7TEJXJQ8fUpRNqaAHXd3qLOrRqeBJu7H+FlseYyMFT1d3EH7CTcsehQeJLpIQGIfPAoak2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB868pTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80AC4CEEC;
	Tue, 22 Apr 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288243;
	bh=k0CvyBXD/JneYEp1nm10fppRGqN6XZUKVHkWxBtVi+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SB868pTE/GSZ5UHt2lm5hz8lFrsDgNPP6TQOrwnAuhTvarKB2onR4pe/QdZ35K+jf
	 RQrexb3SLEWTX+7zbJ4kBWinU4OBq2e9l40G/L0KINp+UCHYQxpII3ntSb/JouYvo9
	 KpYrEjbyqgNRLGyaGArru3CRDvuD1NxWrG35jqSYDUe5Q7QYwWaoNOLIh7Gsoxz3EB
	 5oL38CKCn3fzI1b0kQ79PDZ2LCeDpSvKGkO2JALt95Xv01yIVrZ5lLxZzgybjtt1q6
	 msfhXr2My2TQcuNPeCxhdnc5K8IzqbGoaJKyAzYzUrrnftPFSWC3jI+GKh+Avq+H6p
	 hFl4DcVsyu5rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
	kernel test robot <lkp@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 11/23] riscv: Provide all alternative macros all the time
Date: Mon, 21 Apr 2025 22:16:51 -0400
Message-Id: <20250422021703.1941244-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Andrew Jones <ajones@ventanamicro.com>

[ Upstream commit fb53a9aa5f5b8bf302f3260a7f1f5a24345ce62a ]

We need to provide all six forms of the alternative macros
(ALTERNATIVE, ALTERNATIVE_2, _ALTERNATIVE_CFG, _ALTERNATIVE_CFG_2,
__ALTERNATIVE_CFG, __ALTERNATIVE_CFG_2) for all four cases derived
from the two ifdefs (RISCV_ALTERNATIVE, __ASSEMBLY__) in order to
ensure all configs can compile. Define this missing ones and ensure
all are defined to consume all parameters passed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504130710.3IKz6Ibs-lkp@intel.com/
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20250414120947.135173-2-ajones@ventanamicro.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/alternative-macros.h | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 721ec275ce57e..231d777d936c2 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -115,24 +115,19 @@
 	\old_c
 .endm
 
-#define _ALTERNATIVE_CFG(old_c, ...)	\
-	ALTERNATIVE_CFG old_c
-
-#define _ALTERNATIVE_CFG_2(old_c, ...)	\
-	ALTERNATIVE_CFG old_c
+#define __ALTERNATIVE_CFG(old_c, ...)		ALTERNATIVE_CFG old_c
+#define __ALTERNATIVE_CFG_2(old_c, ...)		ALTERNATIVE_CFG old_c
 
 #else /* !__ASSEMBLY__ */
 
-#define __ALTERNATIVE_CFG(old_c)	\
-	old_c "\n"
+#define __ALTERNATIVE_CFG(old_c, ...)		old_c "\n"
+#define __ALTERNATIVE_CFG_2(old_c, ...)		old_c "\n"
 
-#define _ALTERNATIVE_CFG(old_c, ...)	\
-	__ALTERNATIVE_CFG(old_c)
+#endif /* __ASSEMBLY__ */
 
-#define _ALTERNATIVE_CFG_2(old_c, ...)	\
-	__ALTERNATIVE_CFG(old_c)
+#define _ALTERNATIVE_CFG(old_c, ...)		__ALTERNATIVE_CFG(old_c)
+#define _ALTERNATIVE_CFG_2(old_c, ...)		__ALTERNATIVE_CFG_2(old_c)
 
-#endif /* __ASSEMBLY__ */
 #endif /* CONFIG_RISCV_ALTERNATIVE */
 
 /*
-- 
2.39.5


