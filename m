Return-Path: <stable+bounces-43231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F88BF05E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863FA1F217C1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E1823DD;
	Tue,  7 May 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnsTv2ge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF78060E;
	Tue,  7 May 2024 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122716; cv=none; b=sQ8fE7kbFcmZ1E/biGQWoP6L56xSaVzUT9hlDV6KHZte9/yeJx+PVlIy9NkypzoGiPfjFN/9EzILRnua5FeE8H+zfgQQfDLZ6hI84vpEcmmh6TGTIui2ZXWqpRHPkS1Z0HznTm/vGJX+U0R5U9PXpr70GITVkkuC5fgnqxGknuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122716; c=relaxed/simple;
	bh=jqy6Kg1eZd6Fg+DfhYSY0kLcOaYRotQs//kfM66k3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OprBeO7SHbJ6tsIC4fBwVqo+PC4RveH1IUrCbscvp6ET3x329JUZVw44oE0uFZpfZyJJCrd5uMGDNDfeZ9QrhiCSUORwrp4C4RbKaYrAxBehBQZyO8AXat60Kiqbu4ZmeKDBmMKJBkhqZ+doiI/egor61ZQ6SbXAnF7EvziVQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnsTv2ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109B2C4AF17;
	Tue,  7 May 2024 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122715;
	bh=jqy6Kg1eZd6Fg+DfhYSY0kLcOaYRotQs//kfM66k3Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnsTv2geEUxAU39SvggksQ8NjuyC0/J7Tx+S3H9zQ8sMsMR5Nfvkcbvpka+mTP31z
	 8X0V4syzLlPcts3EcfysO6hoSO0M9HnWKvZP/nb2WiLq++j+o9lFtv/YkXWjd+wIi2
	 DbjDruy6/Obbm8M1IA5DdE8T9ZlA0phqnDcUcd03pkM3lNkOFS5Cekxo6dXDZIuxgN
	 ax9lvJulr80xXZcz77Gm9kk0i7/NmvSXGoaba9n1IWXHQzotIU8Uej40zcS7FRLbOx
	 zWtnGX1Q8QazU9oaaTZlqvrMcOReIBnL1KETWTgIDLmNvRKaChcf9Mc/25Un4PVlCX
	 2DJxMHd6xWMqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jszhang@kernel.org,
	guoren@kernel.org,
	evan@rivosinc.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	peterlin@andestech.com,
	dminus@andestech.com,
	uwu@icenowy.me,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 21/23] riscv: thead: Rename T-Head PBMT to MAE
Date: Tue,  7 May 2024 18:56:47 -0400
Message-ID: <20240507225725.390306-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

[ Upstream commit 6179d4a213006491ff0d50073256f21fad22149b ]

T-Head's vendor extension to set page attributes has the name
MAE (memory attribute extension).
Let's rename it, so it is clear what this referes to.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadmae.adoc
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Link: https://lore.kernel.org/r/20240407213236.2121592-2-christoph.muellner@vrull.eu
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig.errata            |  8 ++++----
 arch/riscv/errata/thead/errata.c     | 10 +++++-----
 arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 910ba8837add8..2acc7d876e1fb 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -82,14 +82,14 @@ config ERRATA_THEAD
 
 	  Otherwise, please say "N" here to avoid unnecessary overhead.
 
-config ERRATA_THEAD_PBMT
-	bool "Apply T-Head memory type errata"
+config ERRATA_THEAD_MAE
+	bool "Apply T-Head's memory attribute extension (XTheadMae) errata"
 	depends on ERRATA_THEAD && 64BIT && MMU
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
-	  This will apply the memory type errata to handle the non-standard
-	  memory type bits in page-table-entries on T-Head SoCs.
+	  This will apply the memory attribute extension errata to handle the
+	  non-standard PTE utilization on T-Head SoCs (XTheadMae).
 
 	  If you don't know what to do here, say "Y".
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1aec..6e7ee1f16bee3 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,10 +19,10 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
-static bool errata_probe_pbmt(unsigned int stage,
-			      unsigned long arch_id, unsigned long impid)
+static bool errata_probe_mae(unsigned int stage,
+			     unsigned long arch_id, unsigned long impid)
 {
-	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_MAE))
 		return false;
 
 	if (arch_id != 0 || impid != 0)
@@ -140,8 +140,8 @@ static u32 thead_errata_probe(unsigned int stage,
 {
 	u32 cpu_req_errata = 0;
 
-	if (errata_probe_pbmt(stage, archid, impid))
-		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
+	if (errata_probe_mae(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_MAE);
 
 	errata_probe_cmo(stage, archid, impid);
 
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index ea33288f8a25b..9bad9dfa2f7a1 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -23,7 +23,7 @@
 #endif
 
 #ifdef CONFIG_ERRATA_THEAD
-#define	ERRATA_THEAD_PBMT 0
+#define	ERRATA_THEAD_MAE 0
 #define	ERRATA_THEAD_PMU 1
 #define	ERRATA_THEAD_NUMBER 2
 #endif
@@ -53,20 +53,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
  * in the default case.
  */
 #define ALT_SVPBMT_SHIFT 61
-#define ALT_THEAD_PBMT_SHIFT 59
+#define ALT_THEAD_MAE_SHIFT 59
 #define ALT_SVPBMT(_val, prot)						\
 asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
 		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
 			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
 		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
-			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
+			ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
 		: "=r"(_val)						\
 		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
-		  "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
+		  "I"(prot##_THEAD >> ALT_THEAD_MAE_SHIFT),		\
 		  "I"(ALT_SVPBMT_SHIFT),				\
-		  "I"(ALT_THEAD_PBMT_SHIFT))
+		  "I"(ALT_THEAD_MAE_SHIFT))
 
-#ifdef CONFIG_ERRATA_THEAD_PBMT
+#ifdef CONFIG_ERRATA_THEAD_MAE
 /*
  * IO/NOCACHE memory types are handled together with svpbmt,
  * so on T-Head chips, check if no other memory type is set,
@@ -83,11 +83,11 @@ asm volatile(ALTERNATIVE(						\
 	"slli    t3, t3, %3\n\t"					\
 	"or      %0, %0, t3\n\t"					\
 	"2:",  THEAD_VENDOR_ID,						\
-		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
+		ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)		\
 	: "+r"(_val)							\
-	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
-	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),			\
-	  "I"(ALT_THEAD_PBMT_SHIFT)					\
+	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAE_SHIFT),		\
+	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAE_SHIFT),			\
+	  "I"(ALT_THEAD_MAE_SHIFT)					\
 	: "t3")
 #else
 #define ALT_THEAD_PMA(_val)
-- 
2.43.0


