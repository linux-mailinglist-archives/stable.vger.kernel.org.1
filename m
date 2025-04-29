Return-Path: <stable+bounces-138901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D46AA1A77
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71FA3B1191
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514024889B;
	Tue, 29 Apr 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t5qFFjv4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE1155A4E;
	Tue, 29 Apr 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950715; cv=none; b=iXHENt6UtI/O7mfkCCUe3yL4wrk94ix/XVhdRlZcbvfjElRmQ8ixdNk39WSrjyh8Li1Dwd3rXic+8sSO6bfcuLPs/aVXUH6j1JyYfVNXr2PQ6vL6EPWHKhlN5i3EubLgSSt/UWzn/RgzPU+GZ5ZQJKLCvNIA8mt2xgBfQqtHD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950715; c=relaxed/simple;
	bh=g+2ts8Y8iakxVX/RByZc4SZSL8vqsUwS2VZ/7tvD3KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHAMyVuJwEa9QKc+91NmHkO4xKUb9574uiaI9qTKFCK1tguJ+1OD2dBW8eyl97h2QbtM9OY28XXAeT6ov0vdsuM6WaT/PhRxs8lC1qtXfdj3kqkcSp2HO0LeIz0YmwNu0ujCL5AWzErEbk+QsEFatb5pYaSsjcnTLVYUY9TWRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t5qFFjv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA49AC4CEE3;
	Tue, 29 Apr 2025 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950715;
	bh=g+2ts8Y8iakxVX/RByZc4SZSL8vqsUwS2VZ/7tvD3KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5qFFjv4B2vGcUVkfPecuqzedc8YF7XEz8p4EhLzD03ifkwfsRqJDW+dpkgtWFX2m
	 3T+7i0WBMU7cU13e/einaGMXNs+ie/cmbYp+F2uSFtHIlHaReH3D032RBsSDfUVa+s
	 2YtnUoTij7cQkGwYAM6y17XzIAsHySMr6PPD7iuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 181/204] riscv: Provide all alternative macros all the time
Date: Tue, 29 Apr 2025 18:44:29 +0200
Message-ID: <20250429161106.798816241@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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




