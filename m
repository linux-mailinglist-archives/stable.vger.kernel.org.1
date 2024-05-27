Return-Path: <stable+bounces-46917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A18D0BCD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB771F235F0
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9215ECFF;
	Mon, 27 May 2024 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zijztP8N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C817E90E;
	Mon, 27 May 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837189; cv=none; b=OXx4mqmAztd6YqIG/MW2mKnbYxuzoMXpx/ewgB9rIrrErml4AAwUkig/P5BRB+47uFCFqNJjkiEFRKW6CaLDfEpyHrCbvd3bjRRXXx8ES6hpQ71wQymiQ5nNhmFSHS0kYzB4pSTh9gYFvaXWH8Vow9VMDtaS9XegB24VayBoIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837189; c=relaxed/simple;
	bh=40uFVohz+nLU61IqcDrmF1tit1zvAjtrh8fskC21dJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N63KEpViowTjrHeIQbjHghXnlk3XcdTCHZlo0ST2jC3pfNT/o9VH5rMUBZhZlX5LB2jn0hV0goNiL8+vPIMKrclJoTXIh8t1nAo0pcLwipYaHXX7ONeR79d9tG636ABY1m8YGiGZsezwrZPXKW2vceAbg5nR5UrRFYuccYmpSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zijztP8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2A0C2BBFC;
	Mon, 27 May 2024 19:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837189;
	bh=40uFVohz+nLU61IqcDrmF1tit1zvAjtrh8fskC21dJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zijztP8NfoL6zSceEXv3+7WsKqFdJ/DhnlerbNHvTv0bXZgiwWF6Apks1xuqEqH0P
	 kt/p4pf2F5IlXwZA7LoALq7JJjGwyNGib6983x0cskTIGY4Wdn1/11/JdwZAaev9qQ
	 65A/lyf3WXRXgmgSStt2tvisfvJVgZ5BrXahGiYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 344/427] RISC-V: Fix the typo in Scountovf CSR name
Date: Mon, 27 May 2024 20:56:31 +0200
Message-ID: <20240527185633.101598259@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Atish Patra <atishp@rivosinc.com>

[ Upstream commit d1927f64e0e1094f296842e127138cb5f3bf3c6d ]

The counter overflow CSR name is "scountovf" not "sscountovf".

Fix the csr name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Link: https://lore.kernel.org/r/20240420151741.962500-2-atishp@rivosinc.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/csr.h | 2 +-
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd0..9d1b07932794e 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -281,7 +281,7 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
-#define CSR_SSCOUNTOVF		0xda0
+#define CSR_SCOUNTOVF		0xda0
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39a..3e44d2fb8bf81 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -27,7 +27,7 @@
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
-- 
2.43.0




